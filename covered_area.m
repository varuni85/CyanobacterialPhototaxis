
%COVERED_AREA Grid indices lying under a specified circle
%
%   This function finds the indices of a grid with LROW rows and LCOL
%   columns that lie below a circle of radius RAD. The coordinates of the
%   center of the circle are specified by X and Y.
%
%   Authors: P. Varuni & Shakti N. Menon
%
%   Reference:
%   Varuni P, Menon SN and Menon GI (2017)
%   Phototaxis as a Collective Phenomenon in Cyanobacterial Colonies. Sci Rep 7: 17799.
%   https://doi.org/10.1038/s41598-017-18160-w

function indices = covered_area(Lrow, Lcol, x, y, rad)

x = ceil(x); y = ceil(y); rad = ceil(rad);

% indices under a square extending from (-rad,-rad) to (rad,rad)
[mx, my] = meshgrid(-rad:rad, -rad:rad);
L_box = length(-rad:rad); % box length
mx = reshape(mx, L_box^2, 1);
my = reshape(my, L_box^2, 1);

% indices under a circle centered at (0,0) with radius rad
D = sqrt( mx.^2 + my.^2 );
circ = find(D < rad);
mx = mx(circ); my = my(circ);

Li = length(mx);  % number of indices per circle
Lc = length(x);   % number of circles
L  = Li*Lc;       % total number of indices under circles

[Ax, Bx] = meshgrid(mx, x);
[Ay, By] = meshgrid(my, y);

Sx = reshape(Ax', L, 1) + reshape(Bx', L, 1);
Sy = reshape(Ay', L, 1) + reshape(By', L, 1);

indices = sub2ind([Lrow Lcol], Sx, Sy);

end