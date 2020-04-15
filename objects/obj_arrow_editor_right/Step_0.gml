/// @description 
event_inherited();

// Selecting
if mouseCheckX >= self.x && mouseCheckX <= self.x - sprite_width && mouseCheckY >= self.y - sprite_height/2 && mouseCheckY <= self.y + sprite_height/2 {
	if mouse_check_button_pressed(mb_left) {
		if canSelect {
			select = true;
		}
	}
}

if instance_exists(trg) {
	if select {
		if floor(mouseCheckX/20)*20 <= room_width {
			if mouseCheckX > trg.x + 20 && trg.str != "slope2" && trg.str != "slope3" {
				x = floor(mouseCheckX/20)*20;
				
				if self.x > trg.x + trg.width*20 {
					trg.width += 1;
				}
				if self.x < trg.x + trg.width*20 {
					trg.width -= 1;
				}
				
				if trg.object_index = obj_editor_staircase {
					with trg {
						event_user(1);
						bakeRaster = true;
					}
				}
				trg.resetArray = true;
			}
			
			if mouseCheckX > trg.x + 40 && trg.str = "slope2" && trg.str != "slope3" {
				x = floor(mouseCheckX/40)*40 + x % 40;
				if self.x > trg.x + trg.width*20 {
					trg.width += 2;
				}
				if self.x < trg.x + trg.width*20 {
					trg.width -= 2;
				}
				
				if trg.object_index = obj_editor_staircase {
					with trg {
						event_user(1);
						bakeRaster = true;
					}
				}
				trg.resetArray = true;
			}
		}
	}
}
