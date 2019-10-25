/// @description 
scrollOff = (obj_subpanel_left.panelHeight - (obj_subpanel_left.scrollVerBotBound - obj_subpanel_left.scrollVerTopBound + 9)) * obj_subpanel_left.scrollVerPartition / 100;
y = 12 - scrollOff;
x = camera_get_view_x(obj_editor_gui.cameraLeftSubPanel);

// Add new tile layer	
plusCol = col;
dieCol = col;

if mouse_y >= y + (tileLayerCount + 2) * 11 && mouse_y <= y + (tileLayerCount + 3) * 11 {
	if mouse_x >= x + 28 && mouse_x <= x + 34 {
		plusCol = orange;
	}
	
	if mouse_x >= x + 37 && mouse_x <= x + 45 {
		dieCol = orange;
		
		// Prevent duplicate marble layers
		for (i = 0; i <= tileLayerCount; i += 2) {
			if layerType[i] = 1 {
				// Re-calculate pre-existant marble layer
				if mouse_check_button_pressed(mb_left) {
					trgId.genMarble = true;
					
					exit;
				}
			}
		}
	}
}

if mouse_check_button_pressed(mb_left) {
	if plusCol = orange || dieCol = orange {
		passIn = true;
		
		tileLayerCount += 2;
		trgId.tileLayerCount = self.tileLayerCount;
		
		// Tile layer
		if plusCol = orange {
			layerType[tileLayerCount] = 0;
			trgId.layerType[tileLayerCount] = 0;
		}
		// Marble layer
		if dieCol = orange {
			layerType[tileLayerCount] = 1;
			trgId.layerType[tileLayerCount] = 1;
			
			trgId.genMarble = true;
		}
		
		obj_tiles_grid.layerType[tileLayerCount] = self.layerType[tileLayerCount];
		
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
		
		obj_tiles_grid.surfaceSubtract[tileLayerCount] = -1;
		
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
		
		// Initialize new tiles
		for (i = 0; i < trgId.width + 2; i += 1) {
			for (j = 0; j < trgId.zfloor - trgId.zcieling + 2; j += 1) {
				trgId.hasTile[ scr_array_xy( i,j,trgId.width + 2 ), tileLayerCount ] = false;
				trgId.hasTile[ scr_array_xy( i,j,trgId.width + 2 ), tileLayerCount + 1 ] = false;
				
				obj_tiles_grid.hasTile[ scr_array_xy( i,j,trgId.width + 2 ), tileLayerCount ] = false;
				obj_tiles_grid.hasTile[ scr_array_xy( i,j,trgId.width + 2 ), tileLayerCount + 1] = false;
			}
		}
		
		exit;
	}
}

// Update the sub-panel height
obj_subpanel_left.panelHeight = (tileLayerCount + 2) * 11 + 33;

// Manipulate layers
for (i = 0; i <= tileLayerCount; i += 2) {
	canSelect[i] = false;
	
	// Toggle layer eye
	eyeCol[i] = col;
	
	if mouse_x >= x + 18 && mouse_x <= x + 27 && mouse_y >= y + 2 + layerOrder[i] * 11 && mouse_y < y + 12 + layerOrder[i] * 11 {
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
			
			// Recalculating a marble surface lost after
			// resizing the game window when invisible
			if layerType[i] = 1 { // Marble layer
				if layerVisible[i] {
					if trgId.marbleLostResize {
						trgId.bakeMarble = true;
						trgId.marbleLostResize = false;
					}
				}
			}
			
			passIn = true;
		}
	}
	
	if !draggingMouseInit {
		// Select layer
		if mouse_x >= x + 30 && ( mouse_x <= x + 36 + string_width(layerName[i]) || (mouse_x <= x + 75 && layerName[i] = "") ) && mouse_y >= y + 2 + layerOrder[i] * 11 && mouse_y < y + 12 + layerOrder[i] * 11 {
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
				if !(window_mouse_get_x() > obj_panel_right.x - room_width && window_mouse_get_y() < obj_panel_bot.y) {
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
		if mouse_x >= x + 34 && ( mouse_x <= x + 44 + string_width(layerName[i+1]) || (mouse_x <= x + 85 && layerName[i+1] = "") ) && mouse_y >= y + 2 + (layerOrder[i] + 1) * 11 && mouse_y < y + 12 + (layerOrder[i] + 1) * 11 {
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
				passIn = true;
			}
		}
	}
	
	// Release dragging layer
	if !mouse_check_button(mb_left) {
		draggingMouse = false;
		select[dragLayer] = false;
		
		layerOrder[dragLayer] = tempOrder;
		
		if eyeState[dragLayer] = 0 {
			layerAlpha[dragLayer] = 1;
		}
	}
}

// Don't prepare to drag layer when merely selecting
if !draggingMouse {
	if !mouse_check_button(mb_left) {
		draggingMouseInit = false;
		dragLayer = -1;
	}
}

// Select resource name
if mouse_x >= x + 2 && mouse_x <= x + 1 + string_width(tileDefaultSpr) && mouse_y >= y - 11 && mouse_y <= y - 2 {
	resourceCanSelect = true;
} else {
	resourceCanSelect = false;
}

if mouse_check_button_pressed(mb_left) {
	if resourceCanSelect {
		resourceSelect = !resourceSelect;
	} else {
		resourceSelect = false;
	}
}

if resourceSelect {
	if keyboard_check_pressed(vk_anykey) {
		tileDefaultSpr = typeText(tileDefaultSpr);
		
		// Pass in tileset resource
		if asset_get_index(tileDefaultSpr) != -1 {
			trgId.tileDefaultSpr = tileDefaultSpr;
			trgId.tileDrawSpr = asset_get_index(tileDefaultSpr);
			obj_tiles_grid.tileDrawSpr = asset_get_index(tileDefaultSpr);
			obj_tiles_sheet.tileDefaultSpr = asset_get_index(tileDefaultSpr);
		}
	}
}

// Pass in layer order into obj_tiles_grid
if passIn {
	passIn = false;
	
	for (i = 0; i <= tileLayerCount; i += 2) { // Arbitrary
		obj_tiles_grid.layerOrder[i] = self.layerOrder[i];
		trgId.layerOrder[i] = self.layerOrder[i];
	}
	
	// obj_tiles_grid passes layer values into terrain instances
	obj_tiles_grid.passIn = true;
}
