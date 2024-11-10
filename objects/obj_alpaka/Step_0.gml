/// @description Insert description here
// You can write your code in this editor
if (keyboard_check_pressed(vk_space)) {	
	if (floor(x - player_look_x() - obj_player.x) == 0 && floor(y - player_look_y() - obj_player.y) == 0) {
		show_debug_message("in");
		if !textbox_exists() {
			// Call the script that creates the textbox
			// Add in the arguments messages that you want the textbox to show consecutively
			textbox_create("This is the best dialogue engine!",
			"As you can see, it works perfectly.",
			"You can change the speed of the text from fast...",
			"...to slow....",
			"You can customize it with different colours, fonts, outlines, transparency and more!",
			"And now you can add options!",
			"Yes it is!");
			
			// Set things of the textbox
			// If you don't call this, it will set all settings to default (you can change the default settings in the textbox_create() script's setting area).
			//textbox_set("Gero",c_black,c_white,#BCB067,1,example_font,example_face,true,example_continue1,35,true);

			// Add options
			// This script adds options to the dialogue
			textbox_add_options(c_black,5,"Cool!","Not good.","Do you have pets?");
			// If you want the options to affect the dialogue, use this script
			// Just indicate the message that changes and add the different messages
			textbox_change_message_according_option(6,
			"Yes it is!",
			"It is cool! You... you just don't understand...",
			"Yes I have a cat. Wait... How is that related to this?");
			
			// Manage speed of text
			// This is only necessary if you want to change the speed of the text.
			// As we have 7 messages, we set 7 values
			textbox_set_speed(0.5,0.5,1,0.2,0.5,0.5,0.5);
			
			// Change the keyboard keys used for speaking (By default space is used for both speak & skip)
			// With this we can also enable controller, like in this example
			// If you want to use this script, you will have to use it every time you create a textbox (except if you change the default settings in the settings area in textbox_create script).
			//textbox_set_key(vk_space,vk_space,gp_face1,example_control.pad);
			
		}
	}
}


//This does that the object is under others if they are in front of it.
//But if there is a textbox the object would be in front of it, so we disable this when textbox exists.
if !instance_exists(textbox) {
	depth = -y;
}else{
	depth = 0;
}