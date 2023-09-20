clc
clear all
close all

n = -10:20;
u = [zeros(1,10) 1 zeros(1, 20)];

figure(1)
plot(n, u);
hold on;
stem(n, u)
xlabel('Time/Discrete Intervals');
ylabel('Unit Step Function');
ylim([-0.1 1.1])
title('Unit Impulse Response')
grid on
