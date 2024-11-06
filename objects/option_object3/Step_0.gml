/// @description Select option with mouse

if (instance_exists(textbox)) {
	if (textbox.mouse_moved) {
		if (distance_to_point(mouse_x,mouse_y)<=1 && textbox.backlog_visible == false) {
			with(textbox) {
				selected = 3;
			}
		}
	}
	if (textbox.options_show == false) {
		instance_destroy();
	}
	
	// Set position (move this to create event?)
	if (textbox.draw_gui == true) { // Or do this in all cases?
		if (textbox.mode = "box") {
			var _option_x,_option_y;
			if (view_enabled == true && textbox.position_set == false) {
				_option_x = camera_get_view_x(view_camera[view_current])+camera_get_view_width(view_camera[view_current])-20;
				_option_y = camera_get_view_y(view_camera[view_current])+camera_get_view_height(view_camera[view_current])-140;
			}else if (textbox.position_set == false) {
				_option_x = room_width-20;
				_option_y = room_height-140;
			}else if (textbox.option1x == noone) {
				_option_x = textbox.x2-20;
				_option_y = room_height-140;
			}else{
				if (view_enabled == true) {
					if (textbox.option3x != noone) {
						_option_x = textbox.option3x+camera_get_view_x(view_camera[view_current]);
						_option_y = textbox.option3y+camera_get_view_y(view_camera[view_current]);
					}else{
						_option_x = textbox.option2x+camera_get_view_x(view_camera[view_current]);
						_option_y = textbox.option1y+camera_get_view_y(view_camera[view_current]);
					}
				}else{
					if (textbox.option3x != noone) {
						_option_x = textbox.option3x;
						_option_y = textbox.option3y;
					}else{
						_option_x = textbox.option2x;
						_option_y = textbox.option1y;
					}
				}
			}
			
			var _opt_h = string_height(opt3); // Text height
			var _oy = 0;
			
			if (textbox.option3y == noone) {
				_oy = _option_y-_opt_h;
			}else{
				_oy = _option_y; //textbox.option3y;
				//_option_x = textbox.option3x;
			}
		
			x = _option_x;
			y = _oy;
			
		}else{
			
			// X position
			var _x1 = textbox.object_talking.x-textbox.bubble_width/2;
			var _x2 = textbox.object_talking.x+textbox.bubble_width/2;
			x = _x2-(_x2-_x1)/2;
				
			// Y position
			var _text_height = string_height_ext(textbox.message_draw,textbox.separation,textbox.bubble_width-6);
			var _name_height = string_height(textbox.name);
			var _dist_from_obj = sprite_get_height(textbox.object_talking.sprite_index);
			var _y1;
			if (textbox.name != noone) { //What? Name is now something built-in? What now?
				_y1 = textbox.object_talking.y-_dist_from_obj-2-_name_height-_text_height;
			}else{
				_y1 = textbox.object_talking.y-_dist_from_obj-2-_text_height;
			}

			var _opt_h = string_height(opt3); //Text height
			var _oy = 0;
			if (textbox.option_outside_view == false) {
				_oy = _y1-_opt_h;
			}else{
				_oy = _y1+_opt_h*3;
			}
			
			y = _oy;
			
		}
	}
	
}else{
	instance_destroy();
}












/*//OLD CODE FOR BACKUP (There is a lot of these...)

//FOR DIALOGUE ENGINE
if asset_get_index("textbox")>-1 && instance_exists(textbox) {
	if distance_to_point(mouse_x,mouse_y)<1 && textbox.backlog_visible == false {
		with(textbox) {
			selected = 3;
		}
	}

	if textbox.options_show = false {
		instance_destroy();
	}
//FOR CUTSCENE ENGINE
}else if asset_get_index("cutscene_textbox")>-1 && instance_exists(cutscene_textbox) {
	if distance_to_point(mouse_x,mouse_y)<1 && cutscene_textbox.backlog_visible == false {
		with(cutscene_textbox) {
			selected = 3;
		}
	}

	if cutscene_textbox.options_show = false {
		instance_destroy();
	}

	if cutscene_textbox.mode = "box" {
		sprite_set_offset(example_option_rect,299,0);
	}else{
		sprite_set_offset(example_option_rect,150,0);
	}
}else{
	instance_destroy();
}




///OLD CODE FOR BACKUP

///If you are using dialogue engine too, uncomment this

//FOR DIALOGUE ENGINE
if instance_exists(textbox) {
	if distance_to_point(mouse_x,mouse_y)<=1 && textbox.backlog_visible == false {
		with(textbox) {
			selected = 3;
		}
	}

	if textbox.options_show = false {
		instance_destroy();
	}
}/*else //Uncomment this if you are using cutscene engine too

//FOR CUTSCENE ENGINE
if instance_exists(cutscene_textbox) {
	if distance_to_point(mouse_x,mouse_y)<1 && cutscene_textbox.backlog_visible == false {
		with(cutscene_textbox) {
			selected = 3;
		}
	}

	if cutscene_textbox.options_show = false {
		instance_destroy();
	}

	if cutscene_textbox.mode = "box" {
		sprite_set_offset(example_option_rect,299,0);
	}else{
		sprite_set_offset(example_option_rect,150,0);
	}
}*//*else{
	instance_destroy();
}





/*------------------
Old code for backup
if instance_exists(textbox) {
	if distance_to_point(mouse_x,mouse_y)<1 {
		with(textbox) {
			selected = 3;
		}

	/*	if mouse_check_button_released(mb_left) {
			keyboard_key_release(textbox.speak_key);
			instance_destroy();
			instance_destroy(option_object2);
			instance_destroy(option_object1);
		}*/
/*	}

	if textbox.options_show = false {
		instance_destroy();
	}
}