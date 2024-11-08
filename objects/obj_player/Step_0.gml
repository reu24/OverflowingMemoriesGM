/// @description step

move_animation();

if (keyboard_check(ord("D"))) {
	move_right(spr_stefan_walk_right);
}
else if (keyboard_check(ord("W"))) {
	move_up(spr_stefan_walk_up);
}
else if (keyboard_check(ord("A"))) {
	move_left(spr_stefan_walk_left);
}
else if (keyboard_check(ord("S"))) {
	move_down(spr_stefan_walk_down);
}
