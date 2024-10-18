clc;

fprintf('Practice 1\n(a) N*N Matrix\n');

n = input('n(must be odd): ');
A = zeros(n);
disp(A);

fprintf('(b) Distance to the center\n');
center = (n+1)/2;
[x, y] = meshgrid(1:n, 1:n);
D = sqrt((x - center).^2 + (y - center).^2); 
disp(D);


fprintf('(c) Inside the crcle\n');
r = input('r(r>0, can be a floating-point number): ');
A(D < r) = 1; 
disp(A);