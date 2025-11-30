import Toybox.Lang;
import Toybox.WatchUi;

class TrainScheduleFinderDelegate extends WatchUi.BehaviorDelegate {
    var mView;

    function initialize(view) {
        BehaviorDelegate.initialize();
        mView = view;
    }

    // Handle swipe left gesture
    function onSwipe(swipeEvent) {
        var direction = swipeEvent.getDirection();
        // Toggle only on right-to-left swipe; let left-to-right fall through to Back
        if (direction == WatchUi.SWIPE_LEFT) {
            mView.toggleDirection();
            return true;
        }
        return false;
    }

    // Some devices interpret horizontal swipes as mode/back behaviors
    function onPreviousMode() {
        mView.toggleDirection();
        return true;
    }

    function onNextMode() {
        mView.toggleDirection();
        return true;
    }

    function onBack() {
        // Do not consume back; allow system to exit to watch
        return false;
    }

    function onNextPage() {
        mView.toggleDirection();
        return true;
    }

    function onPreviousPage() {
        mView.toggleDirection();
        return true;
    }

    function onSelect() {
        var view = new TrainScheduleFinderView();
        var delegate = new TrainScheduleFinderDelegate(view);
        WatchUi.pushView(view, delegate, WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}
