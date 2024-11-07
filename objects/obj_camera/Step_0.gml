/// @description Insert description here
// You can write your code in this editor

if (follow != noone) {
	x_to = follow.x;
	y_to = follow.y;
	
	x += (x_to - x)/4;
	y += (y_to - y)/4;
	
	camera_set_view_pos(view_camera[0], x-(cam_width/2-16), y-(cam_height/2-16));
}