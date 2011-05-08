
function compute_ror() 
    % compute daily rate of returns for 14 ETFs
    load ETF14_Feb05_Dec10.mat;
    
    % SPY IJH	IJR	IYY	
    SPY_dat = computeRate(SPY_dat);
    IJH_dat = computeRate(IJH_dat);
    IJR_dat = computeRate(IJR_dat);
    IYY_dat = computeRate(IYY_dat);
  
    % XLE	EWZ	EWJ	EWH	    
    XLE_dat = computeRate(XLE_dat);
    EWZ_dat = computeRate(EWZ_dat);
    EWJ_dat = computeRate(EWJ_dat);
    EWH_dat = computeRate(EWH_dat);

    % EEM	EZU	EFA	AGG	    
    EEM_dat = computeRate(EEM_dat);
    EZU_dat = computeRate(EZU_dat);
    EFA_dat = computeRate(EFA_dat);
    AGG_dat = computeRate(AGG_dat);

    % IAU	IYR    
    IAU_dat = computeRate(IAU_dat);
    IYR_dat = computeRate(IYR_dat);
    
    save('ETF14_ROR_Feb05_Dec10.mat');

    % Combine rate into one datasdet
    dateVec = SPY_dat.Date;
    [n, ~] = size(SPY_dat);
    dayRateMat = zeros(n,14);    
    dayRateMat(:,1) = SPY_dat.Rate;
    dayRateMat(:,2) = IJH_dat.Rate;
    dayRateMat(:,3) = IJR_dat.Rate;
    dayRateMat(:,4) = IYY_dat.Rate;
    
    dayRateMat(:,5) = XLE_dat.Rate;
    dayRateMat(:,6) = EWZ_dat.Rate;
    dayRateMat(:,7) = EWJ_dat.Rate;
    dayRateMat(:,8) = EWH_dat.Rate;
    
    dayRateMat(:,9) = EEM_dat.Rate;
    dayRateMat(:,10) = EZU_dat.Rate;
    dayRateMat(:,11) = EFA_dat.Rate;
    dayRateMat(:,12) = AGG_dat.Rate;
    dayRateMat(:,13) = IAU_dat.Rate;
    dayRateMat(:,14) = IYR_dat.Rate;
    combineROR(dateVec, dayRateMat);
end

function newdataset = computeRate(data) 
    [n, ~] = size(data);
    data.Prev_Adj_Close = [data.Adj_Close(2:n);NaN];
    data.Rate = 100*(data.Adj_Close - data.Prev_Adj_Close)./data.Prev_Adj_Close;
    newdataset = data;
end

function combineROR(dateVec,dayRateMat)
    outfile = 'dayROR_ETF14';
    dayROR_ETF14 = dataset({dateVec,'Date'}, {dayRateMat, 'SPY', 'IJH','IJR','IYY','XLE', 'EWZ','EWJ','EWH','EEM','EZU','EFA','AGG','IAU','IYR'});
    save(outfile,'-v7.3','dayROR_ETF14');
end



