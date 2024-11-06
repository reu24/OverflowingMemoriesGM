///@function			textbox_show_backlog(show?,scrollSpeed)
///@description			Shows or hides backlog
///@arg show?			True of false
///@arg [scrollSpeed]	Default value is 30.

//notes: make it possible to use mouse wheel to open and close the backlog (currently if it is used, scrolling is not possible...)
//notes: add customization arguments? or use the ones from textbox_set, etc.?
//notes: should I add a button to the textbox to display backlog? like an optional argument in textbox_set()?
//notes: make possible to save backlog so previous textbox dialogues are not lost every time a new conversation starts

function textbox_show_backlog(_show,_scroll_spd) {
	with(textbox) {
		if (_show) {
			backlog_visible = true;
			backlog_position = 0;
		}else{
			backlog_visible = false;
		}
		if (!is_undefined(_scroll_spd)) {
			scroll_speed = _scroll_spd;	
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

This shows or hides the backlog when pressing f7.