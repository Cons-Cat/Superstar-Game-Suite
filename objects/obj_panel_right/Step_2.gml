/// @description Slide out
event_inherited();

if exitInterface {
	exitInterface = false;
	
	moveToX = room_width + view_wport[1];
	moveToSpd = ( room_width + view_wport[1] - (x - room_width) ) / 4;
	moveDirection = 1;
	
	alarm[1] = 18;
}
