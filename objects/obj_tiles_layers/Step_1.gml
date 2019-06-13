/// @description 
y = 0;
x = camera_get_view_x(obj_editor_gui.cameraLeftSubPanel);

// Add new tile layer	
plusCol = col;

if mouse_x >= x + 28 && mouse_x <= x + 34 && mouse_y >= 5 + (array_height_2d(layerName) * 21) && mouse_y <= 12 + (array_height_2d(layerName) * 21) {
	if mouse_check_button_pressed(mb_left) {
		eyeState[array_height_2d(layerName)] = 0;
		eyeCol[array_height_2d(layerName)] = col;
		
		tileLayerCount += 1;
		layerVisible[tileLayerCount] = true;
		
		trgId.tileLayerCount = self.tileLayerCount;
		trgId.layerOrder[tileLayerCount] = tileLayerCount;
		trgId.layerVisible[tileLayerCount] = true;
		
		obj_tiles_grid.tileLayerCount = self.tileLayerCount;
		obj_tiles_grid.layerOrder[tileLayerCount] = tileLayerCount;
		obj_tiles_grid.layerVisible[tileLayerCount] = true;
		
		for (i = 0; i < trgId.width + 2; i += 1) {
			for (j = 0; j < trgId.zfloor - trgId.zcieling + 2; j += 1) {
				// Initialize new tiles
				trgId.hasTile[ scr_array_xy( i,j,trgId.width + 2 ), tileLayerCount ] = false;
				
				obj_tiles_grid.hasTile[ scr_array_xy( i,j,trgId.width + 2 ), tileLayerCount ] = false;
			}
		}
		
		select[tileLayerCount,0] = false;
		canSelect[tileLayerCount,0] = false;
		k = tileLayerCount;
		layerAlpha[tileLayerCount] = 1;
		layerOrder[tileLayerCount] = tileLayerCount;
		
		layerName[tileLayerCount,0] = "layer_" + string(tileLayerCount);
		layerName[tileLayerCount,1] = "sublayer_" + string(tileLayerCount);
		trgId.layerName[tileLayerCount,0] = self.layerName[tileLayerCount,0];
		trgId.layerName[tileLayerCount,1] = self.layerName[tileLayerCount,1];
		
		select[tileLayerCount,1] = false;
		canSelect[tileLayerCount,1] = false;
		trgId.layerName[tileLayerCount,1] = self.layerName[tileLayerCount,1];
	}
	
	obj_subpanel_left.panelHeight = (tileLayerCount + 1) * 21 + 4;
	plusCol = orange;
	
	exit;
}

dieCol = col;

