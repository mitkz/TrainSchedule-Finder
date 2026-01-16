import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;
using TrainScheduleParser;

class TrainScheduleFinderView extends WatchUi.View {
    // false = outbound (going), true = return (coming back)
    var isReturnTrip = false;
    var _currentScheduleIndex = 0;
    var _screenWidth = 240;
    var _screenHeight = 240;

    function initialize() {
        View.initialize();
    }

    // Get the current schedule from the schedules array
    function getCurrentSchedule() {
        return TrainScheduleParser.getSchedule(_currentScheduleIndex);
    }

    // Get the title of the current schedule
    function getCurrentTitle() {
        return TrainScheduleParser.getScheduleTitle(_currentScheduleIndex);
    }

    // Cycle to the next schedule
    function nextSchedule() {
        var count = TrainScheduleParser.getScheduleCount();
        if (count > 0) {
            _currentScheduleIndex = (_currentScheduleIndex + 1) % count;
        }
    }

    // Cycle to the previous schedule
    function previousSchedule() {
        var count = TrainScheduleParser.getScheduleCount();
        if (count > 0) {
            _currentScheduleIndex = (_currentScheduleIndex - 1 + count) % count;
        }
    }

    function toggleDirection() {
        isReturnTrip = !isReturnTrip;
        WatchUi.requestUpdate();
    }

    function getTimetable(weekday as Lang.Number){
        var schedule = getCurrentSchedule();
        if (schedule == null) {
            return [[0,0]];
        }
        
        var isHoliday = (weekday == 1 || weekday == 7);
        var timetableStr = isHoliday ? schedule["holiday_str"] : schedule["weekday_str"];
        
        return timetableStr;
    }

    function getDepartureTime(current_time as Gregorian.Info){
        var schedule = getCurrentSchedule();
        if (schedule == null) {
            return [[-1,0],[-1,0]];
        }
        
        var current_time_formatted = (current_time.hour.format("%02d") + current_time.min.format("%02d")).toNumber();
        var isHoliday = (current_time.day_of_week == 1 || current_time.day_of_week == 7);
        var timetableStr = isHoliday ? schedule["holiday_str"] : schedule["weekday_str"];
        
        return TrainScheduleParser.findNextTrains(timetableStr, current_time_formatted);
    }

    function drawDepartureTime(dc as Dc, time as Lang.Array, x as Lang.Number, y as Lang.Number) as Void {
        var displayTime;
        if (time[0] == -1) {
            displayTime = "----";
        } else {
            displayTime = time[0];
        }
        var trainType = time[1] as Lang.Number;
        if(trainType == 0){
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        } else if (trainType == 1) {
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
        } else if (trainType == 2) {
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        } else {
            dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
        }
        dc.drawText(x, y,  Graphics.FONT_NUMBER_HOT, displayTime, Graphics.TEXT_JUSTIFY_CENTER);
    }

    function getTimeStr(current_time){
        var hour = current_time.hour.format("%02d");
        var minute = current_time.min.format("%02d");
        if(hour.equals("00")){
            hour = "24";
        }
        var TimeStr = Lang.format("$1$ $2$ $3$ $4$", [hour.substring(0, 1), hour.substring(1, 2), minute.substring(0, 1), minute.substring(1, 2)]);
        return TimeStr;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        _screenWidth = dc.getWidth();
        _screenHeight = dc.getHeight();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get screen dimensions
        var width = _screenWidth;
        var height = _screenHeight;
        var centerX = width / 2;
        
        // Draw the background - use black for AMOLED power efficiency
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.fillRectangle(0, 0, width, height);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        var current_time = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        
        // Draw the schedule title at the top
        // Position: ~72% down from top (proportional to original 173/240)
        var titleY = (height * 72) / 100;
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(centerX, titleY, Graphics.FONT_XTINY, getCurrentTitle(), Graphics.TEXT_JUSTIFY_CENTER);
        
        var departure_time = getDepartureTime(current_time) as Lang.Array;
        var nextTrain = departure_time[0] as Lang.Array;
        var followingTrain = departure_time[1] as Lang.Array;
        
        // Position next train: ~12.5% from top (proportional to original 30/240)
        var nextTrainY = (height * 125) / 1000;  // 12.5% = 125/1000
        drawDepartureTime(dc, nextTrain, centerX, nextTrainY);
        
        // Position following train: ~42% from top (proportional to original 100/240)
        var followingTrainY = (height * 42) / 100;
        drawDepartureTime(dc, followingTrain, centerX, followingTrainY);
        
        // Position current time: ~79% from top (proportional to original 190/240)
        var timeY = (height * 79) / 100;
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, timeY, Graphics.FONT_SYSTEM_LARGE, getTimeStr(current_time), Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
}
