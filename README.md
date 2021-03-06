# Picasso^2 art


Detecting lines in Picasso's [Guernica](http://en.wikipedia.org/wiki/Guernica_(painting)) and making art of it. 


![alt tag](img/guernica.jpg)

1) First pass the gray scale version of the image though a Sobel filter to detect all the edges.

![alt tag](img/guernica_edge.png)

2) [Standar Hugh transform](http://en.wikipedia.org/wiki/Hough_transform) of the detected edges. The color represents the count of points in the edges that have given rho (distance from the origin) and theta (angle of the line). The peaks of this map correspond to straight lines in the original image.

![alt tag](img/guernica_hough.png)

3) After making it pretty and squaring the signature we get

![alt tag](img/guernica_hough_signature.png)