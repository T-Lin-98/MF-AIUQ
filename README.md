# MF-AIUQ

**Model-Free Ab Initio Uncertainty Quantification for Scattering Analysis of Microscopy**

[![R](https://img.shields.io/badge/R-%E2%89%A54.2-276DC3?logo=r&logoColor=white)](https://www.r-project.org/)
[![AIUQ](https://img.shields.io/badge/AIUQ-CRAN-1F6F8B)](https://cran.r-project.org/package=AIUQ)
[![Paper](https://img.shields.io/badge/arXiv-2605.29424-B31B1B)](https://arxiv.org/abs/2605.29424)

Model-Free *ab initio* uncertainty quantification (MF-AIUQ) estimates mean squared displacement (MSD) and its uncertainty directly
from microscopy videos with uncertainty quantification. The estimated MSD can be used to compute the storage
and loss moduli through the generalized Stokes–Einstein relation.


## Overview

This repository provides code to reproduce the simulation and experimental results in the
paper [Paper](https://arxiv.org/abs/2605.29424). The MF-AIUQ method is implemented in the
[`AIUQ`](https://cran.r-project.org/package=AIUQ) R package. 

· [Installation](#installation)
· [Quick start](#quick-start)
· [Tutorial](tutorials/MF_AIUQ.Rmd)
· [Reproduce results](#reproducing-the-results)
· [Data](#data-availability)
· [Citation](#citation)



- Brownian, fractional Brownian, Ornstein–Uhlenbeck, and mixed-process
  simulations;
- PVA microscopy experiments;
- PEG hydrogel microscopy experiments; and
- snail mucin MSD and microrheology analysis.


## Installation

Install the AIUQ package from CRAN:

```r
install.packages("AIUQ")
library(AIUQ)
```

The real data examples also use `bioimagetools` to read microscopy image
sequences: 

```r
install.packages("bioimagetools")
library(bioimagetools)
```

## Quick start

Run model-free MSD estimation on a microscopy intensity array:

```r
sam_mf <- SAM(intensity = intensity, intensity_str = "SST_array", 
              mindt = frame_interval, pxsz = pixel_size,
              model_free_estimation = TRUE
)
```

Estimate storage and loss moduli from the MSD uncertainty interval:

```r
moduli <- Get_Gp_Gpp_GSER(
  MSD_est = MSD_est,
  d_input = lag_times,
  MSD_lower = MSD_lower,
  MSD_upper = MSD_upper,
  MSD_unit = MSD_unit,
  Temp = temperature,
  a = particle_radius
)
```

For additional examples, see the
[MF-AIUQ tutorial](tutorials/MF_AIUQ.Rmd).

## Reproducing the results

Run scripts from the root directory of this repository so that relative file
paths resolve consistently.

| Study | Description | Code |
|---|---|---|
| Simulations | BM, FBM, OU, and OU–FBM processes | [Open script](code/simulations/simulation.R) |
| PVA | PVA experiments with multiple probe sizes | [Open script](code/real-data/real_eg_1_PVA.R) |
| PEG hydrogel | PEG hydrogel experiments | [Open script](code/real-data/real_eg_2_PEG_hydrogel.R) |
| Snail mucin | MSD and viscoelastic modulus estimation | [Open script](code/real-data/real_eg_3_snail_mucin.R) |

### Simulated results

[`simulation.R`](code/simulations/simulation.R) contains the parameter settings
for the simulation studies:

- slow and fast Brownian motion;
- subdiffusive and superdiffusive fractional Brownian motion;
- Ornstein–Uhlenbeck motion; and
- a mixture of Ornstein–Uhlenbeck and fractional Brownian motion.

Select the desired scenario by following the comments in the script.

### Real data results

After download the data, run the script corresponding to the experiments:

```r
source("code/real-data/real_eg_1_PVA.R")
source("code/real-data/real_eg_2_PEG_hydrogel.R")
source("code/real-data/real_eg_3_snail_mucin.R")
```

## Repository structure

```text
MF-AIUQ/
├── README.md
├── code/
│   ├── simulations/
│   │   └── simulation.R
│   └── real-data/
│       ├── real_eg_1_PVA.R
│       ├── real_eg_2_PEG_hydrogel.R
│       └── real_eg_3_snail_mucin.R
├── tutorials/
│   └── MF_AIUQ.Rmd
└── data/
```

## Data

The microscopy datasets are published on Zenodo. (need to add DOI and download instruction)

## Citation

```bibtex
@article{lin2026model,
  title={Model-free estimation in scattering analysis of microscopy},
  author={Lin, Tong and Lee, Jinseok and Helgeson, Matt and Valentine, Megan T and Luo, Yimin and Gu, Mengyang},
  journal={arXiv preprint arXiv:2605.29424},
  year={2026}
}
```

## Contact

If you have any questions, please contact tong_lin@ucsb.edu



