A git repository that contains scripts in Matlab to performed the analysis presented in Mayot *et al.* (submitted) - Phil. Trans. R. Soc. A.

## Contact
Nicolas Mayot  
email: n.mayot@uea.ac.uk  

## Folder structure

```text
.
│  
├── /data : the data used are stored here
│   ├── CO2_O2_SAM_timeseries.xlsx : Time series available to editors and reviewers on https://osf.io/
│   │  
│   ├── 2D_CO2..._hw.mat : for the maps in Figure 3 
│   ├── 2D_O2..._hw.mat : for the maps in Figure 3 
│   │  
│   ├── /Models
│   │   ├── /2D_CO2 : one folder for each GOBM (from RECCAP2 ocean project)
│   │   │   ├── /CESM-ETHZ
│   │   │   ├── /CNRM-ESM
│   │   │   ├── ...
│   │   │   └── /ORCA025-GEOMAR
│   │   │  
│   │   └── /2D_O2 : one folder for each GOBM (on request or from GCB project)
│   │   │   ├── /CESM-ETHZ
│   │   │   ├── /CNRM-ESM
│   │   │   ├── ...
│   │   │   └── /NEMO-PlankTOM12
│   │   │  
│   │   └── /CMIP6 : fgco2 and fgo2 from the selected CMIP6 models (from CMIP6 archive)
│   │   │   ├── /areacello
│   │   │   ├── fgco2_Omon_... .nc
│   │   │   ├── ...
│   │   │   └── fgo2_Omon_... .nc
│   │  
│   ├── /Jena_inversion : APO inversion (from Jena CarboScope)
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
