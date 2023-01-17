
%   Authors: P. Varuni & Shakti N. Menon
%
%   Reference:
%   Varuni P, Menon SN and Menon GI (2017)
%   Phototaxis as a Collective Phenomenon in Cyanobacterial Colonies. Sci Rep 7: 17799.
%   https://doi.org/10.1038/s41598-017-18160-w

set_parameters;

[x,y,S] = setup_colony(N, r, Lr, Lc, S0, rho, ctype);
fprintf('The colony and parameters are set. Starting simulation...\n');

cyano_motion(N, x, y, S, r, rho, dtug, ntug, p_phot, spd0, S0, rS, amp, w, ch_frc, Lc, Lr, ctype, nt, trl)