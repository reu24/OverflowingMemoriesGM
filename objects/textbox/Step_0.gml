/// @description Manage everything

// Check for key presses
if (controller_enabled) {
	
	#region Fix gamepad axis problem
	if (-gamepad_axis_value(controller_device,gp_axislv)) {
		pressing = true;
	}
	if (pressing = true) {
		if (abs(-gamepad_axis_value(controller_device,gp_axislv)) <= 0.2) {
			pressing = false;
			axis_action_up = true;
			alarm[2] = 1;
		}
	}
	if (gamepad_axis_value(controller_device,gp_axislv)) {
		pressing2 = true;
	}
	if (pressing2 == true) {
		if (abs(gamepad_axis_value(controller_device,gp_axislv)) <= 0.2) {
			pressing2 = false;
			axis_action_down = true;
			alarm[2] = 1;
		}
	}
	#endregion

	textbox_key_speak = keyboard_check_released(speak_key) || gamepad_button_check_released(controller_device,speak_button_controller);
	textbox_key_skip = keyboard_check_released(skip_key) || gamepad_button_check_released(controller_device,speak_button_controller);
	textbox_key_speak_pressed = keyboard_check_pressed(speak_key) || gamepad_button_check_pressed(controller_device,speak_button_controller);
	textbox_key_skip_pressed = keyboard_check_pressed(skip_key) || gamepad_button_check_pressed(controller_device,speak_button_controller);
	textbox_key_up = keyboard_check(vk_up) || keyboard_check(ord("W")) || gamepad_button_check(controller_device,gp_padu) || -gamepad_axis_value(controller_device,gp_axislv);
	textbox_key_down = keyboard_check(vk_down) || keyboard_check(ord("S")) || gamepad_button_check(controller_device,gp_padd) || gamepad_axis_value(controller_device,gp_axislv);
	textbox_key_up_pressed = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(controller_device,gp_padu) || axis_action_up; // need to add some "bug fix" to these two?
	textbox_key_down_pressed = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(controller_device,gp_padd) || axis_action_down;
}else{
	textbox_key_speak = keyboard_check_released(speak_key); // Change name to textbox_key_speak_released?
	textbox_key_skip = keyboard_check_released(skip_key);
	textbox_key_speak_pressed = keyboard_check_pressed(speak_key);
	textbox_key_skip_pressed = keyboard_check_pressed(skip_key);
	textbox_key_up = keyboard_check(vk_up) || keyboard_check(ord("W"));
	textbox_key_down = keyboard_check(vk_down) || keyboard_check(ord("S"));
	textbox_key_up_pressed = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
	textbox_key_down_pressed = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
}

