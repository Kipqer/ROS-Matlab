%Tor prostoliniowy ustawienie A1,A2,A3,A4
%UWB_trajectory(4,[0 0 70; 794 206 70; 794 12 70; 0 173 70],uwb,uwb2)
%UWB_trajectory(4,[0 0 70; 794 206 70; 794 12 70; 0 173 70],uwb,uwb2)

%Tor prostoliniowy A1,A2,A3,A4'
%UWB_trajectory(4,[0 0 70; 794 206 154; 794 12 70; 0 173 70],uwb,uwb2)

%Tor symetryczny
%UWB_trajectory(4,[0 0 70; 270 0 70; 270 289 70; 0 294 70],uwb,uwb2)

%Tor niesymetryczny
%UWB_trajectory(4,[0 0 70; 270 0 70; 270 289 70; 0 294 70],uwb,uwb2)

%Tor dla JetRacer
%

function UWB_trajectory(numNodes,nodeLoc,Distances1, Distances2)
nodeLoc(numNodes+1:end,:) = [];
f = figure;
ax = gca(f);
hold on;
hold(ax, 'on')
plot(ax, nodeLoc(:, 1), nodeLoc(:, 2), 'kd');
% Nodes
text(ax, nodeLoc(1, 1)+1.5, nodeLoc(1, 2)-1, 'A1');
text(ax, nodeLoc(2, 1)+1.5, nodeLoc(2, 2)-1, 'A2');
text(ax, nodeLoc(3, 1)+1.5, nodeLoc(3, 2)-1, 'A3');
text(ax, nodeLoc(4, 1)+1.5, nodeLoc(4, 2)-1, 'A4');
axis(ax, [0 800 0 800])
hold on
for i = 30:height(Distances1)-50

% Estimate location using Trilateration Function
NodeLoc3D = [nodeLoc';zeros(1,numNodes)];
 [xO, yO] = Trilateration(NodeLoc3D,Distances1(i,2:5),1);
 plot(xO(2),yO(3),'r.')
%plot3(xO(2),yO(3),(xO(4)+yO(4))/2,'r.')
 drawnow;
pause(0.01);
end
for i = 30:height(Distances2)-50

% Estimate location using Trilateration Function
NodeLoc3D = [nodeLoc';zeros(1,numNodes)];
 [xO, yO] = Trilateration(NodeLoc3D,Distances2(i,2:5),1);
 plot(xO(2),yO(3),'b.')
%plot3(xO(2),yO(3),(xO(4)+yO(4))/2,'r.')
 drawnow;
%pause(0.1);
end
%legend('Synchronized nodes','Device', 'Estimation', 'location', 'northwest')
hold off
end