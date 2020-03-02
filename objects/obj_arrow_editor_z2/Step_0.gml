/// @description 
event_inherited();

// Selecting
if mouseCheckX >= self.x - sprite_width/2 && mouseCheckX <= self.x + sprite_width/2 && mouseCheckY >= self.y && mouseCheckY <= self.y + sprite_height {
	if mouse_check_button_pressed(mb_left) {
		select = true;
	}
}

if instance_exists(trg) {
	if select {
		if selectYOff = 0 {
			selectYOff = mouseCheckY - y;
		}
		
		y = floor((mouseCheckY - selectYOff)/20)*20;
		
		if y < trg.y + trg.height*20 {
			y = trg.y + trg.height*20;
		}
		if trg.zcieling = 0 {
			if y > trg.y + trg.height*20 + (trg.zfloor - trg.zcieling)*20 {
				y = trg.y + trg.height*20 + (trg.zfloor - trg.zcieling)*20;
			}
		}
		
		if self.y < trg.y + trg.height*20 + (trg.zfloor - trg.zcieling)*20 {
			trg.zcieling += 1;
		}
		if self.y > trg.y + trg.height*20 + (trg.zfloor - trg.zcieling)*20 {
			if trg.zcieling > 0 {
				trg.zcieling -= 1;
			}
		}
		if obj_z_mode.mode = 1 {
			if trg.zcieling < obj_z_min.z {
				trg.zcieling = obj_z_min.z;
				y = trg.y + trg.height*20 + (trg.zfloor - trg.zcieling)*20;
			}
		}
		
		with trg {
			scr_terrain_update_z();
			resetArray = true;
		}
	}
}
