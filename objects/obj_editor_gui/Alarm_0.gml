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
			actionTime[i] = other.actionTime[i]; // 1/10'th second tick
			
			// Walk action
			if actionInd[other.actionTime[i],other.actionRowInd[i]] = 0 {
				xNode[other.actionTime[i],other.actionRowInd[i]] = other.xNode[i];
				yNode[other.actionTime[i],other.actionRowInd[i]] = other.yNode[i];
				
				// Whether the actor continues walking afterwards
				endWalk[other.actionTime[i],other.actionRowInd[i]] = true;
				
				for (j = 0; j <= totalActions; j += 1) {
					if other.actionRowInd[j] = other.actionRowInd[i] {
						if other.actionInd[j] = 0 {
							if other.actionTime[j] > other.actionTime[i] {
								if abs(other.actionTime[i] - other.actionTime[j]) <= 4 {
									endWalk[other.actionTime[i],other.actionRowInd[i]] = false;
									
									break;
								}
							}
						}
					}
				}
			}
			
			// Rotation action
			if actionInd[other.actionTime[i],other.actionRowInd[i]] = 1 {
				angleRot[other.actionTime[i],other.actionRowInd[i]] = other.angleRotExport[i];
			}
			
			// Dialogue action
			if actionInd[other.actionTime[i],other.actionRowInd[i]] = 2 {
				width[other.actionTime[i],other.actionRowInd[i]] = other.dialogueWidth[i];
				height[other.actionTime[i],other.actionRowInd[i]] = other.dialogueHeight[i];
				textRows[other.actionTime[i],other.actionRowInd[i]] = other.textRows[i];
				xOffDialogue[other.actionTime[i],other.actionRowInd[i]] = other.xOffDialogue[i];
				yOffDialogue[other.actionTime[i],other.actionRowInd[i]] = other.yOffDialogue[i];
				
				for (j = 0; j < textRows[other.actionTime[i],other.actionRowInd[i]]; j += 1) {
					dialogueStr[other.actionTime[i],j] = other.dialogueStr[i,j];
				}
			}
			
			// Camera pan action
			if actionInd[other.actionTime[i],other.actionRowInd[i]] = 3 {
				panAngle[other.actionTime[i]] = other.panAngle[i];
				panMagnitude[other.actionTime[i]] = other.panMagnitude[i];
				// The maximum speed spans the length of the vector in 1.05 seconds
				panMagnitudeSpdMax[other.actionTime[i]] = other.panMagnitude[i] / (60 * 1.05);
				
				if other.easeInVal[i] != 0 {
					panEaseIn[other.actionTime[i]] = other.easeInVal[i] / 320;
				} else {
					panEaseIn[other.actionTime[i]] = -1;
				}
				if other.easeOutVal[i] != 0 {
					panEaseOut[other.actionTime[i]] = other.easeOutVal[i] / 320;
				} else {
					panEaseOut[other.actionTime[i]] = -1;
				}
			}
		}
	}
}
