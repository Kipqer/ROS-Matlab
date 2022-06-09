clear all
clc

subset_straight = rosbag('/home/maciek/bagfiles/bag_255_22.bag');
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

for i=1:1:5
    uwb(:,2)=smooth(uwb(:,2));
    uwb(:,3)=smooth(uwb(:,3));
    uwb(:,4)=smooth(uwb(:,4));
    uwb(:,5)=smooth(uwb(:,5));
end

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

for i=1:1:5
    uwb2(:,2)=smooth(uwb2(:,2));
    uwb2(:,3)=smooth(uwb2(:,3));
    uwb2(:,4)=smooth(uwb2(:,4));
    uwb2(:,5)=smooth(uwb2(:,5));
end

%17.02.2022r. corner
%UWB_trajectory(4,[0 0 65; 0 483 65; -15 34 240; 570 0 65],uwb,uwb2)

%17.02.2022r. prostokat //Zmienic A3 z A4 w UWB_trajectory
%UWB_trajectory(4,[0 0 65; 0 483 65; 570 0 65; 570 483 65],uwb,uwb2)