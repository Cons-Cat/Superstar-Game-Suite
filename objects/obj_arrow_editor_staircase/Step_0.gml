/// @description 
event_inherited();

// Selecting
if collision_point(mouseCheckX,mouseCheckY,self.id,true,false) {
	if mouse_check_button_pressed(mb_left) {
		if canSelect {
			select = true;
			
			mouseOffX = mouseCheckX - self.x;
			mouseOffY = mouseCheckY - self.y;
		}
	}
}

if instance_exists(trg) {
	if select {
		// slopeRun = trg.angleRise;
		// slopeRise = -trg.angleRun;
		// show_debug_message("BUTTON: " + string(slopeRun) + ", " + string(slopeRise));
		
		magnitude = point_distance(
		// trg.x + (trg.width * 20 * slopeRun / 2),
		// trg.y + (trg.width * 20 * slopeRise / 2) + (trg.zfloor - trg.zcieling) * 20,
		trg.x + (trg.width * 20 * trg.angleRise / 2),
		trg.y + (trg.width * 20 * -trg.angleRun / 2) + (trg.zfloor - trg.zcieling) * 20,
		mouseCheckX + mouseOffX,
		mouseCheckY + mouseOffY
		) div 20;
		
		trg.staircaseN = magnitude*20;
		trg.resetArray = true;
	}
}
