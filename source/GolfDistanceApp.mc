using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class GolfDistanceApp extends App.AppBase {

    //! onStart() is called on application start up
    function onStart() {
    }

    //! onStop() is called when your application is exiting
    function onStop() {
    }

    //! Return the initial view of your application here
    function getInitialView() {
        return [ new GolfDistanceView(), new KeyDelegate() ];
    }

}

class KeyDelegate extends Ui.InputDelegate {
	function onKey(key) {
		if (key.getKey() == Ui.KEY_UP) {
			if (currentHoleIdx < 17) {
		    	currentHoleIdx++;
		    } else {
		    	currentHoleIdx = 0;
	    	}
			return true;
		} 
		
		if (key.getKey() == Ui.KEY_DOWN) {
			if (currentHoleIdx > 0) {
    	 		currentHoleIdx--;
			} else {
		    	 currentHoleIdx = 17;
	    	}
			return true;
		}
		return false;
	}
}	

class GolfDistanceDelegate extends Ui.BehaviorDelegate {

    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new GolfDistanceMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }
}
