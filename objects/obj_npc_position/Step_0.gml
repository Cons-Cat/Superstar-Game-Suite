/// @description Manipulating dimensions
if obj_editor_gui.mode = 4 {
	if placed = 1 {
		canSelect = true;
		
		if mouse_check_button_pressed(mb_left) && mouse_x < camera_get_view_x(obj_editor_gui.camera)+camera_get_view_width(obj_editor_gui.camera)-48 {
			if !instance_exists(obj_cutscene_actor_getter_parent) {
				if canSelect {
					if (obj_editor_gui.mode = 4 && mouse_x >= x && mouse_x <= x+width*20 && mouse_y >= y && mouse_y <= y+height*20+(zfloor-zcieling)*20) {
						if select = 0 && !instance_exists(obj_editor_button_parent) && !instance_exists (obj_dialogue_region_interface) {
							select = 1;
				
							with instance_create_layer(x,y,"Instances",obj_arrow_editor_drag) {
								trg = other.id;
							}
							with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z3) {
								trg = other.id;
							}
							with instance_create_layer(x,y+20,"Instances",obj_x_editor) {
								trg = other.id;
							}
							with instance_create_layer(x+20,y+20,"Instances",obj_info_editor) {
								trg = other.id;
							}
						}
					}
				}
			}
		}
		if select = 1 {
			select = 0;
		} else {
			exportString = string_hash_to_newline("#{"+chr(34)+"name"+chr(34)+": "+chr(34)+instId1+chr(34)+","+chr(34)+"id"+chr(34)+": "+chr(34)+instId2+chr(34)+","+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+instId3+" },"+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"creationCodeType"+chr(34)+": "+chr(34)+chr(34)+","+chr(34)+"ignore"+chr(34)+": false,"+chr(34)+"inheritCode"+chr(34)+": false,"+chr(34)+"inheritItemSettings"+chr(34)+": false,"+chr(34)+"IsDnD"+chr(34)+": false,"+chr(34)+"m_originalParentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"m_serialiseFrozen"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRInstance"+chr(34)+","+chr(34)+"name_with_no_file_rename"+chr(34)+": "+chr(34)+instId1+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+instId3+chr(34)+","+chr(34)+"properties"+chr(34)+": null,"+chr(34)+"rotation"+chr(34)+": 0,"+chr(34)+"scaleX"+chr(34)+": "+string(width)+","+chr(34)+"scaleY"+chr(34)+": "+string(height+zfloor-zcieling)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"x"+chr(34)+": "+string(x)+","+chr(34)+"y"+chr(34)+": "+string(y)+"},");
		}
	}
	if !instance_exists(obj_editor_button_parent) {
		// Ensure that object deselects properly
		select = 0;
	}

	// Placing in the level
	if placed = 0 {
		x = floor(mouse_x/20)*20;
		y = floor(mouse_y/20)*20 - zfloor*20;
	}
	if mouse_check_button_released(mb_left) {
		if placed = 0 {
			placed = 1;
			obj_tile_button_parent2.select = 0;
		}
	}
	
	// Find relevant floor object
	trgFinalTemp = 0;
	for (i = 0; i < instance_number(obj_editor_terrain); i += 1) {
		trgScr = instance_find(obj_editor_terrain,i).id;
		if trgScr.zfloor*20 <= self.zfloor*20 {
			if collision_point(x,y,trgScr,true,true) {
				trgLayer[i] = trgScr.zfloor;
				for (a = 0; a <= i; a += 1) {
					if trgLayer[a] >= trgFinalTemp {
						trgFinal = trgScr;
						trgFinalTemp = trgLayer[a];
					}
				}
				platOn = trgFinal.zfloor*20;
			}
		}
	}
	
	if instance_exists(trgFinal) {
		if trgFinal.zfloor = self.zfloor {
			fallSearch = false; // Cancel fall if standing on a platform
			onGround = true;
			depth = - (trgFinal.y + trgFinal.image_yscale*20 + (trgFinal.zfloor - trgFinal.zcieling)*20) - self.platOn - 1;
		}
	}
}
