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
				actorTxt[j] = other.actorTxt[j];
			}
		}
		
		for (i = 1; i <= totalActions; i += 1) {
			actionInd[other.actionTime[i],other.actionRowInd[i]] = other.actionInd[i]; // Action type
			actionTime[i] = other.actionTime[i]; // 1/5'th second tick
			
			// Walk action
			if actionInd[other.actionTime[i],other.actionRowInd[i]] = 0 {
				xNode[other.actionTime[i],other.actionRowInd[i]] = other.xNode[i];
				yNode[other.actionTime[i],other.actionRowInd[i]] = other.yNode[i];
				
				// Whether the actor continues walking afterwards
				endWalk[other.actionTime[i]] = true;
				
				for (j = 0; j <= i + 6; j += 1) {
					if other.xNode[j] != -1 || other.yNode[j] != -1 {
						if j <= longestRowLength {
							endWalk[other.actionTime[i]] = false;
							
							break;
						} else {
							break;
						}
					}
				}
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
