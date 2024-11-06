///@function		textbox_draw_bubble(Text,CharacterName,Colour,TextColour,Alpha,Font,Separation,BubbleWidth,ObjectTalking,SelectedTextColour,Option1,Option2,Option3)
///@description		Draws a speech bubble with text
///@arg Text
///@arg CharacterName
///@arg Colour
///@arg TextColour
///@arg Transparency
///@arg Font
///@arg separation
///@arg bubblewidth
///@arg ObjectTalking
///@arg [SelectedTextColour]
///@arg [Option1]
///@arg [Option2]
///@arg [Option3]

function textbox_draw_bubble(_text,_character_name,_colour,_text_col,_transparency,_font,_separation,_bubble_width,_object,_selected_text_col,_option1,_option2,_option3) {

	#region VARIABLES
	
		// Calculate text height (Set the font here to calculate things correctly)
		draw_set_font(_font);
		var _text_h = string_height_ext(_text,_separation,_bubble_width-6);
		var _name_h = string_height(_character_name);
		var _dist_from_obj = sprite_get_height(_object.sprite_index);

		// Position of things
		var _x1 = _object.x-_bubble_width/2;
		var _y1 = 0;
		if (_character_name != noone) {
			_y1 = _object.y-_dist_from_obj-2-_name_h-_text_h;
		}else{
			_y1 = _object.y-_dist_from_obj-2-_text_h;
		}
		var _x2 = _object.x+_bubble_width/2;
		var _y2 = _object.y-_dist_from_obj;
		var _text_y = _object.y-_dist_from_obj-_text_h;
		var _show_pointer = true;
		var _pointer_x1 = _object.x-8;
		var _pointer_x2 = _object.x+8;
		var _pointer_x3 = _object.x;
		var _pointer_y3 = _object.y-_dist_from_obj/1.3;
		var _continue_icon_x = _object.x+_bubble_width/2;
		var _text_x = _x2-(_x2-_x1)/2;
		
		// Check if using Draw GUI and replace all positions using x_to_gui function
		if (draw_gui == true) {
			var _gui_coords = x_to_gui(_x1,_y1);
			_x1 = _gui_coords[0];
			_y1 = _gui_coords[1];
			_gui_coords = x_to_gui(_x2,_y2);
			_x2 = _gui_coords[0];
			_y2 = _gui_coords[1];
			_gui_coords = x_to_gui(_text_x,_text_y);
			_text_x = _gui_coords[0];
			_text_y = _gui_coords[1];
			_gui_coords = x_to_gui(_pointer_x1,_y2); //Or use _object coords instead?
			_pointer_x1 = _gui_coords[0];
			_gui_coords = x_to_gui(_pointer_x2,_y2);
			_pointer_x2 = _gui_coords[0];
			_gui_coords = x_to_gui(_pointer_x3,_pointer_y3);
			_pointer_x3 = _gui_coords[0];
			_pointer_y3 = _gui_coords[1];
			_gui_coords = x_to_gui(_continue_icon_x,_y2);
			_continue_icon_x = _gui_coords[0];
		}
		
		// If outside view
		if (draw_gui == true) {
			if (_x1<0) {
				_x2 = _x2-_x1;
				_x1 = 0;
			}
			if (_x2>display_get_gui_width()) {
				_x1 = display_get_gui_width()-(_x2-_x1);
				_x2 = display_get_gui_width();
			}
			if (_y1<=0) {
				_y1 = 0;
				if (_character_name == noone) {
					_text_y = _y1;
					_y2 = _y1+_text_h+5;
				}else{
					_text_y = _name_h;
					_y2 = _y1+_text_h+_name_h+5;
				}
				_show_pointer = false;
			}
		}else if (view_enabled == false) {
			if (_x1<0) {
				_x2 = _x2-_x1;
				_x1 = 0;
			}
			if (_x2>room_width) {
				_x1 = room_width-(_x2-_x1);
				_x2 = room_width;
			}
			if (_y1<=0) {
				//_y2 = _y2-_y1+10;
				_y1 = 0;
				if (_character_name == noone) {
					_text_y = _y1;
					_y2 = _y1+_text_h+5;
				}else{
					_text_y = _name_h;
					_y2 = _y1+_text_h+_name_h+5;
				}
				_show_pointer = false;
			}
		}else{
			if (_x1<camera_get_view_x(view_camera[view_current])) {
				_x2 = _x2-_x1;
				_x1 = 0;
			}
			if (_x2>camera_get_view_x(view_camera[view_current])+camera_get_view_width(view_camera[view_current])) {
				_x1 = camera_get_view_x(view_camera[view_current])+camera_get_view_width(view_camera[view_current])-(_x2-_x1);
				_x2 = camera_get_view_x(view_camera[view_current])+camera_get_view_width(view_camera[view_current]);
			}
			if (_y1<=camera_get_view_y(view_camera[view_current])) {
				//_y2 = _y2-_y1+10;
				_y1 = camera_get_view_y(view_camera[view_current]);
				if (_character_name == noone) {
					_text_y = _y1;
					_y2 = _y1+_text_h+5;
				}else{
					_text_y = _name_h;
					_y2 = _y1+_text_h+_name_h+5;
				}
				_show_pointer = false;
			}
		}
		
		_text_x = _x2-(_x2-_x1)/2; //Calculate again so it works in normal Draw event ??

	#endregion


	#region DRAW THINGS
		
		// Rectangle
		draw_set_colour(_colour);
		draw_set_alpha(_transparency);
		draw_roundrect(_x1,_y1,_x2,_y2,false);
		
		if (_show_pointer) {
			// Pointer
			draw_triangle(_pointer_x1,_y2,_pointer_x2,_y2,_pointer_x3,_pointer_y3,false);
			//draw_triangle(_object.x-8,_y2,_object.x+8,_y2,_object.x,_object.y-_dist_from_obj/1.3,false);
		}
		
		// Text
		draw_set_colour(_text_col);
		draw_set_alpha(1);
		draw_set_halign(fa_center);
		draw_text_ext(_text_x,_text_y,_text,_separation,_bubble_width-6);
		
		// Character's name
		if (_character_name != noone) {
			//draw_set_colour(_text_col);
			//draw_set_halign(fa_center);
			draw_set_alpha(0.7);
			draw_text(_text_x,_text_y-_separation,_character_name);
		}

		// AUTO MODE ICON
		if (auto_mode && auto_mode_icon != noone) {
			draw_sprite(auto_mode_icon,-1,_x2+12,_y2);
		}

	#endregion

		if (characters >= message_length) {
		
			// Draw "continue in dialogue" sign
			if (continue_icon != noone && delay == false) {
				draw_set_alpha(1);
				draw_sprite(continue_icon,0,_continue_icon_x,_y2);
				//draw_sprite(continue_icon,0,_object.x+_bubble_width/2,_y2);
			}

			#region OPTIONS
				
				// Options position
				var _posx = _text_x;
				var _posy = _y1;
				
				option_outside_view = false;
				if (view_enabled == false) {
					if (_y1<=0) {
						_posy = _y2-_separation+5;
						option_outside_view = true;
					}
				}else if (_y1<=camera_get_view_y(view_camera[view_current])) {
					_posy = _y2-_separation+5;
					option_outside_view = true;
				}


				if (options_show == true) {
					if (!is_undefined(_option3)) {
						options_draw_bubble(_text_col,_selected_text_col,_font,_posx,_posy,_option1,_option2,_option3);
					}else
					if (!is_undefined(_option2)) {
						options_draw_bubble(_text_col,_selected_text_col,_font,_posx,_posy,_option1,_option2);
					}else
					if (!is_undefined(_selected_text_col) && !is_undefined(_option1)) {
						options_draw_bubble(_text_col,_selected_text_col,_font,_posx,_posy,_option1);
					}
				}

			#endregion
		}

	// Reset settings - This might not be necessary.
	draw_set_halign(fa_left);
	draw_set_alpha(1);

}