/// @description 
event_inherited();

// Selecting
if mouseCheckX >= bbox_left && mouseCheckX <= bbox_right && mouseCheckY >= bbox_top && mouseCheckY <= bbox_bottom {
	if visible {
		if mouse_check_button_pressed(mb_left) {
			if canSelect {
				select = true;
			}
		}
	}
}

// Dragging terrain
if instance_exists(trg) {
	if select {
		xCheck = (mouseCheckX div global.snapDimension) * global.snapDimension;
		yCheck = (mouseCheckY div global.snapDimension) * global.snapDimension;
		
		if xCheck >= 0 && xCheck + trg.width*20 <= room_width {
			x = xCheck;
		}
		if yCheck >= 0 && yCheck + (trg.height + trg.zfloor - trg.zcieling)*20 <= room_height {
			y = yCheck;
		}
		
		trg.x = self.x;
		trg.y += self.y - trg.floorY;
		
		if trg.object_index = obj_editor_staircase {
			with trg {
				event_user(0);
			}
		}
		
		with trg { scr_terrain_update_z();	}
	}
}
