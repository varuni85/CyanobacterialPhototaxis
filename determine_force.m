
%DETERMINE_FORCE Find the total force experienced by all cells
%
%   Authors: P. Varuni & Shakti N. Menon
%
%   Reference:
%   Varuni P, Menon SN and Menon GI (2017)
%   Phototaxis as a Collective Phenomenon in Cyanobacterial Colonies. Sci Rep 7: 17799.
%   https://doi.org/10.1038/s41598-017-18160-w

function [Fx,Fy] = determine_force(x, y, dtug, n_tug, k1, k2)

N = length(x);
r = 1; % cell radius

% x and y components of the force on each cell
Fx = zeros(N,1);
Fy = zeros(N,1);

rand_mat = rand(N);

% c1 is the index of the cell that tugs on others (at most n_tug cells)
for c1 = 1:N
    tugged = 0;            % number of cells tugged by c1
    repelled = zeros(N,1); % whether a cell is repelled by c1
    
    % iterate through N randomly chosen cells c2
    for cnt = 1:N
        c2 = ceil( N * rand_mat(c1,cnt) );
        
        % distance between cells c1 and c2
        dist = sqrt( (x(c1)-x(c2))^2 + (y(c1)-y(c2))^2 );
        
        if dist < dtug % check if the cell pair (c1,c2) is within reach
            if n_tug ~= 0
                K = ( 1 + k1*(tanh(k2*(dist-2*r)) - 1) ) / n_tug; % force magnitude
            else
                K = 0;
            end
            
            if repelled(c2) == 0 && K < 0 % repulsion
                Fx(c2) = Fx(c2) + K * sign(x(c1) - x(c2));
                Fy(c2) = Fy(c2) + K * sign(y(c1) - y(c2));
                repelled(c2) = 1;
            elseif tugged < n_tug % attraction (if not enough attachments used)
                Fx(c2) = Fx(c2) + K * sign(x(c1) - x(c2));
                Fy(c2) = Fy(c2) + K * sign(y(c1) - y(c2));
                tugged = tugged + 1;
            end
        end
    end
end
end