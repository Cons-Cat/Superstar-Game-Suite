/// @description Transfer meta-data
for (i = 0; i <= height; i += 1) {
	obj_panel_bot.str[timeIndex,i] = str[i];
	obj_panel_bot.strWidth[timeIndex,i] = self.width;
	obj_panel_bot.strHeight[timeIndex,i] = self.height;
}

obj_panel_bot.textRows[timeIndex,rowIndex] = self.textRows;
obj_panel_bot.xOffDialogue[timeIndex,rowIndex] = abs(placex - trg.x + 20);
obj_panel_bot.yOffDialogue[timeIndex,rowIndex] = abs(placey - trg.y + 15);

obj_trigger_dialogue_region_editor.alarm[2] = 2;
