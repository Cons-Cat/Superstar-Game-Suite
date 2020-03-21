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
		x = trg.x + lengthdir_x(magnitude * 20, trg.normalAng) + lengthdir_x(trg.staircaseL, trg.ang) / 2;
		y = trg.y + lengthdir_y(magnitude * 20, trg.normalAng) + lengthdir_y(trg.staircaseL, trg.ang) / 2
		+ ( trg.zfloor - trg.zcieling ) * 20;
		
		tempMagnitude = abs( trg.x + lengthdir_x(trg.staircaseL, trg.ang) / 2 - (mouseCheckX - mouseOffX) ) / 20;
		
		magnitude = round(tempMagnitude);
		trg.staircaseN = self.magnitude*20;
		
		trg.resetArray = true;
	}
}
