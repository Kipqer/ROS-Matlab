%% Przygotowanie
clear all
clc

%% Odczytanie rosbaga
%subset_straight_info = rosbag('info','/home/maciek/bagfiles/11.01.2022/bag5.bag');

%subset_straight = rosbag('/home/maciek/bagfiles/11.01.2022/bag5.bag');
%subset_straight = rosbag('/home/maciek/bagfiles/11.01.2022/bag6.bag');
%subset_straight = rosbag('/home/maciek/bagfiles/11.01.2022/bag7.bag');
%subset_straight = rosbag('/home/maciek/bagfiles/11.01.2022/bag8.bag');

%%  encoder   /encoder/right  [timestamp, counter]
subset_straight = rosbag('/home/maciek/bagfiles/bag_160_3.bag');
subset_straight_encoder = select(subset_straight,'Topic','/encoder/right');

counter=zeros(subset_straight_encoder.NumMessages,2); %counter[timestamp,counter]

for i=1:subset_straight_encoder.NumMessages
    msgStructs_encoder = readMessages(subset_straight_encoder, i);
    counter(i,2)=msgStructs_encoder{1,1}.Counter;
    counter(i,1)=msgStructs_encoder{1,1}.Header.Stamp.Nsec+(10^9)*msgStructs_encoder{1,1}.Header.Stamp.Sec;
end

%plot(counter(:,1),counter(:,2)-counter(1,2))

%%  imu   /imu  [timestamp, ax, ay, az, gx, gy, gz, mx, my, mz]  mx,my,mz => 0
subset_straight = rosbag('/home/maciek/bagfiles/bag_1.bag');
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


%%  tfLuna   /tfluna  [timestamp, distance]

subset_straight = rosbag('/home/maciek/bagfiles/bag_1.bag');
subset_straight_tfluna = select(subset_straight,'Topic','/tfluna');

distance=zeros(subset_straight_tfluna.NumMessages,2); %range[timestamp,distance] 

for i=1:subset_straight_tfluna.NumMessages
    msgStructs_tfluna = readMessages(subset_straight_tfluna, i);
    distance(i,2)=msgStructs_tfluna{1,1}.Measurements.Range;
    distance(i,1)=msgStructs_tfluna{1,1}.Measurements(1,1).Header.Stamp.Nsec+(10^9)*msgStructs_tfluna{1,1}.Measurements(1,1).Header.Stamp.Sec;
end

%plot(distance(:,1),distance(:,2))

%%  uwb   /uwb [timestamp, distance1, ..., distance8, gain1, ..., gain8] n=5,6,7,8 => 0
subset_straight = rosbag('/home/maciek/bagfiles/bag_160_3.bag');
subset_straight_uwb = select(subset_straight,'Topic','/uwb');

uwb=zeros(subset_straight_uwb.NumMessages,9); %uwb[timestamp,distance1, ...,distance4, gain1, ..., gain4] 

for i=1:subset_straight_uwb.NumMessages
    msgStructs_uwb = readMessages(subset_straight_uwb, i);
    uwb(i,1)=msgStructs_uwb{1,1}.Measurements(1,1).Header.Stamp.Nsec+(10^9)*msgStructs_uwb{1,1}.Measurements(1,1).Header.Stamp.Sec;
    uwb(i,2)=msgStructs_uwb{1,1}.Measurements(1,1).Distances(1,1);
    uwb(i,3)=msgStructs_uwb{1,1}.Measurements(1,1).Distances(2,1);
    uwb(i,4)=msgStructs_uwb{1,1}.Measurements(1,1).Distances(3,1);
    uwb(i,5)=msgStructs_uwb{1,1}.Measurements(1,1).Distances(4,1);
    uwb(i,6)=msgStructs_uwb{1,1}.Measurements(1,1).Gains(1,1);
    uwb(i,7)=msgStructs_uwb{1,1}.Measurements(1,1).Gains(2,1);
    uwb(i,8)=msgStructs_uwb{1,1}.Measurements(1,1).Gains(3,1);
    uwb(i,9)=msgStructs_uwb{1,1}.Measurements(1,1).Gains(4,1);
 
end

%%  uwb2   /uwb2  [timestamp, distance1, ..., distance8, gain1, ..., gain8] n=5,6,7,8 => 0
subset_straight = rosbag('/home/maciek/bagfiles/bag_160_3.bag');
subset_straight_uwb2 = select(subset_straight,'Topic','/uwb2');

uwb2=zeros(subset_straight_uwb2.NumMessages,9); %uwb2[timestamp,distance1, ...,distance4, gain1, ..., gain4] 

