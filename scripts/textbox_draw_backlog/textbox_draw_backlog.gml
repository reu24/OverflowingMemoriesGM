///@function textbox_draw_backlog()
///@description Shows backlog

// Add options to the backlog too? different colours? or get style from textbox options? (I wrote this earlier but... I suppose with options I'm referring to arguments?)

function textbox_draw_backlog() {
	
	//Variables
	var rect_x1,rect_y1,rect_x2,rect_y2,text_x,text_y,text_w,backlog_width;
	if (view_enabled == true) {
		var cam_x = camera_get_view_x(view_camera[view_current]);
		var cam_y = camera_get_view_y(view_camera[view_current]);
		var cam_w = camera_get_view_width(view_camera[view_current]);
		var cam_h = camera_get_view_height(view_camera[view_current]);
		rect_x1 = cam_x;
		rect_y1 = cam_y;
		rect_x2 = cam_x+cam_w;
		rect_y2 = cam_y+cam_h;
		text_x = cam_x+20;
		text_y = rect_y2-10; //cam_y/*+cam_h*/;
		text_w = cam_w-40;
		backlog_width = cam_x+cam_w;
	}else{
		rect_x1 = 0;
		rect_y1 = 0;
		rect_x2 = room_width;
		rect_y2 = room_height;
		text_x = 20;
		text_y = rect_y2-10;
		text_w = room_width-40;
		backlog_width = room_width;
	}
	if (draw_gui == true) {
		var gui_w = display_get_gui_width();
		var gui_h = display_get_gui_height();
		rect_x1 = 0;
		rect_y1 = 0;
		rect_x2 = gui_w;
		rect_y2 = gui_h;
		text_x = 20;
		text_y = rect_y2-10;
		text_w = gui_w-40;
		backlog_width = gui_w;
	}
	
	// Draw background
	draw_set_colour(c_black);
	draw_set_alpha(0.9);
	draw_rectangle(rect_x1,rect_y1,rect_x2,rect_y2,false);
	
	// Draw text
	draw_set_font(font);
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	
	var text_h = 0;
	for (var i=0;i<texts_in_backlog+1;i++) {	
		// calculate the text height here to not draw things on top of others
		// maybe do this somewhere else for better performance?
		text_h = text_h+string_height_ext(backlog[i],separation,text_w)+10;
		// Draw the text
		draw_text_ext(text_x,text_y-text_h+backlog_position/**2*i*/,backlog[i],separation,text_w);
	}
	
	// Prevent text going completely outside view when scrolling | maybe move this partly to textbox?
	/*/Version 2 - Still has problems
	if text_y-text_h+backlog_position<rect_y1+scroll_speed {
		backlog_stop_up = true;
		//backlog_position+=scroll_speed;
	}else if text_y+backlog_position>rect_y2 {
		backlog_stop_down = true;
		//backlog_position-=scroll_speed;
	}else{
		backlog_stop_down = false;
		backlog_stop_up = false;
	}*/
	// Version 1
	if text_y-text_h+backlog_position<rect_y1-text_h+text_h/texts_in_backlog {
		backlog_stop_up = true;
		//backlog_position+=scroll_speed;
	}else if text_y-text_h+backlog_position>rect_y2-text_h/texts_in_backlog {
		backlog_stop_down = true;
		//backlog_position-=scroll_speed;
	}else{
		backlog_stop_down = false;
		backlog_stop_up = false;
	}
}