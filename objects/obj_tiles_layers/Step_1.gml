/// @description 
y = 0;
x = camera_get_view_x(obj_editor_gui.cameraLeftSubPanel);

// Add new tile layer	
plusCol = col;

if mouse_x >= x + 28 && mouse_x <= x + 34 && mouse_y >= 5 + (tileLayerCount + 2) * 11 && mouse_y <= 12 + (tileLayerCount + 2) * 11 {
	if mouse_check_button_pressed(mb_left) {
		tileLayerCount += 2;
		trgId.tileLayerCount = self.tileLayerCount;
		
		layerOrder[tileLayerCount] = tileLayerCount;
		layerVisible[tileLayerCount] = true;
		layerAlpha[tileLayerCount] = 1;
		
		trgId.layerOrder[tileLayerCount] = tileLayerCount;
		trgId.layerVisible[tileLayerCount] = true;
		
		obj_tiles_grid.tileLayerCount = self.tileLayerCount;
		obj_tiles_grid.layerOrder[tileLayerCount] = tileLayerCount;
		obj_tiles_grid.layerVisible[tileLayerCount] = true;
		
		obj_tiles_grid.hasTileDraw[tileLayerCount] = false;
		obj_tiles_grid.hasTileDraw[tileLayerCount+1] = false;
		obj_tiles_grid.layerVisibleDraw[tileLayerCount] = true;
		
		for (i = 0; i < trgId.width + 2; i += 1) {
			for (j = 0; j < trgId.zfloor - trgId.zcieling + 2; j += 1) {
				// Initialize new tiles
				trgId.hasTile[ scr_array_xy( i,j,trgId.width + 2 ), tileLayerCount ] = false;
				trgId.hasTile[ scr_array_xy( i,j,trgId.width + 2 ), tileLayerCount + 1 ] = false;
				
				obj_tiles_grid.hasTile[ scr_array_xy( i,j,trgId.width + 2 ), tileLayerCount ] = false;
				obj_tiles_grid.hasTile[ scr_array_xy( i,j,trgId.width + 2 ), tileLayerCount + 1] = false;
			}
		}
		
		for (k = 0; k <= tileLayerCount; k += 1) {
			// De-select all layers
			select[k] = false;
		}
		
		eyeState[tileLayerCount] = 0;
		eyeCol[tileLayerCount] = col;
		
		select[tileLayerCount] = true;
		canSelect[tileLayerCount] = true;
		select[tileLayerCount+1] = false;
		canSelect[tileLayerCount+1] = false;
		
		obj_tiles_grid.tileLayerSelect = tileLayerCount;
		
		layerName[tileLayerCount] = "layer_" + string(tileLayerCount div 2);
		trgId.layerName[tileLayerCount] = self.layerName[tileLayerCount];
		layerName[tileLayerCount+1] = "sublayer_" + string(tileLayerCount div 2);
		trgId.layerName[tileLayerCount+1] = self.layerName[tileLayerCount+1];
	}
	
	obj_subpanel_left.panelHeight = (tileLayerCount + 1) * 11 + 4;
	plusCol = orange;
	passIn = true;
	
	exit;
}

dieCol = col;

