import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

class TrainScheduleFinderView extends WatchUi.View {

    private var timetable = [[514,0],[628,1],[655,0],[745,1],[815,0],[900,1],[930,0],[1015,1],[1045,0],[1130,1],[1200,0],[1245,1],[1315,0],[1400,1],[1430,0],[1515,1],[1545,0],[1630,1],[1700,0],[1745,1],[1815,0],[1900,1],[1930,0],[2015,1],[2045,0],[2130,1],[2200,0],[2245,1],[2315,0],[2400,1],[2430,2]];

    function initialize() {
        View.initialize();
    }

    function getTime(current_time){
        var result = [[0,0],[0,0]];
        for(var i = 0; i < timetable.size(); i++){
            if (current_time < timetable[i][0]){
                result[0][0] = timetable[i][0];
                result[0][1] = timetable[i][1];
                if (i == timetable.size()-1){
                    result[1][0] = "";
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

        var clockTime = Sys.getClockTime();
        var hour = clockTime.hour.format("%02d");
        var minute = clockTime.min.format("%02d");
        var hour1 = hour.substring(0, 1);
        var hour2 = hour.substring(1, 2);
        var minute1 = minute.substring(0, 1);
        var minute2 = minute.substring(1, 2);
        
        var TimeStr;
        TimeStr = Lang.format("$1$ $2$ $3$ $4$", [hour1, hour2, minute1, minute2]);
        var tex = Lang.format("$1$$2$", [hour,minute]);
        var hours = getTime(tex.toNumber());

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
