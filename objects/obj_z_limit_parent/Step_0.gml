/// @description 
x = obj_panel_right.baseX + floor( (view_wport[1] + room_width - obj_panel_right.baseX) * 0.22 );

// Arrows
#region

// De-select arrows.
if !mouse_check_button(mb_left) || (!arrowLeftSel && !arrowRightSel) {
	if arrowLeftSel {
		arrowLeftSel = false;
	}
	if arrowRightSel {
		arrowRightSel = false;
	}
	
	arrowLeftSub = 0;
	arrowRightSub = 0;
}

// Select up arrow.
if mouse_x >= self.x - 25 && mouse_x <= self.x - 25 + sprite_get_width(spr_arrow_editor_up)
&& mouse_y >= self.y + 1 && mouse_y <= self.y + 1 + sprite_get_height(spr_arrow_editor_up)
{
	if mouse_check_button_pressed(mb_left) {
		arrowLeftSel = true;
		z++;
	}
	
	if !arrowLeftSel {
		arrowLeftSub = 1;
	} else {
		arrowLeftSub = 2;
	}
}

// Select down arrow.
if mouse_x >= self.x + sprite_width + 2 && mouse_x <= self.x + sprite_width + 2 + sprite_get_width(spr_arrow_editor_up)
&& mouse_y >= self.y + 1 && mouse_y <= self.y + 1 + sprite_get_height(spr_arrow_editor_up)
{
	if mouse_check_button_pressed(mb_left) {
		arrowRightSel = true;
		
		if z > 0 {
			z--;
		}
	}
	
	if !arrowRightSel {
		arrowRightSub = 1;
	} else {
		arrowRightSub = 2;
	}
}

#endregion

// Scrolling
if (mouse_x >= x && mouse_x <= x + sprite_width && mouse_y >= y && mouse_y <= y+sprite_height)
|| arrowLeftSub > 0 || arrowRightSub > 0
{
	if mouse_wheel_up() {
		z++;
		with obj_editor_terrain_par { scr_terrain_update_z(); }
	}
	
	if mouse_wheel_down() {
		if z > 0 {
			z--;
			with obj_editor_terrain_par { scr_terrain_update_z(); }
		}
	}
}

if (z = 0) {
	colZ = c_white;
} else {
	colZ = col[ (z - 1) % 9 ]
}

buttonWidth = buttonWidthRatio * window_get_width()
buttonHeight = buttonHeightRatio * buttonWidth;
