clc;

rng(240926);

% Generate the sample points from a polynomial function plus small random numbers.
xi = -9:3:9;
yi = -.04 * xi.^2 + .1 * xi + 2 + 1 * (rand(1, length(xi)) - 0.5);

% At least do polynomials with degrees of 1, 2, and 4.
degrees = [1, 2, 4];  

figure;

for d = 1:length(degrees)
    r = degrees(d);  
    
    X = ones(length(xi), r + 1);  
    for i = 1:r
        X(:, i+1) = xi'.^i;  
    end
    
    % Use the matrix-division operator (\) to solve for the coefficients in minimum-squared-error manner.
    a = X \ yi';
    
    % For smoother outputs, sample x using a fine grid
    x_fit = -10:0.1:10;
    y_fit = zeros(size(x_fit));
    for i = 1:r+1
        y_fit = y_fit + a(i) * x_fit.^(i-1);
    end
    
    % caculate rms, display the root-mean-square (rms) error within each subplot.
    y_pred = X * a;
    rms_error = sqrt(mean((y_pred - yi').^2));
    
    % Plot them all in the same figure using subplot.
    subplot(1, length(degrees), d);
    plot(xi, yi, 'ro', 'MarkerSize', 8); 
    % Plot the sampled(xi,yi) pairs together with the estimated function.
    % You need to use hold on.
    hold on;
    plot(x_fit, y_fit, 'b-', 'LineWidth', 2);
    
    % add vertical line segments that connect the sample points and their predicted positions.
    for i = 1:length(xi)
        plot([xi(i), xi(i)], [yi(i), y_pred(i)], 'k--');
    end
   
    y_lim = ylim;
    
    % Use function sprintf to create the strings to display.
    text(-9, y_lim(1) - 0.1 * (y_lim(2) - y_lim(1)), sprintf('rms = %.3f', rms_error), ...
        'FontSize', 10, 'HorizontalAlignment', 'left');
    
    title(['Polynomial deg = ', num2str(r)]);
    xlabel('x');
    ylabel('y');
    grid on;
end

legend({'Sample Points', 'Fitted Polynomial'}, 'Location', 'southoutside');
