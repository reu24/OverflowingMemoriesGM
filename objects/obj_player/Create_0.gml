/// @description Insert description here
// You can write your code in this editor



walking_direction = DIRECTION.NONE;

x_pos = x div TILE_WIDTH;
x = x_pos * TILE_WIDTH;
y_pos = y div TILE_HEIGHT;
y = y_pos * TILE_HEIGHT;

x_from = x_pos;
y_from = y_pos;

x_to = x_pos;
y_to = y_pos;

walk_anim_length = 0.7
walk_anim_time = 0

image_speed = 0;	
walk_anim_frames = 5;

frames = [0, 1, 0, 2, 0];

current_direction = DIRECTION.NONE;

var _wall_layer = layer_get_id("Walls");
tile_map = layer_tilemap_get_id(_wall_layer);