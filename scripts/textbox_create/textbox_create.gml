///@function		textbox_create(message1,message2,message3,message4,message5,etc.)
///@description		Creates the textbox and initializes the variables needed - You just need to set the messages in the arguments
///@arg message1
///@arg [message2]
///@arg [message3]
///@arg [message4]
///@arg [message5]
///@arg [etc.]

function textbox_create() {

	// Create the textbox (You need a layer called "hud". Alternatively change the layer name here. But make sure it's above everything.)
	var _textbox = instance_create_layer(x,y,"hud",textbox);

	with(_textbox) {

		// Messages/Texts
		// If you use options, this is the first option path. Other option paths are in the step event. (Note that this comment is old.)
		var _max_messages = argument_count;
		for (var _i = 0; _i < _max_messages; _i ++;) {
		   if (argument_count > _i) {
			   msg[_i] = argument[_i];
		   }
		}
		
		message_current = 0; // Current message
		message_end = argument_count-1; // Last message
		increase = 0.5; // How fast the characters appear
		characters = 0; // How many characters are shown
		message_draw = ""; // What has to be drawn currently
		message_length = string_length(msg[message_current]); // Current message length
		
		
		#region SETTINGS AREA
		//-------------SETTINGS AREA STARTS-------------///
		
		// Here are the default settings. You can change them here so that you
		// don't need to call textbox_set() or other setting scripts every time.
		// Even if you change these, you will be able to make
		// individual textboxes different using the textbox_set() script etc.
		
		// General variables
		name = noone;
		general_colour = c_black;
		text_colour = c_white;
		outline_colour = c_white;
		s_text_colour = c_black; // Colour of the selected option (you will set this in textbox_add_options() script)
		alpha = 1; // Transparency
		font = noone;
		separation = 35; // Text separation
		mouse_enabled = false;
		continue_icon = noone; // The sprite of the icon
		continue_icon_frame = 0; //I gnore, used to handle animation speed
		smart_linebreak = false; // Prevent text from changing line in the middle of a word. Note that this doesn't work on all projects! Read the manual for more info.
		last_space = 0; // Related to smart_linebreak, ignore this
		
		// Especially for speech bubbles - You will probably want to change these every time with the textbox_set_bubble() script anyways.
		bubble_width = 300; // Width of the speech bubble
		object_talking = noone; // Needed only for speech bubbles
		
		// Portrait - You probably don't want to change it here. Use the script textbox_set_portrait() or textbox_set() for this.
		sprite = noone; // Portrait or face of the character
		portrait_behind = false; // If portrait should be behind the text box
		portrait = []; // Array for the portrait/face sprite
		sync_sprite = false; // Sync portrait sprite animation with text or not
		sprite_spd = 0.2; // Image speed of portrait and continue icon
		image_speed = sprite_spd;
		
		// Keys
		speak_key = vk_space;
		skip_key = vk_space;
		speak_button_controller = gp_face1;
		controller_enabled = false;
		controller_device = 0; // Get this with Async - System event
		
		// Textbox sprite
		textbox_sprite_set = false; // Set this to true if you change the variables below
		textbox_sprite = noone; // Sprite of the textbox (not the character)
		textbox_sprite2 = noone; // Sprite of the name textbox
		
		// Positions
		position_set = false; // Set this to true if you change the variables below
		x1 = 0;
		x2 = 0;
		y1 = 0;
		y2 = 0;
		namex1 = 0;
		namex2 = 0;
		namey1 = 0;
		namey2 = 0;
		sprite_position_set = false; // Set this to true if you change the variables below
		spritex = 0;
		spritey = 0;
		text_position_set = false; // Set this to true if you change the variables below
		textx = 0;
		texty = 0;
		name_text_position_set = false; // Set this to true if you change the variables below
		nametextx = 0;
		nametexty = 0;
		option1x = noone;
		option1y = noone;
		option2x = noone;
		option2y = noone;
		option3x = noone;
		option3y = noone;
		
		//-------------SETTINGS AREA ENDS-------------///
		#endregion
		
		// More key/button variables
		textbox_key_speak = 0;
		textbox_key_skip = 0; // Will become obsolete in v.3
		textbox_key_speak_pressed = 0;
		textbox_key_skip_pressed = 0; // Will become obsolete in v.3
		textbox_key_up = 0;
		textbox_key_down = 0;
		textbox_key_up_pressed = 0;
		textbox_key_down_pressed = 0;
		
		// Options
		options_set = false; // Variable to know if options has been set
		//options_set2 = false;
		//options_set3 = false;
		options_show = false; // Variable to know if options has to be shown
		//options_show2 = false;
		//options_show3 = false;
		selected = 0; // Takes track of the selected option
		//chosen_option = noone; // For the user to get what option was chosen
		optioncount = 0; // Variable to check how many options there are
		//optioncount2 = 0;
		//optioncount3 = 0;

		// Set additional option variables
		show_options_when = 0;
		option1 = noone;
		option2 = noone;
		option3 = noone;
		message_to_change = 0;
		//message_to_change2 = 0;
		//message_to_change3 = 0;
		ifoption1 = "";
		ifoption2 = "";
		ifoption3 = "";
		/*ifoptionsecond1 = "";
		ifoptionsecond2 = "";
		ifoptionsecond3 = "";
		ifoptionthird1 = "";
		ifoptionthird2 = "";
		ifoptionthird3 = "";*/
		option_outside_view = false;
		
		// Speed of text
		speed_set = false;
		message_speed = [];
		
		// Text sound
		text_sound = false; // if should make sound
		text_sound_volume = 1;
		text_sound_interval = 5;
		textsound = noone; // what sound
		
		// Voice acting
		voice = [];
		voice_volume = 1;
		voice_sync_text = false;
		voice_sync_sprite = false;
		voice_played = false;
		
		// Textbox visibility
		textbox_visible = true;
		
		// Auto mode
		auto_mode = false;
		auto_mode_icon = noone;
		
		// Change variable at the end variables
		var_object = noone;
		var_to_change = noone;
		var_value = noone;
		
		// Backlog
		backlog_visible = false;
		texts_in_backlog = 0;
		backlog_position = 0;
		backlog_stop_down = false;
		backlog_stop_up = false;
		scroll_speed = 30;
		for (var _i = 0; _i < _max_messages; _i ++;) {
		   if (argument_count > _i) {
			   backlog[_i] = "";
		   }
		}
		backlog[0] = msg[0];

		// Mode
		mode = "box";
	
	}

}


//Example:
//textbox_create("Hi","My name is Bob.","How are you?");