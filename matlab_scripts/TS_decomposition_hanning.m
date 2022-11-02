clearvars

%% For the CO2 time series

% ---- Prepare the data from GOBMs
% For each model, select the Southern Ocean (<30°S), sum all grid cells
% (= create a multi-annual time series), remove the seasonal cycle with a 
% 12-month moving average, convert gC/s into PgC/yr, remove long-term mean
%
% This is done for simulation A and C. Keep only A-C and mean C.
%
% These outputs are saved in CO2_O2_SAM_timeseries.xlsx: CO2 simA, CO2 simC 

load('data/Models/2D_CO2/FGOBM_RECCAP2_A.mat') % 2D_CO2 files concatenated
load('data/Models/2D_CO2/FGOBM_RECCAP2_C.mat')
FGOBM = cat(5,FGOBMA,nan(size(FGOBMA,1),size(FGOBMA,2),size(FGOBMA,3),size(FGOBMA,4)),FGOBMC);

clearvars -except FGOBM lon lat ywanted modelnames YYYY area

% -- Simulation A - Simulation C
SOall = []; % empty files to be filled
for m = 1:size(FGOBM,4)
    F = [];
    for S = [1 3]
        FS = FGOBM(:,lat <= -30,:,m,S); % select Southern Ocean and simulation A or C
        FS = reshape(FS,size(FS,1)*size(FS,2),[]); 
        FS = movmean(permute(nansum(FS),[2,1]),12,'Endpoints','discard')'; % sum + remove seasonal cycle
        F = [F; FS];
    end
    F = F(1,:) - F(2,:); % simulation A - simulation C    
    SOall = [SOall; F*(86400*365)/10^15]; % convert gC/s into PgC/yr
end
SOall = SOall - repmat(mean(SOall,2),1,size(SOall,2)); % remove long-term mean

% -- Simulation C to be used with pCO2-products and ESMs
SOall_CO2 = [];
for m = 1:size(FGOBM,4)
    F = FGOBM(:,lat <= -30,:,m,3); % select Southern Ocean and simulation C
    F = reshape(F,size(F,1)*size(F,2),[]);
    F = movmean(permute(nansum(F),[2,1]),12,'Endpoints','discard')'; % sum + remove seasonal cycle
    SOall_CO2 = [SOall_CO2; F*(86400*365)/10^15]; % convert gC/s into PgC/yr
end
SOall_CO2 = SOall_CO2 - repmat(mean(SOall_CO2,2),1,size(SOall_CO2,2)); % remove long-term mean
SOall_CO2 = mean(SOall_CO2); % average all GOBMs

% -- Associated time-vector
yyyy = sort(repmat(ywanted,1,12));
mm   = repmat(1:12,1,length(ywanted));
time = datenum(yyyy(6:end-6),mm(6:end-6),15);

clearvars -except FGOBM lon lat ywanted modelnames SOall time SOall_CO2


% ---- Prepare the data from pCO2-products
% For each product, select the Southern Ocean (<30°S), sum all grid cells
% (= create a multi-annual time series), remove the seasonal cycle with a 
% 12-month moving average, convert gC/s into PgC/yr, remove simulation C,
% remove long-term mean
%
% These outputs are saved in CO2_O2_SAM_timeseries.xlsx: CO2 simA 

load('data/Surface_CO2/FDATA_RECCAP2.mat') % Surface_CO2 files concatenated
SOall_DATA = [];

for m = 1:size(FDATA,4)
    F = FDATA(:,lat <= -30,:,m); % select Southern Ocean
    F = reshape(F,size(F,1)*size(F,2),[]);
    F = movmean(permute(nansum(F),[2,1]),12,'Endpoints','discard')'; % sum + remove seasonal cycle
    F = F*(86400*365)/10^15; % convert gC/s into PgC/yr
    F = F - SOall_CO2; % remove simulation C
    F = F - mean(F); % remove long-term mean    
    SOall_DATA = [SOall_DATA; F];    
end

clearvars -except FGOBM FDATA lon lat ywanted modelnames SOall time SOall_CO2 SOall_DATA

% ---- Perform the decomposition
% The decadal component is obtained with a 48-month hanning window, the
% interannual component was extracted by removing the decadal component
% from the original time series, the interannual component was smoothed
% with a 5-month hanning window, caluclate average and STD values
%
% These outputs are saved in CO2_O2_SAM_timeseries.xlsx: CO2 decadal, CO2 
% interannual, O2 decadal, O2 interannual

% -- GOBMs decomposition
% decadal component
win = hann(48);
win = win/sum(win);
ydec = nan(size(SOall));
for M = 1:size(SOall,1)
    b2 = SOall(M,:);
    ydec(M,:) = conv(b2,win,'same');
end
% interannual component
win = hann(5);
win = win/sum(win);
ydec2 = nan(size(SOall));
for M = 1:size(SOall,1)
    b2 = SOall(M,:)-ydec(M,:);
    ydec2(M,:) = conv(b2,win,'same');
end
% their STD and average values
ydec_std_GOBM = [std(ydec)', std(ydec2)'];
ydec_GOBM = [mean(ydec)', mean(ydec2)'];

