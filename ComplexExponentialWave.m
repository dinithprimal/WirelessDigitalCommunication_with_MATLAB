clc
clear all;
close all;

n = 0:0.5:100;

omega = 0.15;
phi = pi/4;
c = ((omega.*n)+phi);
A = 2;

x = A*exp(i*c);

real_x = real(x);
imag_x = imag(x);

figure(1)
subplot(2,1,1)
stem(n, real_x);
xlabel('Time/Discrete Intervals')
ylabel('Real Exponential Wave')
title('Real Part')

subplot(2,1,2)
stem(n, imag_x);
xlabel('Time/Discrete Intervals')
ylabel('Imaginary Exponential Wave')
title('Imaginary Part')


