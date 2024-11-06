/// @function				options_draw_bubble(TextColour,SelectedTextColour,Font,x,y,Option1,Option2,Option3)
/// @description			Draws the options for speech bubbles
/// @arg TextColour			Colour of text
/// @arg SelectedTextColour	Colour of the selected option
/// @arg Font				Text font
/// @arg x					X position of the first option?
/// @arg y					Y position of the first option?
/// @arg [option1]			First option
/// @arg [option2]			Second option
/// @arg [option3]			Third option
function options_draw_bubble(_text_col,_selected_text_col,_font,_x,_y,_opt1,_opt2,_opt3) {

	// If there are options
	if (!is_undefined(_opt1)) {

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
			}else
			if (!is_undefined(_opt2)) {
				_option_count = 2;
				_opt1_w = string_width(_opt1);
				_opt2_w = string_width(_opt2);
				_opt_w = max(_opt1_w,_opt2_w);
			}else{
				_option_count = 1;
				_opt_w = string_width(_opt1);
			}/*else{
				_option_count = 0;
			}*/

		#endregion

		#region Draw the options
			
			// Set things
			draw_set_font(_font);
			draw_set_halign(fa_center);
			var _opt_h = string_height(_opt1); //Text height

			// Draw option 1
			
			// Position
			var _oy = 0;
			if (option_outside_view == false) {
				if (_option_count == 3) {
					_oy = _y-_opt_h*3;
				}else if (_option_count == 2) {
					_oy = _y-_opt_h*2;
				}else if (_option_count == 1) {
					_oy = _y-_opt_h;
				}
			}else{
				_oy = _y+_opt_h;
			}
			
			// Colour & rectangle when selected
			if (selected == 1) {
				// Rectangle
				draw_set_colour(_text_col);
				draw_roundrect(_x-_opt_w/2,_oy,_x+_opt_w/2,_oy+_opt_h,false);
				// Colour
				draw_set_colour(_selected_text_col);
			}else{
				draw_set_colour(_text_col);
			}
		
			// Text
			draw_text(_x,_oy,_opt1);

			// If mouse enabled
			if (mouse_enabled) {
				if (!instance_exists(option_object1)) {
					instance_create_layer(_x,_oy,"hud",option_object1);
					option_object1.opt1 = _opt1;
					option_object1.option_count = _option_count;
				}
			}

			// Draw option 2
			if (_option_count >= 2) {
				
				// Position
				if (option_outside_view == false) {
					if (_option_count == 3) {
						_oy = _y-_opt_h*2;
					}else if (_option_count == 2) {
						_oy = _y-_opt_h;
					}
				}else{
					_oy = _y+_opt_h*2;
				}
				
				// Colour & rectangle when selected
				if (selected == 2) {
					// Rectangle
					draw_set_colour(_text_col);
					draw_roundrect(_x-_opt_w/2,_oy,_x+_opt_w/2,_oy+_opt_h,false);
					// Colour
					draw_set_colour(_selected_text_col);
				}else{
					draw_set_colour(_text_col);
				}
				
				// Text
				draw_text(_x,_oy,_opt2);
				
				// If mouse enabled
				if (mouse_enabled) {
					if (!instance_exists(option_object2)) {
						instance_create_layer(_x,_oy,"hud",option_object2);
						option_object2.opt2 = _opt2;
						option_object2.option_count = _option_count;
					}
				}
			}


			// Draw option 3
			if (_option_count >= 3) {
			
				// Position
				if (option_outside_view == false) {
					_oy = _y-_opt_h;
				}else{
					_oy = _y+_opt_h*3;
				}
				
				// Colour & rectangle when selected
				if (selected == 3) {
					// Rectangle
					draw_set_colour(_text_col);
					draw_roundrect(_x-_opt_w/2,_oy,_x+_opt_w/2,_oy+_opt_h,false);
					// Colour
					draw_set_colour(_selected_text_col);
				}else{
					draw_set_colour(_text_col);
				}
				
				// Text
				if (_option_count == 3) {
					draw_text(_x,_oy,_opt3);
				}
				
				// If mouse enabled
				if (mouse_enabled) {
					if (!instance_exists(option_object3)) {
						instance_create_layer(_x,_oy,"hud",option_object3);
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
						// If 3 options
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

	draw_set_halign(fa_left);

}