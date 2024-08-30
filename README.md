![Header](https://github.com/tlorien/Powerful-PowerShell-Suite/blob/main/assets/img/2024-08-30%2010-30-30_1.gif)


# Powerful-PowerShell-Suite

Hi! Welcome to my repository of useful and fun PowerShell scripts. This collection includes a variety of scripts to enhance your PowerShell experience, from simple animations and prompt customizations to system monitoring tools.

To see the scripts in action try out the template PowerShell profile script that I have included. Ensure that the module scripts are within a /scripts/ folder in the directory of your PowerShell profile script.

[Not sure how to use PowerShell Profiles? Click here!](https://www.techtarget.com/searchwindowsserver/tutorial/How-to-find-and-customize-your-PowerShell-profile)

## Scripts

### 1. Mario Animation
A little script that plays an animation of Mario in your PowerShell console. A fun way to initialize new sessions. import the modules and call 'Draw-Mario' to play the animation.

### 2. Network Device Scanner
A network scanning tool designed to detect active devices on a specified subnet. The script pings each IP address within a given range and reports on devices that are active or inactive. Additionally, it can export the scan results to a CSV file for further analysis.

  #### Usage
  ```PowerShell
  -Subnet: The subnet to scan, specified in the format xxx.xxx.xxx. (default: 192.168.1.).
  -StartIP: The starting IP address for the scan range (default: 1).
  -EndIP: The ending IP address for the scan range (default: 254).
  -Timeout: The timeout in milliseconds for each ping request (default: 1000 ms).
  -OutputFile: (Optional) The file path to export the scan results in CSV format.
  ```
  **Example**:
  ```PowerShell
  Scan-Network
  ```

  ```PowerShell
  Scan-Network -Subnet "192.168.0." -StartIP 1 -EndIP 100 -Timeout 500 -OutputFile "C:\NetworkScanResults.csv"
  ```

### 3. Simple To-Do List
Manage your tasks with this simple to-do list script. Add, view, and mark tasks as completed with ease. Saves tasks to your PowerShell profile folder and displays remaining tasks upon new sessions (can be configured to once per day or not at all).

### 4. Theme Loader
Change the theme of your PowerShell environment quickly. Customize the shell's appearance and set XML or JSON templates for neater displays of data.

### 5. Random Programming Quote
Call random programming quotes in times of desperation—or initialize your sessions with them for inspo.

### 6. System Background Jobs
A collection of lightweight scripts to monitor various aspects of your system, ensuring everything runs smoothly. Uses a 'MonitorJob' class to define and manage individual monitoring tasks that run at specified intervals. Each task runs as a background job and reports its status in a consolidated table for easy monitoring.

The `Start-AllMonitors` function can be called to start several background monitoring tasks. Include in your profile script to initialize the tasks.

#### Includes:

  - **CPU Monitor**: Checks the average CPU load every 5 minutes and triggers an alert if the load exceeds 80%.
  - **Memory Monitor**: Monitors memory usage every 5 minutes and triggers an alert if the usage exceeds 80%.
  - **Disk Space Monitor**: Monitors disk space availability every hour and alerts if any drive's free space falls below 20 GB.
  - **Process Monitor**: Maintains a watch list of critical processes (defined by the user). Monitors the presence of the specified critical processes every 5 minutes and alerts if any are not running.
  - **System Health Monitor**: Maintains a watch list of processes critical to Windows system health (defined by the user; defaults to 'wuauserv' and 'bits'). Checks the status of critical Windows services every 10 minutes and alerts if any are not running.
  - **Temperature Monitor**: Monitors CPU and GPU temperatures every 5 minutes and triggers an alert if temperatures exceed 80°C.
  - **Battery Status Monitor**:
    - Checks if your device uses a battery; starts a monitoring process if it does. Monitors battery level every 10 minutes, displays a battery emoji:
      ```
      🔋 (Full), 🟢 (High), 🟡 (Moderate), 🟠 (Low), 🔴 (Very Low), ⚠️ (Critically Low).
      
    - Provides warnings for low or critical battery levels.

### 7. Custom Emoji Prompt
A collection of functions to personalize the command prompt with dynamic and visually engaging elements.

  #### Time of Day emojis:
      Calculates the current time to display an emoji representing the hour:
        Morning (5 AM - 11:59 AM): 🌅
        Afternoon (12 PM - 4:59 PM): 🌞
        Evening (5 PM - 8:59 PM): 🌇
        Night (9 PM - 4:59 AM): Calls 'Get-MoonPhaseEmoji' to get the moon phase emoji.

  #### Moon Phase emojis:
      Calculates the moon phase based on the current date to display an emoji representing the moon's phase:
        New Moon: 🌑
        Waxing Crescent: 🌒
        First Quarter: 🌓
        Waxing Gibbous: 🌔
        Full Moon: 🌕
        Waning Gibbous: 🌖
        Last Quarter: 🌗
        Waning Crescent: 🌘
  #### Late Night Reminder:
      Displays skull emojis 💀💀💀 as a reminder to rest during late night hours (12 AM - 5 AM).

  #### Colour randomization:
        Each prompt line is displayed in a randomly selected color, that does not conflict with the session's background color.
  #### Colour randomization:
        Separates each prompt with a visually appealing dividing line.
    
