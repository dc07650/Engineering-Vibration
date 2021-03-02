clc; clear all; close all;


t = 0:0.01:20;
y0 = [1 1];
z = [0.01 0.1 1 10];
color = 'rgby';

grid on 
hold on;

for i = 1:length(z)

[t y] = ode45(@(t,y) vibration(t, y, z(i)), t, y0);

plot(t, y(:,1), color(i), 'linewidth', 1);

end


title('Engineering Vibration - Matlab Problem #1');
xlabel('time (sec)');
ylabel('displacement (mm)');
legend(strcat('\zeta=',num2str(z(1))),strcat('\zeta=',num2str(z(2))),strcat('\zeta=',num2str(z(3))),strcat('\zeta=',num2str(z(4))));





function dy = vibration(t, y, z)
    wn = 2;
    dy = zeros(2,1);
    dy(1) = y(2);
    dy(2) = (-1).*(wn.^2) .* y(1) - 2 .* z .* wn .* y(2);
end