if (textbox_visible == true && backlog_visible == false) {
	
	#region Mouse related
	// If mouse enabled
	if (mouse_enabled) {
		if (options_show == false) {
			if (mouse_check_button_pressed(mb_left)) {
				keyboard_key_press(speak_key); // or: textbox_key_speak = true; etc.
			}
			if (mouse_check_button_released(mb_left)) {
				keyboard_key_release(speak_key);
			}
			if (mouse_check_button_pressed(mb_right)) {
				keyboard_key_press(skip_key);
			}
			if (mouse_check_button_released(mb_right)) {
				keyboard_key_release(skip_key);
			}
			// Set mouse_moved to false here? (Only necessary if a dialogue has many option situations)
		}else{
			// Prevent dialogue from advancing if mouse is not pointing any option
			if (mouse_on_option) {
				if (mouse_check_button_pressed(mb_left)) {
					keyboard_key_press(speak_key);
				}	
				if (mouse_check_button_released(mb_left)) {
					keyboard_key_release(speak_key);
				}
				if (mouse_check_button_pressed(mb_right)) {
					keyboard_key_press(skip_key);
				}
				if (mouse_check_button_released(mb_right)) {
					keyboard_key_release(skip_key);
				}
			}
			// Check if mouse has been moved (this is after options are already being shown)
			if (mouse_x != mouse_xprevious || mouse_y != mouse_yprevious) {
				mouse_moved = true;
			}
			// Check if mouse is pointing an option
			//if (mouse_moved) { // Do the mouse_moved stuff in option_objects
				if (instance_exists(option_object1)) {
					with(option_object1) {
						if (distance_to_point(mouse_x,mouse_y)<1) {
							textbox.mouse_on_option = true;
						}else with(option_object2) {
							if (distance_to_point(mouse_x,mouse_y)<1) {
								textbox.mouse_on_option = true;
							}else with(option_object3) {
								if (distance_to_point(mouse_x,mouse_y)<1) {
									textbox.mouse_on_option = true;
								}else{
									textbox.mouse_on_option = false;
								}
							}
						}
					}
				}
			//}
		}
		// Set mouse previous position
		mouse_xprevious = mouse_x;
		mouse_yprevious = mouse_y;
	}
	#endregion

	// Increase characters
	if (characters < message_length) {
		characters += increase;
	
		// Make sound
		if (text_sound == true) {
			if (itstime == true) {
				if (audio_exists(textsound)) {
					audio_play_sound(textsound,1,false,text_sound_volume);
				}
				itstime = false;
				alarm[0] = text_sound_interval;
			}
		}
	
		// Press skip key to skip dialogue
		if (itstime2) {
			if (textbox_key_skip_pressed) {
				characters = message_length;
				// Delay to prevent accidental message skips
				itstime2 = false;
				alarm[1] = 6;
			}
		}
		
		// What has to be drawn right now - This has been added to textbox_draw script too. It's here now because speech bubbles won't work otherwise (if not added to textbox_draw_bubble script too)
		message_draw = string_copy(msg[message_current],0,characters);
	
	}else{
		// Press speak key to continue in the dialogue
		if (textbox_key_speak) {
			// Prevent skipping options
			if (options_show == false || options_show == true && selected != 0) {
				if (message_current<message_end) {
					if (delay == false) {
						message_current += 1;
						characters = 0;
						message_draw = "";
						message_length = string_length(msg[message_current]);
						voice_played = false;
						// Reset delay variables
						delay = true;
						itstime3 = true;
						// Related to auto mode
						called = false;
						// Update backlog
						texts_in_backlog ++;
						for (var _i=0;_i<texts_in_backlog;_i++) {
							backlog[texts_in_backlog-_i] = backlog[texts_in_backlog-_i-1];
						}
						backlog[0] = msg[message_current];
					}
				}
				// End dialogue if it is the last message
				else {
					if (delay == false) {
						message_current = 0; // Is resetting these variables here necessary?
						characters = 0;
						message_draw = "";
						message_length = string_length(msg[message_current]);
						if (var_to_change != noone) {
							variable_instance_set(var_object,var_to_change,var_value);
						}
						instance_destroy();
					
						// If in a cutscene, move to the next scene
						if (asset_get_index("control_cutscene")>-1) {
							if (cutscene_going()) {
								with(control_cutscene) {
									if (current_cutscene = cutscene_id) {
										cutscene_next();
									}
								}
							}
						}
					
						// Update backlog here too?
					}
				}
				//if (options_show && selected != 0) {
				//	chosen_option = selected;
				//}
			}
		}
		// Manage auto mode
		if (auto_mode) {
			if (characters >= message_length && options_show == false) {
				if (called == false) {
					called = true;
					alarm[4] = message_length*2+5; // Maybe use auto_mode_delay variable or something to make it easier to change?
				}
			}
		}
	}
	
	var _game_spd = game_get_speed(gamespeed_fps); // Var to be used in some stuff below. Hmm... what about delta_time?

	// Do a little delay to prevent accidentally skipping dialogue
	if (characters>=message_length && delay == true && itstime3 == true) {
		itstime3 = false;
		alarm[3] = _game_spd/5;
	}

	// Options
	if (options_set == true) {
	
		// When to show options
		if (message_current == show_options_when) {
			options_show = true;
		}else{
			options_show = false;
		}

		// Change a message according to selected option
		if (message_to_change != 0) {
			if (selected == 1) {
			    msg[message_to_change] = ifoption1;
			}else{
			    if (selected == 2) {
			        msg[message_to_change] = ifoption2;
			    }else{
			        if (selected == 3) {
			            msg[message_to_change] = ifoption3;
			        }
			    }
			}
		}

	#region Working on this
	/*/If used options second time
	if options_set2 = true {

	//When to show options
	if message_current = show_options_when2 {
		optioncount = optioncount2;
	
		options_show2 = true;
	}else{
		options_show2 = false;
	}
	
	//Change a message according to selected option
	if message_current = show_options_when2 {
		if selected == 1 {
			msg[message_to_change2] = ifoptionsecond1;
		}else{
			if selected == 2 {
				msg[message_to_change2] = ifoptionsecond2;
			}else{
				if selected == 3 {
					msg[message_to_change2] = ifoptionsecond3;
				}
			}
		}
	}
	
	}



	//If used options third time
	if options_set3 = true {
	
	//When to show options
	if message_current = show_options_when3 {
		optioncount = optioncount3;
	
		options_show3 = true;
	}else{
		options_show3 = false;
	}

	//Change a message according to selected option
	if message_current = show_options_when3 {
		if selected == 1 {
			msg[message_to_change3] = ifoptionthird1;
		}else{
			if selected == 2 {
				msg[message_to_change3] = ifoptionthird2;
			}else{
				if selected == 3 {
					msg[message_to_change3] = ifoptionthird3;
				}
			}
		}
	}


	}*/
	#endregion

	}

	// Manage speed of text
	if (speed_set == true) {
		increase = message_speed[message_current];
	}
	
	// Manage portrait
	if (array_length(portrait) > 0) { // This and other similar checks could be optimized checking with a variable if they have been set (more memory usage, but otherwise better performance). Another option could be to do all similar checks the way this is made.
		sprite = portrait[message_current];
	}
	
	// Portrait sprite animation sync with text
	if (sync_sprite == true) {
		if characters<message_length {
			image_speed = sprite_spd;
		}else{
			image_speed = 0;
			image_index = 0;
		}
	}
	
	// Manage voice acting
	if (array_length(voice) > 0) {
		if (voice[message_current] != noone) {
			if (voice_played == false) {
				voice_played = true;
				if (audio_exists(voice[message_current])) {
					audio_play_sound(voice[message_current],1,false,voice_volume);
					// Stop previous sound
					if (message_current > 0) {
						if audio_is_playing(voice[message_current-1]) {
							audio_stop_sound(voice[message_current-1]);
						}
					}
				}else{
					show_debug_message("Dialogue engine: Voice file does not exist.");
				}
			}
			// Sync voice with sprite
			if (voice_sync_sprite == true) {
				if (audio_is_playing(voice[message_current])) { //Or check the pitch of the current position of the sound or something
					image_speed = sprite_spd;
				}else{
					image_speed = 0;
					image_index = 0;
				}
			}
		}
	}
	
	// Manage continue icon animation speed
	if (continue_icon != noone) {
		if (continue_icon_frame >= sprite_get_number(continue_icon)) {
			continue_icon_frame = 0;
		}else{
			continue_icon_frame += sprite_spd*_game_spd/_game_spd;
		}
	}
	/*/ Manage auto mode icon animation speed
	if (auto_mode_icon != noone) {
		if (auto_mode_icon >= sprite_get_number(auto_mode_icon)) {
			auto_mode_icon = 0;
		}else{
			auto_mode_icon += sprite_spd*_game_spd/_game_spd;
		}
	}*/

}

// Backlog
if (backlog_visible) {
	// Scroll with mouse
	if (mouse_wheel_down() && backlog_stop_down == false) {
		backlog_position+=scroll_speed; //could change this amount to the current text height or something. or maybe not.
	}else if (mouse_wheel_up() && backlog_stop_up == false) {
		backlog_position-=scroll_speed;
	}
	// Scroll with keyboard
	if (textbox_key_down && backlog_stop_down == false) {
		backlog_position+=scroll_speed/4;
	}else if (textbox_key_up && backlog_stop_up == false) {
		backlog_position-=scroll_speed/4;
	}
}