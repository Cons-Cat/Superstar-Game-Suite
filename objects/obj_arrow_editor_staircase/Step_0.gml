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
		magnitude = point_distance(
		trg.x1 + (trg.x2 - trg.x1)/2,
		trg.y1 + (trg.y2 - trg.y1)/2,
		mouseCheckX + mouseOffX,
		mouseCheckY + mouseOffY
		) div 30;
		
		trg.staircaseN = magnitude*20;
		trg.resetArray = true;
	}
}
