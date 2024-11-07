// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function move_right() {
	move(1, 0, spr_stefan_walk_right);
}

function move_left() {
	move(-1, 0, spr_stefan_walk_left);
}

function move_up() {
	move(0, -1, spr_stefan_walk_up);
}

function move_down() {
	move(0, 1, spr_stefan_walk_down);
}

function move(_dx, _dy, _sprite) {
	if (state == STATES.IDLE) {
		sprite_index = _sprite;
		if (place_free(x + _dx * TILE_WIDTH, y + _dy * TILE_HEIGHT) && !place_meeting(x + _dx * TILE_WIDTH, y + _dy * TILE_HEIGHT, tile_map)) {
			x_from = x_pos;
			y_from = y_pos;
		
			x_to = x_pos + _dx;
			y_to = y_pos + _dy;
		
			x_pos = x_to;
			y_pos = y_to;
		
			state = STATES.WALKING;
		}
	}
}