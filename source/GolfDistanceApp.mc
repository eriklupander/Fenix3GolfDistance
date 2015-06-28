using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

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

	function onHold(key) {
		Sys.println("onHold");
		Ui.pushView(new Rez.Menus.MainMenu(), new GolfDistanceMenuDelegate(), Ui.SLIDE_UP);
        return true;
	}
	
	function onRelease(key) {
		Sys.println("onRelease");
		Ui.pushView(new Rez.Menus.MainMenu(), new GolfDistanceMenuDelegate(), Ui.SLIDE_UP);
        return true;
	}
	
	function onKey(key) {
	
		if (key.getKey() == Ui.KEY_MENU) {
			Ui.pushView(new Rez.Menus.MainMenu(), new GolfDistanceMenuDelegate(), Ui.SLIDE_UP);
	       return true;
		}
		
		if (key.getKey() == Ui.KEY_UP) {
			if (currentHoleIdx < courses[currentCourseIdx]["holeCount"]-1) {
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
		    	 currentHoleIdx = courses[currentCourseIdx]["holeCount"]-1;
	    	}
			return true;
		}
		return false;
	}
}	

//class GolfDistanceDelegate extends Ui.BehaviorDelegate {

  //  function onMenu() {
   //     Ui.pushView(new Rez.Menus.MainMenu(), new GolfDistanceMenuDelegate(), Ui.SLIDE_UP);
    //    return true;
   // }
//}
