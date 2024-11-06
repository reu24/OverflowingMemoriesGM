///@function	textbox_backlog_visible()
///@description Checks if backlog is visible

function textbox_backlog_visible() {
	with(textbox) {
		if (backlog_visible) {
			return true;
		}else{
			return false;
		}
	}
}

/*Example:
if textbox_exists() {
	if keyboard_check_pressed(vk_f7) {
		if textbox_backlog_visible() {
			textbox_show_backlog(false);
		}else{
			textbox_show_backlog(true);
		}
	}
}

When pressing f7 this checks if the backlog is visible and shows it or hides it.