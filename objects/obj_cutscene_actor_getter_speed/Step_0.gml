/// @description Insert description here
mouseCheckX = obj_editor_gui.mouseCheckX;
mouseCheckY = obj_editor_gui.mouseCheckY;

if mouse_check_button_pressed(mb_left) {
	if mouseCheckX <= x + 21 && mouseCheckX > x - 20 {
		// Walk speed
		if mouseCheckY <= y - 16 && mouseCheckY >= y - 25 {
			slowSpd = true;
		}
		if mouseCheckY <= y - 5 && mouseCheckY >= y - 14 {
			slowSpd = false;
		}
	}
	
	// Click outside interface
	if (mouseCheckX < self.x - 20 || mouseCheckX > x + 21) || (mouseCheckY < y - 30 || mouseCheckY >= y) {
		// Pass all persistent values to obj_panel_bot
		obj_panel_bot.slowSpd[timeIndex] = self.slowSpd;
		
		obj_trigger_dialogue_region_editor.alarm[2] = 2;
			
		instance_destroy();
	}
}

