%% Engineering Vibration MATLAB
% Author: Won Bin Choi (B4)
% E-mail: dc07650@naver.com
% Organization: Sogang University(Korea, Republic of), Mechanical Engineering
% Date: May 27, 2021

%% rectImpulse
% Function for creating rectangular impulse.
% t1: Impulse time [sec]
% Amp: Impulse amplitude [-]
% t_end: Total simulation time duration [sec]
function [F, t] = rectImpulse(t1, Amp, t_end)
    t = linspace(0,t_end,1000);
    F = zeros(1,length(t));
    for i = 1:length(t)
        if t(i) > t1
            F(i) = 0;
        else
            F(i) = Amp;
        end
    end
end