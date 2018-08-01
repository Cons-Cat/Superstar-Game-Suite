/// @description Button functionality
for (i = 1; i <= 4; i += 1) {
	if mouse_x >= x && mouse_x < x + 23 && mouse_y >= y + (i-1)*10 && mouse_y < y + i*10 && menuAlpha = 1 {
		if mouse_check_button_pressed(mb_left) {
			selectButCol[i] = c_yellow;
		}
		if mouse_check_button_released(mb_left) {
			if i < 4 {
				// Add to timeline
				selectButCol[i] = c_white;
				selectButTimelineCol[i] = c_white;
				selectNumCol[rowSelected] = c_white;
				rowSetting[rowSelected] = i;
				
				if !instance_exists(obj_cutscene_actor_dummy_lucy) {
					if rowSetting[rowSelected] != 0 && rowSetting[rowSelected] != 3 && rowSetting[rowSelected] != 5 {
						menuAlpha = 0.3; // Disable menu while defining parameters
						// Create party dummies
						instance_create_layer(trg.x+trg.width*10,trg.y+trg.height*10,"Instances",obj_cutscene_actor_dummy_lucy);
					}
				}
				
				if i = 1 {
					// Talk button
					with instance_create_layer(mouse_x,mouse_y,"Instances",obj_cutscene_actor_getter_talk) {
						i = other.rowSelected;
					}
				}
				if i = 2 {
					// Walk button
					with instance_create_layer(mouse_x,mouse_y,"Instances",obj_cutscene_actor_getter_walk) {
						i = other.rowSelected;
					}
				}
				if i = 3 {
					// Wait button
					wait[rowSelected] = get_integer("Wait Input",0);
				}
				
				if rowSelected = rows {
					rows += 1;
					selectButTimelineCol[rows] = c_white;
					rowSetting[rows] = 0;
					rowSelected = rows;
				}
			} else {
				// Close menu
				for (j = 0; j <= rows; j += 1) {
					trg.selectNumCol[j] = self.selectNumCol[j];
					trg.rowSetting[j] = self.rowSetting[j];
					trg.selectButTimelineCol[j] = self.selectButTimelineCol[j];
					
					if j > 0 && j < rows {
						if rowSetting[j] = 1 {
							trg.str[j] = self.str[j];
							trg.actor[j] = self.actor[j];
						}
						if rowSetting[j] = 2 {
							trg.xNode[j] = self.xNode[j];
							trg.yNode[j] = self.yNode[j];
							trg.actor[j] = self.actor[j];
						}
						if rowSetting[j] = 3 {
							trg.wait[j] = self.wait[j];
						}
					
						trg.rows = self.rows;
					}
				}
				instance_destroy();
			}
		}
	} else {
		selectButCol[i] = c_white;
	}
}

for (i = 0; i <= rows; i += 1) {
	if mouse_check_button(mb_left) && menuAlpha = 1 {
		if i > 0 {
			// Set timeline index to replace command
			if mouse_x >= x + 23 + (i div 10)*43 && mouse_x < x + 43 + (i div 10)*43 && mouse_y >= y + (i-1)*10-(i div 10)*100+10 && mouse_y < y + i*10-(i div 10)*100+10 {
				rowSelected = i;
			} else {
				selectNumCol[i] = c_white;
			}
			
			// Modify timeline values
			if mouse_x >= x + 43 + (i div 10)*43 && mouse_x < x + 66 + (i div 10)*43 && mouse_y >= y + (i-1)*10-(i div 10)*100+10 && mouse_y < y + i*10-(i div 10)*100+10 {
				selectButTimelineCol[i] = c_yellow;
				
				if rowSetting[i] = 1 {
					// Talk button
					str[i] = get_string("Dialogue Input:",str[i]);
				}
				if rowSetting[i] = 2 {
					// Walk button
					if !instance_exists(obj_cutscene_actor_getter_walk_target) {
						menuAlpha = 0.3;
						instance_create_layer(xNode[i],yNode[i]-zfloor*20,"Instances",obj_cutscene_actor_getter_walk_target);
						obj_cutscene_actor_getter_walk_target.canDrag = true;
						obj_cutscene_actor_getter_walk_target.i = self.i;
					}
				}
				if rowSetting[i] = 3 {
					// Wait button
					wait[i] = get_integer("Wait Input",wait[i]);
				}
			} else {
				selectButTimelineCol[i] = c_white;
			}
		}
	}
	if mouse_check_button_released(mb_left) {
		selectButTimelineCol[i] = c_white;
	}
}

selectNumCol[rowSelected] = c_yellow;
