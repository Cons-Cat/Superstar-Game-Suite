/// @description 
x = camera_get_view_x(obj_editor_gui.cameraLeftPanel) + 2 + i*21;
y = 1 + j*21;

tileRowWidth = width + 2;
calculateSub = false;

if tileLayerSelect != -1 {
	if mouse_x >= self.x && mouse_x < self.x+20 {
		if mouse_y >= self.y && mouse_y < self.y+20 {
			if mouse_check_button(mb_left) {
				for (a = 0; a < obj_tiles_sheet.selectWidthOffset; a += 20) {
					for (b = 0; b < obj_tiles_sheet.selectHeightOffset; b += 20) {
						with collision_point(x+a+a/20, y+b+b/20,obj_tiles_grid,false,false) {
							xVal[tileLayerSelect] = obj_tiles_sheet.xVal[other.a,other.b];
							yVal[tileLayerSelect] = obj_tiles_sheet.yVal[other.a,other.b];
						}
						
						hasTile[tileLayerSelect] = true;
						
						if tileLayerSelect % 2 = 1 { // If a sub-layer is selected
							calculateSub = true;
							
							if surfaceSubtract[(tileLayerSelect div 2)*2] != -1 {
								// Clear the surface layer
								surface_set_target(surfaceSubtract[(tileLayerSelect div 2)*2]);
								draw_clear_alpha(c_white,0);
								surface_reset_target();
							} else {
								// Create surface
								surfaceSubtract[(tileLayerSelect div 2)*2] = surface_create(20,20);
							}
						}
					}
				}
				
				passIn = true;
			}
			
			if mouse_check_button(mb_right) {
				hasTile[tileLayerSelect] = false;
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
	calculateSub = true;
	trgId.calculateSub = true;
	
	for (k = 0; k <= tileLayerCount; k += 2) { // Absolute
		for (k2 = 0; k2 <= tileLayerCount; k2 += 2) { // Arbitrary
			if layerOrder[k2] = k {
				hasTileDraw[k] = hasTile[k2];
				hasTileDraw[k+1] = hasTile[k2+1];
				
				trgId.hasTile[scr_array_xy(i,j,tileRowWidth),k] = hasTileDraw[k];
				trgId.hasTile[scr_array_xy(i,j,tileRowWidth),k+1] = hasTileDraw[k+1];
				
				layerVisibleDraw[k] = layerVisible[k2];
				trgId.layerVisible[k] = layerVisibleDraw[k];
				
				trgId.layerType[k] = layerType[k2];
				
				if hasTileDraw[k] {
					xValDraw[k] = xVal[k2];
					yValDraw[k] = yVal[k2];
					
					trgId.tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),k] = xValDraw[k];
					trgId.tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),k] = yValDraw[k];
				}
				
				if hasTileDraw[k + 1] {
					xValDraw[k+1] = xVal[k2+1];
					yValDraw[k+1] = yVal[k2+1];
					
					trgId.tileArrayDrawX[scr_array_xy(i,j,tileRowWidth),k+1] = xValDraw[k+1];
					trgId.tileArrayDrawY[scr_array_xy(i,j,tileRowWidth),k+1] = yValDraw[k+1];
				}
				
				break;
			}
		}
	}
	
	trgId.slope3MustUpdate = true;
	
	passIn = false;
}
