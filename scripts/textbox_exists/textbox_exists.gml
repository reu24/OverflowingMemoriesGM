///@function	textbox_exists()
///@description Checks if textbox exists - instead of using this script you could just use the instance_exists function

function textbox_exists() {
	if (instance_exists(textbox)) {
		return true;
	}else{
		return false;
	}
}

//Example:
/*if !textbox_exists() {
	textbox_create(...);
}
*/