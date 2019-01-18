/// @description 
if collision_rectangle(x,y,x+image_xscale*20,y+image_yscale*20,obj_player_overworld,true,false) {
	// Activate interactive cutscene
	if !activated {
		for (i = 1; i <= totalActions; i += 1) {
			if i = 0 {
				actor[actionTime[i],0] = obj_player_overworld.id; // 1/5'th second, 0'th Row
			} else {
				for (j = 1; j < instance_number(obj_npc_level) + 1; j += 1) { // Start at 1 to compensate for player
					if instance_find(obj_npc_position,j-1).instId1[0] = self.actorTxt[j] {
						actor[actionTime[i],j] = instance_find(obj_npc_position,j-1).trg; // 1/5'th second, Row
						actor[actionTime[i],j].trgRegion = self.id;
						actor[actionTime[i],j].activated = true;
						
						for (a = 0; a <= longestRowLength; a += 1) {
							actor[actionTime[i],j].xNode[a] = -1; // Initialize xNode
							actor[actionTime[i],j].yNode[a] = -1; // Initialize xNode
						}
					}
				}
			}
		}
		
		activated = true;
	}
}

if activated {
	if timeIndexCalc < longestRowLength {
		if timeIndexCalc*6 = timeIndex {
			for (i = 0; i < rows; i += 1) {
				// Walk action
				if actionInd[timeIndexCalc,i] = 0 {
					// Expresses intent to the actor. The actual movement is handled by that instance.
					actor[timeIndexCalc,i].xNode[timeIndexCalc] = self.xNode[timeIndexCalc,i];
					actor[timeIndexCalc,i].yNode[timeIndexCalc] = self.yNode[timeIndexCalc,i];
					actor[timeIndexCalc,i].endWalk[timeIndexCalc] = false; //self.endWalk[timeIndexCalc,i];
				}
				
				// Dialogue action
				if actionInd[timeIndexCalc,i] = 2 {
					// Create text box with expressed intent.
					with instance_create_layer(actor[timeIndexCalc,i].x-xOffDialogue[timeIndexCalc,i],actor[timeIndexCalc,i].y-yOffDialogue[timeIndexCalc,i],"Instances",obj_chat_bubble) {
						canMove = true;
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
				}
			}
		}
		
		timeIndex += 1; // Increment time each game tick
		timeIndexCalc = floor(timeIndex/6); // 1/10'th second increments
	}
}
