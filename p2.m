clc; clear all; close all;
%% Initialize Variables
t = 0:0.01:2;
y0 = [5/180*pi 0];
y1 = [60/180*pi 0];
magnitude = 1.5;
%% Compute and plot (Inital condition 5 deg)
subplot(121);
grid on
hold on;
title('Engineering Vibration - Matlab Problem #2');
[t y] = ode45(@(t,y) vibration_nonlinear(t, y), t, y0);
[t w] = ode45(@(t,w) vibration_linear(t, w), t, y0);
plot(t, w(:,1)/pi *180, 'r-', 'linewidth', 1);
plot(t, y(:,1)/pi *180, 'b--', 'linewidth', 1);
xlabel('time (sec)'); ylabel('displacement (rad) [Initial \theta_0 = 5 deg]');
legend('linear', 'nonlinear'); ylim([-(y0(1)/pi*180*magnitude) y0(1)/pi*180*magnitude]);
%% Compute and plot (Inital condition 60 deg)
subplot(122);
grid on
hold on;
[t y] = ode45(@(t,y) vibration_nonlinear(t, y), t, y1);
[t w] = ode45(@(t,w) vibration_linear(t, w), t, y1);
plot(t, w(:,1)/pi *180, 'r-', 'linewidth', 1);
plot(t, y(:,1)/pi *180, 'b--', 'linewidth', 1);
xlabel('time (sec)'); ylabel('displacement (rad) [Initial \theta_0 = 60 deg]');
legend('linear', 'nonlinear'); ylim([-(y1(1)/pi*180*magnitude) y1(1)/pi*180*magnitude]);

%% Function declaration
function dy = vibration_nonlinear(t, y)
g = 9.81;
l = 0.1;
dy = zeros(2,1);
dy(1) = y(2);
dy(2) = - g./l .* sin(y(1));
end

function dy = vibration_linear(t, y)
g = 9.81;
l = 0.1;
dy = zeros(2,1);
dy(1) = y(2);
dy(2) = - g./l .* y(1);
end