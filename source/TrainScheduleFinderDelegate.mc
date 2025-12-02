import Toybox.Lang;
import Toybox.WatchUi;

class TrainScheduleFinderDelegate extends WatchUi.BehaviorDelegate {
    var mView;

    function initialize(view) {
        BehaviorDelegate.initialize();
        mView = view;
    }

    function onSelect() {
        mView.nextSchedule();
        WatchUi.requestUpdate();
        return true;
    }

    function onNextPage() {
        mView.nextSchedule();
        WatchUi.requestUpdate();
        return true;
    }

    function onPreviousPage() {
        mView.previousSchedule();
        WatchUi.requestUpdate();
        return true;
    }
}
