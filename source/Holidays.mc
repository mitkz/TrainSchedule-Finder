import Toybox.Lang;

// Holiday data for train schedule determination
// Format: Array of dates in MMDD format (e.g., 101 = January 1st, 1225 = December 25th)
// This data can be updated by an external program
module Holidays {
    // Japanese national holidays and other holidays
    // Add holiday dates in MMDD format
    var holiday_dates = [
        // January
        101,    // 元日 (New Year's Day)
        109,    // 成人の日 (Coming of Age Day) - 2nd Monday of January (example date)
        // February
        211,    // 建国記念の日 (National Foundation Day)
        223,    // 天皇誕生日 (Emperor's Birthday)
        // March
        320,    // 春分の日 (Vernal Equinox Day) - varies
        // April
        429,    // 昭和の日 (Showa Day)
        // May
        503,    // 憲法記念日 (Constitution Memorial Day)
        504,    // みどりの日 (Greenery Day)
        505,    // こどもの日 (Children's Day)
        // July
        715,    // 海の日 (Marine Day) - 3rd Monday of July (example date)
        // August
        811,    // 山の日 (Mountain Day)
        // September
        916,    // 敬老の日 (Respect for the Aged Day) - 3rd Monday of September (example date)
        923,    // 秋分の日 (Autumnal Equinox Day) - varies
        // October
        1009,   // スポーツの日 (Sports Day) - 2nd Monday of October (example date)
        // November
        1103,   // 文化の日 (Culture Day)
        1123,   // 勤労感謝の日 (Labour Thanksgiving Day)
        // December
        1231    // 大晦日 (New Year's Eve) - optional
    ];

    // Check if the given date (month, day) is a holiday
    function isHoliday(month as Number, day as Number) as Boolean {
        var dateValue = month * 100 + day;
        for (var i = 0; i < holiday_dates.size(); i++) {
            if (holiday_dates[i] == dateValue) {
                return true;
            }
        }
        return false;
    }
}
