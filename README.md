# Numerical-tools-and-procedures-for-oating-wind-farms-performances-and-stress-simulation
SOWFA, FAST and OpenFOAM codes for Floating Of-Shore Wind Turbines (FOWT) fields simulation

The aim of this thesis is to investigate and present some open-source software
for wind energy application. In particular the intention was to implement on
a super-computer all the simulation tools required for the analysis of floating
of-shore wind turbines (FOWT) as HydroDyn, OpenFAST and SOWFA.
The main result are procedures and guidelines to implement steady-wind and
real-wind simulations using the NREL 5 MW Reference turbine model and the
mentioned software. Those instruments are presented, explained and evaluated
for their possible application to on-shore, of-shore and deep-of-shore (floating)
wind farms. The simulation procedure is presented with many details regarding
scripts and variable declaration learned trough tens of debug runs.
The NREL 5 MW has been modelled together with the OC4 Semi-submersible
platform and the structure RAO has been investigated trough HydroDyn varying
the incoming wave direction. A spectral analysis has been made considering
more than 30 degrees of freedom and studying natural frequencies coupling respect
to perturbations on the platform displacements.
The same simulation set-up was used with both stand-alone SOWFA and SOWFA
coupled with OpenFAST and HydroDyn to study differences in the output precision.
Differences are produced by the aero-elastic behaviour of the turbine and
by the floating platform motion. In conclusion, this work provides deep comprehension
of already mentioned software capabilities and usage.
