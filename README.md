# Phototaxis as a Collective Phenomenon in Cyanobacterial Colonies

[![Paper DOI : https://doi.org/10.1038/s41598-017-18160-w](https://badgen.net/badge/Sci%20Rep%20DOI/10.1038%2Fs41598-017-18160-w)](https://doi.org/10.1038/s41598-017-18160-w)

A set of MATLAB codes that simulate a model for the motion of phototactic cyanobacterial cells, described in the manuscript:

> Varuni P, Menon SN and Menon GI (2017) Phototaxis as a Collective Phenomenon in Cyanobacterial Colonies. _Sci Rep_ <b>7</b>: 17799. 
> https://doi.org/10.1038/s41598-017-18160-w

This model uses an active matter framework to describe the forces experienced by individual cyanobacterial cells upon being subjected to a light source. It captures experimentally observed changes in colony morphology, namely dense finger-like projections that extend outwards from the colony towards the direction of the light source.

The repository contains the following files:


* ```cyano_main.m''' : main file (start here)

* ```set_parameters.m''' : sets parameters

* ```setup_colony.m''' : initializes a cyanobacterial colony, specifying the cell positions and slime content

* ```cyano_motion.m''' : simulates the motion of cyanobacterial cells

* ```determine_force.m''' : determines the force on each cell at each time point

* ```covered_area.m''' : finds the grid indices lying under a circle of specified radius

* ```pack_balls_circle.m''' : pack balls of a given radius within a circular region


The following table provides a description of the parameters specified in ```set_parameters.m''', and supplied to the function ```cyano_motion.m''':

| Variable | Description |
| --- | --- |
| N | the number of cells in the colony |
| RHO | the initial colony density |
| DTUG | max. tugging distance between cell edges |
| NTUG | the avg. no of cells that a cell can tug on |
| P_PHOT | the probility that cells move in direction of light |
| SPD0 | the initial speed of each cell (# body length/sec) |
| S0 | the initial slime content |
| RS | the rate at which slime is deposited |
| AMP | amplitude of force function |
| W | steepness of force function |
| CH_FRC | fraction of cheaters |
| LC | length of domain along columns |
| LR | length of domain along rows |
| CTYPE | colony type |
| NT | the total number of time steps |
| TRL | the trial number |

