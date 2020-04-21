/// @description 
width = floor(13 * obj_editor_gui.windowWRatio);
height = floor(58 * obj_editor_gui.windowWRatio);

if height > obj_panel_top.baseY + y - 4 {
	height = obj_panel_top.baseY + y - 4;
	width = floor(height * 13/58);
}

x = obj_panel_right.baseX + floor( (view_wport[1] + room_width - obj_panel_right.baseX) * 0.22 ) + 77;
y = 5 + floor( (obj_panel_top.y-5) / 2 - (height-5) / 2 );

if mouse_x >= self.x && mouse_x <= self.x + width
&& mouse_y >= self.y && mouse_y <= self.y + height
{
	canSelect = true;
} else {
	canSelect = false;
	
	if !mouse_check_button(mb_left) {
		select = false;
	}
}

if canSelect {
	if mouse_check_button_pressed(mb_left) {
		select = true;
	}
	
	if mouse_check_button_released(mb_left) {
		if select {
			mode++;
			
			if mode > 1 {
				mode = 0;
			}
			
			with obj_editor_placeable_parent { scr_terrain_update_z(); }
			select = false;
		}
	}
}

if select && canSelect {
	selState = 2;
} else if select xor canSelect {
	selState = 1;
} else {
	selState = 0;
}
