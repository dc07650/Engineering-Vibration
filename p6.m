clear all; close all; clc;
L=[3000 2500]; % time vector length in millisecond
freq=1;
%% FFT
for i = 1: length(L)
    
    Fs = 1000;            % Sampling frequency
    T = 1/Fs;             % Sampling period
    t = (0:L(i)-1)*T;        % Time vector
    S = sin(2*pi*freq*t);
    
    Y = fft(S);
    P2 = abs(Y/L(i));
    P1 = P2(1:L(i)/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    f1 = Fs*(0:(L(i)/2))/L(i);
    
    
    %% Plot
    figure(2*i);
    plot(f1,P1);
    grid on;
    title(sprintf('FFT of the 1 Hz sine wave (T = %d ms)', L(i)));
    axis([0 50 0 1]);
    xlabel('Frequency (Hz)');ylabel('Amplitude');
end
 
%% hann window application
 
Fs=1000;
t=0:1/Fs:2.5;
x=sin(2*pi*freq*t).* hann(length(t))';
 
%% FFT
Fs = 1000;            % Sampling frequency
T = 1/Fs;             % Sampling period
t = (0:L(2)-1)*T;        % Time vector
 
Y = fft(x);
P2 = abs(Y/L(2));
P1 = P2(1:L(2)/2+1);
P1(2:end-1) = 2*P1(2:end-1);
 
f1 = Fs*(0:(L(2)/2))/L(2);
%% Plot
figure(2*3);
plot(f1,P1);
grid on;
title('FFT of the sine wave (Hann Window Applied)');
axis([0 50 0 1]);
xlabel('Frequency (Hz)');ylabel('Amplitude');
