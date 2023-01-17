
%SETUP_COLONY Initialize a cyanobacterial colony
%
%   This function sets up a cyanobacterial colony with N cells, each of
%   radius R, and outputs their positions (X,Y) in a computational domain
%   of width LCOL and height LROW. In addition, slime is uniformly
%   allocated over the extent of a region of shape specified by
%   COLONY_TYPE, i.e. every grid point in this region is assigned a value
%   of S0. The options for COLONY_TYPE are 'FLAT' and 'CIRCLE'.
%
%   Authors: P. Varuni & Shakti N. Menon
%
%   Reference:
%   Varuni P, Menon SN and Menon GI (2017)
%   Phototaxis as a Collective Phenomenon in Cyanobacterial Colonies. Sci Rep 7: 17799.
%   https://doi.org/10.1038/s41598-017-18160-w

function [x,y,slime] = setup_colony(N, r, Lr, Lc, S0, rho, colony_type)

slime = zeros( Lr, Lc );
    
if strcmp(colony_type,'flat')
    
    Ls = ceil(N/(Lc*rho));  % length of the colony (i.e. slime extent)
    x = rand(N,1)*Ls;       % initial (random) x-positions of cells
    y = rand(N,1)*Lc;       % initial (random) y-positions of cells
    slime(1:Ls, :) = S0;

elseif strcmp(colony_type,'circle')

    dish_midx = 0.50*Lc;    % center of the colony (x-position)
    dish_midy = 0.50*Lc;    % center of the colony (y-position)
    dish_rad  = sqrt(N/(pi*rho)); % radius of the colony
    
    [x, y] = pack_balls_circle(N, r, Lc, dish_midx, dish_midy, dish_rad);

    slime = zeros( Lr, Lc );
    indices   = covered_area(Lr, Lc, dish_midy, dish_midx, dish_rad);
    slime(indices) = S0;

end

end