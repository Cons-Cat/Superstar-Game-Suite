/// @description Transfer data
/*for (i = 0; i <= height; i += 1) {
	obj_panel_bot.str[timeIndex,i] = str[i];
}

obj_panel_bot.textRows[timeIndex] = self.textRows;
obj_panel_bot.dialogueWidth[timeIndex] = self.boxWidth;
obj_panel_bot.dialogueHeight[timeIndex] = self.boxHeight;
obj_panel_bot.xOffDialogue[timeIndex] = (trg.x - x);
obj_panel_bot.yOffDialogue[timeIndex] = (trg.y - trg.zfloor*20 - y);
*/
obj_panel_bot.xNode[timeIndex] = self.x;
obj_panel_bot.yNode[timeIndex] = self.y;
obj_camera_editor.canInputMove = true;

obj_trigger_region_parent.alarm[2] = 2;
obj_trigger_cutscene_region_editor.alarm[2] = 2;
