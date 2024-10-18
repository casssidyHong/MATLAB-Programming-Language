clc;

fprintf('Practices 4\n');
n = input('n: ');

A = eye(n);
A = A .* (1:+1:n)';

disp(A);
