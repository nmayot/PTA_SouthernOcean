%% Decadal variability CO2 and O2 from observation-based products

clearvars
close all
close all
% ---- extract values from table

T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','O2 decadal');
ydata_O2 = T.DATA_94;
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CO2 decadal');
ydata_CO2 = T.DATA;
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','O2 decadal');
ydata_O2_99 = T.DATA_99;

time = T.mtime;
YYYY = str2num(datestr(time,'yyyy'));

xtick = datenum(1985:2019,1,1);
xticklab = datestr(datenum(1985:2019,1,1),'YYYY');

h1 = plot(time,ydata_CO2,'LineWidth',1.5,'color',[.2 .5 .7]);
hold on
plot(xtick([1 end]),[0 0],'k-')
set(gca,'Xlim',xtick([1 end]),'Xtick',xtick(1:5:end),'xticklabel',xticklab(1:5:end,:),'Xgrid','on','Ygrid','on','box','on','ylim',[-.15 .15],'YTick',-.15:.05:.15)
ylabel('CO_2 Flux (PgC yr^{-1})')
yyaxis right
h2 = plot(time,ydata_O2,'LineWidth',1.5,'color',[.9 .2 .1]);
hold on
h3 = plot(time,ydata_O2_99,'--','LineWidth',1.5,'color',[.9 .2 .1]);
set(gca,'ydir','reverse','ylim',[-45 45],'ycolor',[.9 .2 .1],'YTick',-45:15:45)
ylabel('O_2 Flux (Tmol yr^{-1})')
legend([h1 h2 h3],{'pCO_2 products','APO inversion (5 stn.)','APO inversion (9 stn.)'},'location','southwest')

% set(gcf,'PaperPosition',[1 1 18 10])
% print('Figure_05.jpeg','-djpeg','-r300')