clear all
clc

%  imu   /imu  [timestamp, ax, ay, az, gx, gy, gz, mx, my, mz]  mx,my,mz => 0
subset_straight = rosbag('/home/maciek/bagfiles/bag_160_1.bag');
subset_straight_imu = select(subset_straight,'Topic','/imu');

acceleration=zeros(subset_straight_imu.NumMessages,4); %acceleration[timestamp,ax,ay,az] 
velocity=zeros(subset_straight_imu.NumMessages,4); %velocity[timestamp,gx,gy,gz]

for i=1:subset_straight_imu.NumMessages
    msgStructs_imu = readMessages(subset_straight_imu, i);
    acceleration(i,1)=msgStructs_imu{1,1}.Measurements(1,1).Header.Stamp.Nsec+(10^9)*msgStructs_imu{1,1}.Measurements(1,1).Header.Stamp.Sec;
    acceleration(i,2)=msgStructs_imu{1,1}.Measurements(1,1).LinearAcceleration.X;
    acceleration(i,3)=msgStructs_imu{1,1}.Measurements(1,1).LinearAcceleration.Y;
    acceleration(i,4)=msgStructs_imu{1,1}.Measurements(1,1).LinearAcceleration.Z;
    velocity(i,1) = acceleration(i,1);
    velocity(i,2)=msgStructs_imu{1,1}.Measurements(1,1).AngularVelocity.X;
    velocity(i,3)=msgStructs_imu{1,1}.Measurements(1,1).AngularVelocity.Y;
    velocity(i,4)=msgStructs_imu{1,1}.Measurements(1,1).AngularVelocity.Z;
end

%plot(acceleration(:,1),acceleration(:,2))
%plot(velocity(:,1),velocity(:,2))

%% FUSE quaternion

gyroReadings = velocity(:,[2,3,4]);
accelReadings = acceleration(:,[2,3,4]);

FUSE = imufilter;

[orientation,angularVelocity] = FUSE(accelReadings,gyroReadings);

%% FUSE plot

gyroReadings = velocity(:,[2,3,4]);
accelReadings = acceleration(:,[2,3,4]);

ifilt = imufilter;
for ii=1:size(accelReadings,1)
    qimu = ifilt(accelReadings(ii,:), gyroReadings(ii,:));
    set(poseplot, "Orientation", qimu)
    xlabel("North-x (m)")
    ylabel("East-y (m)")
    zlabel("Down-z (m)");
    drawnow limitrate
    pause(0.2);
end

%% SLERP

q0 = quaternion([80 70 70], 'eulerd', 'ZYX', 'frame');
q1 = quaternion([80 70 70], 'eulerd', 'ZYX', 'frame');

p30 = slerp(q0, q1, 0.3);

eulerd(p30, 'ZYX', 'frame')

dt = 0.01;
h = (0:dt:1).';
trajSlerped = slerp(q0, q1, h);

partsLinInterp = interp1( [0;1], compact([q0;q1]), h, 'linear');

trajLerped = normalize(quaternion(partsLinInterp));

avSlerp = helperQuat2AV(trajSlerped, dt);
avLerp = helperQuat2AV(trajLerped, dt);

sp = HelperSlerpPlotting;
sp.plotAngularVelocities(avSlerp, avLerp);

