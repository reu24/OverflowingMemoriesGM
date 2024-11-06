/// @function		textbox_automode(enable,icon)
/// @description	Enable auto mode (dialogue advancing automaticaly, without user input)
/// @arg enable		boolean
/// @arg [icon]		Auto mode icon sprite
function textbox_automode(_enable,_icon){
	with(textbox) {
		auto_mode = _enable;
		auto_mode_icon = _icon;
	}
}

// Example:
// textbox_automode(true,spr_automode)
// This enables auto mode and sets the icon sprite to spr_automode