%% (A) Recall that in u(t)= R sin(2*pi*f - sigma),
% R is the amplitude
% f is the frequency
% sigma is the phase
% Fourier analysis (with fft) helps us determine R, f, and sigma. 
% Recall that when converting u(t) to the complex form, we have sin(theta)=1/2i (exp(i*theta)-exp(-i*theta)).
% In the FFT/DFT/Fourier analysis you will therefore have the same (redundant=symmetric) information about R,f, and sigma, in two parts of the spectrum: that corresponding to exp(i*theta), and to exp(-i*theta).
% That is why we can truncate some of the data. Also, recall that cos(theta) = sin(theta+pi/2).

Fs = 1000; 
t=linspace(0,1-1/Fs,Fs); 
x=7*sin(2*pi*20*t-0.3); 
length(x)
X = fft(x); 
plot(abs(X)/500) 

%%

t = 0:1/50:10-1/50;                     
x = 30*sin(2*pi * t) + 15*sin(pi * t) + 60*sin(2*pi/3 * t) + 15*sin(pi/4 * t);
plot(t,x)

pause;

y = fft(x);     
f = (0:length(y)-1)*50/length(y);

plot(f,abs(y))
title('Magnitude')


%% (B) Now consider an experiment that will help you understand how fft and ifft work. The use of MATLABs functions abs and angle helps to determine the magnitude and argument of a complex number. Together, (by Euler formula), they give you this number back. 
t = linspace(0,1); 
f = exp(-0.1*t).*t.^2+0.3*rand(size(t)); %%% some chaotic looking signal 
plot(t,f); pause;
ft = fft(f); 
ift = abs(ft).*exp(i*angle(ft));
ff = ifft(ift); 
plot(t,f,'k',t,ff,'*',t,ifft(ft),'r-') %% plot original, and de-re-assembled signals 
% So you have seen how a complex signal f is analyzed and "coded" in ft, then reassembled as ift, and then brought back as ff, or via ifft(ft)


%% (C) Now we use Fourier analysis in 2D.
% We will need first to understand the Fourier basis functions in 2D.
% Recall in one dimension and on the interval (0,1), these were sin(n*pi*x).
% Now on the unit square R=(0,1) x )(0,1), the Fourier basis functions are sin(n*pi*x)*sin(m*pi*y)
% (With general boundary conditions also cosines need to be included).

[xx,yy]=meshgrid(linspace(0,1),linspace(0,1)); 
n=3;m=5;surfc(xx,yy,sin(pi*n*xx).*sin(m*pi*yy))

%% (D) Now we use Fourier analysis of images.
% Images in JPG and PNG (and some other formats) are nothing but the arrays of numbers (integers or double format reals), which give information about the pixel colors/grayscale level. Fourier analysis encodes the information about the images by getting the "spectral" information (amplitudes, angles, phases) for all the components of an image. We will use fft2 and ifft2. 
% Note that Fourier analysis requires real numbers, but that the image display requires (unsigned) integers. 
% We will use MATLAB's functions double() and uint8 to convert between these types. Fourier analysis helps to encode information about images, and/or to compress/encode and decompress/decode this information.

close all

% First, download sdragon.png and ssunset.png. After you have downloaded them, proceed with the analysis. 
sdragon = imread('smoke.jpg');imagesc(sdragon);
ssunset = imread('ezio.jpg');imagesc(ssunset);colormap gray
size(sdragon), size(ssunset)

% perform FFT in 2D using MATLAB's fft2  
fftD = fft2(double(sdragon)); 

% check that you have the same image as original 
imD = abs(fftD).*exp(i*angle(fftD));
imDD = ifft2(imD);
imagesc(uint8(abs(imDD))); pause;

% repeat for the sunset image 

fftS = fft2(double(ssunset)); 
 
% ... check that you can get the sunset image back ?
imS = abs(fftS).*exp(i*angle(fftS));
imSS = ifft2(imS);
imagesc(uint8(abs(imSS))); pause;
 
% Now mix the frequencies and amplitudes of the "dragon" and "sunset" for an "artistic" image 
figure();
im = abs(fftS).*exp(i*angle(fftD));
imART = ifft2(im);
imagesc(uint8(abs(imART))); 

figure();
im = abs(fftD).*exp(i*angle(fftS));
imART = ifft2(im);
imagesc(uint8(abs(imART))); 

% Which one is more attractive ?