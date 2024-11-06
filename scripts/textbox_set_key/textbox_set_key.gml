/// @function			textbox_set_key(ForSpeak,ForSkip,Controller)
/// @description		Change the keyboard or controller key used to continue in dialogue and to skip dialogue
/// @arg ForSpeak		The keyboard key used to continue the dialogue
/// @arg [ForSkip]		The keyboard key used to skip dialogue - Will become obsolete in v.3 because same key can now be used for both
/// @arg [Controller]	The controller button used to continue the dialogue
/// @arg [Device]		The controller device

function textbox_set_key(_speak,_skip,_controller,_controller_device) {

	with(textbox) {
		speak_key =_speak;
		if (!is_undefined(_skip)) {
			skip_key = _skip;
		}
		if (!is_undefined(_controller)) {
			speak_button_controller = _controller;
			controller_enabled = true;
		}
		if (!is_undefined(_controller_device)) {
			controller_device = _controller_device;
		}
	}

}

//Example:
//textbox_set_key(vk_enter,vk_enter,gp_face1);
//This sets the speak and skip key to enter and controller button to gp_face1.