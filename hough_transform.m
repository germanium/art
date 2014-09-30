addpath('~/Documents/MATLAB/image_tools/')

I = imread('img/guernica.jpg');
figure,imshow(I)

%% Get edges

Ig  = rgb2gray(I);
BW = edge(Ig, 'Sobel');
figure
imshow(BW)

%% Line hough transform

[H,theta,rho] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89.5);

figure
imshow(imadjust(mat2gray(H)),'XData',theta,'YData',rho,...
      'InitialMagnification','fit');

xlabel('$\theta$ (degrees)', 'FontSize',30)    
ylabel('$\rho$ (pixels)', 'FontSize',30)
axis on normal 
ylim([-2000 max(rho)])
set(gca,'FontSize',16)
colormap(pink);

%% Find peaks

Nlines = 50;
P = houghpeaks(H, Nlines, 'threshold',ceil(0.3*max(H(:))));
x = theta(P(:,2));
y = rho(P(:,1));
hold on
plot(x,y,'s','color','black');

%% Plot lines corresponding to peaks

lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',7);

figure, imshow(I), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

%% Circular hough transform

radii = 30:5:100;
h = circle_hough(BW, radii, 'same', 'normalise');

stackSlider(h)
