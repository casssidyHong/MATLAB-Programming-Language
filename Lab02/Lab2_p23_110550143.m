clc;

fprintf('Practice 2\n');

% Step 1 -> Change it into gray scale
IM = rgb2gray( imread( 'input.jpg' ) ); %same file with this file
figure;  
imshow(IM);

% Step 2 -> Allocate a vector of size 256 to store the histogram, as the pixel values are 0~255.
his = zeros(1, 256); %need to start from 1
for i = 0:255
    his(i+1) = sum(IM(:)==i);
end

% Step 3 -> Show what you calculate above
figure; % so it will not disapear
bar(0:255, his);
title('Calculate histogram');

% Step 4 -> imhist(IM, 256)
figure;
imhist(IM, 256);
title('IMhist histogram');

% Step 5 -> Compare
diff = his' - imhist(IM, 256);
figure;
bar(0:255, diff);
title('Compare (cal-imhist)');

clc;
fprintf('Practice 3\n');

% Step 1 -> normalize the histogram
% N = normalize(his);
N = his/sum(his);

% Step 2 -> compute w in one statement by using cumsum on H.
CDF = cumsum(N);

% Step 3 -> computes a mapping of pixel values
w = uint8( CDF * 255 );

% Step 4 -> apply the mapping to the image in one statement
IMM = w(double(IM)+1);
figure;
imshow(IMM);
title('contrast-adjusted images');

figure;
imshow(IM);
title('original');