// Manipulate layers
for (i = 0; i < array_height_2d(layerName); i += 1) {
	canSelect[i,0] = false;
	
	// Toggle layer eye
	eyeCol[i] = col;
	
	if mouse_x >= x + 18 && mouse_x <= x + 27 && mouse_y >= 2 + layerOrder[i] * 21 && mouse_y < 12 + layerOrder[i] * 21 {
		eyeCol[i] = orange;
		
		if mouse_check_button_pressed(mb_left) {
			if eyeState[i] = 0 {
				eyeState[i] = 1;
				layerAlpha[i] = 0.5;
				trgId.layerVisible[i] = false;
				obj_tiles_grid.layerVisible[i] = false;
			} else {
				eyeState[i] = 0;
				layerAlpha[i] = 1;
				trgId.layerVisible[i] = true;
				obj_tiles_grid.layerVisible[i] = true;
			}
		}
	}
	
	if !draggingMouseInit {
		// Select layer
		if mouse_x >= x + 30 && (mouse_x <= x + 36 + string_width(layerName[i,0]) || (mouse_x <= x + 75 && layerName[i,0] = "")) && mouse_y >= 2 + layerOrder[i] * 21 && mouse_y < 12 + layerOrder[i] * 21 {
			canSelect[i,0] = true;
			
			if mouse_check_button_pressed(mb_left) {
				if select[i,0] {
					select[i,0] = false;
					obj_tiles_grid.tileLayerSelect = -1;
				} else {
					select[i,0] = true;
					obj_tiles_grid.tileLayerSelect = i;
					
					tempMouseX = window_mouse_get_x();
					tempMouseY = window_mouse_get_y();
					mouseOffY = y + 1 + layerOrder[i] * 21 - mouse_y;
				}
				
				dragLayer = i;
				tempOrder = layerOrder[i];
				draggingMouseInit = true;
				
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
				layerName[i,0] = typeText(layerName[i,0]);
			}
			
			trgId.layerName[i,0] = self.layerName[i,0];
		}
		
		// Sub-layers
		for (j = 1; j < array_length_2d(layerName,i); j += 1) {
			canSelect[i,j] = false;
			
			// Select sub-layer
			if mouse_x >= x + 34 && (mouse_x <= x + 44 + string_width(layerName[i,j]) || (mouse_x <= x + 85 && layerName[i,j] = "")) && mouse_y >= 2 + (layerOrder[i] * 21) + (j * 11) && mouse_y < 12 + (layerOrder[i] * 21) + (j * 11) {
				canSelect[i,j] = true;
				
				if mouse_check_button_pressed(mb_left) {
					if select[i,j] {
						select[i,j] = false;
						obj_tiles_grid.tileLayerSelect = -1;
					} else {
						select[i,j] = true;
						obj_tiles_grid.tileLayerSelect = i;
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
					layerName[i,j] = typeText(layerName[i,j]);
					
					/*if j > tileSubLayerCount[i] {
						with obj_tiles_grid {
							trgId.tileSubLayerCount[i] = j;
							tileSubLayerCount[i] = j;
							other.tileSubLayerCount[i] = j;
						}
					}*/
				}
				
				trgId.layerName[i,j] = self.layerName[i,j];
			}
			
			// Increase sub-layer count
			/*if j = array_length_2d(layerName,i) - 1 {
				if layerName[i,j] != "" {
					layerName[i,j+1] = "";
					select[i,j+1] = false;
				}
			}*/
		}
	} else {
		// De-select when dragging
		if draggingMouse {
			canSelect[i,0] = false;
			canSelect[i,1] = false;
			
			select[i,0] = false;
			select[i,1] = false;
		}
	}
}

// Dragging layers
if (point_distance(window_mouse_get_x(),window_mouse_get_y(),tempMouseX,tempMouseY) > 6 && draggingMouseInit) || draggingMouse {
	draggingMouse = true;
	select[dragLayer,0] = true;
	layerAlpha[dragLayer] = 0.5;
	
	layerOrder[dragLayer] = (window_mouse_get_y() - obj_subpanel_left.y - y + 1 + mouseOffY) / 21;
	
	// Snapping layer to position
	if layerOrder[dragLayer] < tempOrder - 1 + 0.2 {
		layerOrder[dragLayer] = tempOrder - 1;
	} else if layerOrder[dragLayer] > tempOrder + 1 - 0.2 {
		layerOrder[dragLayer] = tempOrder + 1;
	} else if layerOrder[dragLayer] < tempOrder + 0.2 && layerOrder[dragLayer] > tempOrder - 0.2 {
		layerOrder[dragLayer] = tempOrder;
	}
	
	// Layer boundaries; clamp() wasn't working for some reason
	if layerOrder[dragLayer] < 0 { layerOrder[dragLayer] = 0; }
	if layerOrder[dragLayer] > tileLayerCount { layerOrder[dragLayer] = tileLayerCount; }
	
	// Shift displaced layers
	for (i = 0; i <= tileLayerCount; i += 1) {
		if i != dragLayer {
			if layerOrder[dragLayer] = layerOrder[i] {
				if tempOrder < layerOrder[i] {
					layerOrder[i] -= 1;
				}
				
				if tempOrder > layerOrder[i] {
					layerOrder[i] += 1;
				}
				
				tempOrder = layerOrder[dragLayer];
			}
		}
	}
	
	if mouse_check_button_released(mb_left) {
		draggingMouse = false;
		select[dragLayer,0] = false;
		
		layerOrder[dragLayer] = tempOrder;
		
		if eyeState[dragLayer] = 0 {
			layerAlpha[dragLayer] = 1;
		}
	}
	
	passIn = true;
}

// Don't prepare to drag layer when merely selecting
if !mouse_check_button(mb_left) {
	draggingMouseInit = false;
	dragLayer = -1;
}

// Pass in layer order cypher
if passIn {
	for (i = 0; i < array_height_2d(layerName); i += 1) { // Absolute
		for (j = 0; j < array_height_2d(layerName); j += 1) { // Arbitrary
			if layerOrder[j] = i {
				obj_tiles_grid.layerOrder[i] = j;
				trgId.layerOrder[i] = j;
			}
		}
	}
	
	passIn = false;
}

// Add foliated marble layer
/*if mouse_x >= x + 38 && mouse_x <= x + 44 && mouse_y >= 5 + (i * 21) && mouse_y <= 12 + (i * 21) {
	if mouse_check_button_pressed(mb_left) {
		eyeState[array_height_2d(layerName)] = 0;
		eyeCol[array_height_2d(layerName)] = col;
		
		select[array_height_2d(layerName),0] = false;
		canSelect[array_height_2d(layerName),0] = false;
		layerName[array_height_2d(layerName),0] = "layer_" + string(array_height_2d(layerName));
		
		select[array_height_2d(layerName)-1,1] = false;
		canSelect[array_height_2d(layerName)-1,1] = false;
		layerName[array_height_2d(layerName)-1,1] = "sublayer_" + string(array_height_2d(layerName));
	}
	
	dieCol = orange;
}*/
