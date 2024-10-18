% P2_110550143.m
% Author: 洪巧芸
% Student ID: 110550143
% Assignment: Assignment #2
% Topic: Normal Distribution and Mahalanobis Distance

% Clear all variables and console
clc;  % Clear command window (console) output

% ===== 1. Create the samples =====
% Set the attributes for generating samples
N = 100; % Number of samples
theta = 20 * pi / 180; % Rotation angle in radians (20 degrees)

% Scaling factors for x and y directions
scale_x = 120;  % Scaling factor for x-axis
scale_y = 50;   % Scaling factor for y-axis
translation = [400, 300]; % Translation vector for shifting the samples

% Start by using `randn` to generate initial x and y coordinates of N points 
% `randn` creates normally distributed samples with zero mean and unit standard deviation
x = randn(N, 2);  % Generate N samples with 2 columns representing x and y coordinates

% Create a matrix of rotation and scaling transformation
% R represents the rotation matrix, which rotates the points by `theta` radians
% S represents the scaling matrix, which scales the x and y values
R = [cos(theta) -sin(theta); sin(theta) cos(theta)]; % Rotation matrix
S = [scale_x 0; 0 scale_y];  % Scaling matrix
T = R * S;  % Combined transformation matrix with both rotation and scaling

% Apply the desired rotation, scaling, and translation to these points 
% to generate samples of a general 2D normal distribution
x_transformed = (x * T') + translation;  % Apply transformation and translation

% ===== 2. Compute the mean and covariance matrix of the samples =====
% The mean represents the center of the distribution, while covariance defines its shape
mean_x = mean(x_transformed);  % Compute the mean of the transformed samples
cov_x = cov(x_transformed);  % Compute the covariance matrix of the transformed samples

% Create a dense 2D grid of points using `meshgrid` for visualization
[x_grid, y_grid] = meshgrid(linspace(min(x_transformed(:,1))-50, max(x_transformed(:,1))+50, 100), ...
                            linspace(min(x_transformed(:,2))-50, max(x_transformed(:,2))+50, 100));
grid_points = [x_grid(:) y_grid(:)]; % Convert grid points to column vector format for calculations

% ===== 3. Mahalanobis distance computation =====
% Mahalanobis distance is a measure of the distance between a point and a distribution
% It takes into account the covariance of the data points
% Formula: sqrt((x - mean_x) * inv(cov_x) * (x - mean_x)')
% Calculate Mahalanobis distance for each point in the grid
mahalanobis_distance = sqrt(sum((grid_points - mean_x) / cov_x .* (grid_points - mean_x), 2));

% Reshape the Mahalanobis distance into the grid format for visualization
mahalanobis_distance_grid = reshape(mahalanobis_distance, size(x_grid));

% Create a pseudo-color visualization of the Mahalanobis distance distribution using `imagesc`
% `imagesc` creates a color-scaled image of the matrix `mahalanobis_distance_grid`
imagesc(linspace(min(x_transformed(:,1))-50, max(x_transformed(:,1))+50, 100), ...
        linspace(min(x_transformed(:,2))-50, max(x_transformed(:,2))+50, 100), mahalanobis_distance_grid);
colormap('summer');  % Use color space 'summer' for visualization
colorbar;  % Display color bar to show value mapping of colors
hold on;  % Keep the current figure active for additional plotting

% ===== 4. Draw the contours =====
% Use `contour` to generate the contours of several Mahalanobis distances
% The contour levels are set to [0.5 1 2], representing Mahalanobis distance values
[C, h] = contour(x_grid, y_grid, mahalanobis_distance_grid, [0.5 1 2], 'LineWidth', 1.5, 'LineColor', 'k'); 
% Apply `clabel` to add labels to the contours, showing the contour values
clabel(C, h, 'FontSize', 12, 'Color', 'k');  % Set label font size and color

% ===== 5. Display additional items =====
% Plot the transformed sample points
plot(x_transformed(:,1), x_transformed(:,2), 'b.', 'MarkerSize', 12);  % Plot sample points as blue dots

% Plot the mean of the transformed samples using a red star marker
plot(mean_x(1), mean_x(2), 'rp', 'MarkerSize', 12, 'MarkerFaceColor', 'r');  % Plot mean point as a red star

% Create a legend to label sample points and mean point
legend('Sample Points', 'Mean Point');

% Set x-axis and y-axis labels
xlabel('X-axis');  % Label for x-axis
ylabel('Y-axis');  % Label for y-axis

% Set title for the plot
title('Normal Distribution and Mahalanobis Distance');

% Ensure the y-axis direction is upwards (default in most cases)
set(gca, 'YDir', 'normal'); 

% Set equal scaling for both axes to maintain aspect ratio
axis equal;  % Make x and y axes equally scaled
hold off;  % Release the hold on the current figure

% ===== Save the image =====
% drawnow;  
% saveas(gcf, 'Normal_Distribution_Visualization.png');  
