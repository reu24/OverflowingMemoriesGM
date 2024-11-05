/// @description step

if (state == STATES.WALKING) {
	walk_anim_time += delta_time / 1000000;
	
	var _walking_progress = walk_anim_time / walk_anim_length;
	image_index = frames[floor((walk_anim_frames - 1) * _walking_progress)]
	
	if (_walking_progress >= 1) {
		walk_anim_time = 0;
		_walking_progress = 1;
		state = STATES.IDLE;
		image_index = 0;
	}
	
	var _x = lerp(x_from, x_to, _walking_progress);
	var _y = lerp(y_from, y_to, _walking_progress);
	
	x = _x * TILE_WIDTH;
	y = _y * TILE_HEIGHT;
}