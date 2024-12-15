#!/bin/bash

# Full path to PowerShell executable
POWERSHELL_PATH="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"

# Log file with date and time
LOG_DIR="logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/cookie_clicker_$(date +'%Y-%m-%d_%H-%M-%S').log"

# Colors for formatting
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RED='\033[0;31m'
RESET='\033[0m'

# Track the start time and elapsed days
START_TIME=$(date +%s)
DAYS_ELAPSED=0

# Trap SIGINT (Ctrl+C) to ensure cleanup on exit
function cleanup {
    echo -e "${RED}Exiting script... Cleaning up.${RESET}"
    close_cookie_clicker
    log_action "Script terminated by user."
    exit 0
}
trap cleanup SIGINT

# Function to log actions
function log_action {
    echo "$(date): $1" >> "$LOG_FILE"
}

# Function to open the Cookie Clicker game
function open_cookie_clicker {
    log_action "Opening Cookie Clicker."
    nohup "/mnt/c/Program Files (x86)/Steam/steamapps/common/Cookie Clicker/Cookie Clicker.exe" &> /dev/null &
    if [ $? -eq 0 ]; then
        log_action "Cookie Clicker opened successfully."
    else
        log_action "Failed to open Cookie Clicker."
    fi
}

# Function to close Cookie Clicker using taskkill
function close_cookie_clicker {
    log_action "Closing Cookie Clicker."
    /mnt/c/Windows/System32/taskkill.exe /IM "Cookie Clicker.exe" /F &> /dev/null
    if [ $? -eq 0 ]; then
        log_action "Cookie Clicker closed successfully."
    else
        log_action "Failed to close Cookie Clicker or it was not running."
    fi
}

# Function to move the Windows system time forward by 1 hour
function move_time_forward {
    log_action "Moving system time forward by 1 hour."
    $POWERSHELL_PATH -Command "Start-Process powershell.exe -ArgumentList 'Set-Date -Date (Get-Date).AddHours(1)' -Verb RunAs" &> /dev/null
    if [ $? -eq 0 ]; then
        log_action "System time moved forward successfully."
    else
        log_action "Failed to move system time forward."
    fi
}

# Function to display the title block and runtime
function display_runtime {
    local current_time=$(date +%s)
    local elapsed_seconds=$((current_time - START_TIME))
    local elapsed_days=$((elapsed_seconds / 86400))
    local elapsed_hours=$(( (elapsed_seconds % 86400) / 3600 ))
    local elapsed_minutes=$(( (elapsed_seconds % 3600) / 60 ))
    local elapsed_secs=$((elapsed_seconds % 60))

    if [ $elapsed_days -ne $DAYS_ELAPSED ]; then
        DAYS_ELAPSED=$elapsed_days
    fi

    # Clear the screen and display runtime
    clear
    echo -e "${GREEN}=========================================${RESET}"
    echo -e "${CYAN}      COOKIE CLICKER TIME SKIPPER       ${RESET}"
    echo -e "${GREEN}=========================================${RESET}"
    echo -e "${YELLOW}Cookie Clicker Opened:${RESET} ${BLUE}$(date)${RESET}"
    echo -e "${YELLOW}Days Passed:${RESET} ${BLUE}${elapsed_days}${RESET}"
    echo -e "${YELLOW}Elapsed Time:${RESET} ${BLUE}${elapsed_hours}h ${elapsed_minutes}m ${elapsed_secs}s${RESET}"
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

# Main loop to repeatedly run the script
while true; do
    display_runtime
    run
done
