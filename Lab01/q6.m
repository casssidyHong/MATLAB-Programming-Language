clc;

fprintf('Practices 6\n');

x = 1:3;  
y = 4:6;

X = repmat(x, length(y), 1);
Y = repmat(y', 1, length(x));

disp('X matrix:');
disp(X);
disp('Y matrix:');
disp(Y);
