# PTA_SouthrnOcean

A git repository that contains scripts in Matlab to performed the analysis presented in Mayot et al. (submitted) - Phil. Trans. R. Soc. A.

## Folder structure

```text
.
├── CO2_O2_SAM_timeseries.xlsx : The Excel file used to do the figures (available on zenodo: xxx)
│  
├── /data : the data used are stored here
│   ├── /Models
│   │   ├── /2D_CO2 : one folder for each GOBM (from RECCAP2 ocean project)
│   │       ├── /CESM-ETHZ
│   │       ├── /CNRM-ESM
│   │       ├── ...
│   │       └── /ORCA025-GEOMAR
│   │   └── /2D_O2 : one folder for each GOBM (on request or from GCB project)
│   │       ├── /CESM-ETHZ
│   │       ├── /CNRM-ESM
│   │       ├── ...
│   │       └── /ORCA025-GEOMAR
│   │   
│   └── /Surface_CO2 : one folder for each pCO2 product (from RECCAP2 ocean project)
│           ├── /CMEMS-LSCEFFNN
│           ├── /CSIR-ML6
│           ├── ...
│           └── /Watson2020
│   
└── /matlab_scripts
    ├── Figure_... .m : To produce a figure (one file for each figure in the manuscript)
    ├── TS_decomposition_hanning.m : To decompose the time series
    └── correlation_DF.m : To calculate the correlation values
```

Note that the data are not accessible on GitHub. They need to be downloaded locally from the mentioned sources and placed inside the correct folders. 
