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
        if (direction == WatchUi.SWIPE_LEFT || direction == WatchUi.SWIPE_RIGHT) {
            mView.toggleDirection();
            return true;
        }
        return false;
    }
}
