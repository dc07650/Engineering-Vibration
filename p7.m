clc; clear all; close all;
L=[0.1*1000 100*1000];
Fs = 1000;            % Sampling frequency
T = 1/Fs;             % Sampling period
%% (a) plot half sine of t1
for i = 1: length(L)
    t = (0:L(i)-1)*T;
    x=sin(pi/(L(i)/1000)*t);
    figure(2*i-1);
    plot(t,x)
    grid on;
    title('SineWave');
    xlabel('Times (s)');ylabel('Amplitude');
    
    %% Perform FFT    
    Y = fft(x);
    P2 = abs(Y/L(i));
    P1 = P2(1:L(i)/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    f1 = Fs*(0:(L(i)/2))/L(i);
    
    
    figure(2*i);
    plot(f1,P1);
    grid on;
    title('FFT of the sine wave');
    axis([0 50 0 1]);
    xlabel('Frequency (Hz)');ylabel('Amplitude');
end

%% (b) plot xdd + x = F
t = 0:0.01:150;
y0 = [0 0];
color = 'rgby';
for i = 1:length(L)
    hold on;
    
    [t y] = ode45(@(t,y) vibration(t, y, L(i)/1000), t, y0);
    figure(i + 4);
    plot(t, y(:,1), color(i), 'linewidth', 1);
    grid on;
    title('Engineering Vibration - Matlab Problem #7');
    xlabel('time (sec)');
    ylabel('displacement (mm)');
    
    hold off;
end
%% Function Declaration
function dy = vibration(t, y, t1)
dy = zeros(2,1);
dy(1) = y(2);
dy(2) = -y(1) + sin(pi/t1 * t)*(1 - stepfun(t, t1));
end