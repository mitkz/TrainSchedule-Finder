import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;

class TrainScheduleFinderView extends WatchUi.View {
    // false = outbound (going), true = return (coming back)
    var isReturnTrip = false;

    function initialize() {
        View.initialize();
    }

    function toggleDirection() {
        isReturnTrip = !isReturnTrip;
        WatchUi.requestUpdate();
    }

    function getTimetable(weekday){
        var isHoliday = (weekday == 1 || weekday == 7);
        if (isReturnTrip) {
            return isHoliday ? TrainScheduleData.holiday_return_table : TrainScheduleData.weekday_return_table;
        } else {
            return isHoliday ? TrainScheduleData.holiday_table : TrainScheduleData.weekday_table;
        }
    }

    function getDepartureTime(current_time){
        var result = [["----",0],["----",0]] as Lang.Array;
        var current_time_formatted = (current_time.hour.format("%02d") + current_time.min.format("%02d")).toNumber();
        var timetable = getTimetable(current_time.day_of_week) as Lang.Array;
        for(var i = 0; i < timetable.size(); i++){
            var entry = timetable[i] as Lang.Array;
            if (current_time_formatted < entry[0]){
                var firstResult = result[0] as Lang.Array;
                firstResult[0] = entry[0];
                firstResult[1] = entry[1];
                if (i == timetable.size()-1){
                    var secondResult = result[1] as Lang.Array;
                    secondResult[0] = "----";
                    secondResult[1] = 0;
                }else{
                    var nextEntry = (timetable as Lang.Array)[i+1] as Lang.Array;
                    var secondResult = result[1] as Lang.Array;
                    secondResult[0] = nextEntry[0];
                    secondResult[1] = nextEntry[1];
                }
                break;
            }
        }
        return result;
    }

    function drawDepartureTime(dc as Dc, time as Lang.Array, x as Lang.Number, y as Lang.Number) as Void {
        var trainType = time[1] as Lang.Number;
        if(trainType == 0){
            dc.setColor(0x000000, Graphics.COLOR_WHITE);
        } else if (trainType == 1) {
            dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.COLOR_WHITE);
        } else if (trainType == 2) {
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_WHITE);
        } else {
            dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_WHITE);
        }
        dc.drawText(x, y, Graphics.FONT_NUMBER_HOT, time[0].toString(), Graphics.TEXT_JUSTIFY_CENTER);
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

    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Draw the background
        dc.setColor (Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        dc.fillRectangle(0, 0, 240,240);

        dc.setColor(0x000000, Graphics.COLOR_WHITE);
        var current_time = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        
        // Draw direction indicator (arrow showing direction)
        var directionLabel = isReturnTrip ? "<<<" : ">>>";
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.drawText(120, 165, Graphics.FONT_SYSTEM_TINY, directionLabel, Graphics.TEXT_JUSTIFY_CENTER);

        var departure_time = getDepartureTime(current_time) as Lang.Array;
        var nextTrain = departure_time[0] as Lang.Array;
        var followingTrain = departure_time[1] as Lang.Array;
        drawDepartureTime(dc, nextTrain, 120, 30);
        drawDepartureTime(dc, followingTrain, 120, 100);
        
        dc.setColor(0x000000, Graphics.COLOR_WHITE);
        dc.drawText(120, 190, Graphics.FONT_SYSTEM_LARGE, getTimeStr(current_time), Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
}
