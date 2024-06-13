#!/usr/bin/env bash

BASE_DIR=$(pwd)

CHARTLIST_DIR="$BASE_DIR/chartList"

TV_URL="https://www.tradingview.com/chart/?symbol="

#----------


#TV_TIMEFRAME="1"
#TV_TIMEFRAME="3"
#TV_TIMEFRAME="5" 
#TV_TIMEFRAME="15"
#TV_TIMEFRAME="30"
#TV_TIMEFRAME="60"

TV_TIMEFRAME="D" 
#TV_TIMEFRAME="W" 
#TV_TIMEFRAME="M" 


#----------

BROWSER="firefox"

#------------COLORS--------------

declare -A colors

# ------------------
# ${colors[red]}
# ------------------

colors["red"]="\e[1;31m"
colors["cyan"]="\e[1;36m"
colors["magenta"]="\e[1;35m"
colors["green"]="\e[1;32m"
colors["yellow"]="\e[1;33m"
colors["blue"]="\e[1;34m"
colors["white"]="\e[1;37m"
colors["orange"]="\e[1;38;5;208m"
colors["purple"]="\e[1;38;5;93m"
colors["pink"]="\e[1;38;5;205m"
colors["skyblue"]="\e[1;38;5;111m"
colors["brown"]="\e[1;38;5;130m"
colors["lavender"]="\e[1;38;5;183m"
colors["lime"]="\e[1;38;5;154m"
colors["gold"]="\e[1;38;5;220m"
colors["teal"]="\e[1;38;5;23m"

cend="\e[0m"
# ------------------
# $cend
# ------------------

#-----------------------------------

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

if command_exists $BROWSER; then
    echo -e "${colors[green]}$BROWSER : installed$cend"
else
    echo -e "${colors[red]}$BROWSER : not installed$cend"
    exit 1
fi

if pidof $BROWSER >/dev/null; then
    echo -e "${colors[orange]}$BROWSER : already running$cend"
    echo -e "${colors[orange]}Close All $BROWSER Windows$cend"
    exit 1
fi

if command_exists fzf; then
    echo -e "${colors[green]}fzf : installed$cend"
else
    echo -e "${colors[red]}fzf : not installed$cend"
    exit 1
fi

if [ -d "$CHARTLIST_DIR" ]; then
    echo -e "${colors[green]}$CHARTLIST_DIR : exists$cend"
else
    echo -e "${colors[red]}$CHARTLIST_DIR : not found$cend"
    mkdir -p $CHARTLIST_DIR && echo -e "${colors[green]}$CHARTLIST_DIR : created$cend"
fi

echo -e "${colors[cyan]}~~~~~~~~~~~~~~~~~~~~~$cend"

files=($(ls "$CHARTLIST_DIR"))
chartFile=$(printf '%s\n' "${files[@]}" | fzf --prompt="Select List of Charts  " --height=30% --layout=reverse --border --exit-0)

if [[ -n "$chartFile" ]]; then

echo -e "${colors[cyan]}$chartFile"

total_lines=$(wc -l < "$CHARTLIST_DIR/$chartFile")
count=0  # Initialize count

    while IFS= read -r scrip_name; do
	
		count=$((count + 1))  # Increment count
		echo -e "${colors[orange]}~~~~~ $count / $total_lines ~~~~~$cend"
		
		echo -e "${colors[cyan]}$scrip_name$cend"
		
		LAUNCH_URL="$TV_URL$scrip_name&interval=$TV_TIMEFRAME"

        echo -e "${colors[yellow]}$LAUNCH_URL$cend"

        $BROWSER "$LAUNCH_URL" >/dev/null 2>&1

        wait $(pgrep -x "$(basename "$BROWSER")")

    done <$CHARTLIST_DIR/$chartFile
	
	echo -e "${colors[cyan]}~~~~~~~~~~~~~~~~~~~~~$cend"
	
	echo -e "${colors[cyan]}$chartFile : DONE$cend"
fi

