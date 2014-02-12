addpath('~/Documents/MATLAB/image_tools/')
% TODO: Mark the maximums in the hough space

I = imread('img/guernica.jpg');
figure,imshow(I)

%% Get edges
Ig  = rgb2gray(I);
BW = edge(Ig, 'Sobel');
figure
imshow(BW)

%% Line hough transform
[H,theta,rho] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89.5);

figure,
imshow(imadjust(mat2gray(H)),'XData',theta,'YData',rho,...
      'InitialMagnification','fit');

xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot);

%% Circular hough transform

radii = 30:5:100;
h = circle_hough(BW, radii, 'same', 'normalise');

stackSlider(h)
