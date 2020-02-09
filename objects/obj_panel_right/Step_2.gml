/// @description Slide out
event_inherited();

if exitInterface {
	exitInterface = false;
	
	moveToX = room_width + view_wport[1];
	moveToSpd = ( room_width + view_wport[1] - (x - room_width) ) / 4;
	moveDirection = 1;
	
	alarm[1] = 18;
}

// Scrolling the tilesheet
if instance_exists(obj_tiles_sheet) {
	obj_tiles_sheet.xOff = ( camera_get_view_x(obj_editor_gui.cameraRightPanel) - (obj_panel_right.panelWidth - (obj_panel_right.scrollHorRightBound - obj_panel_right.scrollHorLeftBound)) * obj_panel_right.scrollHorPartition / 100 );
	obj_tiles_sheet.yOff = ( camera_get_view_y(obj_editor_gui.cameraRightPanel) - (obj_panel_right.panelHeight - (obj_panel_right.scrollVerBotBound - obj_panel_right.scrollVerTopBound)) * obj_panel_right.scrollVerPartition / 100 );
	
	panelOffset = ceil( abs(obj_tiles_sheet.xOff) );
} else {
	panelOffset = 0;
}
