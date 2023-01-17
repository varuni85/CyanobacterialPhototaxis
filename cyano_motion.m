
%CYANO_MOTION Cell motion within (and out of) a cyanobacterial colony
%
%   This is the central function for the simulation of the collective
%   motion of cells in a cyanobacterial colony under the influence of an
%   external light source.
%
%   Authors: P. Varuni & Shakti N. Menon
%
%   Reference:
%   Varuni P, Menon SN and Menon GI (2017)
%   Phototaxis as a Collective Phenomenon in Cyanobacterial Colonies. Sci Rep 7: 17799.
%   https://doi.org/10.1038/s41598-017-18160-w
%
%   --------------------------------------------------------------------
%   The following inputs are required:
%
%   N           the number of cells in the colony
%   X, Y        positions of the cells
%   S           matrix representing the slime
%   R           radius of an individual cell
%   RHO         the initial colony density
%   DTUG        the maximum tugging distance between cell edges
%   NTUG        the avg. no of cells that a cell can tug on
%   P_PHOT      the probility that cells move in direction of light
%   SPD0        the initial speed of each cell
%   S0          the initial slime content
%   RS          the rate at which slime is deposited
%   AMP         amplitude of force function
%   W           steepness of force function
%   CH_FRC      fraction of cheaters
%   LC          length of domain along columns
%   LR          length of domain along rows
%   CTYPE       colony type
%   NT          the total number of time steps
%   TRIAL       the trial number
%
%   The function saves the positions of all cells and the slime content
%   across the domain at intervals specified by REC_VAL_STAT and
%   REC_VAL_SLIM respectively
%

function cyano_motion(N, x, y, S, r, rho, dtug, ntug, p_phot, spd0, S0, rS, amp, w, ch_frc, Lc, Lr, ctype, nt, trl)

fname = sprintf('N_%d_rho_%1.3f_dtug_%1.2f_ntug_%1.2f_pphot_%1.2f_spd_%1.2f_rS_%1.2f_amp_%1.2f_w_%1.2f_ch_%1.2f_#%02d',...
                    N,     rho,       dtug,      ntug,       p_phot,   spd0,    rS,       amp,    w,      ch_frc,  trl);

gamma0 = (1/spd0);        % initial inverse of speeds
gamma = gamma0*ones(N,1); % initialize frictions

%------------------------Decide on the cheaters------------------------%
rnpick = (1-eps)*rand(N,1);  % N uniformly distributed random numbers  %
non_cheaters = 1 - floor( rnpick + ch_frc );                           %
fname0 = strcat('nc_',fname,'.dat');                                   %
fid0   = fopen(fname0,'w');                                            %
fprintf(fid0,'%f ', non_cheaters); fprintf(fid0,'\n');                 %
%----------------------------------------------------------------------%

ANG = 0;

% times at which we record the cell positions and slime
rec_val_stat = 5e2:5e2:nt;
rec_val_slim = 1e3:1e3:nt;


cnt = 1; cnt2 = 1; % counters
for t1 = 1:nt
    if mod(t1,1e3)==0
    	fprintf('iteration #%d\n',t1);
    end

    % only non-cheaters can sense light direction
    % cheaters hence have pphot = 0
    pphot = p_phot * non_cheaters;

    % pick N uniformly distributed random numbers in the range [0,1]
    rnpick = (1-eps)*rand(N,1);
    toss = floor( rnpick + pphot );
    
    % move in light direction if toss = 1
    % move in random direction if toss = 0

    % each cell selects a direction
    TH = (1-toss).*2*pi.*rand( size(toss) ) + ANG.*toss.*sign(rand( size(toss) ) - 0.5);

    [Fx_ext, Fy_ext] = determine_force(x, y, dtug, ntug, amp, w);

    %_____update the positions of all cells______%
    F_int = 1; % "internal" force                %
    x1 = x + ( F_int*cos(TH) +  Fx_ext )./gamma; %
    y1 = y + ( F_int*sin(TH) +  Fy_ext )./gamma; %
                                                 %
    % prevent cells from leaving the box         %
    if ~isempty(find(x1 > Lr, 1)); break; end;   %
    x1( x1 < 1 ) = 1;                            %
    y1( y1 < 1 ) = 1; y1( y1 > Lc ) = Lc;        %
    %- - - - - - - - - - - - - - - - - - - - - - %

    % find locations of cells on the lattice
    indx = sub2ind( size(S), ceil(x1), ceil(y1) );

    % increment slime on lattice
    S(indx) = S(indx) + rS;

    % update cell speeds
    gamma = gamma0 * (S0 ./ S(indx));

    % save data
    if t1 == rec_val_stat(cnt)
        fname1 = strcat('stats_',fname,sprintf('_%02d.dat',t1));
        fid1   = fopen(fname1,'w');
        fprintf(fid1,'%f ', x); fprintf(fid1,'\n');
        fprintf(fid1,'%f ', y); fprintf(fid1,'\n');
        fclose(fid1);
        cnt = cnt + 1;
    end
    if t1 == rec_val_slim(cnt2)
        fname2 = strcat('slime_',fname,sprintf('_%02d.dat',t1));
        fid2   = fopen(fname2,'w');
        fprintf(fid2,'%f ', reshape(S,size(S,1)*size(S,2),1));
        fclose(fid2);
        cnt2 = cnt2 + 1;
    end
    x = x1; y = y1;
end

fprintf('Data collected\n');

end
