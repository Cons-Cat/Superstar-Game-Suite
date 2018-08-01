/// @description Freeze the player
if !canMove {
	obj_player_overworld.canMove = false;
	obj_player_overworld.c_hspeed = 0;
	obj_player_overworld.c_vspeed = 0;
} else {
	freeDecay = string_length(message[0])*1.9 + 45;
}
