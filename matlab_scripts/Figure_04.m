%% SAM timeseries
clearvars
close all

% ---- extract values from table
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','SAM 1985-2021');

ywanted = 1985:2018;
time = T.mtime;
YYYY = str2num(datestr(time,'yyyy'));

ysam = T.Original(ismember(YYYY,ywanted));
ydec = T.Decadal(ismember(YYYY,ywanted));
ydec = [ydec, T.Interannual(ismember(YYYY,ywanted))];
time = time(ismember(YYYY,ywanted));

subtitle = {'(a) Original SAM time series';
    '(b) Decadal component';
    '(c) Interannual component';
    '(d) Decadal SAM {\it vs.} Decadal CO_2';
    '(e) Interannual SAM {\it vs.} Interannual CO_2';
    '(f) Decadal SAM {\it vs.} Decadal O_2';
    '(g) Interannual SAM {\it vs.} Interannual O_2'};
    
% ---- plot

xtick = datenum(1985:2019,1,1);
xticklab = datestr(datenum(1985:2019,1,1),'YYYY');
subfig = [1 2 1 2;
    3 3 3 3;
    4 4 4 4;
    6 7 11 12;
    9 10 14 15;
    16 17 21 22;
    19 20 24 25];

for sub = 1:7
    subplot(5,5,subfig(sub,:))
    plot(xtick([1 end]),[0 0],'k-'); hold on
    set(gca,'Xlim',xtick([1 end]),'Xtick',xtick(1:5:end),'xticklabel',xticklab(1:5:end,:),'Xgrid','on','Ygrid','on','box','on','Layer','top')
%     yyaxis right
    ylabel('SAM index')
%     yticks([])
    if sub == 1
        plot(time,ysam,'g-')
        set(gca,'Ylim',[-7 7])
    elseif ismember(sub, 2:2:6)
        plot(time,ydec(:,1),'g-','linewidth',1.5)
        set(gca,'Ylim',[-1 1])
    elseif ismember(sub, 3:2:7)
        plot(time,ydec(:,2),'g-','linewidth',1.5)
        set(gca,'Ylim',[-1.5 1.5])
    end

    if ismember(sub, 2:3)
        set(gca,'Xlim',xtick([1 end]),'Xtick',xtick(1:5:end),'xticklabel','','Xgrid','on','Ygrid','on','box','on','Layer','top')
    end

    title(cell2mat(subtitle(sub)),'fontweight','normal')
end

%% CO2 timeseries data

% ---- extract values from table

T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CO2 decadal');
ydata = T.DATA;
ygobm = T.MEAN;
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','CO2 interannual');
ydata = [ydata, T.DATA];
ygobm = [ygobm, T.MEAN];

ywanted = 1985:2018;
time = T.mtime;
YYYY = str2num(datestr(time,'yyyy'));

% ---- plot
subfig = [1 2 1 2;
    3 3 3 3;
    4 4 4 4;
    6 7 11 12;
    9 10 14 15;
    16 17 21 22;
    19 20 24 25];

for sub = 4:5
    subplot(5,5,subfig(sub,:))
    
    if ismember(sub, 4)
        yyaxis right
        plot(time,ydata(:,1),'b-','linewidth',1.5)
        hold on
        plot(time,ygobm(:,1),'k-','linewidth',1.5)
        set(gca,'Ylim',[-.2 .2],'Ydir','reverse','ycolor','k')
        ylabel('CO_2 Flux (PgC yr^{-1})')
    elseif ismember(sub, 5)
        yyaxis right
        plot(time,ydata(:,2),'b-','linewidth',1.5)
        hold on
        plot(time,ygobm(:,2),'k-','linewidth',1.5)
        set(gca,'Ylim',[-.15 .15],'Ydir','reverse','ycolor','k')
        ylabel('CO_2 Flux (PgC yr^{-1})')
    end
end

%%  O2 timseries 
% ---- extract values from table

T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','O2 decadal');
ydata = T.DATA_94;
ygobm = T.MEAN;
T = readtable('data/CO2_O2_SAM_timeseries.xlsx','sheet','O2 interannual');
ydata = [ydata, T.DATA_94];
ygobm = [ygobm, T.MEAN];

ywanted = 1985:2018;
time = T.mtime;
YYYY = str2num(datestr(time,'yyyy'));

% ---- plot
subfig = [1 2 1 2;
    3 3 3 3;
    4 4 4 4;
    6 7 11 12;
    9 10 14 15;
    16 17 21 22;
    19 20 24 25];

for sub = 6:7
    subplot(5,5,subfig(sub,:))
    
    if ismember(sub, 4:6)
        yyaxis right
        plot(time,ydata(:,1),'b-','linewidth',1.5)
        hold on
        plot(time,ygobm(:,1),'k-','linewidth',1.5)
        set(gca,'Ylim',[-50 50],'ycolor','k')
        ylabel('O_2 Flux (Tmol yr^{-1})')
    elseif ismember(sub, 7:9)
        yyaxis right
        plot(time,ydata(:,2),'b-','linewidth',1.5)
        hold on
        plot(time,ygobm(:,2),'k-','linewidth',1.5)
        set(gca,'Ylim',[-75 75],'ycolor','k')
        ylabel('O_2 Flux (Tmol yr^{-1})')
    end
end

% set(gcf,'PaperPosition',[1 1 40 20])
% print('Fig_04.jpeg','-djpeg','-r300')