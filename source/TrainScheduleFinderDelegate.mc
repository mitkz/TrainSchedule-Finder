import Toybox.Lang;
import Toybox.WatchUi;

class TrainScheduleFinderDelegate extends WatchUi.BehaviorDelegate {

    private var _view as TrainScheduleFinderView;

    function initialize(view as TrainScheduleFinderView) {
        BehaviorDelegate.initialize();
        _view = view;
    }

    // Handle next page behavior (swipe up or next button)
    function onNextPage() as Boolean {
        _view.nextSchedule();
        WatchUi.requestUpdate();
        return true;
    }

    // Handle previous page behavior (swipe down or previous button)
    function onPreviousPage() as Boolean {
        _view.previousSchedule();
        WatchUi.requestUpdate();
        return true;
    }
}
