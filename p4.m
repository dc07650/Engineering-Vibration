clc; clear all; close all;
%% Variable Initialization
y0 = [0 0];
m = 1;
k = 1;
wn = sqrt(k/m);
T = 2 * pi / wn;
t1 = [0 0.5 * T T];
colors = 'rgb';
t = 0:0.01:15;
%% Compute and Plot
grid on; hold on;
for i = 1:length(t1)
    [t y] = ode45(@(t,y) vibration(t, y, t1(i), k, m), t, y0);
    plot(t, y(:,1), colors(i), 'linewidth', 1);
end
hold off;
title('Engineering Vibration - Matlab Problem #4');
xlabel('time (sec)'); ylabel('displacement (mm)');
legend('t_1 = 0 (F_0)', 't_1 = T/2 (F_0)', 't_1 = T (F_0)');
%% Function Declaration
function dy = vibration(t, y, t1, k, m)
    F = 1;
    dy = zeros(2,1);
    dy(1) = y(2);
    if t1 == 0 % When t1 is 0, the external force becomes F (Step function)
        dy(2) = (- k .* y(1) + F) ./ m;
    else
        dy(2) = (- k .* y(1) + t .* F ./ t1 - (t-t1)./t1 *F *stepfun(t,t1)) ./ m;
    end
end
