/// @description 
calculateSub = false;

// Scrolling
xOff = camera_get_view_x(obj_editor_gui.cameraLeftPanel) - (obj_panel_left.panelWidth - (obj_panel_left.scrollHorRightBound - obj_panel_left.scrollHorLeftBound)) * obj_panel_left.scrollHorPartition / 100;
yOff = camera_get_view_y(obj_editor_gui.cameraLeftPanel) - (obj_panel_left.panelHeight - (obj_panel_left.scrollVerBotBound - obj_panel_left.scrollVerTopBound)) * obj_panel_left.scrollVerPartition / 100;

x = xOff /*+ camera_get_view_x(obj_editor_gui.cameraLeftPanel)*/ + 2 + i*21;
y = yOff + 1 + j*21;

if tileLayerSelect != -1 {
	if mouse_x >= self.x && mouse_x < self.x+20 {
		if mouse_y >= self.y && mouse_y < self.y+20 {
			if mouse_check_button(mb_left) {
				for (a = 0; a < obj_tiles_sheet.selectWidthOffset/20; a += 1) {
					for (b = 0; b < obj_tiles_sheet.selectHeightOffset/20; b += 1) {
						with obj_tiles_grid {
							if i = other.i + other.a {
								if j = other.j + other.b {
									xVal[tileLayerSelect] = obj_tiles_sheet.xVal[other.a,other.b];
									yVal[tileLayerSelect] = obj_tiles_sheet.yVal[other.a,other.b];
									passIn = true;
									
									if !hasTile[tileLayerSelect] {
										hasTile[tileLayerSelect] = true;
										tilesCount++;
									}
									
									if tileLayerSelect % 2 = 1 { // If a sub-layer is selected
										calculateSub = true;
									}
								}
							}
						}
					}
				}
			}
			
			if mouse_check_button(mb_right) {
				if hasTile[tileLayerSelect] {
					hasTile[tileLayerSelect] = false;
					tilesCount--;
				}
				
				passIn = true;
			}
		}
	}
}

// Refresh surface
if calculateSub {
	surface_free(tileSurface);
	tileSurface = surface_create(20,20);
}

// Sort layers
if passIn {
	#region
	
	passIn = false;
	trgId.calculateSub = true;
	trgId.slope3MustUpdate = true;
	
	for (k = 0; k <= tileLayerCount; k += 2) { // Absolute
		for (k2 = 0; k2 <= tileLayerCount; k2 += 2) { // Arbitrary
			if layerOrder[k2] = k {
				// hasTileAbsolute is absolute, hasTile is arbitrary
				hasTileAbsolute[k] = hasTile[k2];
				hasTileAbsolute[k+1] = hasTile[k2+1];
				
				trgId.hasTile[scr_array_xy(i,j,tileArrayHeight),k] = hasTileAbsolute[k];
				trgId.hasTile[scr_array_xy(i,j,tileArrayHeight),k+1] = hasTileAbsolute[k+1];
				
				layerVisibleAbsolute[k] = layerVisible[k2];
				trgId.layerVisible[k] = layerVisible[k2];
				
				// layerTypeAbsolute is absolute, layerType is arbitrary
				layerTypeAbsolute[k] = layerType[k2];
				trgId.layerType[k] = layerType[k2];
				
				if hasTileAbsolute[k] {
					if layerTypeAbsolute[k] = 0 { // Tiles
						xValDraw[k] = xVal[k2];
						yValDraw[k] = yVal[k2];
					
						trgId.tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k] = xValDraw[k];
						trgId.tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k] = yValDraw[k];
					}
				}
				
				if hasTileAbsolute[k + 1] {
					xValDraw[k+1] = xVal[k2+1];
					yValDraw[k+1] = yVal[k2+1];
					
					trgId.tileArrayDrawX[scr_array_xy(i,j,tileArrayHeight),k+1] = xValDraw[k+1];
					trgId.tileArrayDrawY[scr_array_xy(i,j,tileArrayHeight),k+1] = yValDraw[k+1];
				}
				
				break;
			}
		}
	}
	
	#endregion
}
