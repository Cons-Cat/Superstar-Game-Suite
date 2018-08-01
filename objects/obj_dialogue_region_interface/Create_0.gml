/// @description Initialize variables
rows = 1;
rowSetting[1] = 0;
rowSelected = rows;

selectButCol[1] = c_white;
selectButCol[2] = c_white;
selectButCol[3] = c_white;
selectButCol[4] = c_white;

selectNumCol[1] = c_yellow;
selectButTimelineCol[1] = c_white;
menuAlpha = 1;

depth = -room_height - 120;

with obj_editor_button_parent {
	instance_destroy();
}
