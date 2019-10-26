/// @description 
scrollOff = (obj_subpanel_left.panelHeight - (obj_subpanel_left.scrollVerBotBound - obj_subpanel_left.scrollVerTopBound + 9)) * obj_subpanel_left.scrollVerPartition / 100;
y = 12 - scrollOff + sprite_get_height(sprite_index);
x = camera_get_view_x(obj_editor_gui.cameraLeftSubPanel) + sprite_get_width(sprite_index);