// Manipulate layers
for (i = 0; i <= tileLayerCount; i += 2) {
	canSelect[i] = false;
	
	// Toggle layer eye
	eyeCol[i] = col;
	
	if mouse_x >= x + 18 && mouse_x <= x + 27 && mouse_y >= 2 + layerOrder[i] * 11 && mouse_y < 12 + layerOrder[i] * 11 {
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
			
			passIn = true;
			obj_tiles_grid.passIn = true;
		}
	}
	
	if !draggingMouseInit {
		// Select layer
		if mouse_x >= x + 30 && (mouse_x <= x + 36 + string_width(layerName[i]) || (mouse_x <= x + 75 && layerName[i] = "")) && mouse_y >= 2 + layerOrder[i] * 11 && mouse_y < 12 + layerOrder[i] * 11 {
			canSelect[i] = true;
			
			if mouse_check_button_pressed(mb_left) {
				if select[i] {
					select[i] = false;
					obj_tiles_grid.tileLayerSelect = -1;
				} else {
					for (k = 0; k <= tileLayerCount + 1; k += 1) {
						// De-select all other layers
						select[k] = false;
					}
					
					select[i] = true;
					obj_tiles_grid.tileLayerSelect = i;
					
					tempMouseX = window_mouse_get_x();
					tempMouseY = window_mouse_get_y();
					mouseOffY = y + 1 + layerOrder[i] * 11 - mouse_y;
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
						select[i] = false;
						obj_tiles_grid.tileLayerSelect = -1;
					}
				}
			}
		}
		
		// Name
		if select[i] {
			if keyboard_check_pressed(vk_anykey) {
				layerName[i] = typeText(layerName[i]);
				passIn = true;
			}
			
			trgId.layerName[i] = self.layerName[i];
		}
		
		// Sub-layers
		canSelect[i+1] = false;
		
		// Select sub-layer
		if mouse_x >= x + 34 && (mouse_x <= x + 44 + string_width(layerName[i+1]) || (mouse_x <= x + 85 && layerName[i+1] = "")) && mouse_y >= 2 + (layerOrder[i] + 1) * 11 && mouse_y < 12 + (layerOrder[i] + 1) * 11 {
			canSelect[i+1] = true;
			
			if mouse_check_button_pressed(mb_left) {
				if select[i+1] {
					select[i+1] = false;
					obj_tiles_grid.tileLayerSelect = -1;
				} else {
					for (k = 0; k <= tileLayerCount + 1; k += 1) {
						// De-select all other layers
						select[k] = false;
					}
					
					select[i+1] = true;
					obj_tiles_grid.tileLayerSelect = i + 1;
				}
				
				break;
			}
		} else {
			// De-select sub-layer
			if !(window_mouse_get_x() < obj_panel_left.x && window_mouse_get_y() < obj_subpanel_left.y) {
				if !(window_mouse_get_x() > obj_panel_right.x && window_mouse_get_y() < obj_panel_bot.y) {
					if mouse_check_button_pressed(mb_left) {
						select[i+1] = false;
						obj_tiles_grid.tileLayerSelect = -1;
					}
				}
			}
		}
		
		// Name sub-layer
		if select[i+1] {
			if keyboard_check_pressed(vk_anykey) {
				layerName[i+1] = typeText(layerName[i+1]);
				passIn = true;
			}
			
			trgId.layerName[i+1] = self.layerName[i+1];
		}
	} else {
		// De-select when dragging
		if draggingMouse {
			canSelect[i] = false;
			canSelect[i+1] = false;
			
			select[i] = false;
			select[i+1] = false;
		}
	}
}

// Dragging layers
if (point_distance(window_mouse_get_x(),window_mouse_get_y(),tempMouseX,tempMouseY) > 6 && draggingMouseInit) || draggingMouse {
	draggingMouse = true;
	select[dragLayer] = true;
	layerAlpha[dragLayer] = 0.5;
	
	layerOrder[dragLayer] = (window_mouse_get_y() - obj_subpanel_left.y - y + 1 + mouseOffY) / 11;
	
	// Snapping layer to position
	if layerOrder[dragLayer] < tempOrder - 2 + 0.35 {
		layerOrder[dragLayer] = tempOrder - 2;
	} else if layerOrder[dragLayer] > tempOrder + 2 - 0.35 {
		layerOrder[dragLayer] = tempOrder + 2;
	} else if layerOrder[dragLayer] < tempOrder + 0.35 && layerOrder[dragLayer] > tempOrder - 0.35 {
		layerOrder[dragLayer] = tempOrder;
	}
	
	// Layer boundaries; clamp() wasn't working for some reason
	if layerOrder[dragLayer] < 0 { layerOrder[dragLayer] = 0; }
	if layerOrder[dragLayer] > tileLayerCount { layerOrder[dragLayer] = tileLayerCount; }
	
	// Shift displaced layers
	for (i = 0; i <= tileLayerCount; i += 2) {
		if i != dragLayer {
			if layerOrder[dragLayer] = layerOrder[i] {
				if tempOrder < layerOrder[i] {
					layerOrder[i] -= 2;
				}
				
				if tempOrder > layerOrder[i] {
					layerOrder[i] += 2;
				}
				
				tempOrder = layerOrder[dragLayer];
			}
		}
	}
	
	if mouse_check_button_released(mb_left) {
		draggingMouse = false;
		select[dragLayer] = false;
		
		layerOrder[dragLayer] = tempOrder;
		
		if eyeState[dragLayer] = 0 {
			layerAlpha[dragLayer] = 1;
		}
	}
	
	passIn = true;
	obj_tiles_grid.passIn = true;
}

// Don't prepare to drag layer when merely selecting
if !mouse_check_button(mb_left) {
	draggingMouseInit = false;
	dragLayer = -1;
}

// Pass in layer order
if passIn {
	for (i = 0; i <= tileLayerCount; i += 1) { // Absolute
		obj_tiles_grid.layerOrder[i] = self.layerOrder[i];
		trgId.layerOrder[i] = self.layerOrder[i];
	}
	
	passIn = false;
}

// Add foliated marble layer
/*if mouse_x >= x + 38 && mouse_x <= x + 44 && mouse_y >= 5 + (i * 11) && mouse_y <= 12 + (i * 11) {
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
