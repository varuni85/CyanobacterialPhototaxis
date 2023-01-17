
%PACK_BALLS_CIRCLE Pack balls of a given radius within a circular region
%
%   This program packs N balls, each of radius R, randomly within a circle
%   of radius RAD, and centered at (MID_X, MID_Y) in a computational domain
%   of width LCOL.
%
%   Authors: P. Varuni & Shakti N. Menon
%
%   Reference:
%   Varuni P, Menon SN and Menon GI (2017)
%   Phototaxis as a Collective Phenomenon in Cyanobacterial Colonies. Sci Rep 7: 17799.
%   https://doi.org/10.1038/s41598-017-18160-w

function [x, y] = pack_balls_circle(N, r, Lcol, mid_X, mid_Y, RAD)

x = zeros(N,1);
y = zeros(N,1);

for n = 1:N
    distance = -1;
    while min( min( distance ) ) < 0
        
        % pick (x,y) randomly from the box [[0,LCOL],[0,LCOL]]
        x(n) = Lcol*rand;
        y(n) = Lcol*rand;
        
        % find distance of (x,y) from the centre of the circular region
        center_dist = sqrt( (x(n) - mid_X)^2 + (y(n) - mid_Y)^2 );
        
        if (center_dist < RAD ) % if (x,y) lies within the circle
            if n>2
                for i1 = 1:n
                    for j1 = 1:n
                        distance(i1,j1) = sqrt((x(i1)-x(j1))^2 + (y(i1)-y(j1))^2) - 2*r;
                    end
                end
                distance( diag(1:n) > 0 ) = 0;
            else
                distance = 1;
            end
        end
    end
end

end