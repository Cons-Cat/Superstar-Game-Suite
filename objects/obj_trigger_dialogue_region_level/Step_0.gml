/// @description 
if collision_rectangle(x,y,x+image_xscale*20,y+image_yscale*20,obj_player_overworld,true,false) {
	// Activate interactive cutscene
	activated = true;
}
	
if activated {
	if timeIndex < rows {
		if waitCounter = 0 {
			if rowSetting[timeIndex] = 1 {
				// Talk trigger
				with instance_create_layer(actor[timeIndex].x,actor[timeIndex].y,"Instances",obj_chat_bubble) {
					canMove = true;
					message[0] = other.str[other.timeIndex];
					trg = other.actor[other.timeIndex];
					outlineColor = red;
					speakerHeightY = 24//trg.sprite_height;
				}
			}
			if rowSetting[timeIndex] = 2 {
				// Walk trigger
				actor[timeIndex].xNode[timeIndex] = self.xNode[timeIndex];
				actor[timeIndex].yNode[timeIndex] = self.yNode[timeIndex];
				actor[timeIndex].endWalk[timeIndex] = self.endWalk[timeIndex];
				actor[timeIndex].trgRegion = self.id;
				actor[timeIndex].canIncrement = true;
			}
			if rowSetting[timeIndex] = 3 {
				// Wait trigger
				waitCounter = wait[timeIndex];
			}
			
			timeIndex += 1;
		} else {
			waitCounter -= 1;
		}
	}
}
