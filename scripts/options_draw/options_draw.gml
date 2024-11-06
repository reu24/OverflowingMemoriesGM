/// @function				options_draw(TextCol,SelectedTextCol,Font,Option1,Option2,Option3)
/// @description			Draws options/choices to the dialogue
/// @arg TextCol			Colour of the text
/// @arg SelectedTextCol	Colour of text of the selected option
/// @arg Font				Font
/// @arg X					X position of the first option
/// @arg Y					Y position of the first option
/// @arg [option1]			First option
/// @arg [option2]			Second option
/// @arg [option3]			Third option
function options_draw(_text_col,_selected_text_col,_font,_x,_y,_opt1,_opt2,_opt3) {
	
	#region Variables
		
		// Maybe get the x & y positions in a similar way as in options_draw_bubble?
		var _smaller = 0; //This can be used to quickly change the position of everything (Remove it from the code?)
		var _option_x = _x; // If this new way is okkei, change all _option_x and _option_y to _x and _y
		var _option_y = _y; // And remove the commented code below
		//var _option_x,_option_y;
		//if (view_enabled == true && position_set == false) {
		//	_option_x = camera_get_view_x(view_camera[view_current])+camera_get_view_width(view_camera[view_current])-20;
		//	_option_y = camera_get_view_y(view_camera[view_current])+camera_get_view_height(view_camera[view_current])-camera_get_view_height(view_camera[view_current])/3-2; //-140
		//}else if (position_set == false) {
		//	_option_x = room_width-20;
		//	_option_y = room_height-room_height/3-2; //room_height-140
		//}else if (option1x == noone) {
		//	_option_x = x2-20;
		//	_option_y = y1-10;
		//}else{
		//	_option_x = option1x;
		//	_option_y = option1y;
		//}
		//if (draw_gui == true && position_set == false) { //Or maybe do something similar as in textbox_draw_bubble?
		//	_option_x = display_get_gui_width()-20;
		//	_option_y = display_get_gui_height()-140;
		//}
		
		if (position_set && option1x != noone) {
			_option_x = option1x;
			_option_y = option1y;
		}
	
	#endregion


	//If there are options
	if (!is_undefined(_opt1)) { // This could be put before the variables too, because the whole script is useless without options anyway

		#region Check how many options there are

			// Count options and get their width
			var _option_count = 1;
			var _opt_w,_opt1_w,_opt2_w,_opt3_w;
			if (!is_undefined(_opt3)) {
				_option_count = 3;
				_opt1_w = string_width(_opt1);
				_opt2_w = string_width(_opt2);
				_opt3_w = string_width(_opt3);
				_opt_w = max(_opt1_w,_opt2_w,_opt3_w);
			}else if (!is_undefined(_opt2)) {
				_option_count = 2;
				_opt1_w = string_width(_opt1);
				_opt2_w = string_width(_opt2);
				_opt_w = max(_opt1_w,_opt2_w);
			}else{
				_option_count = 1;
				_opt_w = string_width(_opt1);
			}/*else{
				var _option_count = 0;
			}*/

		#endregion


		#region Draw the options
			
			// Set things
			draw_set_font(_font); //Font
			draw_set_halign(fa_right); //Halign
			var _opt_h = string_height(_opt1); //Text height
			
			// Draw option 1
			
			// Position
			var _oy = 0;
			if (option1y == noone) {
				if (_option_count == 3) { // By the way, there could be an easier way of calculating this. Like having a starting position and adding + aLittleSpace for every option.
					_oy = _option_y-_opt_h*3+_smaller;
				}else if (_option_count == 2) {
					_oy = _option_y-_opt_h*2+_smaller;
				}else if (_option_count == 1) {
					_oy = _option_y-_opt_h+_smaller;
				}
			}else{
				_oy = option1y;
			}
			
			// Colour & rectangle if selected
			if (selected == 1) {
				// Rectangle
				draw_set_colour(_text_col);
				draw_roundrect(_option_x-_opt_w,_oy,_option_x,_oy+_opt_h,false);
				// Colour
				draw_set_colour(_selected_text_col);
			}else{
				draw_set_colour(_text_col);
			}
			
			// Text
			draw_text(_option_x,_oy,_opt1);

			// If mouse enabled
			if (mouse_enabled) {
				if (!instance_exists(option_object1)) {
					instance_create_layer(_option_x,_oy,"hud",option_object1);
					option_object1.opt1 = _opt1;
					option_object1.option_count = _option_count;
				}
			}

			// Draw option 2
			if (_option_count >= 2) {
				
				// Position
				if (option2y == noone) {
					if (_option_count == 3) {
						_oy = _option_y-_opt_h*2+_smaller;
					}else if (_option_count == 2) {
						_oy = _option_y-_opt_h+_smaller;
					}
				}else{
					_oy = option2y;
					_option_x = option2x;
				}
				
				// Colour & rectangle if selected
				if (selected == 2) {
					// Rectangle
					draw_set_colour(_text_col);
					draw_roundrect(_option_x-_opt_w,_oy,_option_x,_oy+_opt_h,false);
					// Colour
					draw_set_colour(_selected_text_col);
				}else{
					draw_set_colour(_text_col);
				}
				
				// Text
				draw_text(_option_x,_oy,_opt2);
	
				// If mouse enabled
				if (mouse_enabled) {
					if (!instance_exists(option_object2)) {
						instance_create_layer(_option_x,_oy,"hud",option_object2);
						option_object2.opt2 = _opt2;
						option_object2.option_count = _option_count;
					}
				}
			}

			// Draw option 3
			if (_option_count == 3) {
				
				// Position
				if (option3y == noone) {
					_oy = _option_y-_opt_h+_smaller;
				}else{
					_oy = option3y;
					_option_x = option3x;
				}
				
				// Colour & rectangle if selected
				if (selected == 3) {
					// Rectangle
					draw_set_colour(_text_col);
					draw_roundrect(_option_x-_opt_w,_oy,_option_x,_oy+_opt_h,false);
					// Colour
					draw_set_colour(_selected_text_col);
				}else{
					draw_set_colour(_text_col);
				}
				
				// Text
				draw_text(_option_x,_oy,_opt3);
	
				// If mouse enabled
				if (mouse_enabled) {
					if (!instance_exists(option_object3)) {
						instance_create_layer(_option_x,_oy,"hud",option_object3);
						option_object3.opt3 = _opt3;
						option_object3.option_count = _option_count;
					}
				}
			}

		#endregion


		#region Enable action (changing option)
			
			if (backlog_visible == false) {
				
				// If up
				if (textbox_key_up_pressed) {
					if (selected == 0) {
						selected = 1;
					}else{
						// If 2 options
						if (_option_count == 2) {
							switch(selected) {

								case 1:
								selected = 2;
								break;

								case 2:
								selected = 1;
								break;
							}
						}
						//If 3 options
						if (_option_count == 3) {
							switch(selected) {

								case 1:
								selected = 3;
								break;

								case 2:
								selected = 1;
								break;

								case 3:
								selected = 2;
								break;
							}
						}
					}
				}

				// If down
				if (textbox_key_down_pressed) {
					if (selected == 0) {
						selected = 1;
					}else{
						// If 2 options
						if (_option_count == 2) {
							switch(selected) {

								case 1:
								selected = 2;
								break;

								case 2:
								selected = 1;
								break;
							}
						}
						// If 3 options
						if (_option_count == 3) {
							switch(selected) {

								case 1:
								selected = 2;
								break;

								case 2:
								selected = 3;
								break;

								case 3:
								selected = 1;
								break;
							}
						}
					}
				}
				
			}

		#endregion

	}

	//This might not be necessary
	draw_set_halign(fa_left);

}
