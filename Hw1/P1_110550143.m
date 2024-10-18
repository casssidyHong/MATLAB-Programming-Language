clc;

% Use imread to load image files
Source = imread('input1_110550143.jpg'); 
Overlay = imread('input2_110550143.png'); 

% Because my source image will not be in the write position
% so I rotate it -90 to make it correct
Source = imrotate(Source, -90); 
Overlay = imrotate(Overlay, 30);

% set the position of starting overlay I want
start_row = 2220; 
start_col = 1700; 

% Create a 2D logical array based on some conditions on the pixel colors of B.
% -> if the color in Overlay image is red, it'll be set as 1
% :,: -> all rows, all columns
% 1,2,3 -> R,G,B
mask = Overlay(:,:,1) > 150 & Overlay(:,:,2) < 100 & Overlay(:,:,3) < 100; 

% record the coordinates of 'true'
[rows, columns] = find(mask);

% move the rows and columns to the position I want
rows_shifted = rows + start_row - 1;
columns_shifted = columns + start_col - 1;

% check whether the position is out of the source image
valid_indices = rows_shifted <= size(Source, 1) & columns_shifted <= size(Source, 2);
rows_shifted = rows_shifted(valid_indices);
columns_shifted = columns_shifted(valid_indices);
rows = rows(valid_indices);
columns = columns(valid_indices);

% Compute the linear indices of the target elements in A, and then do the copying.
% Do each color one by one
for color = 1:3
    Sc = sub2ind(size(Source), rows_shifted, columns_shifted, color * ones(size(rows_shifted)));
    Ov = sub2ind(size(Overlay), rows, columns, color * ones(size(rows)));
    
    % Overlaying Source image
    Source(Sc) = Overlay(Ov);
end

% Show the image after Overlaying
imshow(Source);

% Save the image
imwrite(Source, 'output_110550143.jpg');
