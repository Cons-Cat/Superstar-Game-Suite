/// @description 
x = obj_panel_right.baseX + floor( (view_wport[1] + room_width - obj_panel_right.baseX) * 0.22 ) + 77;

if mouse_x >= self.x && mouse_x <= self.x + sprite_width
&& mouse_y >= self.y && mouse_y <= self.y + sprite_height
{
	if !select {
		image_index = mode*3 + 1;
	}
	
	if mouse_check_button_pressed(mb_left) {
		image_index = mode*3 + 2;
		
		select = true;
	}
	
	if mouse_check_button_released(mb_left) {
		if select {
			mode++;
			
			if mode > 1 {
				mode = 0;
			}
			
			select = false;
		}
	}
} else {
	if !mouse_check_button(mb_left) || !select {
		image_index = mode * 3;
		
		select = false;
	}
}
