clearvars
close all

%% For CO2 air-sea fluxes
% ---- extract values from table
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CO2 decadal');
ydata_D = T.DATA;
ygobm_D = T.MEAN;
ygobm_all_D = table2array(T(:,4:13));

T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CO2 interannual');
ydata_I = T.DATA;
ygobm_I = T.MEAN;
ygobm_all_I = table2array(T(:,4:13));

T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CMIP6 CO2 decadal');
yesm_all_D = table2array(T(:,4:8));
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CMIP6 CO2 interannual');
yesm_all_I = table2array(T(:,4:8));


% subplot(1,2,1)
T = cov(detrend(ygobm_I,1),detrend(ygobm_D,1))./var(detrend(ygobm_I,1)+detrend(ygobm_D,1));
T = T *100;
h1 = scatter(T(1,1),T(2,2),200,'o','filled','MarkerFaceColor','k','MarkerEdgeColor','w');
hold on

for M = 1:10
    T = cov(detrend(ygobm_all_I(:,M),1),detrend(ygobm_all_D(:,M),1))./var(detrend(ygobm_all_I(:,M),1)+detrend(ygobm_all_D(:,M),1));
    T = T *100;
    h2 = scatter(T(1,1),T(2,2),50,'o','filled','MarkerFaceColor','k','MarkerEdgeColor','w');
end

T = cov(detrend(ydata_I,1),detrend(ydata_D,1))./var(detrend(ydata_I,1)+detrend(ydata_D,1));
T = T *100;
h3 = scatter(T(1,1),T(2,2),200,'o','filled','MarkerFaceColor','b','MarkerEdgeColor','w');

for M = 1:5
    T = cov(detrend(yesm_all_I(:,M),1),detrend(yesm_all_D(:,M),1))./var(detrend(yesm_all_I(:,M),1)+detrend(yesm_all_D(:,M),1));
    T = T *100;
    h4 = scatter(T(1,1),T(2,2),50,'o','filled','MarkerFaceColor',[0.9 0.4 0],'MarkerEdgeColor','w');
end

patch([0 100 100 0],[100 100 0 100],[.6 .6 .6])
ylabel('Decadal variability (% total variance)')
xlabel('Interannual variability (% total variance)')
title('Climate-driven air-sea CO_2 fluxes','fontweight','normal')
ax = gca;
ax.TitleHorizontalAlignment = 'left';
set(gca,'Ylim',[0 100],'Xlim',[0 100],'XGrid','on','Ygrid','on','box','on')
legend([h1 h3 h4],{'GOBMs','pCO_2 product mean','ESMs (CMIP6)'},'location','northeast')

%% For O2 air-sea fluxes
clearvars

% ---- extract values from table

T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','O2 decadal');
ydata_D = T.DATA_99;
ygobm_D = T.MEAN;
ygobm_all_D = table2array(T(:,4:12));

ygobm_all_D = ygobm_all_D(~isnan(ygobm_all_D(:,1)),:);
ydata_D = ydata_D(~isnan(ydata_D));
ygobm_D = ygobm_D(~isnan(ygobm_D));

T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','O2 interannual');
ydata_I = T.DATA_99;
ygobm_I = T.MEAN;
ygobm_all_I = table2array(T(:,4:12));

ygobm_all_I = ygobm_all_I(~isnan(ygobm_all_I(:,1)),:);
ydata_I = ydata_I(~isnan(ydata_I));
ygobm_I = ygobm_I(~isnan(ygobm_I));


T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CMIP6 O2 decadal');
yesm_all_D = table2array(T(:,4:8));
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CMIP6 O2 interannual');
yesm_all_I = table2array(T(:,4:8));



T = cov(detrend(ygobm_I,1),detrend(ygobm_D,1))./var(detrend(ygobm_I,1)+detrend(ygobm_D,1));
T = T *100;

h1 = scatter(T(1,1),T(2,2),200,'o','filled','MarkerFaceColor','w','MarkerEdgeColor','k');
set(gca,'Ylim',[0 100],'Xlim',[0 100])
hold on

for M = 1:9
    T = cov(detrend(ygobm_all_I(:,M),1),detrend(ygobm_all_D(:,M),1))./var(detrend(ygobm_all_I(:,M),1)+detrend(ygobm_all_D(:,M),1));
    T = T *100;
    h2 = scatter(T(1,1),T(2,2),50,'o','filled','MarkerFaceColor','w','MarkerEdgeColor','k');
end

T = cov(detrend(ydata_I,1),detrend(ydata_D,1))./var(detrend(ydata_I,1)+detrend(ydata_D,1));
T = T *100;
h3 = scatter(T(1,1),T(2,2),200,'bo','filled','MarkerEdgeColor','w');

for M = 1:5
    T = cov(detrend(yesm_all_I(:,M),1),detrend(yesm_all_D(:,M),1))./var(detrend(yesm_all_I(:,M),1)+detrend(yesm_all_D(:,M),1));
    T = T *100;
    h4 = scatter(T(1,1),T(2,2),50,'o','filled','MarkerFaceColor',[0.9 0.4 0],'MarkerEdgeColor','k');
end

patch([0 100 100 0],[100 100 0 100],[.6 .6 .6])
ylabel('Decadal variability (% total variance)')
xlabel('Interannual variability (% total variance)')
title('Climate-driven air-sea O_2 fluxes','fontweight','normal')
ax = gca;
ax.TitleHorizontalAlignment = 'left';
set(gca,'Ylim',[0 100],'Xlim',[0 100],'XGrid','on','Ygrid','on','box','on')
legend([h1 h3 h4],{'GOBMs','APO inversion (5 stn.)','ESMs (CMIP6)'},'location','northeast')

% % ----
% set(gcf,'PaperPosition',[1 1 12.5 10])
% print('Figure_06.jpeg','-djpeg','-r300')
