/// @description 
subPointDisplacement = 0;

y = 0;
x = camera_get_view_x(obj_editor_gui.cameraLeftSubPanel);

// Add layers
for (i = 0; i < array_height_2d(list); i += 1) {
	canSelect[i,0] = false;
	
	// Toggle eye
	eyeCol[i] = col;
	
	if mouse_x >= x + 2 && mouse_x <= x + 11 && mouse_y >= 2 + i * 10 + subPointDisplacement && mouse_y < 12 + i * 10 + subPointDisplacement {
		eyeCol[i] = orange;
		
		if mouse_check_button_pressed(mb_left) {
			if eyeState[i] = 0 {
				eyeState[i] = 1;
			} else {
				eyeState[i] = 0;
			}
		}
	}
	
	// Select layer
	if mouse_x >= x + 14 && (mouse_x <= x + 19 + string_width(list[i,0]) || (mouse_x <= x + 59 && list[i,0] = "")) && mouse_y >= 2 + i * 10 + subPointDisplacement && mouse_y < 12 + i * 10 + subPointDisplacement {
		canSelect[i,0] = true;
		
		if mouse_check_button_pressed(mb_left) {
			if select[i,0] {
				select[i,0] = false;
			} else {
				select[i,0] = true;
			}
		}
	} else {
		if mouse_check_button_pressed(mb_left) {
			select[i,0] = false;
		}
	}
	
	// Name
	if select[i,0] {
		if keyboard_check_pressed(vk_anykey) {
			list[i,0] = typeText(list[i,0]);
		}
	}
	
	for (j = 1; j < array_length_2d(list,i); j += 1) {
		canSelect[i,j] = false;
		
		if mouse_x >= x + 25 && (mouse_x <= x + 25 + string_width(list[i,j]) || (mouse_x <= x + 70 && list[i,j] = "")) && mouse_y >= 2 + (i * 10) + (j * 11) + subPointDisplacement && mouse_y < 12 + (i * 10) + (j * 11) + subPointDisplacement {
			canSelect[i,j] = true;
			
			if mouse_check_button_pressed(mb_left) {
				if select[i,j] {
					select[i,j] = false;
				} else {
					select[i,j] = true;
				}
			}
		} else {
			if mouse_check_button_pressed(mb_left) {
				select[i,j] = false;
			}
		}
		
		// Name
		if select[i,j] {
			if keyboard_check_pressed(vk_anykey) {
				list[i,j] = typeText(list[i,j]);
			}
		}
		
		// Increase length
		if j = array_length_2d(list,i) - 1 {
			if list[i,j] != "" {
				list[i,j+1] = "";
				select[i,j+1] = false;
			}
		}
	}
	
	subPointDisplacement += (array_length_2d(list,i) - 1) * 11;
}

// Add new layer
plusCol = col;

if mouse_x >= x + 12 && mouse_x <= x + 18 && mouse_y >= 5 + (i * 10) + subPointDisplacement && mouse_y <= 12 + (i * 10) + subPointDisplacement {
	if mouse_check_button_pressed(mb_left) {
		eyeState[array_height_2d(list)] = 0;
		eyeCol[array_height_2d(list)] = col;
		
		for (i = 0; i < trgId.width + 2; i += 1) {
			for (j = 0; j < trgId.height + 1; j += 1) {
				// Initialize new tiles
				trgId.hasTile[ scr_array_xy( i,j,array_height_2d(list) ), array_height_2d(list) ] = false;
			}
		}
		
		select[array_height_2d(list),0] = false;
		canSelect[array_height_2d(list),0] = false;
		k = array_height_2d(list);
		list[array_height_2d(list),0] = "layer_" + string(array_height_2d(list));
		
		select[array_height_2d(list)-1,1] = false;
		canSelect[array_height_2d(list)-1,1] = false;
		list[array_height_2d(list)-1,1] = "";		
	}
	
	plusCol = orange;
}

dieCol = col;

if mouse_x >= x + 22 && mouse_x <= x + 28 && mouse_y >= 5 + (i * 10) + subPointDisplacement && mouse_y <= 12 + (i * 10) + subPointDisplacement {
	if mouse_check_button_pressed(mb_left) {
		eyeState[array_height_2d(list)] = 0;
		eyeCol[array_height_2d(list)] = col;
		
		select[array_height_2d(list),0] = false;
		canSelect[array_height_2d(list),0] = false;
		list[array_height_2d(list),0] = "layer_" + string(array_height_2d(list));
		
		select[array_height_2d(list)-1,1] = false;
		canSelect[array_height_2d(list)-1,1] = false;
		list[array_height_2d(list)-1,1] = "";
	}
	
	dieCol = orange;
}

obj_subpanel_left.panelHeight = ( array_height_2d(list) + 1 ) * 10 + 4 + subPointDisplacement;
