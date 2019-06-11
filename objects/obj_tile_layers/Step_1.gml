/// @description 
subPointDisplacement = 0;

y = 0;
x = camera_get_view_x(obj_editor_gui.cameraLeftSubPanel);

// Layers
for (i = 0; i < array_height_2d(list); i += 1) {
	canSelect[i,0] = false;
	
	// Toggle layer eye
	eyeCol[i] = col;
	
	if mouse_x >= x + 2 && mouse_x <= x + 11 && mouse_y >= 2 + i * 10 + subPointDisplacement && mouse_y < 12 + i * 10 + subPointDisplacement {
		eyeCol[i] = orange;
		
		if mouse_check_button_pressed(mb_left) {
			if eyeState[i] = 0 {
				eyeState[i] = 1;
				obj_tiles_grid.layerVisible[i*2 div 2] = false;
			} else {
				eyeState[i] = 0;
				obj_tiles_grid.layerVisible[i*2 div 2] = true;
			}
		}
	}
	
	// Select layer
	if mouse_x >= x + 14 && (mouse_x <= x + 19 + string_width(list[i,0]) || (mouse_x <= x + 59 && list[i,0] = "")) && mouse_y >= 2 + i * 10 + subPointDisplacement && mouse_y < 12 + i * 10 + subPointDisplacement {
		canSelect[i,0] = true;
		
		if mouse_check_button_pressed(mb_left) {
			if select[i,0] {
				select[i,0] = false;
				obj_tiles_grid.tileLayerSelect = -1;
			} else {
				select[i,0] = true;
				obj_tiles_grid.tileLayerSelect = i*2;
			}
			
			break;
		}
	} else {
		// De-select layer
		if !(window_mouse_get_x() < obj_panel_left.x && window_mouse_get_y() < obj_subpanel_left.y) {
			if !(window_mouse_get_x() > obj_panel_right.x && window_mouse_get_y() < obj_panel_bot.y) {
				if mouse_check_button_pressed(mb_left) {
					select[i,0] = false;
					obj_tiles_grid.tileLayerSelect = -1;
				}
			}
		}
	}
	
	// Name
	if select[i,0] {
		if keyboard_check_pressed(vk_anykey) {
			list[i,0] = typeText(list[i,0]);
		}
	}
	
	// Sub-layers
	for (j = 1; j < array_length_2d(list,i); j += 1) {
		canSelect[i,j] = false;
		
		// Select sub-layer
		if mouse_x >= x + 25 && (mouse_x <= x + 25 + string_width(list[i,j]) || (mouse_x <= x + 70 && list[i,j] = "")) && mouse_y >= 2 + (i * 10) + (j * 11) + subPointDisplacement && mouse_y < 12 + (i * 10) + (j * 11) + subPointDisplacement {
			canSelect[i,j] = true;
			
			if mouse_check_button_pressed(mb_left) {
				if select[i,j] {
					select[i,j] = false;
					obj_tiles_grid.tileLayerSelect = -1;
				} else {
					select[i,j] = true;
					obj_tiles_grid.tileLayerSelect = i*2 + 1;
				}
				
				break;
			}
		} else {
			// De-select sub-layer
			if !(window_mouse_get_x() < obj_panel_left.x && window_mouse_get_y() < obj_subpanel_left.y) {
				if !(window_mouse_get_x() > obj_panel_right.x && window_mouse_get_y() < obj_panel_bot.y) {
					if mouse_check_button_pressed(mb_left) {
						select[i,j] = false;
						obj_tiles_grid.tileLayerSelect = -1;
					}
				}
			}
		}
		
		// Name sub-layer
		if select[i,j] {
			if keyboard_check_pressed(vk_anykey) {
				list[i,j] = typeText(list[i,j]);
				
				/*if j > tileSubLayerCount[i] {
					with obj_tiles_grid {
						trgId.tileSubLayerCount[i] = j;
						tileSubLayerCount[i] = j;
						other.tileSubLayerCount[i] = j;
					}
				}*/
			}
		}
		
		// Increase sub-layer count
		/*if j = array_length_2d(list,i) - 1 {
			if list[i,j] != "" {
				list[i,j+1] = "";
				select[i,j+1] = false;
			}
		}*/
	}
	
	subPointDisplacement += (array_length_2d(list,i) - 1) * 11;
}

// Add new tile layer
plusCol = col;

if mouse_x >= x + 12 && mouse_x <= x + 18 && mouse_y >= 5 + (i * 10) + subPointDisplacement && mouse_y <= 12 + (i * 10) + subPointDisplacement {
	if mouse_check_button_pressed(mb_left) {
		eyeState[array_height_2d(list)] = 0;
		eyeCol[array_height_2d(list)] = col;
		
		tileLayerCount += 2;
		trgId.tileLayerCount = self.tileLayerCount;
		layerVisible[tileLayerCount div 2] = true;
		
		obj_tiles_grid.tileLayerCount = self.tileLayerCount;
		obj_tiles_grid.layerVisible[tileLayerCount div 2] = true;
		
		for (i = 0; i < trgId.width + 2; i += 1) {
			for (j = 0; j < trgId.zfloor - trgId.zcieling + 2; j += 1) {
				// Initialize new tiles
				trgId.hasTile[ scr_array_xy( i,j,trgId.width + 2 ), tileLayerCount - 1 ] = false;
				trgId.hasTile[ scr_array_xy( i,j,trgId.width + 2 ), tileLayerCount ] = false;
				
				obj_tiles_grid.hasTile[ scr_array_xy( i,j,trgId.width + 2 ), tileLayerCount - 1 ] = false;
				obj_tiles_grid.hasTile[ scr_array_xy( i,j,trgId.width + 2 ), tileLayerCount ] = false;
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

// Add foliated marble layer
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
