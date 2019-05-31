

[x, fs] = audioread('sunflower_slowed.mov');
sound(x,fs);

plot(x)
xlabel('Sample Number')
ylabel('Amplitude')%%


x = x(2.45e4:3.10e4); % tune this
t = 10*(0:1/fs:(length(x)-1)/fs);

plot(t,x)
xlabel('Time (seconds)')
ylabel('Amplitude')
xlim([0 t(end)])

m = length(x);          % original sample length
n = pow2(nextpow2(m));  % transform length
y = fft(x,n);           % DFT of signal

f = (0:n-1)*(fs/n)/10;
power = abs(y).^2/n;      

plot(f(1:floor(n/2)),power(1:floor(n/2)))
xlabel('Frequency')
ylabel('Power')
