clc; clear all; close all;
%% Variable Initialization
y0 = [0; 0; 0; 0];
colors = 'rgbk';
w = [0];
t = 0:0.001:60;
%% Compute and Plot
grid on;
for i = 1:length(w)
    subplot(1, length(w), i);
    if i == 1
        title('Engineering Vibration - Matlab Problem #5');
    end
    hold on;
    xlabel('time (sec)');
    ylabel('displacement (mm)');
    [t y] = ode45(@(t,y) vibration(t, y, w(i)), t, y0);
    plot(t, y(:,1), t, y(:,2), colors(i), 'linewidth', 1);
    axis([0 60 -1.5 1.5])
    legend('x_1', 'x_2');
    hold off;
end
%% Function Declaration
function dy = vibration(t, y, w)
    m1 = 9;    m2 = 1;
    k1 = 24;    k2 = 3;
    M = [m1 0 ; 0 m2];
    K = [k1+k2 -k2 ; -k2 k2];
    B = [1; 0];
    A1 = [zeros(2) eye(2); -inv(M)*K zeros(2)];
    f = inv(M) * B;
    dy = A1*y+[0;0;f]*cos(w*t); 
end
