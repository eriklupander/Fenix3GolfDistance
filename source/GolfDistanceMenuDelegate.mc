using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Communications as Comms;

class GolfDistanceMenuDelegate extends Ui.MenuInputDelegate {

    function onMenuItem(item) {
        if (item == :item_1) {
            //Sys.println("Download...");
            //Comms.makeJsonRequest(url, request, options, responseCallback)
        	currentCourseIdx = 0;
        	currentHoleIdx = 0;
        	
       		Sys.println("IDX1");
        }
        
        if (item == :item_2) {
        	currentCourseIdx = 1;
       		currentHoleIdx = 0;
       		Sys.println("IDX2");
        }
    }

}