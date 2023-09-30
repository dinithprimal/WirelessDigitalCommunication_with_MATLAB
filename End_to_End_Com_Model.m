%% End-to-End Communication Model

clc;
clear all;
close all;

%% Signal Generation

f = 1000;           % Frequency
harm = [1 0.5 2 1]; % Hramonics
amp = [1 2 3 1];    % Amplitude levels

max_freq = max(f*harm); % Maximum Frequency
min_freq = min(f*harm); % Minimum Frequency
system_freq = 20*max_freq;  % Sampling Frequency
system_sampling_rate = 1/system_freq;   % Sampling Rate

range = 2/min_freq;
t = 0:system_sampling_rate:range;

% Generate the signal
msg = zeros(size(t));

for k = 1:length(harm)
    msg = msg + amp(k)*sin(2*pi*harm(k)*f*t);
end

figure(1)
plot(t,msg,'r')


%% Sampling

nwMsg = msg ;%+ max(msg);

n_sample = 5;
samp_freq = n_sample*max_freq;  % Sample Frequency

sample_msg = zeros(size(t));
samp_steps = 1:system_freq/samp_freq:length(t);

sample_msg(1:system_freq/samp_freq:length(t)) = nwMsg(1:system_freq/samp_freq:length(t));


%% Quantization

no_of_levels = 4;
quantile = (max(sample_msg)-min(sample_msg))/no_of_levels;
code = min(sample_msg):quantile:max(sample_msg);

for k = 1:length(code)
    values = (sample_msg > (code(k) - quantile/2) & sample_msg < (code(k) + quantile/2));
    mq(values) = round(code(k));
end

clear values;

%% Encoding

mq1 = mq - min(mq);

bits = de2bi(mq1(1:system_freq/samp_freq:length(t)),4,'left-msb');

bits = bits(:)';

%% Pass Band Modulation

fc = 1e6;   % 1MHz of Frequency
nsamp = 10;
ncyc = 2;

tb = 0:1/(fc*nsamp):ncyc/fc;
t_tran = 0:1/(fc*nsamp):(ncyc*length(bits))/fc+(length(bits)-1)/(fc*nsamp);
mod_sig = zeros(size(t_tran));
l=1;
for k = 1:length(tb):length(mod_sig)
    if (bits(l)==1)
        mod_sig(k:k+length(tb)-1)=cos(2*pi*fc*tb);
    else
        mod_sig(k:k+length(tb)-1)=-cos(2*pi*fc*tb);
    end
    l = l + 1;
end

%% AWGN Transmittion

tran_signal = awgn(mod_sig, 10);

%% Receiver Filter

f_freq = -(fc*n_sample)/2:(fc*n_sample)/length(t_tran):(fc*n_sample)/2-(fc*n_sample)/length(t_tran);

f_tran = fft(tran_signal);

f_rece = zeros(size(f_tran));
fir = (f_freq<-3*fc | f_freq>3*fc);
f_rece(fir) = f_tran(fir);
f_rece(~fir) = 0.5*f_tran(~fir);
t_rece = ifft(f_rece);


%% Plotting
figure(1)
subplot(4,2,1)
plot(t,msg,'r')
grid on

subplot(4,2,2)
plot(t,nwMsg,'r')
hold on
stem(t,sample_msg,'b')
grid on
stem(t, mq, 'r*')

subplot(4,2,3)
stem(bits, 'm*')

subplot(4,2,4)
plot(t_tran, mod_sig, '.-b', t_tran, tran_signal,'r');
axis([0 20*ncyc/fc -2 2])
grid on
title('Transmitted Signal and Noise (AWGN) added Recived Signal')
legend('Transmitted Signal', 'Recieved Signal')

subplot(4, 2, 5)
plot(f_freq, fftshift(f_tran), f_freq, fftshift(mod_sig));
xlabel('Frequency')
ylabel('Signal Amplitude')
legend('Received Signal', 'Modulated Signal')

subplot(4,2,6)
plot(t_tran,t_rece)
grid on
xlabel('time')
ylabel('Received Signal')