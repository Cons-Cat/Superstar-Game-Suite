/// @description 
event_inherited();

if instance_exists(trg) {
	zfloor = trg.zfloor;
}

if select {
	if mouse_x >= bbox_left && mouse_x <= bbox_right && mouse_y >= bbox_top && mouse_y <= bbox_bottom {
		select = false;
	}
	
	if mouse_x > obj_panel_left.x && mouse_x < obj_panel_right.x {
		if mouse_y > obj_panel_top.y {
			if !(mouse_x >= obj_panel_left.x - 1 && mouse_x < obj_panel_left.x + 21 && mouse_y >= obj_panel_left.y - 60 && mouse_y <= obj_panel_left.y + 60) && obj_panel_left.select = 0 {
				if !(mouse_x > obj_panel_right.x - 21 && mouse_x <= obj_panel_right.x + 1 && mouse_y >= obj_panel_right.y - 60 && mouse_y <= obj_panel_right.y + 60) && obj_panel_right.select = 0 {
					if !(mouse_x > obj_panel_top.x - 60 && mouse_x < obj_panel_top.x + 60 && mouse_y >= obj_panel_top.y && mouse_y <= obj_panel_top.y + 21) && obj_panel_top.select = 0 {
						if mouse_check_button_pressed(mb_left) {
							if trg.anchorId = -1 {
								trg.anchorId = instance_create_layer(floor(mouse_x / 20) * 40 + camera_get_view_x(obj_editor_gui.cameraRealGame), floor(mouse_y / 20) * 40 + camera_get_view_y(obj_editor_gui.cameraRealGame), "Instances",obj_camera_target);
							}
						}
					}
				}
			}
		}
	}
}
