
%SET_PARAMETERS Set the parameter values needed for the cyanobacteria
%colony program
%
%   Running this script will generate all parameter values needed for the
%   cyanobacterial colony program CYANO_MOTION.
%
%   Authors: P. Varuni & Shakti N. Menon
%
%   Reference:
%   Varuni P, Menon SN and Menon GI (2017)
%   Phototaxis as a Collective Phenomenon in Cyanobacterial Colonies. Sci Rep 7: 17799.
%   https://doi.org/10.1038/s41598-017-18160-w

% Cell properties
N = 500;        % number of cells
r = 1;          % radius of each cell
rho = 0.05;     % packing density rho = N/(Lc*Ls)
dtug  = 4.0*r;  % max. tugging distance btwn. cell edges (appendage length)
ntug  = 4.00;   % avg. # cells that a cell can tug on (appendages per cell)
p_phot = 0.1;   % probility that cells move in direction of light
spd0  = 0.1*r;  % the initial speed of each cell
S0   = 1e3;     % initial amount of slime of all grid points in the colony
rS   = 0.1;     % slime secretion rate (slime units deposited per second)
amp   = 1.00;   % force parameter 1
w     = 2.00;   % force parameter 2
ch_frc = 0.0;   % fraction of cheaters

% Colony shape (choices: "flat", "circle")
ctype = 'circle';

% Grid layout
Lc = 150;       % length of domain along columns
Lr = 2*Lc;      % length of domain along rows

% Iteration procedure
tf = 5.0e4;     % final value of t
dt = 1;         % timestep
nt = tf/dt;     % number of timesteps
trl = 1;        % trial number
