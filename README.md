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

## Analysis Dataset

The data used in this study cannot be publicly shared due to
Estonian Biobank access restrictions.

The analyses were performed using a person-level dataset
containing one record per emulated trial participant.

### Variables

| Variable | Type | Description |
|-----------|--------|-------------|
| id | character | Participant identifier |
| interDate | date | Trial start date |
| interLDL | numeric | LDL cholesterol value interpolated to the trial start (mmol/L)  |
| interTotal | numeric | Total cholesterol value interpolated to the trial start (mmol/L) |
| gender.name | character | Gender value |
| birthYear | integer | Birth year value |
| measurementAge | numeric | Age at trial start (years) |
| prescribedDate | Date | Date of statin precription |
| icd10 | character | ICD-10 code of developed diagnosis |
| diagnosisDate | Date | Date of the developed diagnosis |
| deathDate | Date | Date of death |
| cardiovascularDeath | integer | Binary indicator for whether the death was of primary cause from I00-I99 |
| date10y | Date | Date 10-years from trial start |
| treatment | integer | Binary treatment initiation indicator | 
| endDate | Date | individual trial end date | 
| timeToEvent | numeric | Follow-up time (years) |
| ageAtEvent | numeric | Age at end of follow-up (years) |
| Event | integer | Binary indicator for event | 
| diabetes | integer | Binary indicator for diabetes diagnosis at trial baseline | 
| smokingStatus | character | Smoking status at trial baseline, taking values 'Never', 'Former', 'Current' |
| valueBMI | numeric | BMI value at trial baseline | 
| valueSBP | numeric | Systolic blood pressure at trial baseline (mm Hg) | 
| medicationUse | integer | Binary indicator for medication use in the last 24 months | 
| educationGroup.name | character | Last obtained education status, taking values 'Primary or baric', 'Secondary', 'University' |
| cohortNr | integer | Indicator for first or second EstBB cohort | 
| CADgrs | numeric | Coronary artery disease polygenic risk score |
| CADgrsGroup | character | Coronary artery disease polygenic risk score group by distribution, taking values '<90%', 'top 10%' | 
| hypertension | integer | Binary indicator for hypertension diagnosis at trial baseline | 
| dyslipidemia | integer | Binary indicator for dyslipidemia diagnosis at trial baseline |   
| CVDHistory | integer | Binary indicator for I20 diagnosis before baseline | 
| calendarYear | intefer | Year of trial start date | 
| nr_visits | integer | Number of general practitioners visits in the last 24 months | 
| sample_date | Date | Participants plasma sample obtainment date, from which cellular metabolite measurements are obtained by nuclear magnetic resonance. | 
| VLDL_C | numeric | VLDL Cholesterol (mmol/L) from plasma sample | 
| Clinical_LDL_C | numeric | Clinical LDL cholesterol (mmol/L) from plasma sample |
| HDL_C | numeric | HDL cholesterol (mmol/L) from plasma sample | 

## Repository Structure

```
├── scripts/
|   ├── 01_variable_derivation.R
│   ├── 02_estimation.R
│   ├── 03_bootstrap.R
│   └── 04_figures.R
├── figures/
├── tables/
└── README.md
```

## Software Requirements

Analyses were conducted in:

- R 4.4.0

## Reproducing the Analysis

1. Prepare the input datasets.
2. Run:

```r
source("scripts/01_variable_derivation.R")
source("scripts/02_estimation.R")
source("scripts/03_bootstrap.R")
source("scripts/04_figures.R")
