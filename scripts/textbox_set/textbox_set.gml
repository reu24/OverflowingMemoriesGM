///@function				textbox_set(characterName,colour,textColour,outlineColour,alpha,font[,sprite,enableMouse,continueIcon,Separation,SmartLineBreak,syncsprite?,imageSpeed,PortraitBehind])
///@description				Set the style of the textbox
///@arg CharacterName		Name of the character. Can be noone.
///@arg Colour				Colour of the text box
///@arg TextCol				Colour of the text
///@arg OutlineCol			Colour of the outline. Can be noone.
///@arg Alpha				Transparency
///@arg Font				Font of the text
///@arg [Sprite]			Character sprite
///@arg [EnableMouse]		True or false
///@arg [ContinueIcon]		Sprite of the icon
///@arg [Separation]		Text separation
///@arg [SmartLineBreak]	Prevents text from changing line in the middle of a word. Note that this doesn't work correctly in all projects.
///@arg [_syncsprite]		Play animation of portrait sprite only when text is going and stop it when text is complete?
///@arg [imgSpeed]			image_speed of character portrait and continue icon
///@arg [PortraitBehind]	If character portrait should be behind text box. By default it's in front of it.

function textbox_set(_ca,_col,_text_col,_outline_col,_transparency,_font,_portrait,_mouse,_cicon,_sep,_smartlinebreak,_syncspr,_imgspd,_portrait_behind) {

	with(textbox) {
		name = _ca;
		general_colour = _col;
		text_colour = _text_col;
		outline_colour = _outline_col;
		alpha = _transparency;
		font = _font;
		if (!is_undefined(_portrait)) {
			sprite = _portrait;
		}
		if (!is_undefined(_mouse)) {
			mouse_enabled = _mouse;
		}
		if (!is_undefined(_cicon)) {
			continue_icon = _cicon;
		}
		if (!is_undefined(_sep)) {
			separation = _sep;
		}
		if (!is_undefined(_smartlinebreak)) {
			smart_linebreak = _smartlinebreak;
		}
		if (!is_undefined(_syncspr)) {
			sync_sprite = _syncspr;
		}
		if (!is_undefined(_imgspd)) {
			sprite_spd = _imgspd;
		}
		if (!is_undefined(_portrait_behind)) {
			portrait_behind = _portrait_behind;
		}
		mode = "box";
	}

}

//Example:
//textbox_set("Bob",c_black,c_white,c_white,1,Bobs_favourite_font,spr_Bobs_face,true);