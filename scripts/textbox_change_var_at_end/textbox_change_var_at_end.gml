/// @function		textbox_change_var_at_end(objectID,variable,value)
/// @description	Changes a variable when the dialogue ends.
/// @arg objectID	Of the object that has the variable
/// @arg variable	The variable needs to be between "".
/// @arg value		The value that will be assigned to the variable.

function textbox_change_var_at_end(_object,_variable,_value) {

	with(textbox) {
		var_object = _object;
		var_to_change = _variable;
		var_value = _value;
	}

}

/*Example:
textbox_change_var_at_end(player.id,"hp",10);
This sets a variable called hp to 10 at the end of the dialogue.*/