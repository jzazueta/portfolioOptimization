## 'iShares MSCI EMU Index 

library("quantmod")
        
getSymbols("EZU",src="yahoo")
barChart(EZU)

EZU.returns = periodReturn(EZU,period='monthly')
ndays = dim(EZU.returns)[1]

today.returns = EZU.returns
today.returns[1,] = NA
today.returns = subset(today.returns, !is.na(today.returns))

prev.returns = EZU.returns
prev.returns[ndays,] = NA
prev.returns = subset(prev.returns, !is.na(prev.returns))

corr.returns = data.frame(today.returns)
corr.returns$prev.returns = prev.returns

names(corr.returns) = c("today.returns", "prev.returns")

cor(corr.returns)

corr.returns$today_bins=cut(corr.returns$today.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))
corr.returns$prev_bins =cut(corr.returns$prev.returns, breaks = c(-1.0,-0.04,-0.02, -0.01, 0.0, 0.01, 0.02, 0.04, 1.0))

freq_table = table(corr.returns$prev_bins, corr.returns$today_bins)

freq_table

sum(freq_table)

cond_prob = freq_table

cond_prob = cond_prob/colSums(cond_prob)

print(round(cond_prob,2))

