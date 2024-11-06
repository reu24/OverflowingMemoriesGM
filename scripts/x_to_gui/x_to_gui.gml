///@function	x_to_gui(x,y)
///@description Converts normal coordinates to gui coordinates. Returns an array.
///@arg x
///@arg y
//Change script name to coordinates_to_gui or something else, because it gets the y position too?
function x_to_gui(argx,argy) {
	
    var cl = camera_get_view_x(view_camera[0]);
    var ct = camera_get_view_y(view_camera[0]);
      
    var off_x = argx - cl; // x is the normal x position
    var off_y = argy - ct; // y is the normal y position
      
    //Convert to gui
    var off_x_percent = off_x / camera_get_view_width(view_camera[0]);
    var off_y_percent = off_y / camera_get_view_height(view_camera[0]);
      
    var gui_x = off_x_percent * display_get_gui_width();
    var gui_y = off_y_percent * display_get_gui_height();
	
	return [gui_x,gui_y];
	
}