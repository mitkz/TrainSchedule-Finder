# TrainSchedule-Finder
A GARMIN watch widget to know the departure times of the nearest train station.

This program does not get data from the internet; it uses offline data defined as an array in `source/TrainScheduleData.mc`.

## Setup

1. Copy `source/TrainScheduleData.mc.example` to `source/TrainScheduleData.mc`
2. Replace with your actual train schedule data (see format below)
3. Build or deploy using the script in this repo

## Train Schedule Data Format

The data structure uses an array of schedule objects. Each schedule contains:
- `title`: Name/description of the timetable (displayed in the widget)
- `weekday`: Array of departure times for weekdays
- `holiday`: Array of departure times for holidays/weekends

Time entries use the format: `[hhmm(int), type(int)]`
- `hhmm`: departure time in 24-hour format (e.g., 514 = 05:14, 1200 = 12:00)
- `type`: 0 = local (black), 1 = express (green), 2 = special (red)

Example:
```
module TrainScheduleData {
    var schedules = [
        {
            "title" => "Commuting - Outbound (Home → Office)",
            "weekday" => [
                [514,0],[628,1],[655,0],[745,1],[815,0],[900,1],[930,0],[1015,1]
            ],
            "holiday" => [
                [614,0],[738,1],[855,0]
            ]
        },
        {
            "title" => "Commuting - Inbound (Office → Home)",
            "weekday" => [
                [1700,0],[1745,1],[1830,0],[1900,1],[2000,0]
            ],
            "holiday" => [
                [1700,0],[1800,1]
            ]
        },
        {
            "title" => "Airport Access (Central ↔ Airport)",
            "weekday" => [
                [500,1],[530,1],[600,1]
            ],
            "holiday" => [
                [520,1],[620,1]
            ]
        }
    ];
}
```

Please get time schedule from your favorite train company and convert it to the above format.
Edit the `schedules` variable in `source/TrainScheduleData.mc` to set your train schedules.

## Interaction

- Tap the watch (select button) to cycle to the next schedule in `TrainScheduleData.schedules`.
- The current schedule title is displayed on screen. The top area shows the title, and the bottom area (previously arrows) also shows the title for clarity.
- Swipe and page gestures are not used.

Note: Time entries are static and offline; the widget does not perform network access.

## Build & Deploy

Use the provided PowerShell script:

```powershell
# Build only (no deploy)
./deploy.ps1 -Action Build

# Build and deploy to device (default behavior)
./deploy.ps1 -Action Deploy
```

- `Build` compiles the widget and exits.
- `Deploy` waits for the device drive (e.g., `D:\GARMIN\APPS`) and copies `bin/TrainScheduleFinder.prg`.

## FAQ  

Q: Why don't you get data from the internet?  
A: Watch and phone are frequently disconnected. Train schedules don’t change often, so offline data is simpler and more reliable.

