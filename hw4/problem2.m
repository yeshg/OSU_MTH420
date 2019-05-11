close all;
clear all;
clc;

yg = imread('more_cropped.jpg');
gray_yg = rgb2gray(yg);
imshow(gray_yg);
db_gray_yg = double(gray_yg);
imshow(uint8(db_gray_yg));

% Decompose with SVD
[U,S,V]=svd(db_gray_yg);

% Arrays to record number of singular values (k) and error
dispEr = [];
numSVals = [];

for k=[5,10,25,50,75,100]
    figure();
    buffer = sprintf('Image output using %d singular values', k);
    
    % Construct and display image with singular values
    D = U(:,1:k)*S(1:k,1:k)*V(:,1:k)';
    imshow(uint8(D));
    
    % Compute error
    error=sum(sum((db_gray_yg-D).^2));
    
    % store vals for display
    dispEr = [dispEr; error];
    numSVals = [numSVals; k];
end

% dislay the error graph
figure; 
title('Error in compression');
plot(numSVals, dispEr);
grid on
xlabel('Number of Singular Values used');
ylabel('Error between compress and original image');