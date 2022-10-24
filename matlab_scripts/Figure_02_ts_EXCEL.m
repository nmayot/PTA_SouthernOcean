%% CO2 timeseries data
clearvars
close all
% ---- extract values from table

T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CO2 original');
ydata = T.DATA;
ygobm = T.MEAN;
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CO2 decadal');
ydata = [ydata, T.DATA];
ygobm = [ygobm, T.MEAN];
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CO2 interannual');
ydata = [ydata, T.DATA];
ygobm = [ygobm, T.MEAN];
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CO2 decadal');
v = ydata(:,2) + T.std_DATA;
v = [v; ydata(:,2) - T.std_DATA];
ydata_std = v;
v = ygobm(:,2) + T.std_MEAN;
v = [v; ygobm(:,2) - T.std_MEAN];
ygobm_std = v;
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CO2 interannual');
v = ydata(:,3) + T.std_DATA;
v = [v; ydata(:,3) - T.std_DATA];
ydata_std = [ydata_std, v];
v = ygobm(:,3) + T.std_MEAN;
v = [v; ygobm(:,3) - T.std_MEAN];
ygobm_std = [ygobm_std, v];
ydata_std = [nan(size(ydata_std,1),1), ydata_std];
ygobm_std = [nan(size(ygobm_std,1),1), ygobm_std];
ywanted = 1985:2018;
time = T.mtime;
YYYY = str2num(datestr(time,'yyyy'));
time_std = repmat(time,2,1);
n = size(ydata,1);
f = [1:n n*2:-1:n+1];
xtick = datenum(1985:2019,1,1);
xticklab = datestr(datenum(1985:2019,1,1),'YYYY');
titlename = {'(a) Climate-driven air-sea CO_2 fluxes';'(c) Decadal variability';'(e) Interannual variability'};

ylimval = [-.2 .2; -.2 .2; -.15 .15];

% ---- plot
for sub = [1 3 5]
    subplot(3,2,sub)
    plot(xtick([1 end]),[0 0],'k-')
    hold on
    col = ismember([1 3 5],sub);
    title(titlename(col),'fontweight','normal');
    
    if ismember(sub, 1)
        plot(time,ygobm(:,1),'k-','linewidth',1.5)
        plot(time,ydata(:,1),'b-','linewidth',1.5)
    
    elseif ismember(sub, [3 5])
        patch('Faces',f,'Vertices',[time_std,ygobm_std(:,col)],'FaceColor',[.6 .6 .6],'EdgeColor','none','facealpha',.8)
        h1 = plot(time,ygobm(:,col),'k-','linewidth',1.5);
        patch('Faces',f,'Vertices',[time_std,ydata_std(:,col)],'FaceColor',[0 0 1],'EdgeColor','none','facealpha',.2)
        h2 = plot(time,ydata(:,col),'b-','linewidth',1.5);
        
        if sub == 3
            legend([h1 h2], {'GOBMs','pCO_2 products'},'Location','north')
        end
    end
    set(gca,'Ylim',ylimval(col,:),'ytick',ylimval(col,1):.05:ylimval(col,2),'Xlim',xtick([1 end]),'Xtick',xtick(1:5:end),'xticklabel',xticklab(1:5:end,:),'Xgrid','on','Ygrid','on','box','on','Layer','top')
    ylabel('CO_2 Flux (PgC yr^{-1})')
    set(gca,'XMinorTick','on','XMinorGrid','on')
end

%%  O2 timseries
clearvars
% ---- extract values from table

