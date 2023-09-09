import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;

class TrainScheduleFinderView extends WatchUi.View {

    private var weekday_table = [[514,0],[628,1],[655,0],[745,1],[815,0],[900,1],[930,0],[1015,1],[1045,0],[1130,1],[1200,0],[1245,1],[1315,0],[1400,1],[1430,0],[1515,1],[1545,0],[1630,1],[1700,0],[1745,1],[1815,0],[1900,1],[1930,0],[2015,1],[2045,0],[2130,1],[2200,0],[2245,1],[2315,0],[2400,1],[2430,2]];
    private var holiday_table = [[514,0],[628,1],[645,0],[735,1],[805,0],[900,0],[920,0],[1005,1],[1035,0],[1120,1],[1150,0],[1235,1],[1305,0],[1400,0],[1420,0],[1505,1],[1535,0],[1620,1],[1650,0],[1735,1],[1805,0],[1900,0],[1920,0],[2005,1],[2035,0],[2120,1],[2150,0],[2235,1],[2305,0],[2400,0],[2420,2]];
    
    function initialize() {
        View.initialize();
    }

    function getTimetable(weekday){
        if (weekday == 1 || weekday == 7){
            return holiday_table;
        }else{
            return weekday_table;
        }
    }

    function getDepartureTime(current_time){
        var result = [["----",0],["----",0]];
        var current_time_formatted = (current_time.hour.format("%02d") + current_time.min.format("%02d")).toNumber();
        var timetable = getTimetable(current_time.day_of_week);
        for(var i = 0; i < timetable.size(); i++){
            if (current_time_formatted < timetable[i][0]){
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

    function drawDepartureTime(dc as Dc, time, x, y) as Void {
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
        
        var departure_time = getDepartureTime(current_time);
        drawDepartureTime(dc, departure_time[0], 120, 30);
        drawDepartureTime(dc, departure_time[1], 120, 100);
        
        dc.setColor(0x000000, Graphics.COLOR_WHITE);
        dc.drawText(120, 190, Graphics.FONT_SYSTEM_LARGE, getTimeStr(current_time), Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
}
