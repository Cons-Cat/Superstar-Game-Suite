/// @description Delayed objects spawn
instance_create_layer(obj_camera_editor.x,obj_camera_editor.y,"Instances",obj_player_overworld);

with obj_trigger_dialogue_region_editor {
	// Region collision
	with instance_create_layer(x,y,"Instances",obj_trigger_dialogue_region_level) {
		y = other.y;
		x = other.x;
		image_xscale = other.width;
		image_yscale = other.height;
		zfloor = other.zfloor;
		rows = instance_number(obj_actor_parent);
		totalActions = other.totalActions;
		longestRowLength = other.longestRowLength;
		
		// Initialize ticks
		for (i = 0; i <= longestRowLength; i += 1) {
			for (j = 0; j < rows; j += 1) {
				actionInd[i,j] = -1; // Null action
			}
		}
		
		for (i = 1; i <= totalActions; i += 1) {
			actionInd[other.actionTime[i],other.actionRowInd[i]] = other.actionInd[i]; // Action type
			
			// Walk action
			if actionInd[other.actionTime[i],other.actionRowInd[i]] = 0 {
				/*xNode[i] = other.xNode[i];
				yNode[i] = other.yNode[i];
				actor[i] = other.actor[i];
				
				with actor[i] {
					// Dummy data
					for (j = 1; j <= other.rows; j += 1) {
						xNode[j] = -1;
						yNode[j] = -1;
					}
				}
				
				if i <= rows - 1 {
					var iTemp = i + 1;
					
					if other.rowSetting[iTemp] = 2 {
						if other.actor[iTemp] = actor[i] {
							endWalk[i] = false;
						} else {
							endWalk[i] = true;
						}
					} else {
						endWalk[i] = true;
					}
				} else {
					endWalk[i] = true;
				}
				
				if actor[i] = 0 {
					actor[i] = obj_player_overworld.id;
				}*/
			}
			
			// Dialogue action
			if actionInd[other.actionTime[i],other.actionRowInd[i]] = 2 {
				/*str[i] = other.str[i];
				actor[i] = other.actor[i];
				
				if actor[i] = 0 {
					actor[i] = obj_player_overworld.id;
				}*/
			}
		}
	}
}
