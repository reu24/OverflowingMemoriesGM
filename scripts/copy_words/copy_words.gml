///@function	copy_words(string,index,count)
///@arg string
///@arg index
///@arg count

function copy_words(_text,_index,_count) {
	var _char = string_char_at(_text,_count);
	
	while(_char != " " && _char != "") {
		_count++;
		_char = string_char_at(_text,_count);
	}
	return string_copy(_text,_index,_count);
}