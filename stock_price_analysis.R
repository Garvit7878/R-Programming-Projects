
# Stock Price Analysis using R
# Author: Garvit Sharma | University ID: 2301730190

# Install required packages (uncomment if not installed)
# install.packages("quantmod")
# install.packages("TTR")

library(quantmod)
library(TTR)

# Step 1: Fetch stock data for Apple Inc. (AAPL)
getSymbols("AAPL", src = "yahoo", from = "2023-01-01", to = Sys.Date())

# Step 2: Calculate Moving Averages
AAPL$SMA50 <- SMA(Cl(AAPL), n = 50)
AAPL$SMA200 <- SMA(Cl(AAPL), n = 200)

# Step 3: Plot the stock data and moving averages
chartSeries(AAPL, name = "Apple Inc. (AAPL) Stock Price with SMA50 & SMA200", theme = chartTheme("white"))
addSMA(n = 50, col = "blue")
addSMA(n = 200, col = "red")
