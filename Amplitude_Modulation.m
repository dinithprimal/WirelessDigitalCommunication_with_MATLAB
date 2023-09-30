%% AM Signal

clc;
clear all;
close all;

n = 1:0.1:100;      % Steps

m = 0.4;        % Modulation Index
fh = 0.5;       % High Frequency
fl = 0.01;      % Low Freqency

xh = sin(2*pi*fh*n);
xl = sin(2*pi*fl*n);

y = (1 + m*xl).*xh;

figure(1)

subplot(3, 1, 1)
plot(n, xl)
grid on;
xlabel('Time')
ylabel('Amplitude')
title('Message siganl')

subplot(3, 1, 2)
plot(n, xh)
grid on;
xlabel('Time')
ylabel('Amplitude')
title('Carrier siganl')

subplot(3, 1, 3)
plot(n, y)
grid on;
xlabel('Time')
ylabel('Amplitude')
title('Amplitude Modulated siganl')