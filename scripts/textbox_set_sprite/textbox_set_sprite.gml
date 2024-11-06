///@function	textbox_set_sprite(MainRectangleSprite,NameRectangleSprite)
///@description	Sets a sprite to the textbox, instead of using coloured rectangles. The sprite size needs to be a multiple of 3
///@arg MainRectangleSprite
///@arg NameRectangleSprite

function textbox_set_sprite(_main_rect,_name_rect) {

	with(textbox) {
		textbox_sprite = _main_rect;
		textbox_sprite_set = true;
		if (!is_undefined(_name_rect)) {
			textbox_sprite2 = _name_rect;
		}else{
			textbox_sprite2 = _main_rect;
		}
	}

}

//Example:
//textbox_set_sprite(sprite_textbox);