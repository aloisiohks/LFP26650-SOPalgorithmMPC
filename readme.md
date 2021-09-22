# A123_26650_StateOfPowerEstimation_MPC

This repository contains the MPC-based lithium-ion battery state of power estimation algorithm for the A123 26650 m1b cell developed and used in the following publication

<a href="https://mountainscholar.org/handle/10976/167269">Kawakita de Souza, A. (2020). Advanced Predictive Control Strategies for Lithium-Ion Battery Management Using a Coupled Electro-Thermal Model [Master thesis, University of Colorado, Colorado Springs]. ProQuest Dissertations Publishing.</a>

- This software uses Model Predictive Control(MPC) to enforce constraints on current, voltage and temperature during charging. 
- The underlying model of this MPC-based algorithm is a coupled electro-thermal (CET) model developed in thesis above. The details of the CET model is presented below. The CET model can be parameterized using the <a href="https://data.mendeley.com/datasets/p8kf893yv3/1">A123 26650 dataset</a> . For details about the model parameterization see the <a href="https://mountainscholar.org/handle/10976/167269">thesis</a>.<br/>
- mainMPC.m is the main file to run the MPC algorithm



<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_1.png"><img src="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_1.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_2.png"><img src="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_2.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_3.png"><img src="https://github.com/aloisiohks/A123_26650_SPKF/blob/main/material/Snip_3.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip1.png"><img src="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip1.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip2.png"><img src="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip2.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip3.png"><img src="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip3.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip4.png"><img src="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip4.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip5.png"><img src="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip5.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip6.png"><img src="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip6.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip7.png"><img src="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip7.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip8.png"><img src="https://github.com/aloisiohks/A123_26650_MPCcharging/blob/main/slides/Snip8.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_StateOfPowerEstimation_MPC/blob/main/slides/Snip9.png"><img src="https://github.com/aloisiohks/A123_26650_StateOfPowerEstimation_MPC/blob/main/slides/Snip9.png" width="900" height="400"/></a>
</p>

<p align="center">
 <a href="https://github.com/aloisiohks/A123_26650_StateOfPowerEstimation_MPC/blob/main/slides/Snip10.png"><img src="https://github.com/aloisiohks/A123_26650_StateOfPowerEstimation_MPC/blob/main/slides/Snip10.png" width="900" height="400"/></a>
</p>

References:<br/>
[1] G. L. Plett, Battery Management Systems, Volume 1: Battery Modeling. Artech House, 2015.<br/>
[2] X. Lin, H. E. Perez, S. Mohan, J. B. Siegel, A. G. Stefanopoulou,Y. Ding, and M. P. Castanier, “A lumped-parameter electro-thermal model for cylindrical batteries,”Journal of PowerSources, vol. 257, pp. 1–11, Jul. 2014.<br/>
[3] G. L. Plett, Battery Management Systems, Volume 2: Equivalent-Circuit Methods. Artech House, 2015.<br/>
[4] M. A. Xavier and M. S. Trimboli, “Lithium-ion battery cell-level control using constrained model predictive control and equivalent circuit models,” Journal of Power Sources, vol. 285, pp. 374–384, 2015. <br/>
 
