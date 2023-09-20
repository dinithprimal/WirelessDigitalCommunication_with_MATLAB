clc
clear all
close all

n = 0:0.5:40;       % Descrete Intervals
f1 = 0.1;           % Frequecny of the signal1
f2 = 0.2;           % Frequecny of the signal2
p1 = 0;             % Phase shift of the signal1
p2 = 2;             % Phase shift of the signal2
A1 = 1.5;           % Amplitude of the signal1
A2 = 1.2;           % Amplitude of the signal2

arg1 = 2*pi*f1*n + p1;      % Argument1
arg2 = 2*pi*f2*n + p2;      % Argument1

x1 = A1*sin(arg1);          % Modeling sinusoidal signal1
x2 = A2*sin(arg2);          % Modeling sinusoidal signal1

% Figure plotting
figure(1)
subplot(2,1,1)
plot(n,x1);
hold on;
stem(n,x1)
xlabel('Time/Discrete Intervals');
ylabel('Sinusoidal Signal');
ylim([-1.6 1.6])
title('Sinusoidal Signal1')
grid on

subplot(2,1,2)
plot(n,x2);
hold on;
stem(n,x2)
xlabel('Time/Discrete Intervals');
ylabel('Sinusoidal Signal');
ylim([-1.6 1.6])
title('Sinusoidal Signal2')
grid on



