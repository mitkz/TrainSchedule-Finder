import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

class TrainScheduleFinderView extends WatchUi.View {

    private var timetable = [[514,false],[628,true],[655,false],[745,true],[815,false],[900,true],[930,false],[1015,true],[1045,false],[1130,true],[1200,false],[1245,true],[1315,false],[1400,true],[1430,false],[1515,true],[1545,false],[1630,true],[1700,false],[1745,true],[1815,false],[1900,true],[1930,false],[2015,true],[2045,false],[2130,true],[2200,false],[2245,true],[2315,false],[2400,true],[2430,false]];

    function initialize() {
        View.initialize();
    }

    function getTime(current_time){
        var result = [[0,false],[0,false]];
        for(var i = 0; i < timetable.size(); i++){
            if (current_time < timetable[i][0]){
                System.println(Lang.format("$1$ : $2$", [timetable[i][0],timetable[i][1]]));
                result[0][0] = timetable[i][0];
                result[0][1] = timetable[i][1];
                if (i == timetable.size()-1){
                    result[1][0] = "";
                    result[1][1] = false;
                }else{
                    result[1][0] = timetable[i+1][0];
                    result[1][1] = timetable[i+1][1];
                }
                break;
            }
        }

    return result;
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

        dc.drawText(120, 30, Graphics.FONT_NUMBER_HOT, hours[0][0], Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(120, 100, Graphics.FONT_NUMBER_HOT, hours[1][0], Graphics.TEXT_JUSTIFY_CENTER);
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
