///@function	textbox_set_speed(speed1,speed2,speed3,etc.)
///@description Sets how fast the text increases in each message. Default is 0.5.
///@arg speed1
///@arg [speed2]
///@arg [speed3]
///@arg [etc.]

function textbox_set_speed() {

	with(textbox) {
		// Set the speed for all the provided arguments
		var maxmessages = array_length(msg);
		for (var i = 0; i < maxmessages; i ++;) {
			if (argument_count > i) {
				message_speed[i] = argument[i];
			}else{
				message_speed[i] = 0.5;
			}
		}
		speed_set = true;
	}

}

//Example:
//textbox_set_speed(0.5,0.5,1,0.2,0.5);
//This sets the speed for 5 messages.