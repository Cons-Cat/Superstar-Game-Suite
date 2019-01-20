/// @description 
draw_sprite(sprite_index,image_index,x,y);

draw_set_color(make_color_rgb(252,244,122));
draw_rectangle(x,y - zfloor*20,x,y,false);

tempActionTime = 0;
originX[obj_panel_bot.totalActions] = -1;
j = 1;
i = 1;

while tempActionTime < obj_panel_bot.longestRowLength {
	for (i = 1; i <= obj_panel_bot.totalActions; i += 1) {
		if obj_panel_bot.actionRowInd[i] = rowIndex {
			if obj_panel_bot.actionInd[i] = 0 {
				if obj_panel_bot.actionTime[i] = tempActionTime {
					if timeIndex != i {
						originX[j] = obj_panel_bot.xNode[i];
						originY[j] = obj_panel_bot.yNode[i];
					} else {
						originX[j] = self.x;
						originY[j] = self.y;
					}
					
					j += 1;
					break;
				} 
			}
		}
	}
	
	tempActionTime += 1;
}

// originX[0] and originY[0] are transmitted from obj_panel_bot

for (i = 1; i < j; i += 1) {
	draw_line(originX[i],originY[i] - zfloor*20,originX[i-1],originY[i-1] - zfloor*20);
}

draw_sprite(sprite_index,image_index,x,y - zfloor*20);