% -- pCO2-products decomposition
% decadal component
win = hann(48);
win = win/sum(win);
ydec = nan(size(SOall_DATA));
for M = 1:size(SOall_DATA,1)
    b2 = SOall_DATA(M,:);
    ydec(M,:) = conv(b2,win,'same');
end
% interannual component
win = hann(5);
win = win/sum(win);
ydec2 = nan(size(SOall_DATA));
for M = 1:size(SOall_DATA,1)
    b2 = SOall_DATA(M,:)-ydec(M,:);
    ydec2(M,:) = conv(b2,win,'same');
end
% their STD and average values
ydec_std_DATA = [std(ydec)', std(ydec2)'];
ydec_DATA = [mean(ydec)', mean(ydec2)'];

clearvars -except FGOBM FDATA lon lat time ydec_DATA ydec_std_DATA ydec_GOBM ydec_std_GOBM


%% For the O2 time series

% ---- Prepare the data from GOBMs
% For each model, select the Southern Ocean (<30°S), convert mol/m2/s into
% mol/s, sum all grid cells (= create a multi-annual time series), remove
% the seasonal cycle with a 12-month moving average, convert mol/s into
% Tmol/yr and change sign, remove long-term mean
%
% This is done for simulation A.
%
% These outputs are saved in CO2_O2_SAM_timeseries.xlsx: O2 original

load('data/Models/2D_O2/FGOBM_O2.mat')  % 2D_O2 files concatenated
ywanted = 1994:2018;
mwanted = {'cesm-ethz','cnrm','ec-earth3','fesom','mpi','ipsl','noresm','princeton','planktom12'};

clearvars -except FGOBM lon lat ywanted YYYY area mwanted modelnames

SOall = [];

for m = find(ismember(modelnames,mwanted))
    F = FGOBM(:,lat <= -30,ismember(YYYY,ywanted),m); % select Southern Ocean
    F = F.*repmat(area(:,lat <= -30),1,1,size(F,3)); % mol/m2/s into mol/s
    F = reshape(F,size(F,1)*size(F,2),[]);
    F = nansum(F); % sum
    F = movmean(permute(F,[2,1]),12,'Endpoints','discard')'; % remove seasonal cycle    
    SOall = [SOall; -F*(86400*365)/10^12]; % mol/s into Tmol/yr
    
end
SOall = SOall - repmat(nanmean(SOall,2),1,size(SOall,2)); % remove long-term mean

% -- Associated time-vector
yyyy = sort(repmat(ywanted,1,12));
mm   = repmat(1:12,1,length(ywanted));
time = datenum(yyyy(6:end-6),mm(6:end-6),15);

clearvars -except FGOBM lon lat ywanted SOall time

% ---- Prepare the data from GOBMs
% For each model, select the Southern Ocean (<30°S), sum all grid cells
% (= create a multi-annual time series), remove the seasonal cycle with a 
% 12-month moving average, remove long-term mean, change sign
%
% Select the inversion wanted: since 1994 or 1999
%
% These outputs are saved in CO2_O2_SAM_timeseries.xlsx: O2 original

% load('data/Jena_inversion/FDATA_O2_9420.mat')
load('data/Jena_inversion/FDATA_O2_9920.mat')
SOall_DATA = [];

F = FDATA(:,lat <= -30,ismember(YYYY,ywanted)); % select Southern Ocean
F = reshape(F,size(F,1)*size(F,2),[]);
F = movmean(permute(nansum(F),[2,1]),12,'Endpoints','discard')'; % sum + remove seasonal cycle
F(F == 0) = NaN; % flag with NaN months without data
F = F - nanmean(F); % remove long-term mean
SOall_DATA = -F; % change sign
    
clearvars -except FGOBM FDATA lon lat ywanted modelnames SOall time SOall_DATA

% ---- Perform the decomposition
% The decadal component is obtained with a 48-month hanning window, the
% interannual component was extracted by removing the decadal component
% from the original time series, the interannual component was smoothed
% with a 5-month hanning window, caluclate average and STD values
%
% These outputs are saved in CO2_O2_SAM_timeseries.xlsx: CO2 decadal, CO2 
% interannual, O2 decadal, O2 interannual

% -- GOBMs decomposition
% decadal component
win = hann(48);
win = win/sum(win);
ydec = nan(size(SOall));
for M = 1:size(SOall,1)
    b2 = SOall(M,:);
    ydec(M,:) = conv(b2,win,'same');
end
% interannual component
win = hann(5);
win = win/sum(win);
ydec2 = nan(size(SOall));
for M = 1:size(SOall,1)
    b2 = SOall(M,:)-ydec(M,:);
    ydec2(M,:) = conv(b2,win,'same');
end
% their STD and average values
ydec_std_GOBM = [std(ydec)', std(ydec2)'];
ydec_GOBM = [mean(ydec)', mean(ydec2)'];

% -- Atmospheric inversion decomposition
% decadal component
win = hann(48);
win = win/sum(win);
b2 = SOall_DATA;
ydec = conv(b2,win,'same');
% interannual component
win = hann(5);
win = win/sum(win);
b2 = SOall_DATA-ydec;
ydec2 = conv(b2,win,'same');
% values
ydec_DATA = [ydec', ydec2'];

clearvars -except FGOBM FDATA lon lat time ydec_DATA ydec_GOBM ydec_std_GOBM