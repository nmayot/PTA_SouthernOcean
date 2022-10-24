clearvars
close all


lat = -89.5:89.5;
lon = 0.5:359.5;
load('data/2D_SAF_location.mat')
ocmask(:,lat >-30) = NaN;

filename = {'data/2D_CO2i_GOBMs_hw.mat';
    'data/2D_CO2i_pCO2_hw.mat';
    'data/2D_O2i_GOBMs_hw.mat'};

clim = [0 2.5; 0 2.5; 0 2];
% ctitle = {['CO_2 sink',newline,'(gC m^{-2} yr^{-1})'];
%     ['O_2 flux',newline,'(mol m^{-2} yr^{-1})']};
ctitle = {'(gC m^{-2} yr^{-1})';
    '(mol m^{-2} yr^{-1})'};
ctitlenum = [1 1 2];
ftitle = {'(a) GOBMs', '(b) pCO_2 products', '(c) GOBMs'};
ftxt = {'CO_2', 'CO_2', 'O_2'};
subfig = [1 3 5];
for subf = 1:length(filename)
    load(cell2mat(filename(subf)))
    
    subplot(3,2,subfig(subf))
    title(cell2mat(ftitle(subf)),'fontweight','normal')
    
    % --- average all Oflx 3D maps data
    F = nanmean(SO_all,3);
    F = std(F,0,2)*(86400*365);
    Fmap = F;
    Fmap = reshape(Fmap,360,180);

    f = Fmap';
    m_proj('stereographic','lat',-90,'radius',60);
    m_image(lon,lat,f);
    m_image(-179.5:0.5,lat,f(:,[181:end 1]));
    hold on
    m_contour(lon,lat,ocmask',[8 8],'k-','linewidth',2)
    m_grid('xtick',12,'tickdir','out','ytick',[-90 -60 -45 -30],'yticklabel','','xticklabel','');
    m_coast('patch',[.7 .7 .7]);
    colormap(parula(5))
    
    set(gca,'Clim',clim(subf,:))
    hcb = colorbar();
    title(hcb,cell2mat(ctitle(ctitlenum(subf))),'fontsize',9)
    ylabel(hcb,'Standard deviation')
    set(hcb,'ytick',clim(subf,1):clim(subf,2)/5:clim(subf,2))

    text(-.1,0,ftxt(subf),'HorizontalAlignment','left','FontSize',8,'BackgroundColor','w','EdgeColor','k','FontWeight','bold')
    
end

% set(gcf,'PaperPosition',[1 1 20 20])
% print('Documents/UEA-postdoc/Mirror/redaction/20220630 - RS/Fig_03.png','-dpng','-r300')

subplot(3,2,1)
txt = 'Interannual';
text(0,1.8,txt,'HorizontalAlignment','center','FontSize',20,'FontWeight','bold')

%% for decadal variations

clearvars

lat = -89.5:89.5;
lon = 0.5:359.5;
load('data/2D_SAF_location.mat')
ocmask(:,lat >-30) = NaN;

filename = {'data/2D_CO2d_GOBMs_hw.mat';
    'data/2D_CO2d_pCO2_hw.mat';
    'data/2D_O2d_GOBMs_hw.mat'};

clim = [0 2.5; 0 2.5; 0 2];
% ctitle = {['CO_2 sink',newline,'(gC m^{-2} yr^{-1})'];
%     ['O_2 flux',newline,'(mol m^{-2} yr^{-1})']};
ctitle = {'(gC m^{-2} yr^{-1})';
    '(mol m^{-2} yr^{-1})'};
ctitlenum = [1 1 2];
ftitle = {'(d) GOBMs', '(e) pCO_2 products', '(f) GOBMs'};
ftxt = {'CO_2', 'CO_2', 'O_2'};
subfig = [2 4 6];

for subf = 1:length(filename)
    load(cell2mat(filename(subf)))
    
    subplot(3,2,subfig(subf))
    title(cell2mat(ftitle(subf)),'fontweight','normal')
    
    % --- average all Oflx 3D maps data
    F = nanmean(SO_all,3);
    F = std(F,0,2)*(86400*365);
    Fmap = F;
    Fmap = reshape(Fmap,360,180);

    f = Fmap';
    m_proj('stereographic','lat',-90,'radius',60);
    m_image(lon,lat,f);
    m_image(-179.5:0.5,lat,f(:,[181:end 1]));
    hold on
    m_contour(lon,lat,ocmask',[8 8],'k-','linewidth',2)
    m_grid('xtick',12,'tickdir','out','ytick',[-90 -60 -45 -30],'yticklabel','','xticklabel','');
    m_coast('patch',[.7 .7 .7]);
    colormap(parula(5))
    
    set(gca,'Clim',clim(subf,:))
    hcb = colorbar();
    title(hcb,cell2mat(ctitle(ctitlenum(subf))),'fontsize',9)
    ylabel(hcb,'Standard deviation')
    set(hcb,'ytick',clim(subf,1):clim(subf,2)/5:clim(subf,2))
    
    text(-.1,0,ftxt(subf),'HorizontalAlignment','left','FontSize',8,'BackgroundColor','w','EdgeColor','k','FontWeight','bold')

end

subplot(3,2,2)
txt = 'Decadal';
text(0,1.8,txt,'HorizontalAlignment','center','FontSize',20,'FontWeight','bold')

% set(gcf,'PaperPosition',[1 1 20 20])
% print('Documents/UEA-postdoc/Mirror/redaction/20220630 - RS/Figure_03.png','-dpng','-r300')
