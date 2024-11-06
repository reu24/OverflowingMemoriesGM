///@function textbox_set_portrait(sprite1,sprite2,sprite3,sprite4,etc.)
///@description Set the character portrait for the textbox
///@arg sprite1
///@arg [sprite2]
///@arg [sprite3]
///@arg [sprite4]
///@arg [etc.]

//If you set only one argument, the same sprite will be for all messages.
//Otherwise you should provide as many arguments as there are messages in the dialogue.

function textbox_set_portrait() {

	with(textbox) {
		//If there is only one argument, use it for all the dialogue
		if (argument_count == 1) {
			sprite = argument[0];
		}else{
			//Otherwise use the provided sprites for the different messages
			var al = array_length(msg);
			if (argument_count >= al) {
				for (var i=0;i<al;i++) {
					portrait[i] = argument[i];
				}
			}else{
				//But if they didn't give as many arguments as there are messages, use the first sprite for all the rest
				for (var i=0;i<argument_count;i++) {
					portrait[i] = argument[i];
				}
				var empty_slots = al-(al-argument_count); //in other words, from this onwards the slots are empty
				for (var i=empty_slots;i<al;i++) {
					portrait[i] = argument[0];
				}
			}
		}
	}

}

//Example:
//textbox_set_portrait(example_face,example_face,example_face_surprised,example_face);
//This example uses example_face sprite for messages 0, 1 and 3. In the message 2 the portrait will be example_face_surprised.