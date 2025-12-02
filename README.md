# TrainSchedule-Finder
A GARMIN watch widget to know the departure times of the nearest train station.

This program does not get data from the internet, it uses the data, which defined as Array in source/TrainScheduleData.mc.

## Setup

1. Copy `source/TrainScheduleData.mc.example` to `source/TrainScheduleData.mc`
2. Replace with your actual train schedule data

## Train Schedule Data Format

The data structure uses an array of schedule objects. Each schedule contains:
- `title`: Name/description of the timetable (displayed at the top of the widget)
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

## FAQ  

Q: Why don't you get data from the internet?  
A: Watch and phone are frequently disconected. I think it isn't reasonable to get data from the internet everytime. (Train schedule is not changed frequently.) 
