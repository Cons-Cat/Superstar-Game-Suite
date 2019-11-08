/// @description 
if activeState = 0 {
	for (i = 0; i < ds_list_size(polygon); i += 6) {
		if rectangle_in_triangle(obj_player_overworld.bbox_left,obj_player_overworld.bbox_top,obj_player_overworld.bbox_right,obj_player_overworld.bbox_bottom,ds_list_find_value(polygon,i),ds_list_find_value(polygon,i+1),ds_list_find_value(polygon,i+2),ds_list_find_value(polygon,i+3),ds_list_find_value(polygon,i+4),ds_list_find_value(polygon,i+5)) {
			// Activate interactive cutscene
			actor[0] = obj_player_overworld.id; // 1/10'th second, 0'th row
			
			for (j = 0; j < rows; j += 1) {
				if j >= 1 {
					with obj_npc_position {
						if actorTxt = other.actorTxt[other.j] {
							other.actor[other.j] = instance_find(obj_npc_position,other.j-1).trg; // 1/10'th second, j'th row
						}
					}
				}
				
				actor[j].trgRegion = self.id;
				actor[j].sceneLength = self.longestRowLength;
				
				for (a = 0; a <= longestRowLength; a += 1) {
					actor[j].xNode[a] = -1; // Initialize xNode
					actor[j].yNode[a] = -1; // Initialize yNode
					actor[j].angleRot[a] = -1; // Initialize angleRot
					actor[j].arbitraryInd[a] = -1; // Initialize arbitraryInd
				}
			}
			
			activeState = 1;
		}
	}
}

if activeState = 1 {
	if timeIndexCalc <= longestRowLength {
		if timeIndexCalc*6 = timeIndex { // If the tick is aligned with a multiple of 1/10th seconds
			for (i = 0; i < rows; i += 1) {
				// Walk action
				if actionInd[timeIndexCalc,i] = 0 {
					// Expresses intent to the actor. The actual movement is handled by that instance.
					actor[i].xNode[timeIndexCalc] = self.xNode[timeIndexCalc,i];
					actor[i].yNode[timeIndexCalc] = self.yNode[timeIndexCalc,i];
					actor[i].endWalk[timeIndexCalc] = self.endWalk[timeIndexCalc,i];
					actor[i].activeInScene = true;
				}
				
				// Rotation action
				if actionInd[timeIndexCalc,i] = 1 {
					actor[i].angleRot[timeIndexCalc] = self.angleRot[timeIndexCalc,i];
					actor[i].activeInScene = true;
				}
				
				// Dialogue action
				if actionInd[timeIndexCalc,i] = 2 {
					// Create text box with expressed intent.
					with instance_create_layer(actor[i].x-xOffDialogue[timeIndexCalc,i],actor[i].y-yOffDialogue[timeIndexCalc,i],"Instances",obj_chat_bubble) {
						canMove = false;
						message_end = 0;
						textRows = other.textRows[other.timeIndexCalc,other.i];
						trg = other.actor[other.timeIndexCalc,other.i];
						
						width = other.width[other.timeIndexCalc,other.i];
						height = other.height[other.timeIndexCalc,other.i];
						xOffDialogue = other.xOffDialogue[other.timeIndexCalc,other.i];
						yOffDialogue = other.yOffDialogue[other.timeIndexCalc,other.i];
						
						placex = trg.x - xOffDialogue;
						placey = trg.y - yOffDialogue + 10;
						outlineColor = red;
						
						for (j = 0; j < textRows; j += 1) {
							message[0,j] = other.dialogueStr[other.timeIndexCalc,j];
							message_draw[0,j] = "";
							characters[j] = 0;
						}
					}
					
					actor[i].activeInScene = true;
				}
				
				// Camera pan action
				if actionInd[timeIndexCalc,i] = 3 {
					// Expresses intent to the camera. The actual movement is handled by that instance.
					if instance_exists(obj_camera_editor) {
						obj_camera_editor.anchored = true;
						obj_camera_editor.zoomLevel = 1 - self.zoomVal[timeIndexCalc,i];
						obj_camera_editor.anchorId = self.id;
						obj_camera_editor.cutscenePan = true;
						obj_camera_editor.magnitudeTemp = 0;
						self.trgX = self.xNode[timeIndexCalc,i];
						self.trgY = self.yNode[timeIndexCalc,i];
						obj_camera_editor.cutscenePanSpd = point_distance(camera_get_view_x(obj_editor_gui.cameraRealGame) + camera_get_view_width(obj_editor_gui.cameraRealGame)/2,camera_get_view_y(obj_editor_gui.cameraRealGame) + camera_get_view_height(obj_editor_gui.cameraRealGame)/2,trgX,trgY) / ( 20 * 60 * 4 );
						
						if obj_camera_editor.cutscenePanSpd > 0.0175 {
							obj_camera_editor.cutscenePanSpd = 0.0175;
						}
					}
					
					if instance_exists(obj_camera) {
					}
				}
				
				// Walk speed action
				if actionInd[timeIndexCalc,i] = 5 {
					// Expresses intent to the actor. The actual movement is handled by that instance.
					actor[i].slowSpd = self.slowSpd[timeIndexCalc,i];
				}
				
				// Arbitrary action
				if actionInd[timeIndexCalc,i] = 6 {
					show_message(arbitraryInd[timeIndexCalc,i]);
					// Expresses intent to the actor. The actual execution is handled by that instance.
					actor[i].arbitraryInd[timeIndexCalc] = self.arbitraryInd[timeIndexCalc,i];
					actor[i].activeInScene = true;
				}
			}
		}
		
		timeIndex += 1; // Increment time each game tick
		timeIndexCalc = timeIndex div 6; // 1/10'th second increments
	} else {
		// If not in dialogue
		if !instance_exists(obj_chat_bubble) {
			// Iterate through all actors
			for (i = 0; i < instance_number(obj_actor_parent); i += 1) {
				// If any actors are walking
				if instance_find(obj_actor_parent,i).activeInScene {
					break;
				}
				
				// End the scene
				if i = instance_number(obj_actor_parent) - 1 {
					activeState = 2;
				}
			}
		}
	}
}
