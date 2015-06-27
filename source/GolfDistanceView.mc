using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Position as Position;
using Toybox.Math as Math;

var currentHoleIdx = 0; // 0-17

// Sotenas GK gul/rod test data.
var testCourse = [
	{"hcp" => 7, "par" => 4, "lat" => 58.433293, "lon" => 11.376316},
	{"hcp" => 13, "par" => 3, "lat" => 58.432704, "lon" => 11.374762},
	{"hcp" => 3, "par" => 5, "lat" => 58.430835, "lon" => 11.381258}, 
	{"hcp" => 9, "par" => 5, "lat" => 58.433912, "lon" => 11.378363}, 
	{"hcp" => 15, "par" => 3, "lat" => 58.433800, "lon" => 11.382001},
	{"hcp" => 5, "par" => 5, "lat" => 58.430854, "lon" => 11.384911}, 
	{"hcp" => 11, "par" => 4, "lat" => 58.433701, "lon" => 11.383324},
	{"hcp" => 17, "par" => 3, "lat" => 58.433514, "lon" => 11.387451},
	{"hcp" => 1, "par" => 4, "lat" => 58.435504, "lon" => 11.381626}, 
	
	{"hcp" => 18, "par" => 3, "lat" => 58.438454, "lon" => 11.376239}, 
	{"hcp" => 4, "par" => 5, "lat" => 58.436743, "lon" => 11.381761}, 
	{"hcp" => 2, "par" => 3, "lat" => 58.435566, "lon" => 11.384203}, 
	{"hcp" => 16, "par" => 4, "lat" => 58.434301, "lon" => 11.378668},
	{"hcp" => 14, "par" => 3, "lat" => 58.432243, "lon" => 11.378452},
	{"hcp" => 6, "par" => 4, "lat" => 58.432360, "lon" => 11.373674},  
	{"hcp" => 12, "par" => 4, "lat" => 58.434987, "lon" => 11.368901},
	{"hcp" => 10, "par" => 5, "lat" => 58.432148, "lon" => 11.372480}, 
	{"hcp" => 8, "par" => 4, "lat" => 58.435491, "lon" => 11.378662}
];
class GolfDistanceView extends Ui.View {

	var posnInfo = null;
	

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    	Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
    }

    //! Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
		var string;

        // Set background color
        dc.setColor( Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK );
        dc.clear();
        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
        if( posnInfo != null ) {
        	var lat = posnInfo.position.toDegrees()[0];
        	var lon = posnInfo.position.toDegrees()[1];
            
            string = "" + getDistance(lon.toFloat(), lat.toFloat(), testCourse[currentHoleIdx]["lon"], testCourse[currentHoleIdx]["lat"]);
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 5) ), Gfx.FONT_NUMBER_THAI_HOT, string, Gfx.TEXT_JUSTIFY_CENTER );
        }
        else {
            dc.drawText( (dc.getWidth() / 2), (dc.getHeight() / 2), Gfx.FONT_SMALL, "No position info", Gfx.TEXT_JUSTIFY_CENTER );
        }
        dc.drawText( (dc.getWidth() / 4), dc.getHeight() - (dc.getHeight() / 4), Gfx.FONT_TINY, "Par " + testCourse[currentHoleIdx]["par"], Gfx.TEXT_JUSTIFY_CENTER ); 
        
        dc.drawText( dc.getWidth() - (dc.getWidth() / 4), dc.getHeight() - (dc.getHeight() / 4), Gfx.FONT_TINY, "Hcp " + testCourse[currentHoleIdx]["hcp"], Gfx.TEXT_JUSTIFY_CENTER ); 
        
        dc.drawText( (dc.getWidth() / 2), dc.getHeight() - (dc.getHeight() / 8), Gfx.FONT_TINY, "Hole " + (currentHoleIdx+1), Gfx.TEXT_JUSTIFY_CENTER ); 
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    	Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPosition));
    }

	function onPosition(info) {
        posnInfo = info;
        Ui.requestUpdate();
    }
    
    function getDistance(lon, lat, lon2, lat2) {
		var xDiff = lon2 - lon;
		var yDiff = lat2 - lat;		
		var dist = Math.sqrt( (xDiff*xDiff) + (yDiff*yDiff) ) * 100000;

		return dist.format("%d");
    } 
}
