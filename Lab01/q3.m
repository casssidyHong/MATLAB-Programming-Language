clc;

fprintf('Practices 3\n');
a = input('a: '); 
n = 1:100;  
terms = cumprod([1 a./n]);  
sum_series = sum(terms);
fprintf('cumprod: %.10f\n', sum_series);
fprintf('exp(a) = %.10f\n', exp(a));