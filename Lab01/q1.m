clc;

fprintf('Practices 1\n');

v = input('vector: ');

numerator = v(1)*v(4) + v(3)*v(2);
denominator = v(2)*v(4);

fprintf('%d/%d + %d/%d = %d/%d\n', v(1), v(2), v(3), v(4), ...
        numerator, denominator);
 