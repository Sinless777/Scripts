# Cookie Clicker Automation Script

## Description

This script automates running the Cookie Clicker game, advancing the system time, and keeping track of runtime. It is designed to repeatedly open the game, simulate gameplay, and then adjust the system time for automation purposes.

## File Structure

```
cookie-clicker/
│
├── cookie-clicker.sh   # The main automation script
├── logs/               # Directory containing log files
└── Readme.md           # This documentation
```

## Prerequisites

1. **Environment Requirements**:
   - The script is designed for Linux with access to Windows applications through WSL (Windows Subsystem for Linux).
   - Ensure PowerShell is installed and accessible via `/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe`.

2. **Permissions**:
   - Administrator privileges are required to run commands like `Set-Date` and `taskkill`.

3. **Cookie Clicker Path**:
   - Verify that Cookie Clicker is installed in the default Steam path:
     ```
     /mnt/c/Program Files (x86)/Steam/steamapps/common/Cookie Clicker/Cookie Clicker.exe
     ```

## Usage

1. **Setup**:
   - Place `cookie-clicker.sh` in the `cookie-clicker/` directory.
   - Create a `logs/` folder inside the `cookie-clicker/` directory to store log files.

2. **Execution**:
   - Run the script using the command:
     ```
     ./cookie-clicker.sh
     ```

3. **Exit**:
   - Press `Ctrl+C` to stop the script. It will clean up resources (e.g., close the game) and log the termination.

## Features

- **Automatic Gameplay**:
  - Opens the Cookie Clicker game and allows it to run for a set period.

- **System Time Advancement**:
  - Moves the system clock forward by one hour to simulate progression.

- **Logging**:
  - All actions (e.g., game open/close, time adjustments) are logged in the `logs/` directory for tracking and debugging.

- **Runtime Display**:
  - Dynamically updates and displays the runtime, elapsed days, and session details.

- **Graceful Exit**:
  - Handles `Ctrl+C` signals to ensure a clean termination process.

## Log File

Logs are stored in `logs/` and can be reviewed to track the script's actions. Example usage:
```
cat logs/cookie_clicker.log
```

## Customization

1. **Sleep Duration**:
   - Modify sleep intervals to adjust gameplay and pause durations in the script.

2. **Paths**:
   - Update the paths to Cookie Clicker or PowerShell if they differ from the defaults.

## Troubleshooting

- **Permission Denied**:
  - Ensure the script has executable permissions:
    ```
    chmod +x cookie-clicker.sh
    ```

- **Incorrect Paths**:
  - Verify paths to PowerShell and Cookie Clicker in the script.

- **Administrator Rights**:
  - Run the script with elevated permissions if required for modifying the system time.