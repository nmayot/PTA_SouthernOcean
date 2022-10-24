%% CO2 timeseries data
clearvars
% ---- extract values from table

T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CO2 simA');
ydata = T.DATA;
ygobm = T.MEAN;

T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CO2 simC');
ygobm_co2 = T.MEAN;

T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CO2 simA');
v = ydata + T.std_DATA;
v = [v; ydata - T.std_DATA];
ydata_std = v;
v = ygobm + T.std_MEAN;
v = [v; ygobm - T.std_MEAN];
ygobm_std = v;

ywanted = 1985:2018;
time = T.mtime;
YYYY = str2num(datestr(time,'yyyy'));
time_std = repmat(time,2,1);
n = size(ydata,1);
f = [1:n n*2:-1:n+1];
xtick = datenum(1985:2019,1,1);
xticklab = datestr(datenum(1985:2019,1,1),'YYYY');

% ---- plot
patch('Faces',f,'Vertices',[time_std,ygobm_std],'FaceColor',[.6 .6 .6],'EdgeColor','none','facealpha',.8)
hold on
h1 = plot(time,ygobm,'k-','linewidth',1.5);
h2 = plot(time,ygobm_co2,'k--','linewidth',1.5);

patch('Faces',f,'Vertices',[time_std,ydata_std]+0.38,'FaceColor',[0 0 1],'EdgeColor','none','facealpha',.2)
h3 = plot(time,ydata+0.38,'b-','linewidth',1.5);

legend([h1 h2 h3], {'GOBMs ("Simulation A")','GOBMs ("Simulation C")','pCO_2 products'},'Location','northwest')

set(gca,'Ylim',[0 2.2],'Xlim',xtick([1 end]),'Xtick',xtick(1:5:end),'xticklabel',xticklab(1:5:end,:),'Ytick',0:.25:2,'Xgrid','on','Ygrid','on','box','on','Layer','top')
ylabel('CO_2 Flux (PgC yr^{-1})')

set(gca,'XMinorTick','on','XMinorGrid','on')

% % ----
% set(gcf,'PaperPosition',[1 1 16.18 10])
% print('Figure_01.jpeg','-djpeg','-r300')