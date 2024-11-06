///@function			textbox_set_bubble(CharacterName,Colour,TextColour,Alpha,Font,Separation,BubbleWidth,ObjectTalking,EnableMouse,ContinueIcon,imageSpeed)
///@description			Set the style of speech bubble - This is needed to use it.
///@arg CharacterName	Name of the character. Can be noone.
///@arg Colour			Colour of the speech bubble
///@arg TextColour		Colour of the text
///@arg Alpha			Transparency
///@arg Font			Font of the text
///@arg Separation		Text separation
///@arg BubbleWidth		Width of the speech bubble
///@arg ObjectTalking	The pointer of the speech bubble will point this object
///@arg [EnableMouse]	True or false
///@arg [ContinueIcon]	Sprite of the continue icon
///@arg [imageSpeed]	image_speed of continue icon

function textbox_set_bubble(_name,_col,_text_col,_transparency,_font,_separation,_bubble_w,_obj,_mouse,_icon,_sprite_spd) {

	with(textbox) {
		name = _name;
		general_colour = _col;
		text_colour = _text_col;
		alpha = _transparency;
		font = _font;
		separation = _separation;
		bubble_width = _bubble_w;
		object_talking = _obj;
		if (!is_undefined(_mouse)) {
			mouse_enabled = _mouse;
		}
		if (!is_undefined(_icon)) {
			continue_icon = _icon;
		}
		if (!is_undefined(_sprite_spd)) {
			sprite_spd = _sprite_spd;
		}
	
		mode = "bubble";
	}

}

//Example:
//textbox_set_bubble("Bob",c_black,c_white,c_white,1,Bobs_favourite_font,25,300,obj_player);
//Tip: To make it fit smaller view sizes, make the font smaller and also make the separation and BubbleWidth smaller.