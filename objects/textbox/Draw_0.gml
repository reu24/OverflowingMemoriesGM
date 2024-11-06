/// @description Draw textbox

draw_gui = false; //Change this to true if you change this event to Draw GUI. Note that it hasn't been tested as much as normal Draw.

if (textbox_visible) {
	if (mode == "box") {
		switch(optioncount) {
			case 0:
			textbox_draw(message_draw,name,general_colour,text_colour,outline_colour,alpha,font,sprite);
			break;
			case 1:
			textbox_draw(message_draw,name,general_colour,text_colour,outline_colour,alpha,font,sprite,s_text_colour,option1);
			break;
			case 2:
			textbox_draw(message_draw,name,general_colour,text_colour,outline_colour,alpha,font,sprite,s_text_colour,option1,option2);
			break;
			case 3:
			textbox_draw(message_draw,name,general_colour,text_colour,outline_colour,alpha,font,sprite,s_text_colour,option1,option2,option3);
			break;
		}
	}else{
		switch(optioncount) {
			case 0:
			textbox_draw_bubble(message_draw,name,general_colour,text_colour,alpha,font,separation,bubble_width,object_talking);
			break;
			case 1:
			textbox_draw_bubble(message_draw,name,general_colour,text_colour,alpha,font,separation,bubble_width,object_talking,s_text_colour,option1);
			break;
			case 2:
			textbox_draw_bubble(message_draw,name,general_colour,text_colour,alpha,font,separation,bubble_width,object_talking,s_text_colour,option1,option2);
			break;
			case 3:
			textbox_draw_bubble(message_draw,name,general_colour,text_colour,alpha,font,separation,bubble_width,object_talking,s_text_colour,option1,option2,option3);
			break;
		}
	}
}
if (backlog_visible) {
	textbox_draw_backlog();
}