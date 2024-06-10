# TradingView Chart Launcher

The TradingView Chart Launcher is a shell script designed to streamline your stock analysis workflow by automating the process of opening multiple stock charts on TradingView. Given a list of stock tickers, this script opens each corresponding chart in your web browser sequentially. Once you close the browser tab or window for a particular stock, the script automatically proceeds to open the chart for the next stock in the list.

## Dependencies

- [Firefox](https://www.mozilla.org/en-US/firefox/download/thanks/)
- [fzf](https://github.com/junegunn/fzf)

## Installation

```
git clone https://github.com/XEHIL/chartLauncher.git
cd chartLauncher
chmod +x chartLauncher.sh
```

## Execution

`./chartLauncher.sh`

This will load the list of stocks present in `chartList` directory.

![chartLauncher](https://github.com/XEHIL/chartLauncher/blob/main/images/chartLauncher.jpg "chartLauncher")
