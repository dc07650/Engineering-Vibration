%% Engineering Vibration MATLAB
% Author: Won Bin Choi (B4)
% E-mail: dc07650@naver.com
% Organization: Sogang University(Korea, Republic of), Mechanical Engineering
% Date: May 27, 2021

%% Initialize
clear all; close all; clc;
%% rectImpulse (F: Amplitude, t: time)
[F, t] = rectImpulse(10,10,15);
%% Plot
plot(t,F)
xlim([0,15])
ylim([-1,15])