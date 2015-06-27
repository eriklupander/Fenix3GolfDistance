using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Communications as Comms;

class GolfDistanceMenuDelegate extends Ui.MenuInputDelegate {

    function onMenuItem(item) {
        if (item == :item_1) {
            Sys.println("Download...");
            //Comms.makeJsonRequest(url, request, options, responseCallback)
        }
    }

}