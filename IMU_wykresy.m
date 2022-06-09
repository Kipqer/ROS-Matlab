%%
clear all
clc

subset_straight = rosbag('/home/maciek/bagfiles/bag_255_22.bag');
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

%% wykres imu velocity

%velocity X
subplot(3,3,1);
plot((velocity(:,1)-velocity(1,1))/10^9,velocity(:,2))
title('Plot 1: velocity X')

%velocity Y
subplot(3,3,2);
plot((velocity(:,1)-velocity(1,1))/10^9,velocity(:,3))
title('Plot 2: velocity Y')

%velocity Z
subplot(3,3,3);
plot((velocity(:,1)-velocity(1,1))/10^9,velocity(:,4))
title('Plot 3: velocity Z')

%velocity XYZ
subplot(3,2,[4,5,6]);
plot((velocity(:,1)-velocity(1,1))/10^9,velocity(:,2),(velocity(:,1)-velocity(1,1))/10^9,velocity(:,3),(velocity(:,1)-velocity(1,1))/10^9,velocity(:,4)) 
title('Plot 3: velocity XYZ')

%% wykres imu acceleration

%acceleration X
subplot(3,3,1);
plot((acceleration(:,1)-acceleration(1,1))/10^9,acceleration(:,2))
title('Plot 1: acceleration X')

%acceleration Y
subplot(3,3,2);
plot((acceleration(:,1)-acceleration(1,1))/10^9,acceleration(:,3))
title('Plot 2: acceleration Y')

%acceleration Z
subplot(3,3,3);
plot((acceleration(:,1)-acceleration(1,1))/10^9,acceleration(:,4))
title('Plot 3: acceleration Z')

%acceleration XYZ
subplot(3,2,[4,5,6]);
plot((acceleration(:,1)-acceleration(1,1))/10^9,acceleration(:,2),(acceleration(:,1) ...
    -acceleration(1,1))/10^9,acceleration(:,3),(acceleration(:,1)-acceleration(1,1))/10^9,acceleration(:,4)) 
title('Plot 3: acceleration XYZ')