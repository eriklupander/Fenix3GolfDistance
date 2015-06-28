using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Position as Position;
using Toybox.Math as Math;

// 198.3
var test1 = [58.435349, 11.378371]; // 58.435349, 11.378371
var test2 = [58.433432, 11.378533];

// 1 to 3 = 256.7
var test3 = [58.434504, 11.374378];

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

var testCourse2 = [
	{"hcp" => 7, "par" => 4, "lat" => 58.438253, "lon" => 11.377348}, // 58.438253, 11.377348
	{"hcp" => 13, "par" => 4, "lat" => 58.440298, "lon" => 11.374679},// 58.440298, 11.374679
	{"hcp" => 3, "par" => 5, "lat" => 58.443850, "lon" => 11.368959}, //  58.443850, 11.368959
	{"hcp" => 9, "par" => 5, "lat" => 58.446957, "lon" => 11.364698}, //  58.446957, 11.364698
	{"hcp" => 15, "par" => 3, "lat" => 58.444598, "lon" => 11.366344}, // 58.444598, 11.366344
	{"hcp" => 5, "par" => 4, "lat" => 58.442465, "lon" => 11.368424},  // 58.442465, 11.368424
	{"hcp" => 11, "par" => 4, "lat" => 58.444430, "lon" => 11.365285}, // 58.444430, 11.365285
	{"hcp" => 17, "par" => 5, "lat" => 58.440557, "lon" => 11.369183}, // 58.440557, 11.369183
	{"hcp" => 1, "par" => 3, "lat" => 58.438901, "lon" => 11.375197}   // 58.438901, 11.375197
];

var courses = [
	{"id" => 0, "name" => "Sotenas GK Gul/Rod", "holeCount" => 18, "holes" => testCourse},
	{"id" => 1, "name" => "Sotenas GK Bla", "holeCount" => 9, "holes" => testCourse2}	
];


var currentHoleIdx = 0; // 0-17
var currentCourseIdx = 0;
 
class GolfDistanceView extends Ui.View {

	var posnInfo = null;
	var R = 6371000; // Meters

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
		
        // Set background color
        dc.setColor( Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK );
        dc.clear();
        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
        if( posnInfo != null ) {
        	var lat = posnInfo.position.toDegrees()[0];
        	var lon = posnInfo.position.toDegrees()[1];
            
            var distanceStr = "" + dist(lon.toFloat(), lat.toFloat(), 
            	courses[currentCourseIdx]["holes"][currentHoleIdx]["lon"], 
            	courses[currentCourseIdx]["holes"][currentHoleIdx]["lat"]);
            
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 5) ), Gfx.FONT_NUMBER_THAI_HOT, distanceStr, Gfx.TEXT_JUSTIFY_CENTER );
        }
        else {
            dc.drawText( (dc.getWidth() / 2), (dc.getHeight() / 2), Gfx.FONT_SMALL, "Waiting for GPS position...", Gfx.TEXT_JUSTIFY_CENTER );
        }
        
        dc.drawText( (dc.getWidth() / 2), (dc.getHeight() / 6), Gfx.FONT_XTINY, "" + courses[currentCourseIdx]["name"], Gfx.TEXT_JUSTIFY_CENTER ); 
        dc.drawText( (dc.getWidth() / 4), dc.getHeight() - (dc.getHeight() / 4), Gfx.FONT_TINY, "Par " + courses[currentCourseIdx]["holes"][currentHoleIdx]["par"], Gfx.TEXT_JUSTIFY_CENTER ); 
        dc.drawText( dc.getWidth() - (dc.getWidth() / 4), dc.getHeight() - (dc.getHeight() / 4), Gfx.FONT_TINY, "Hcp " + courses[currentCourseIdx]["holes"][currentHoleIdx]["hcp"], Gfx.TEXT_JUSTIFY_CENTER );
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
    
    
    // Calculates the equirectangular distance. For golf shot distances it's accurate enough.
	// Note that coords are entered in decimal format and then converted to radians.
	// A possible optimization is to save all course coords in radians right away.
    function dist(lat1, lon1, lat2, lon2) {
		var x = deg2rad((lon2 - lon1)) * Math.cos(deg2rad( (lat1 + lat2) / 2));
		var y = deg2rad(lat2 - lat1);
		var distance = Math.sqrt(x * x + y * y) * R;
		return distance.format("%d");
    }
    
    var d2r = (Math.PI / 180.0);
    
	function deg2rad(deg) {
	  return deg * d2r;
	}
}
