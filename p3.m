clc; clear all; close all;
%% Variable Initialization
y0 = [0.01 0.1];
t = 0:0.01:10;
%% Compute and Plot
grid on;
hold on;
[t y] = ode45(@(t,y) vibration(t, y), t, y0);
plot(t, y(:,1), 'r-', 'linewidth', 1);
% plot(t, (160/(sqrt((20000-100*5*5)^2+(200*5)^2)))*cos(5*t));
hold off;
title('Engineering Vibration - Matlab Problem #3');
xlabel('time (sec)');
ylabel('displacement (mm)');
legend('Displacement');
%% Function Declaration
function dy = vibration(t, y)
    F = 160;
    w = 5;
    m = 100;
    c = 200;
    k = 20000;
    dy = zeros(2,1);
    dy(1) = y(2);
    dy(2) = (-c .* y(2) - k .* y(1) + F .* cos(5*t)) ./ m;    
end
