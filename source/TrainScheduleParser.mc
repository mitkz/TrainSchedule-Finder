// Train Schedule Parser - Processing logic
// Handles string parsing and schedule retrieval
using TrainScheduleData;

module TrainScheduleParser {
    
    // Cache variables
    var _scheduleCache = null;
    var _cachedIndex = -1;

    // Find next two trains from string without parsing entire timetable
    function findNextTrains(str, currentTime) {
        var result = [[-1,0],[-1,0]];
        var len = str.length();
        var i = 0;
        var found = 0;
        
        while (i < len && found < 2) {
            var time = 0;
            var c;
            
            // Parse time
            while (i < len) {
                c = str.substring(i, i+1);
                var digit = -1;
                if (c.equals("0")) { digit = 0; }
                else if (c.equals("1")) { digit = 1; }
                else if (c.equals("2")) { digit = 2; }
                else if (c.equals("3")) { digit = 3; }
                else if (c.equals("4")) { digit = 4; }
                else if (c.equals("5")) { digit = 5; }
                else if (c.equals("6")) { digit = 6; }
                else if (c.equals("7")) { digit = 7; }
                else if (c.equals("8")) { digit = 8; }
                else if (c.equals("9")) { digit = 9; }
                
                if (digit >= 0) {
                    time = time * 10 + digit;
                    i++;
                } else {
                    break;
                }
            }
            
            // Expect ':'
            if (i < len && str.substring(i, i+1).equals(":")) {
                i++;
                var type = 0;
                if (i < len) {
                    c = str.substring(i, i+1);
                    if (c.equals("1")) { type = 1; }
                    else if (c.equals("2")) { type = 2; }
                    i++;
                }
                
                // Check if this train is after current time
                if (time > currentTime) {
                    result[found][0] = time;
                    result[found][1] = type;
                    found++;
                }
                
                // Skip ','
                if (i < len && str.substring(i, i+1).equals(",")) {
                    i++;
                }
            } else {
                // Skip to next comma
                while (i < len && !str.substring(i, i+1).equals(",")) {
                    i++;
                }
                if (i < len) { i++; }
            }
        }
        return result;
    }

    // Get schedule data by index
    function getSchedule(idx) {
        if (idx < 0 || idx >= TrainScheduleData.getScheduleCount()) {
            return null;
        }
        if (_cachedIndex == idx && _scheduleCache != null) {
            return _scheduleCache;
        }
        
        // Clear old cache
        _scheduleCache = null;
        
        var raw = TrainScheduleData.getRawSchedule(idx);
        // Only cache title and strings, not parsed arrays
        _scheduleCache = {
            "title" => raw["title"],
            "weekday_str" => raw["weekday_str"],
            "holiday_str" => raw["holiday_str"]
        };
        _cachedIndex = idx;
        return _scheduleCache;
    }
    
    // Get schedule title without caching
    function getScheduleTitle(idx) {
        if (idx < 0 || idx >= TrainScheduleData.getScheduleCount()) {
            return "No Schedule";
        }
        return TrainScheduleData.getRawSchedule(idx)["title"];
    }

    // Get total number of schedules
    function getScheduleCount() {
        return TrainScheduleData.getScheduleCount();
    }
}