for i=1:subset_straight_uwb2.NumMessages
    msgStructs_uwb2 = readMessages(subset_straight_uwb2, i);
    uwb2(i,1)=msgStructs_uwb2{1,1}.Measurements(1,1).Header.Stamp.Nsec+(10^9)*msgStructs_uwb2{1,1}.Measurements(1,1).Header.Stamp.Sec;
    uwb2(i,2)=msgStructs_uwb2{1,1}.Measurements(1,1).Distances(1,1);
    uwb2(i,3)=msgStructs_uwb2{1,1}.Measurements(1,1).Distances(2,1);
    uwb2(i,4)=msgStructs_uwb2{1,1}.Measurements(1,1).Distances(3,1);
    uwb2(i,5)=msgStructs_uwb2{1,1}.Measurements(1,1).Distances(4,1);
    uwb2(i,6)=msgStructs_uwb2{1,1}.Measurements(1,1).Gains(1,1);
    uwb2(i,7)=msgStructs_uwb2{1,1}.Measurements(1,1).Gains(2,1);
    uwb2(i,8)=msgStructs_uwb2{1,1}.Measurements(1,1).Gains(3,1);
    uwb2(i,9)=msgStructs_uwb2{1,1}.Measurements(1,1).Gains(4,1);
    
end

%% uwb filtrowanie (odciecie zer)

for n=2:5
    for i=1:subset_straight_uwb.NumMessages
        if uwb(i,n)==0
            if i==1
                uwb(i,n)=uwb(i+1,n);
            else
                uwb(i,n)=uwb(i-1,n);
            end
        end
    end
end

%% uwb filtrowanie (wygladzenie)

uwb(:,2)=smooth(uwb(:,2));
uwb(:,3)=smooth(uwb(:,3));
uwb(:,4)=smooth(uwb(:,4));
uwb(:,5)=smooth(uwb(:,5));

%% uwb2 filtrowanie (odciecie zer)

for n=2:5
    for i=1:subset_straight_uwb2.NumMessages
        if uwb2(i,n)==0
            if i==1
                uwb2(i,n)=uwb2(i+1,n);
            else
                uwb2(i,n)=uwb2(i-1,n);
            end
        end
    end
end

%% Wykres UWB

%UWB-Anchor1
subplot(2,2,1);
plot((uwb(:,1)-uwb(1:1))/10^9,uwb(:,2))
title('Plot 1: UWB-Anchor1')

%UWB-Anchor2
subplot(2,2,2);
plot((uwb(:,1)-uwb(1:1))/10^9,uwb(:,3))
title('Plot 2: UWB-Anchor2')

%UWB-Anchor3
subplot(2,2,3);
plot((uwb(:,1)-uwb(1:1))/10^9,uwb(:,4))
title('Plot 3: UWB-Anchor3')

%UWB-Anchor4
subplot(2,2,4);
plot((uwb(:,1)-uwb(1:1))/10^9,uwb(:,5))
title('Plot 4: UWB-Anchor4')

%% Wykres UWB2

%UWB2-Anchor1
subplot(2,2,1);
plot((uwb2(:,1)-uwb2(1:1))/10^9,uwb2(:,2))
title('Plot 1: UWB2-Anchor1')

%UWB2-Anchor2
subplot(2,2,2);
plot((uwb2(:,1)-uwb2(1:1))/10^9,uwb2(:,3))
title('Plot 2: UWB2-Anchor2')

%UWB2-Anchor3
subplot(2,2,3);
plot((uwb2(:,1)-uwb2(1:1))/10^9,uwb2(:,4))
title('Plot 3: UWB2-Anchor3')

%UWB2-Anchor4
subplot(2,2,4);
plot((uwb2(:,1)-uwb2(1:1))/10^9,uwb2(:,5))
title('Plot 4: UWB2-Anchor4')

%% wykres encoder i tfLuna

%encoder
subplot(2,2,1);
plot((distance(:,1)-distance(1,1))/10^9,distance(:,2))
title('Plot 1: tfluna distance')

%tfluna
subplot(2,2,2);
plot((counter(:,1)-distance(1,1))/10^9,counter(:,2)-counter(1,2))
title('Plot 2: encoder impuls')

%encoder+tfluna
subplot(2,2,[3,4]);
plot((distance(:,1)-distance(1,1))/10^9,distance(:,2)*100,(counter(:,1) ...
    -distance(1,1))/10^9,((counter(:,2)-counter(1,2))*0.6)) 
%Skalowanie enkoderow dla lepszej wizualizacji, dystans w metrach

title('Plot 3: tfluna distance + encoder impulse')

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
plot((velocity(:,1)-velocity(1,1))/10^9,velocity(:,2),(velocity(:,1) ...
    -velocity(1,1))/10^9,velocity(:,3),(velocity(:,1)-velocity(1,1))/10^9,velocity(:,4)) 
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
