///@function		textbox_draw(Text,CharacterName,Colour,TextColour,OutlineColour,Transparency,Font,Sprite,SelectedTextColour,Option1,Option2,Option3)
///@description		Draw a box with text - Supports different camera and view sizes
///@arg Text
///@arg CharacterName
///@arg Colour
///@arg TextColour
///@arg OutlineColour
///@arg Transparency
///@arg Font
///@arg Sprite
///@arg [SelectedTextColour]
///@arg [Option1]
///@arg [Option2]
///@arg [Option3]

function textbox_draw(_text,_name,_colour,_text_colour,_outline_colour,_transparency,_font,_sprite,_selected_colour,_option1,_option2,_option3) {

	#region Variables
	
	var _smaller = 0; // This can be used to quickly change the size of some things
	var _linebreak_addition = 10; // Change this to -5, -10, 10 or something else if smart line break doesn't work correctly on your project. If it still doesn't work, sorry, I'll improve it in the future.
	
	// Check if views are being used and if position is set and then set position variables
	var _view_x,_view_y,_view_w,_view_h;
	var main_rect_x1,main_rect_y1,main_rect_x2,main_rect_y2,text_x,text_y,text_w,name_rect_x1,name_rect_y1,name_rect_x2,name_rect_y2,name_x,name_y;
	if (view_enabled == true && position_set == false) {
		// One option could be to get the camera (and gui) stuff only once for all scripts, like in textbox step event. That would mean more variables, but slightly better performance.
		// The textbox height is now relative to the view height when view_enabled and not using draw_gui. Consider adding the same functionality to the others.
		_view_x = camera_get_view_x(view_camera[view_current]);
		_view_y = camera_get_view_y(view_camera[view_current]);
		_view_w = camera_get_view_width(view_camera[view_current]);
		_view_h = camera_get_view_height(view_camera[view_current]);
		main_rect_x1 = _view_x+10;
		main_rect_y1 = _view_y+_view_h-_view_h/3+_smaller; //-187
		main_rect_x2 = _view_x+_view_w-10;
		main_rect_y2 = _view_y+_view_h-10;
		text_x = _view_x+20;
		text_y = _view_y+_view_h-_view_h/3+10+_smaller; //-177
		text_w = _view_w-40;
		name_rect_x1 = _view_x+10;
		name_rect_y1 = _view_y+_view_h-_view_h/3-_view_h/7+_smaller*1.3; //-257 -55
		name_rect_x2 = _view_x+290;
		name_rect_y2 = _view_y+_view_h-_view_h/3+_smaller-3; //-180
		name_x = _view_x+150;
		name_y = _view_y+_view_h-_view_h/3-_view_h/7+12+_smaller*1.2; //-240 -40
	}else if (position_set == false) {
		_view_x = 0;
		_view_y = 0;
		_view_w = room_width;
		_view_h = room_height;
		main_rect_x1 = 10;
		main_rect_y1 = room_height-187+_smaller; //-room_height/3
		main_rect_x2 = room_width-10;
		main_rect_y2 = room_height-10;
		text_x = 20;
		text_y = room_height-177+_smaller;
		text_w = room_width-40;
		name_rect_x1 = 10;
		name_rect_y1 = room_height-257+_smaller*1.3;
		name_rect_x2 = 300;
		name_rect_y2 = room_height-180+_smaller-10;
		name_x = 160;
		name_y = room_height-240+_smaller*1.2;
	}else{
		_view_x = 0;
		_view_y = 0;
		_view_w = room_width;
		_view_h = room_height;
		main_rect_x1 = x1;
		main_rect_y1 = y1;
		main_rect_x2 = x2;
		main_rect_y2 = y2;
		name_rect_x1 = namex1;
		name_rect_y1 = namey1;
		name_rect_x2 = namex2;
		name_rect_y2 = namey2;
		if (text_position_set == false) {
			text_x = x1+10;
			text_y = y1+10;
		}else{
			text_x = textx;
			text_y = texty;
		}
		text_w = x2-x1-40;
		if (name_text_position_set == false) {
			name_x = namex1+(namex2-namex1)/2;
			name_y = namey1+(namey2-namey1)/2-15;
		}else{
			name_x = nametextx;
			name_y = nametexty;
		}
	}
	
	// If using draw GUI, overwrite positions except if they have been set by user
	// This could be done the same way as in draw_bubble... which option is better?
	if (draw_gui == true && position_set == false) {
		_view_w = display_get_gui_width();
		_view_h = display_get_gui_height();
		main_rect_x1 = 10;
		main_rect_y1 = _view_h-187+_smaller;
		main_rect_x2 = _view_w-10;
		main_rect_y2 = _view_h-10;
		text_x = 20;
		text_y = _view_h-177+_smaller;
		text_w = _view_w-40;
		name_rect_x1 = 10;
		name_rect_y1 = _view_h-257+_smaller*1.3;
		name_rect_x2 = 300;
		name_rect_y2 = (_view_h-180+_smaller)-10;
		name_x = 160;
		name_y = _view_h-240+_smaller*1.2;
	}
	
	// More variables
	var main_rect_height = main_rect_y2-main_rect_y1;
	//var main_rect_width = main_rect_x2-main_rect_x1;
	
	#endregion
	
	#region Resize sprite
	
	// If there is a sprite, scale things to fit it (but don't do it if the sprite position has been specified)
	// Maybe there should be another variable to disable this?
	var sprite_new_w,spr_newsize;
	if (_sprite != noone && sprite_position_set == false) {
		var sprite_w = sprite_get_width(_sprite);
		if (sprite_w > main_rect_height) {
			spr_newsize = 1-(sprite_w-main_rect_height)/sprite_w;
		}else{
			spr_newsize = main_rect_height/sprite_w;
		}
		sprite_new_w = sprite_w*spr_newsize;
	}else{
		sprite_new_w = 0;
	}
	text_x = text_x+sprite_new_w;
	text_w = text_w-sprite_new_w-5; // the 5 here prevents bug in smart line breaks (wait, is this necessary now that there is _linebreak_addition var?)
	
	#endregion
	
	#region Smart line break
	
	// Add automatic line break to prevent changing line in the middle of a word
	if (smart_linebreak == true) {
		// Get last space
		if (string_char_at(msg[message_current],characters) == " " || string_char_at(msg[message_current],characters) == "") {
			last_space = characters;
		}
		// Smart line breaks
		var _t = copy_words(msg[message_current],0,characters);
		draw_set_font(_font); // Use correct font to calculate the width
		if (string_width(_t) >= text_w) {
			// Remove space and add line break
			msg[message_current] = string_delete(msg[message_current],last_space,1);
			msg[message_current] = string_insert("\n",msg[message_current],last_space);
			if (message_current == message_to_change) {
				ifoption1 = string_delete(ifoption1,last_space,1);
				ifoption1 = string_insert("\n",ifoption1,last_space);
				ifoption2 = string_delete(ifoption2,last_space,1);
				ifoption2 = string_insert("\n",ifoption2,last_space);
				ifoption3 = string_delete(ifoption3,last_space,1);
				ifoption3 = string_insert("\n",ifoption3,last_space);
			}
		}
		// Remove added line breaks when message is complete to prevent bug when skipping text
		if (characters>=message_length) {
			msg[message_current] = string_replace_all(msg[message_current],"\n"," ");
		}
		// Update text that has to be drawn currently
		_text = string_copy(msg[message_current],0,characters);
	}
	
	#endregion
	
	#region Draw the stuff
	
	// SPRITE/PORTRAIT - if behind textbox
	if (portrait_behind && _sprite != noone) {
			
		var sprite_h = sprite_get_height(_sprite);
		if (sprite_h > main_rect_height) {
			spr_newsize = 1-(sprite_h-main_rect_height)/sprite_h;
		}else{
			spr_newsize = main_rect_height/sprite_h;
		}
			
		if (sprite_position_set == false) {
			draw_sprite_ext(_sprite,-1,main_rect_x1,main_rect_y1,spr_newsize,spr_newsize,0,c_white,1);
		}else{
			draw_sprite_ext(_sprite,-1,spritex,spritey,spr_newsize,spr_newsize,0,c_white,1);
		}
	}
		
	// THE TEXT BOX ITSELF
	if (textbox_sprite_set == false) {
			
		// MAIN RECTANGLE
		draw_set_colour(_colour);
		draw_set_alpha(_transparency);
		draw_rectangle(main_rect_x1,main_rect_y1,main_rect_x2,main_rect_y2,false);

		// NAME RECTANGLE
		if (_name != noone) {
			//draw_set_colour(_colour);
			//draw_set_alpha(_transparency);
			draw_rectangle(name_rect_x1,name_rect_y1,name_rect_x2,name_rect_y2,false);
		}
		
		// OUTLINE
		if (_outline_colour != noone) {
			draw_set_colour(_outline_colour);
			draw_rectangle(main_rect_x1,main_rect_y1,main_rect_x2,main_rect_y2,true);
		}
		
		// NAME RECTANGLE OUTLINE
		if (_name != noone) {
			if (_outline_colour != noone) {
				draw_set_colour(_outline_colour);
				draw_rectangle(name_rect_x1,name_rect_y1,name_rect_x2,name_rect_y2,true);
			}
		}
	}else{
		// Draw the things with nine slice - Maybe move the nine slice stuff to its own script? Or use the new nine slice functions of gamemaker?
		var slice_width = sprite_get_width(textbox_sprite)/3;
		var slice_height = sprite_get_height(textbox_sprite)/3;

		// MAIN RECTANGLE
		var _width = abs(main_rect_x2-main_rect_x1);
		var _height = abs(main_rect_y2-main_rect_y1);

		// Top
		draw_sprite_part_ext(textbox_sprite,0,0,0,slice_width,slice_height,main_rect_x1,main_rect_y1,1,1,c_white, 1); // Left
		draw_sprite_part_ext(textbox_sprite,0,slice_width,0,slice_width,slice_height,main_rect_x1+slice_width,main_rect_y1,(_width-slice_width*2)/slice_width,1,c_white,1); // Middle
		draw_sprite_part_ext(textbox_sprite,0,slice_width*2,0,slice_width,slice_height,main_rect_x2-slice_width,main_rect_y1,1,1,c_white,1); // Right

		// Middle
		draw_sprite_part_ext(textbox_sprite,0,0,slice_height,slice_width,slice_height,main_rect_x1,main_rect_y1+slice_height,1,(_height-slice_height*2)/slice_height,c_white,1); // Left
		draw_sprite_part_ext(textbox_sprite,0,slice_width,slice_height,slice_width,slice_height,main_rect_x1+slice_width,main_rect_y1+slice_height,(_width-slice_width*2)/slice_width,(_height-slice_height*2)/slice_height,c_white,1); // Middle
		draw_sprite_part_ext(textbox_sprite,0,slice_width*2,slice_height,slice_width,slice_height,main_rect_x2-slice_width,main_rect_y1+slice_height,1,(_height-slice_height*2)/slice_height,c_white,1); // Right

		// Bottom
		draw_sprite_part_ext(textbox_sprite,0,0,slice_height*2,slice_width,slice_height*2,main_rect_x1,main_rect_y2-slice_height,1,1,c_white,1); // Left
		draw_sprite_part_ext(textbox_sprite,0,slice_width,slice_height*2,slice_width,slice_height,main_rect_x1+slice_width,main_rect_y2-slice_height,(_width-slice_width*2)/slice_width,1,c_white,1); // Middle
		draw_sprite_part_ext(textbox_sprite,0,slice_width*2,slice_height*2,slice_width,slice_height,main_rect_x2-slice_width,main_rect_y2-slice_height,1,1,c_white,1); // Right
			
		// NAME RECTANGLE
		if (_name != noone) {
			slice_width = sprite_get_width(textbox_sprite2)/3;
			slice_height = sprite_get_height(textbox_sprite2)/3;
		
			_width = abs(name_rect_x2-name_rect_x1);
			_height = abs(name_rect_y2-name_rect_y1);

			// Top
			draw_sprite_part_ext(textbox_sprite2,0,0,0,slice_width,slice_height,name_rect_x1,name_rect_y1,1,1,c_white,1); // Left
			draw_sprite_part_ext(textbox_sprite2,0,slice_width,0,slice_width,slice_height,name_rect_x1+slice_width,name_rect_y1,(_width-slice_width*2)/slice_width,1,c_white,1); // Middle
			draw_sprite_part_ext(textbox_sprite2,0,slice_width*2,0,slice_width,slice_height,name_rect_x2-slice_width,name_rect_y1,1,1,c_white,1); // Right

			// Middle
			draw_sprite_part_ext(textbox_sprite2,0,0,slice_height,slice_width,slice_height,name_rect_x1,name_rect_y1+slice_height,1,(_height-slice_height*2)/slice_height,c_white,1); // Left
			draw_sprite_part_ext(textbox_sprite2,0,slice_width,slice_height,slice_width,slice_height,name_rect_x1+slice_width,name_rect_y1+slice_height,(_width-slice_width*2)/slice_width,(_height-slice_height*2)/slice_height,c_white,1); // Middle
			draw_sprite_part_ext(textbox_sprite2,0,slice_width*2,slice_height,slice_width,slice_height,name_rect_x2-slice_width,name_rect_y1+slice_height,1,(_height-slice_height*2)/slice_height,c_white,1); // Right

			// Bottom
			draw_sprite_part_ext(textbox_sprite2,0,0,slice_height*2,slice_width,slice_height*2,name_rect_x1,name_rect_y2-slice_height,1,1,c_white,1); // Left
			draw_sprite_part_ext(textbox_sprite2,0,slice_width,slice_height*2,slice_width,slice_height,name_rect_x1+slice_width,name_rect_y2-slice_height,(_width-slice_width*2)/slice_width,1,c_white,1); // Middle
			draw_sprite_part_ext(textbox_sprite2,0,slice_width*2,slice_height*2,slice_width,slice_height,name_rect_x2-slice_width,name_rect_y2-slice_height,1,1,c_white,1); // Right
		
			// NAME TEXT
			//draw_set_colour(_text_colour);
			draw_set_halign(fa_center);
			draw_text(name_x,name_y,_name);
		}
	}

	// SPRITE / PORTRAIT - If in front
	if (_sprite != noone && portrait_behind == false) {
			
		var sprite_h = sprite_get_height(_sprite);
		if (sprite_h > main_rect_height) {
			spr_newsize = 1-(sprite_h-main_rect_height)/sprite_h;
		}else{
			spr_newsize = main_rect_height/sprite_h;
		}
			
		if (sprite_position_set == false) {
			draw_sprite_ext(_sprite,-1,main_rect_x1,main_rect_y1,spr_newsize,spr_newsize,0,c_white,1);
		}else{
			draw_sprite_ext(_sprite,-1,spritex,spritey,spr_newsize,spr_newsize,0,c_white,1);
		}
	}

	// TEXT
	draw_set_colour(_text_colour);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_font(_font);
	draw_text_ext(text_x,text_y,_text,separation,text_w-_linebreak_addition);

	// NAME TEXT
	if (_name != noone) {
		//draw_set_colour(_text_colour);
		draw_set_halign(fa_center);
		draw_text(name_x,name_y,_name);
	}
	
	// AUTO MODE ICON
	if (auto_mode && auto_mode_icon != noone) {
		draw_sprite(auto_mode_icon,continue_icon_frame,_view_x+_view_w-32,_view_y+8);
	}
	
	#endregion
	
	if (characters >= message_length) {
		
		// Draw "continue in dialogue" sign
		if (continue_icon != noone && delay == false) {
			draw_set_alpha(1);
			draw_sprite(continue_icon,continue_icon_frame,main_rect_x2-10,main_rect_y2-10);
		}
		
		// Show options
		if (options_show = true) {
			if (!is_undefined(_option3)) {
				options_draw(_text_colour,_selected_colour,_font,_view_x+_view_w-20,main_rect_y1-2,_option1,_option2,_option3);
			}else if (!is_undefined(_option2)) {
				options_draw(_text_colour,_selected_colour,_font,_view_x+_view_w-20,main_rect_y1-2,_option1,_option2);
			}else if (!is_undefined(_option1)) {
				options_draw(_text_colour,_selected_colour,_font,_view_x+_view_w-20,main_rect_y1-2,_option1);
			}
		}
	}

	draw_set_halign(fa_left);

}