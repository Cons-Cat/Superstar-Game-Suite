/// @description 
event_inherited();

// Selecting
if mouseCheckX >= self.x - sprite_width/2 && mouseCheckX <= self.x + sprite_width/2 && mouseCheckY >= self.y - sprite_height + 4 && mouseCheckY <= self.y + 4 {
	if mouse_check_button_pressed(mb_left) {
		select = true;
	}
}

if instance_exists(trg) {
	if select {
		if mouseCheckY >= 0 {
			if selectYOff = 0 {
				selectYOff = mouseCheckY - y;
			}
			
			y = floor((mouseCheckY - selectYOff)/20)*20 + 10;
			
			if y > trg.y + trg.height*10 + (trg.zfloor - trg.zcieling) * 20 {
				y = trg.y + trg.height*10 + (trg.zfloor - trg.zcieling) * 20;
			}
			
			while self.y < trg.y + 20 {
				trg.zfloor += 1;
				trg.y -= 20;
			}
			while self.y > trg.y + 20 && trg.zfloor > trg.zcieling {
				trg.zfloor -= 1;
				trg.y += 20;
			}
			
			if obj_z_mode.mode = 1 {
				if trg.zfloor > obj_z_max.z {
					trg.y += (trg.zfloor - obj_z_max.z) * 20;
					trg.zfloor = obj_z_max.z;
					y = trg.y + trg.height*10;
				}
			}
			
			trg.tilingY = trg.y - 20;
			
			with trg {
				scr_terrain_update_z();
				
				if object_index = obj_editor_staircase {
					event_user(1);
					bakeRaster = true;
				}
				
				resetArray = true;
			}
		}
	}
}
