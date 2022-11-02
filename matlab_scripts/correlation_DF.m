% ---- Calculate the correlation between time series
% Correlation coefficients found between time series, with the degree of
% freedom being adjusted by considering the e-folding decay time of
% autocorrelation.
%
% The reemaining long-term trends of the time series are removed to focus
% on the correlation between interannual or decadal variations

X = DATA; % (row = time, 1 column = variable observed)
Y = GOBM; % (row = time, columns = variable simulated)

RHO = []; % empty matrix to be filled
PVAL = []; % empty matrix to be filled

% -- Degree of freedom of X
[xval, xlags] = xcorr(detrend(X,1),'coeff'); % detrend and autocorrelation
xval(xlags < 0) = [];
xlags(xlags < 0) = [];
Te = min(xlags(xval < 1/exp(1))); % find the e-folding decay time
DF_X = ceil(length(X)/(2*Te)); % calculate degree of freedom = (N ∆t)/(2Te)

for M = 1:size(Y,2)
    
    % ---- Degree of freedom of Y
    [yval, ylags] = xcorr(detrend(Y(:,M),1),'coeff'); % detrend and autocorrelation
    yval(ylags < 0) = [];
    ylags(ylags < 0) = [];
    Te = min(ylags(xval < 1/exp(1)));
    DF_Y = ceil(length(X)/(2*Te)); % calculate degree of freedom = (N ∆t)/(2Te)

    DF = min(DF_X,DF_Y); % select the smallest DF between X or Y

    [rho, ~] = corr(detrend(X,1),detrend(Y(:,M),1)); % correlation coefficient
    
    t = (rho*sqrt(DF))/(sqrt(1-rho^2));
    pval = 2*(1-tcdf( abs(t), DF)); % calulate the p-value with adjusted DF
    
    PVAL = [PVAL; pval];
    RHO  = [RHO; rho];
    
end

PVAL = round(PVAL*100)/100; % display the pvalue and coefficient with two decimals
RHO  = round(RHO*100)/100;

%% In development...
% ---- Calculate the correlation between annual and seasonal time series

clearvars -except Y MM YYYY
annY = grpstats(Y,YYYY);

sMM = [12 1 2; 3 4 5; 6 7 8; 9 10 11];
RHO = [];
for s = 1:4   
    seaY = grpstats(Y(ismember(MM,sMM(s,:))),YYYY(ismember(MM,sMM(s,:))));    
    rho = corr(annY(ismember(unique(YYYY),unique(YYYY(ismember(MM,sMM(s,:)))))),seaY);
    RHO = [RHO, rho];
end
