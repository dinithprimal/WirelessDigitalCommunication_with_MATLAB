clc
clear all
close all

n = 0:35;
alpha = 1.2;
c = 0.2;

x = c*alpha.^n;

figure(1)
stem(n,x)
xlabel('Time/Discrete Intervals')
ylabel('real exponential wave')
grid on
title('Exponential Wave')