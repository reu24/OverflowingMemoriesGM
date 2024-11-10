// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum DIRECTION {
	NONE,
	LEFT,
	RIGHT,
	UP,
	DOWN
}

function move_right(_spr) {
	move(1, 0, _spr, DIRECTION.RIGHT);
}

function move_left(_spr) {
	move(-1, 0, _spr, DIRECTION.LEFT);
}

function move_up(_spr) {
	move(0, -1, _spr, DIRECTION.UP);
}

function move_down(_spr) {
	move(0, 1, _spr, DIRECTION.DOWN);
}

enum STATES {
	IDLE,
	WALKING
}

function move(_dx, _dy, _sprite, _dir) {
	if (walking_direction == DIRECTION.NONE) {
		sprite_index = _sprite;
		look_direction = _dir;
		if (walk_place_free(x + _dx * TILE_WIDTH, y + _dy * TILE_HEIGHT)) {
			x_from = x_pos;
			y_from = y_pos;
		
			x_to = x_pos + _dx;
			y_to = y_pos + _dy;
		
			x_pos = x_to;
			y_pos = y_to;
		
			walking_direction = _dir;
		}
	}
}

function move_animation() {
	if (walking_direction != DIRECTION.NONE) {
		if (walk_anim_time > walk_anim_length) {
			walk_anim_time -= walk_anim_length;
		}
		walk_anim_time += delta_time / 1000000;
	
		var _walking_progress = walk_anim_time / walk_anim_length;
		image_index = frames[floor((walk_anim_frames - 1) * min(1, _walking_progress))]
	
		if (_walking_progress >= 1) {
			if (!direction_key_pressed(walking_direction) && walk_place_free(x_to + player_look_x(), y_to + player_look_y())) {
				walk_anim_time = 0;
				_walking_progress = 1;
				image_index = 0;
			}
			walking_direction = DIRECTION.NONE;
		}
	
		var _x = lerp(x_from, x_to, _walking_progress);
		var _y = lerp(y_from, y_to, _walking_progress);
	
		x = _x * TILE_WIDTH;
		y = _y * TILE_HEIGHT;
	}
}

function direction_key_pressed(_dir) {
	if (_dir == DIRECTION.RIGHT) {
		return keyboard_check(ord("D"));
	}
	if (_dir == DIRECTION.UP) {
		return keyboard_check(ord("W"));
	}
	if (_dir == DIRECTION.DOWN) {
		return keyboard_check(ord("S"));
	}
	return keyboard_check(ord("A"));
}

function player_look_x() {
	if (obj_player.look_direction == DIRECTION.RIGHT) {
		return TILE_WIDTH;
	}
	if (obj_player.look_direction == DIRECTION.LEFT) {
		return -TILE_WIDTH;
	}
	return 0;
}

function player_look_y() {
	if (obj_player.look_direction == DIRECTION.UP) {
		return -TILE_WIDTH;
	}
	if (obj_player.look_direction == DIRECTION.DOWN) {
		return TILE_WIDTH;
	}
	return 0;
}

function walk_place_free(_x, _y) {
	return place_free(_x, _y) && !place_meeting(_x, _y, tile_map);
}