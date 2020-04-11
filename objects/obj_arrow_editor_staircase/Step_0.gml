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
		trg.x + lengthdir_x(trg.staircaseL, trg.normalAngle) / 2, trg.y + lengthdir_y(trg.staircaseL, trg.normalAngle) / 2 + (trg.zfloor - trg.zcieling) *20,
		mouseCheckX - mouseOffX, mouseCheckY - mouseOffY
		) div 20;
		
		trg.staircaseN = self.magnitude*20;
		
		trg.resetArray = true;
	}
}
