/// @description 
if collision_rectangle(x,y,x+image_xscale*20,y+image_yscale*20,obj_player_overworld,true,false) {
	// Activate interactive cutscene
	activated = true;
}

if activated {
	if timeIndexCalc <= longestRowLength {
		for (i = 0; i < rows; i += 1) {
			// Walk action
			if actionInd[timeIndexCalc,i] = 0 {
				show_message("Walk executed");
				/*actor[timeIndexPrec,i].xNode[timeIndexPrec,i] = self.xNode[timeIndexPrec,i];
				actor[timeIndexPrec,i].yNode[timeIndexPrec,i] = self.yNode[timeIndexPrec,i];
				actor[timeIndexPrec,i].endWalk[timeIndexPrec,i] = self.endWalk[timeIndexPrec,i];
				actor[timeIndexPrec,i].trgRegion = self.id;
				actor[timeIndexPrec,i].canIncrement = true;*/
			}
			
			// Dialogue action
			if actionInd[timeIndexCalc,i] = 2 {
				/*with instance_create_layer(actor[timeIndexPrec,i].x,actor[timeIndexPrec,i].y,"Instances",obj_chat_bubble) {
					canMove = true;
					message[0] = other.str[other.timeIndexPrec,i];
					trg = other.actor[other.timeIndexPrec,i];
					outlineColor = red;
					speakerHeightY = 24//trg.sprite_height;
				}*/
			}
		}
		
		timeIndex += 1; // Increment time in steps 
		timeIndexCalc = floor(timeIndex/6); // 1/6 second increments
	} else { show_message("DONE");}
}
