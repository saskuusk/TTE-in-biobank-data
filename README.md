--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Target Trial Emulation in biobank data: estimating the effect of cholesterol-lowering therapy and PRS on cardiovascular diseases in the Estonian Biobank
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Target Trial Emulation in the Estonian Biobank

Repository accompanying the manuscript:

Kuusk S, Fischer K, ..., "Target Trial Emulation in Biobank Data:
Estimating the Effect of Cholesterol-Lowering Therapy and Polygenic Risk
on Cardiovascular Disease in the Estonian Biobank".

## Overview

This repository contains the code used to:

- estimate treatment effects
- perform sensitivity analyses
- generate tables and figures
- validate CAD polygenic risk score effects

## Data Availability

The data originate from the Estonian Biobank and cannot be publicly shared.

Access requests should be made through:
https://genomics.ut.ee/en/content/estonian-biobank

## Repository Structure

├── scripts/
│   ├── 01_estimation.R
│   ├── 02_bootstrap.R
│   └── 03_figures.R
├── figures/
├── tables/
└── README.md

## Software Requirements

Analyses were conducted in:

- R 4.4.0

## Reproducing the Analysis

1. Prepare the input datasets.
2. Run:

```r
source("scripts/01_estimation.R")
source("scripts/02_bootstrap.R")
source("scripts/03_figures.R")