T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','O2 original');
ydata_94 = T.DATA_94;
ydata_99 = T.DATA_99;
ygobm = T.MEAN;
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','O2 decadal');
ydata_94 = [ydata_94, T.DATA_94];
ydata_99 = [ydata_99, T.DATA_99];
ygobm = [ygobm, T.MEAN];
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','O2 interannual');
ydata_94 = [ydata_94, T.DATA_94];
ydata_99 = [ydata_99, T.DATA_99];
ygobm = [ygobm, T.MEAN];
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','O2 decadal');
v = ygobm(:,2) + T.std_MEAN;
v = [v; ygobm(:,2) - T.std_MEAN];
ygobm_std = v;
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','O2 interannual');
v = ygobm(:,3) + T.std_MEAN;
v = [v; ygobm(:,3) - T.std_MEAN];
ygobm_std = [ygobm_std, v];
ygobm_std = [nan(size(ygobm_std,1),1), ygobm_std];
ywanted = 1994:2018;
time = T.mtime;
YYYY = str2num(datestr(time,'yyyy'));
index = find(~isnan(ygobm(:,2)));
time_std = repmat(time(index),2,1);
n = size(time_std,1)/2;
f = [1:n n*2:-1:n+1];
xtick = datenum(1985:2019,1,1);
xticklab = datestr(datenum(1985:2019,1,1),'YYYY');
ylimval = [-120 120; -80 80; -100 100];
ytickinterval = [40; 20; 40];
titlename = {'(b) Air-sea O_2 fluxes';'(d) Decadal variability';'(f) Interannual variability'};
% ---- plot
for sub = [2 4 6]
    subplot(3,2,sub)
    plot(xtick([1 end]),[0 0],'k-')
    hold on
    col = ismember([2 4 6],sub);
    title(titlename(col),'fontweight','normal');
    if ismember(sub, 2)
        plot(time,ygobm(:,1),'k-','linewidth',1.5);
        plot(time,ydata_94(:,1),'b-','linewidth',1.5)
        plot(time,ydata_99(:,1),'m-','linewidth',1)
        set(gca,'Xlim',xtick([1 end]),'Xtick',xtick(1:5:end),'xticklabel',xticklab(1:5:end,:),'Xgrid','on','Ygrid','on','box','on','Layer','top')
        set(gca,'ylim',ylimval(col,:),'Ytick',[ylimval(col,1):ytickinterval(col):ylimval(col,2)],'Yticklabel',[ylimval(col,1):ytickinterval(col):ylimval(col,2)])
        ylabel('O_2 Flux (Tmol yr^{-1})')
        
    elseif ismember(sub, [4 6])
        patch('Faces',f,'Vertices',[time_std,ygobm_std(~isnan(ygobm_std(:,col)),col)],'FaceColor',[.6 .6 .6],'EdgeColor','none','facealpha',.8)
        h1 = plot(time,ygobm(:,col),'k-','linewidth',1.5);
        h2 = plot(time,ydata_94(:,col),'b-','linewidth',1.5);
        h3 = plot(time,ydata_99(:,col),'m-','linewidth',1.5);
        if sub == 4
            legend([h1 h2 h3], {'GOBMs','APO inversion (5 stn.)','APO inversion (9 stn.)'},'Location','northwest')
        end
        set(gca,'Xlim',xtick([1 end]),'Xtick',xtick(1:5:end),'xticklabel',xticklab(1:5:end,:),'Xgrid','on','Ygrid','on','box','on','Layer','top')
        set(gca,'ylim',ylimval(col,:),'Ytick',[ylimval(col,1):ytickinterval(col):ylimval(col,2)],'Yticklabel',[ylimval(col,1):ytickinterval(col):ylimval(col,2)])
        ylabel('O_2 Flux (Tmol yr^{-1})')
%         yyaxis right
%         set(gca,'Ycolor','b','ylim',ylimval(col,:),'Ytick',[ylimval(col,1):ytickinterval(col):ylimval(col,2)],'Yticklabel',[ylimval(col,1):ytickinterval(col):ylimval(col,2)]*2)
%         ylabel('O_2 Flux (Tmol yr^{-1})')
    end
    set(gca,'XMinorTick','on','XMinorGrid','on')
end

% % ----
% set(gcf,'PaperPosition',[1 1 25 22])
% print('Figure_02.jpeg','-djpeg','-r300')