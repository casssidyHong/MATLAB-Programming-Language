clc;

function tmp = meann(v, a, b)
    avg = mean([v(a), v(b)]);
    if mod(avg, 1)==0
        tmp = round(avg);
    else
        tmp = avg;
    end
end

fprintf('Practices 5\n');
v = input('vector: ');

len = length(v);
len = len * 2 - 1;
result = zeros(1, len);

result(1:2:end) = v;
% result(2:2:end) = meann(v, 1:end-1, 2:end);
result(2:2:end) = (v(1:end-1)+ v(2:end)) / 2;

% fprintf('[');
disp(result);

% while i < len + 1
%     if mod(i, 2) == 1  
%         fprintf('%d', v((i + 1) / 2));
%     else
%         before = i-1;
%         after = i+1;
%         avg = mean([v((before+1)/2), v((after+1)/2)]);
%         if mod(avg, 1)==0
%             fprintf(' %d ', avg); 
%         else
%             fprintf(' %.1f ', avg);
%         end
%     end
%     i = i + 1;
% end
% 
% fprintf(']\n');  % 打印换行符
