///@function	chooses_option()
///@description Returns the option the player chose in a dialogue (1, 2 or 3)
function chooses_option() {

	with(textbox) {
		if (textbox_key_speak_pressed) {
			if (options_show) {
					if (selected == 1) {
						return 1;
					}else if (selected == 2) {
						return 2;
					}else if (selected == 3) {
						return 3;
					}
				}
			}
		//}
		//if (textbox_key_speak_pressed && options_show) {
			//if (chosen_option != noone) {
			//	return chosen_option;
			//}
		//}
	}

}

/*Example:
if chooses_option() == 2 {
	with(player) {
		got_sword = true;
	}
}
*/