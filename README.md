# Powerful-Powershell-Suite

Hi! Welcome to my repository of useful and fun PowerShell scripts. This collection includes a variety of scripts to enhance your PowerShell experience, from simple animations and prompt customizations to system monitoring tools.

To see the scripts in action try out the template powershell profile script that I have included.

[Not sure how to use Powershell Profiles? Click here!](https://www.techtarget.com/searchwindowsserver/tutorial/How-to-find-and-customize-your-PowerShell-profile)

## Scripts

### 1. Mario Animation
A little script that plays an animation of Mario in your PowerShell console. A fun way to initialize new sessions.

### 2. Network Device Scanner
Contains a function that can quickly scan your network for devices and displays the results. Useful for network administrators or anyone curious about active devices on their network.

### 3. Simple To-Do List
Manage your tasks with this simple to-do list script. Add, view, and mark tasks as completed with ease. Saves tasks to your powershell profile folder and displays remaining tasks upon new sessions (can be configured to once per day or not at all).

### 4. Theme Loader
Change the theme of your PowerShell environment quickly. Customize the shell's appearance and set XML or JSON templates for neater displays of data.

### 5. Random Programming Quote
Call random programming quotes in times of desperation—or initialize your sessions with them.

### 6. System Background Jobs
A collection of lightweight scripts to monitor various aspects of your system, ensuring everything runs smoothly. 

The `Start-AllMonitors` function can be used in your profile script to start several background monitoring tasks:

#### Includes:

  - **CPU Monitor**: Periodically checks on CPU usage (checks every 5 minutes). If CPU usage exceed 80% an alert message is displayed in the console.
  - **Memory Monitor**: Periodically checks on memory usage (checks every 5 minutes). If memory usage exceed 80% an alert message is displayed in the console.
  - **Disk Space Monitor**: Periodically checks on the remaining disk space (checks every 60 minutes).
  - **Process Monitor**: Maintains a watch list of critical processes (defined by the user). Periodically checks in on the critical processes (checks every 5 minutes) by retrieving the list and checking if any are missing. Alerts the user of missing processes.
  - **System Health Monitor**: Maintains a watch list of processes critical to Windows system health (defined by the user; defaults to 'wuauserv' and 'bits'). Periodically checks in on the system health services (checks every 5 minutes) by retrieving the list and checking if any are missing. Alerts the user of missing services.
  - **Temperature Monitor**: Periodically checks on CPU and GPU temperatures (checks every 5 minutes). If temperatures exceed 80°C an alert message is displayed in the console.
  - **Battery Status Monitor**:
    - Checks if your device uses a battery; starts a monitoring process if it does. Starts a lightweight monitoring process that modifies the user prompt to include emojis representing the remaining battery life:
      ```
      🔋 (Full), 🟢 (High), 🟡 (Moderate), 🟠 (Low), 🔴 (Very Low), ⚠️ (Critically Low).
      
    - Displays periodic warning messages when the battery is critically low, 'CRITICAL BATTERY LEVEL! BATTERY BELOW $criticalBatteryThreshold%! PLUG IN CHARGER!'.

### 7. Custom Emoji Prompt
A collection of functions to personalize the user prompt:
  - ISO 8601 Timestamp with appropriate emojis to represent the time of day and moon phases:
  #### Time of Day emojis:
      Calculates the moon phase based on the current date to display an emoji representing the moon's phase:
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

  - Changes the color of each new prompt randomly for easier reading; adds an ASCII art divider line.
    
