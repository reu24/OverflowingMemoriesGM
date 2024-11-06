///@function			textbox_set_position(x1,y1,x2,y2,namex1,namey1,namex2,namey2,spritex,spritey,textx,texty,nameTextX,nameTextY,option1X,option1Y,option2X,option2Y,option3X,option3Y)
///@description			Change the position of everything
///@arg x1				Textbox / Text rectangle
///@arg y1
///@arg x2
///@arg y2
///@arg [namex1]		Name rectangle
///@arg [namey1]
///@arg [namex2]
///@arg [namey2]
///@arg [spriteX]		Portrait
///@arg [spriteY]
///@arg [textX]			Text
///@arg [textY]
///@arg [NameTextX]		Character name text
///@arg [NameTextY]
///@arg [Option1X]		The x position of the first option (you need to take into account the option sprite size and origin)
///@arg [Option1Y]		The y position of the first option
///@arg [Option2X]
///@arg [Option2Y]
///@arg [Option3X]
///@arg [Option3Y]

// NOTE: Many of these will go to correct positions even if you set only the arguments before them.
// Also, if you set only the Option1X and Option1Y, the other options will automatically go to correct positions.
// But if you want to customize it more, you can of course set them to something different.

function textbox_set_position() {

	with(textbox) {
		// Textbox
		position_set = true;
		x1 = argument[0];
		y1 = argument[1];
		x2 = argument[2];
		y2 = argument[3];
		// Name rectangle
		if (argument_count >= 5) {
			namex1 = argument[4];
			namey1 = argument[5];
			namex2 = argument[6];
			namey2 = argument[7];
		}
		// Portrait
		if (argument_count >= 9) {
			sprite_position_set = true;
			spritex = argument[8];
			spritey = argument[9];
		}
		// Text
		if (argument_count >= 11) {
			text_position_set = true;
			textx = argument[10];
			texty = argument[11];
		}
		// Name text
		if (argument_count >= 13) {
			name_text_position_set = true;
			nametextx = argument[12];
			nametexty = argument[13];
		}
		// Options
		if (argument_count >= 15) {
			option1x = argument[14];
			option1y = argument[15];
		}
		if (argument_count >= 17) {
			option2x = argument[16];
			option2y = argument[17];
		}
		if (argument_count >= 19) {
			option3x = argument[18];
			option3y = argument[19];
		}
	}

}

/*Example:
textbox_set_position(100,room_height-200,room_width-100,room_height-10);

This sets the textbox to a position in the room, using only the necessary arguments.

*/