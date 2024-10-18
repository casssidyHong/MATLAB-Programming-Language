clc;

function [varargout] = randn2d(varargin)
    % RANDN2D Generate 2D normally distributed random numbers
    % Various forms:
    %   X = randn2d(n)
    %   X = randn2d(n,s,a,u)
    %   X = randn2d(n,C,u)
    %   X = randn2d(...,'plot')
    %   [X,Ct,ut] = randn2d(...)
    
    % Check number of input/output arguments
    narginchk(1, 5);
    
    % Check if last argument is 'plot'
    plot_flag = false;
    if nargin > 1 && ischar(varargin{end}) && strcmpi(varargin{end}, 'plot')
        plot_flag = true;
        varargin = varargin(1:end-1);
    end
    
    % Process input arguments based on their number
    switch length(varargin)
        case 1  % X = randn2d(n)
            n = varargin{1};
            validateattributes(n, {'numeric'}, {'scalar', 'positive', 'integer'});
            
            % standard normal distribution
            X = randn(n, 2);
            C = eye(2);
            u = [0 0];
            
        case 4  % X = randn2d(n,s,a,u)
            [n, s, a, u] = deal(varargin{:});
            
            validateattributes(n, {'numeric'}, {'scalar', 'positive', 'integer'});
            validateattributes(s, {'numeric'}, {'vector', 'numel', 2, 'positive'});
            validateattributes(a, {'numeric'}, {'scalar'});
            validateattributes(u, {'numeric'}, {'vector', 'numel', 2});
            
            X = randn(n, 2);
            
            % scaling
            X = X .* s;
            
            % rotation
            R = [cos(a) -sin(a); sin(a) cos(a)];
            X = X * R;
            
            % covariance matrix for output
            C = R * diag(s.^2) * R';
            
        case 3  % X = randn2d(n,C,u)
            [n, C, u] = deal(varargin{:});
            
            validateattributes(n, {'numeric'}, {'scalar', 'positive', 'integer'});
            validateattributes(C, {'numeric'}, {'size', [2 2]});
            validateattributes(u, {'numeric'}, {'vector', 'numel', 2});
            
            % symmetric
            if ~isequal(C, C')
                error('Covariance matrix must be symmetric');
            end
            
            % positive eigenvalues
            [V, D] = eig(C);
            if any(diag(D) <= 0)
                error('Covariance matrix must have positive eigenvalues');
            end
            
            % eigendecomposition
            X = randn(n, 2) * sqrt(D) * V';
            
        otherwise
            error('Invalid number of input arguments');
    end
    
    % Add mean/displacement
    X = X + u;
    
    % Generate output arguments
    if nargout == 3
        % Calculate sample statistics if requested
        Ct = cov(X);
        ut = mean(X);
        varargout = {X, Ct, ut};
    else
        varargout = {X};
    end
    
    % Plot if requested
    if plot_flag
        figure;
        scatter(X(:,1), X(:,2), '.');
        grid on;
        axis equal;
        title('2D Normal Distribution Samples');
        xlabel('X');
        ylabel('Y');
    end
end
