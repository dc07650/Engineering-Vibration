%% Engineering Vibration MATLAB
% Author: Won Bin Choi (B3)
% E-mail: dc07650@naver.com
% Organization: Sogang University(Korea, Republic of), Mechanical Engineering
% Date: April 4, 2021

%% Initialize
clear all; clc; close all;

T=0.001;      % Sampling Period [sec]
Tfinal=60;    % Simulation Time [sec]
t=0:T:Tfinal; % Time Sequence [sec]
N=length(t);  % Number of Samples [unit]

L1 = 1.5; L2 = 1.5; % Spring Free Length [m]
m1=9;    m2=1;    % Mass [kg]
k1 = 24; k2 = 3;  % Spring Constant [N/m]

%% Generalized coordinate
s = zeros(N,2); ds = zeros(N,2); dds = zeros(N,2);        % Displacement
f1 = zeros(N,1); f2 = zeros(N,1); f = zeros(N,2);   % Force
s(1,1) = 0;  s(1,2) = 0; % Initial Value

Tfinal_force = Tfinal;

for k=1:N
    % Force Input
    if k < round((Tfinal_force)/(Tfinal)*N,0)
        f1(k) = cos(1.9*t(k));
        f2(k) = 0;
        f(k,:) = [f1(k) f2(k)];
    end
end

%% Forward Dynamics
for k=1:N-1
    
    % Mass Matrix
    M11(k)=m1;
    M12(k)=0;
    M21(k)=0;
    M22(k)=m2;
    M=[M11(k) M12(k); M21(k) M22(k)];
    M_inv =inv(M);
    
    % Spring Constant Matrix
    K11(k)=k1+k2;
    K12(k)=-k2;
    K21(k)=-k2;
    K22(k)=k2;
    K=[K11(k) K12(k); K21(k) K22(k)];
    
    % Forward Dynamics (Force -> Displacement)
    C_input=f(k,:)'-K*s(k,:)';
    dds(k,:)=(M_inv*C_input);      % Initial acceleration definition
    ds(k+1,:)=ds(k,:)+dds(k,:)*T;  % Linear Integration
    s(k+1,:)=s(k,:)+ds(k+1,:)*T;   % Linear Integration
end

%% Forward Kinematics
x=zeros(N,3); y=zeros(N,3); % Initialize Coordinate Space
for k=1:N
    x(k,1)=0;
    y(k,1)=0;
    x(k,2)=s(k,1) + L1;
    y(k,2)=0;
    x(k,3)=s(k,1)+ s(k,2) + L1 + L2;
    y(k,3)=0;
end

%% Simulation
figure('color','w');
for k=1:200:N
    plot(x(k,1),y(k,1),'ko'); hold on; % Joint 1
    plot(x(k,2),y(k,2),'bs', 'MarkerSize', 20); hold on; % Joint 2
    plot(x(k,3),y(k,3),'rs', 'MarkerSize', 20); hold on; % Joint 3
    plot([x(k,1) x(k,2)],[y(k,1) y(k,2)],'b','linewidth',2); hold on; % Link 1
    plot([x(k,2) x(k,3)],[y(k,2) y(k,3)],'r','linewidth',2); hold on; % Link 2
    axis([-1 5 -1 1])                         % Axis X, Y
    grid on;
    drawnow;
    hold off;
end

%% Plot
figure('color','w');

subplot(211); % Graphs of end point
plot(t,f1,'b','linewidth',2); hold on;
plot(t,f2,'r','linewidth',2); hold on;
legend('F_1','F_2')
ylabel('Force [N]'); xlabel('Time [sec]')

subplot(212); % Graphs of displacement
plot(t,s(:,1)*180/pi,'b','linewidth',2); hold on;
plot(t,s(:,2)*180/pi,'r','linewidth',2); hold on;
legend('x_1','x_2')
ylabel('Displacement [m]'); xlabel('Time [sec]')

figure('color','w');

subplot(311); % Graphs of end point
plot(t,x(:,3),'b','linewidth',2); hold on;
ylabel('x_3 [m]'); xlabel('Time [sec]')

subplot(312); % Graphs of joint angle
plot(t,y(:,3),'r','linewidth',2); hold on;
ylabel('y_3 [m]'); xlabel('Time [sec]')

subplot(313); % Graphs of joint angle
plot(x(:,3),y(:,3),'b','linewidth',2); hold on;
ylabel('y_3 [m]'); xlabel('x_3 [m]')