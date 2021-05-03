
library(tidyhydat)
source("./R/ch_tidyhydat_ECDE.R")
source("./R/ch_qa_hydrograph.R")
source("./R/ch_get_wscstation.R")

data<- hy_daily_flows("05BB001")
data.n <- ch_tidyhydat_ECDE(data)
data.nn <- data.n[!is.na(data.n$Flow),]

data.nn.2013 <- data.nn[data.nn$Date>="2012-01-01" & data.nn$Date< "2014-12-31",]
ch_qa_hydrograph(data.nn.2013)

source("./R/ch_regime_plot.R")
source("./R/ch_doys.R")
source("./R/ch_axis_doy.R")
ch_regime_plot(data.nn)

source("./R/ch_fdcurve.R")
ch_fdcurve(data.nn)


# There is an automated way to find thresholds for POT, but it's currently
# under review/not part of CSHShydRology yet.
source("./R/ch_get_peaks.R")
source("./R/ch_booth_plot.R")
thresh <- quantile(data.nn$Flow, 0.95)
POT<- ch_get_peaks(data.nn, threshold = thresh)
ch_booth_plot(POT$POTevents, threshold = thresh, title = "Booth plot (magnitude)")

