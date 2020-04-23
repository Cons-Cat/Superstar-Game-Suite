/// @description 
event_inherited();

// Slide sub-panel in.
if spawnActions {
	spawnActions = false;
	
	if obj_subpanel_left.anchored {
		obj_subpanel_left.tempY = round( (obj_panel_bot.y - obj_panel_top.y + 10) * 3/5);
		obj_subpanel_left.moveToSpd = 1;
	} else {
		obj_subpanel_left.tempY = obj_subpanel_left.y;
		obj_subpanel_left.moveToSpd = (obj_panel_bot.y - obj_subpanel_left.y)/6.5;
	}
	
	obj_subpanel_left.moveDirection = 1;
	obj_subpanel_left.moveToY = obj_panel_bot.y;
	
	// Standard formula to solve for time, given speed and distance
	// +5 is a pause to dramatize the motion
	obj_subpanel_left.alarm[1] = abs(obj_panel_bot.y - obj_subpanel_left.y) / obj_subpanel_left.moveToSpd + 5;
	
	alarm[3] = obj_subpanel_left.alarm[1];
}
