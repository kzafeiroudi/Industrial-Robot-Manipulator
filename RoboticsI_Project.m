%% *** Robot (kinematic) model parameters *** 
clear all;
close all;

syms x
l1 = 0.420;       %in m
l2 = 0.450;
l3 = 0.650;
l4 = 0.085;
lE = 0.100;

%% *** sampling period *** 
%% *** for the robot motion, kinematic simulation: 
dt = 0.001; %dt = 0.001; i.e. 1 msec)   

%% *** Create (or load from file) reference signals *** 
%% *** DESIRED MOTION PROFILE - TASK SPACE *** 
Tf = 10.0; 	% 10sec duration of motion 
t = 0:dt:Tf;  

%(xd0,yd0,zd0) --> (xd1,yd1,d1): initial/final end-point position --> desired task-space trajectory  
xd0 = 0.4;	
xd1 = 0.4; 
yd0 = 0.3; 
yd1 = 0.4; 
zd0 = 1.2;
zd1 = 1.2;

% Example of desired trajectory : linear segment (x0,y0,z0)-->(x1,y1,z1); Time duration: Tf; 
disp('Initialising Desired Task-Space Trajectory (Motion Profile) ...'); %% 
disp(' ');   
xd(1) = xd0; 
yd(1) = yd0; 
zd(1) = zd0;
v(1) = 0.0;
w(1) = 0.0;
lambda_x = (xd1-xd0)/Tf;
lambda_z = (zd1-zd0)/Tf;
kmax = Tf/dt + 1;
a = (yd1 - yd0)/16;

for i = 1:1:kmax;
    tt = dt * i;
     if (tt <= 2)
         yd(i) = a*tt^2/2 + yd0;
     elseif (tt > 2) && (tt <= 8)
         yd(i) = yd(2/dt) + a*2*(tt - 2);
     else
         yd(i) = yd(8/dt) + a*2*(tt - 8) - a*(tt - 8)^2/2;
     end
end

v(1)=0;
for i = 2:1:kmax;
    v(i) = (yd(i) - yd(i-1))/dt;
end;

for k=2:kmax; 
   xd(k) = xd(k-1) + lambda_x*dt;    
   zd(k) = zd(k-1) + lambda_z*dt;
end   
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% ****** KINEMATIC SIMULATION - Main loop ****** 
disp('Kinematic Simulation ...'); %% 
disp(' '); %%  

%% ***** INVESRE KINEMATICS  -->  DESIRED MOTION - JOINT SPACE ***** 
%% compute the reference joint-motion vectors: 
%% {qd(k,i), i=1,...,n (num of degrees of freedom), with k=1,..., kmax,} 
%% and reference joint (angular) velocities {qd_1(k,i)} 
for k = 1:kmax
    
    q3(k) = (acos((xd(k)^2 + yd(k)^2 + (zd(k) - l1)^2 - (l3 + l4 + lE)^2 - l2^2)/(2*l2*(l3 + l4 + lE))));
    c3 = cos(q3(k));
    s3 = sin(q3(k));
    q1(k) = (atan(yd(k)./xd(k)));
    s1 = sin(q1(k));
    c1 = cos(q1(k));
    r = sqrt((xd(k).*c1 + yd(k).*s1)^2 + (zd(k) - l1)^2);
    q2(k) = asin(((l3 + l4 + lE)*c3 + l2)./r) - atan((zd(k) - l1)./(xd(k).*c1 + yd(k).*s1));
end   
dq1(1) = 0;
dq2(1) = 0;
dq3(1) = 0;
for k=2:kmax;  
    dq1(k) = (q1(k) - q1(k-1))./dt; 
	dq2(k) = (q2(k) - q2(k-1))./dt;
	dq3(k) = (q3(k) - q3(k-1))./dt; 
end;

%% *** SAVE and PLOT output data *** %%** use functions plot(...)  
save;  %% --> save data to 'matlab.mat' file   

fig1 = figure;
subplot(3,1,1); 
plot(t,xd); 
ylabel('xd (mm)'); 
xlabel('time t (sec)');  

subplot(3,1,2); 
plot(t,yd); 
ylabel('yd (mm)'); 
xlabel('time t (sec)');  

subplot(3,1,3); 
plot(t,zd); 
ylabel('zd (mm)'); 
xlabel('time t (sec)');  

fig2 = figure;
axis([0 2 0 2 0 2]) %%set xyz plot axes
axis on 
grid on
xlabel('x (mm)'); 
ylabel('y (mm)'); 
zlabel('z (mm)');
plot3(xd,yd,zd, 'r*');
grid on;

fig3 = figure;
plot(0:0.001:10,v);
ylabel('v (mm/s)');
xlabel('time (sec)');

fig4 = figure;
subplot(2,3,1); 
plot(t,q1); 
ylabel('q1 (rad)'); 
xlabel('time t (sec)');  

subplot(2,3,2); 
plot(t,q2); 
ylabel('q2 (rad)'); 
xlabel('time t (sec)');    

subplot(2,3,3); 
plot(t,q3); 
ylabel('q3 (rad)'); 
xlabel('time t (sec)');  

subplot(2,3,4); 
plot(t,dq1); 
ylabel('dq1 (rad/s)'); 
xlabel('time t (sec)');  

subplot(2,3,5); 
plot(t,dq2); 
ylabel('dq2 (rad/s)'); 
xlabel('time t (sec)');    

subplot(2,3,6); 
plot(t,dq3); 
ylabel('dq3 (rad/s)'); 
xlabel('time t (sec)');  