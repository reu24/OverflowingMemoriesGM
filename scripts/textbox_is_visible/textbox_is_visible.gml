///@function	textbox_is_visible()
///@description Checks if textbox is visible or not

function textbox_is_visible() {
	if (instance_exists(textbox)) {
		if (textbox.textbox_visible == true) {
			return true;
		}else{
			return false;
		}
	}
}

/*/Example:
if textbox_exists() {
	if keyboard_check_pressed(vk_escape) {
		if textbox_is_visible() {
			textbox_hide(true);
		}else{
			textbox_hide(false);
		}
	}
}
This code checks if the textbox is visible and hides or shows it when pressing esc.