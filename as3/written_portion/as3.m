% Initial Setup
disp('W: World Coordinates origin (in homogenous coordinates)')
W=[0;0;0;1]
disp('O1: Object 1 vertices (each column is vertex in homogenous coordinates)')
O1=[0, 1, 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1;
    1, 1, 1, 1] 

% Problem 1
disp('C1: Origin of Object 1 coordinate frame')
C1=[0;10;0]
disp('C2: Origin of Object 2 coordinate frame')
C2=[10;0;20]
disp('MWC1: Obj 1 modeling transformation')
MWC1=[[eye(3),C1];0,0,0,1]
C2_trans=[[eye(3),C2];0,0,0,1] % Obj 2 translation matrix
C2_rot=[cos(pi/6), 0, sin(pi/6), 0;
         0, 1, 0, 0;
         -sin(pi/6), 0, cos(pi/6), 0;
         0, 0, 0, 1]; % Obj 2 rotation matrix
disp('CWC2: Obj 2 modeling transformation')
MWC2=C2_trans*C2_rot 

% Problem 2
disp('C1W: Coordinates of C1 in world frame (homog coords)')
C1=[C1;1]
disp('O1W: Coordinates of O1 in world frame (homog coords)')
O1W=MWC1*O1

% Problem 3
Pwv=[-50;-50;-50]; % Coordinates of camera in world frame
V=[0;1;0]; % Up vector (+y direction) of camera
N=[50;50;50]; % Direction camera is pointing (at origin)
n=N / norm(N); % unit vector of camera +z direction
U=cross(V,N);
u=U / norm(U); % unit vector of camera +x direction
v=cross(n,u); % unit vector of camera +y direction
disp('Mvw: Viewing transformation')
Mvw=[u', dot(-u,Pwv);
     v', dot(-v,Pwv);
     n', dot(-n,Pwv);
     0, 0, 0, 1]
disp('Mvc1: Obj 1 Modelview transformation')
Mvc1=Mvw*MWC1
disp('Mvc2: Obj 2 Modelview transformation')
Mvc2=Mvw*MWC2

% Problem 4
disp('Wv: World Coordinates in viewing frame')
Wv=Mvw*W
disp('C1v: Obj 1 coordinates in viewing frame')
C1v=Mvw*C1

% Problem 5
O1_45_rot=[1,0,0,0;
           0,cos(pi/4),-sin(pi/4),0;
           0,sin(pi/4),cos(pi/4),0;
           0,0,0,1]; % O1 45 deg rotation around x transformation
disp('Mwc1_5: Obj 1 modeling transform (p5)')
Mwc1_5=MWC1*O1_45_rot
disp('Mvc1_5: Obj 1 viewing transformation (p5)')
Mvc1_5=Mvw*Mwc1_5

% Problem 6
O1_60_rot=[cos(pi/3),-sin(pi/3),0,0;
           sin(pi/3),cos(pi/3),0,0;
           0,0,1,0;
           0,0,0,1]; % O1 60 deg rotation around z transform
O1_30_rot=[cos(-pi/6),0,sin(-pi/6),0;
           0,1,0,0;
           -sin(-pi/6),0,cos(-pi/6),0;
           0,0,0,1]; % O1 -30 deg rotation around y transform
disp('Mwc1_6: Obj 1 modeling transform (p6)')
Mwc1_6=Mwc1_5*O1_60_rot*O1_30_rot
disp('Mwc1_6: Obj 1 viewing transform (p6)')
Mvc1_6=Mvw*Mwc1_6

% Problem 7
O2_30_rot=[1,0,0,0;
           0,cos(pi/6),-sin(pi/6),0;
           0,sin(pi/6),cos(pi/6),0;
           0,0,0,1]; % O2 30 deg rotation around world x
disp('Mwc2_7: Obj 2 modeling transform (p7)')
Mwc2_7=O2_30_rot*MWC2
disp('Mvc2_7: obj 2 viewing transform (p7)')
Mvc2_7=Mvw*Mwc2_7