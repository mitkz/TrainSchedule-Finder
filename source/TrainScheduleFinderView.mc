import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;

class TrainScheduleFinderView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function getTimetable(weekday){
        if (weekday == 1 || weekday == 7){
            return TrainScheduleData.holiday_table;
        }else{
            return TrainScheduleData.weekday_table;
        }
    }

    function getTime(clockTime){
        var result = [["----",0],["----",0]];
        var current_time = (clockTime.hour.format("%02d") + clockTime.min.format("%02d")).toNumber();
        var timetable = getTimetable(clockTime.day_of_week);
        for(var i = 0; i < timetable.size(); i++){
            if (current_time < timetable[i][0]){
                result[0][0] = timetable[i][0];
                result[0][1] = timetable[i][1];
                if (i == timetable.size()-1){
                    result[1][0] = "----";
                    result[1][1] = 0;
                }else{
                    result[1][0] = timetable[i+1][0];
                    result[1][1] = timetable[i+1][1];
                }
                break;
            }
        }

    return result;
    }

    function displayTime(dc as Dc, time, x, y) as Void {
        if(time[1] == 0){
            dc.setColor(0x000000, Graphics.COLOR_WHITE);
        } else if (time[1] == 1) {
            dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.COLOR_WHITE);
        } else if (time[1] == 2) {
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_WHITE);
        } else {
            dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_WHITE);
        }
        dc.drawText(x, y,  Graphics.FONT_NUMBER_HOT, time[0], Graphics.TEXT_JUSTIFY_CENTER);
    }

    function drawTime(dc as Dc) as Void {
        dc.setColor(0x000000, Graphics.COLOR_WHITE);

        var clockTime = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var hour = clockTime.hour.format("%02d");
        var minute = clockTime.min.format("%02d");
        if(hour.equals("00")){
            hour = "24";
        }
        var hour1 = hour.substring(0, 1);
        var hour2 = hour.substring(1, 2);
        var minute1 = minute.substring(0, 1);
        var minute2 = minute.substring(1, 2);
        
        var TimeStr;
        TimeStr = Lang.format("$1$ $2$ $3$ $4$", [hour1, hour2, minute1, minute2]);
        var hours = getTime(clockTime);

        displayTime(dc, hours[0], 120, 30);
        displayTime(dc, hours[1], 120, 100);
        
        dc.setColor(0x000000, Graphics.COLOR_WHITE);
        dc.drawText(120, 190, Graphics.FONT_SYSTEM_LARGE, TimeStr, Graphics.TEXT_JUSTIFY_CENTER);

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
        drawTime(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
