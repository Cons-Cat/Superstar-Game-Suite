/// @description Activate special

// Deselect terrain
if mouse_check_button_pressed(mb_left) {
	alarm[0] = 2;
}

if select = 1 {
	if mouse_x > self.x && mouse_x < self.x + sprite_width && mouse_y > self.y && mouse_y < self.y+sprite_height {
		if mouse_check_button_released(mb_left) {
			with trg {
				if str = "actor" {
				}
				if str = "door" {
					roomStr = get_string("What is the room name?",string(roomStr));
				}
				if str = "slope1" || str = "slope2" || str = "slope3" {
					if other.str2 = "mirror" {
						mirror = !mirror;
					}
					if other.str2 = "flip" {
						flip = !flip;
						
						if flip {
							depthOffset = 3;
						} else {
							depthOffset = 0;
						}
					}
					
					resetArray = true;
					other.select = 0;
					other.col = c_white;
				}
				if str = "staircase" {
					if other.str2 = "mirror" {
						staircaseType += 1;
						
						if staircaseType > 2 {
							staircaseType = 0;
						}
						
						show_debug_message(staircaseType);
					}
					if other.str2 = "flip" {
						staircaseRotation += 1;
						
						if staircaseRotation > 9 {
							staircaseRotation = 0;
						}
						
						show_debug_message(staircaseRotation);
					}
					
					resetArray = true;
					other.select = 0;
					other.col = c_white;
				}
				if str = "moveScene" {
					instance_create_layer(x,y,"Instances",obj_dialogue_region_interface);
					obj_dialogue_region_interface.trg = other.trg;
					obj_dialogue_region_interface.zfloor = self.zfloor;
					obj_dialogue_region_interface.rows = self.rows;
				
					for (j = 0; j <= rows; j += 1) {
						obj_dialogue_region_interface.selectNumCol[j] = self.selectNumCol[j];
						obj_dialogue_region_interface.selectButTimelineCol[j] = self.selectButTimelineCol[j];
						obj_dialogue_region_interface.rowSetting[j] = self.rowSetting[j];
						
						if j > 0 {
							if rowSetting[j] = 1 {
								obj_dialogue_region_interface.str[j] = self.str[j];
								obj_dialogue_region_interface.actor[j] = self.actor[j];
							}
							if rowSetting[j] = 2 {
								obj_dialogue_region_interface.xNode[j] = self.xNode[j];
								obj_dialogue_region_interface.yNode[j] = self.yNode[j];
								obj_dialogue_region_interface.actor[j] = self.actor[j];
							}
							if rowSetting[j] = 3 {
								obj_dialogue_region_interface.wait[j] = self.wait[j];
							}
						}
					}
				}
			}
		}
	} else {
		select = 0;
		col = c_white;
	}
}
