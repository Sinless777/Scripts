#!/bin/bash

# Full path to PowerShell executable
POWERSHELL_PATH="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"

# Colors for formatting
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Track the start time and elapsed days
START_TIME=$(date +%s)
DAYS_ELAPSED=0

# Function to open the Cookie Clicker game
function open_cookie_clicker {
    nohup "/mnt/c/Program Files (x86)/Steam/steamapps/common/Cookie Clicker/Cookie Clicker.exe" &> /dev/null &
}

# Function to close Cookie Clicker using taskkill
function close_cookie_clicker {
    /mnt/c/Windows/System32/taskkill.exe /IM "Cookie Clicker.exe" /F &> /dev/null
}

# Function to move the Windows system time forward by 1 hour
function move_time_forward {
    $POWERSHELL_PATH -Command "Start-Process powershell.exe -ArgumentList 'Set-Date -Date (Get-Date).AddHours(1)' -Verb RunAs" &> /dev/null
}

# Function to display the title block and runtime
function display_runtime {
    while true; do
        local current_time=$(date +%s)
        local elapsed_seconds=$((current_time - START_TIME))
        local elapsed_days=$((elapsed_seconds / 86400))
        local elapsed_hours=$(( (elapsed_seconds % 86400) / 3600 ))
        local elapsed_minutes=$(( (elapsed_seconds % 3600) / 60 ))
        local elapsed_secs=$((elapsed_seconds % 60))

        if [ $elapsed_days -ne $DAYS_ELAPSED ]; then
            DAYS_ELAPSED=$elapsed_days
        fi

        # Single-line output with carriage return to overwrite
        echo -ne "\r${GREEN}=========================================${RESET}"
        echo -ne "\n${CYAN}      COOKIE CLICKER TIME SKIPPER       ${RESET}"
        echo -ne "\n${GREEN}=========================================${RESET}"
        echo -ne "\n${YELLOW}Cookie Clicker Opened:${RESET} ${BLUE}$(date)${RESET}"
        echo -ne "\n${YELLOW}Days Passed:${RESET} ${BLUE}${elapsed_days}${RESET}"
        echo -ne "\n${YELLOW}Elapsed Time:${RESET} ${BLUE}${elapsed_hours}h ${elapsed_minutes}m ${elapsed_secs}s${RESET}   \r"
        sleep 1
    done
}

# Main function to open, close, and move time forward
function run {
    # Open the game
    open_cookie_clicker

    # Let the game run for a bit (adjust as needed)
    sleep 61

    # Close the game
    close_cookie_clicker

    # Move the system time forward by 1 hour
    move_time_forward

    # Pause to allow changes to take effect
    sleep 5
}

# Main loop to display runtime and execute the main function
(
    display_runtime
) &  # Run display_runtime in the background

while true; do
    run
done
