/// @description 
if calculateSub {
	// Calculate subtraction mask
	emptyPixels = 0;
	totalPixels = 0;
	
	currentWidth = 0;
	currentHeight = 0;
	
	currentPixelX = 0;
	currentPixelY = 0;
	
	canIncHor = true;
	canIncVer = true;
	
	while totalPixels < 400 - emptyPixels {
		show_message("Pixels remaining: " + string(400 - emptyPixels - totalPixels))
		
		if canIncHor {
			for (a2 = currentPixelY; a2 < currentPixelY + currentHeight; a2 += 1) {
				if !subMask[currentPixelX + currentWidth,a2] || passedPixel[currentPixelX + currentWidth,a2] {
					canIncHor = false;
					canIncVer = false;
					
					currentPixelX += currentWidth;
					currentHeight = 0;
					currentWidth = 0;
					show_message("STOPPED HOR");
					
					break;
				}
			}
			
			if canIncHor {
				// Increment right one pixel
				currentWidth += 1;
				tempPixX = currentPixelX;
				tempPixWidth = currentWidth;
				
				totalPixels += currentHeight;
				show_message("Horizontally. " + "currentPixelX: " + string(currentPixelX + currentWidth) + ", currentPixelY: " + string(currentPixelY + currentHeight) + ", totalPixels: " + string(totalPixels));
				
				if currentPixelX + currentWidth >= 20 {
					show_message("HIT HOR BOUND");
					canIncVer = false;
					
					currentPixelX = 0;
					currentPixelY += 1;
					
					currentWidth = 0;
					currentHeight = 0;
				}
			}
		}
		
		if canIncVer {
			for (a2 = currentPixelX; a2 < currentPixelX + currentWidth; a2 += 1) {
				if !subMask[a2,currentPixelY + currentHeight] || passedPixel[a2,currentPixelY + currentHeight] {
					canIncVer = false;
					
					currentPixelX += currentWidth;
					currentHeight = 0;
					currentWidth = 0;
					show_message("STOPPED VER");
					
					break;
				}
			}
			
			if canIncVer {
				// Increment down  one pixel
				currentHeight += 1;
				tempPixY = currentPixelY;
				tempPixHeight = currentHeight;
				
				totalPixels += currentWidth;
				show_message("Vertically. " + "currentPixelX: " + string(currentPixelX + currentWidth) + ", currentPixelY: " + string(currentPixelY + currentHeight) + ", totalPixels: " + string(totalPixels));
				
				if currentPixelY + currentHeight >= 20 {
					show_message("HIT VER BOUND");
					currentPixelX += 1;
					currentPixelY = 0;
					
					currentWidth = 0;
					currentHeight = 0;
				}
			}
		}
		
		// Update passed pixels
		for (a2 = tempPixX; a2 < tempPixX + tempPixWidth; a2 += 1) {
			for (b2 = tempPixY; b2 < tempPixY + tempPixHeight; b2 += 1) {
				passedPixel[a2,b2] = true;
			}
		}
		
		// Reset values for next tick
		tempPixX = 0;
		tempPixY = 0;
		tempPixWidth = -1;
		tempPixHeight = -1;
		
		canIncHor = true;
		canIncVer = true;
	}
	
	calculateSub = false;
}

/*if mouse_y >= 600 {
	if mouse_x <= 170 {
		if !keyboard_check(vk_shift) {
			if mouse_wheel_down() {
				y -= 10;
			}
			if mouse_wheel_up() {
				y += 10;
			}
		} else {
			if mouse_wheel_down() {
				x -= 10;
			}
			if mouse_wheel_up() {
				x += 10;
			}
		}
	}
}*/

x = camera_get_view_x(obj_editor_gui.cameraLeftPanel) + 2 + i*21;
y = 1 + j*21;

tileRowWidth = width + 2;

if tileLayerSelect != -1 {
	if mouse_x >= self.x && mouse_x < self.x+20 {
		if mouse_y >= self.y && mouse_y < self.y+20 {
			if mouse_check_button(mb_left) {
				for (a = 0; a < obj_tiles_sheet.selectWidthOffset; a += 20) {
					for (b = 0; b < obj_tiles_sheet.selectHeightOffset; b += 20) {
						with collision_point(x+a+a/20, y+b+b/20,obj_tiles_grid,false,false) {
							xVal[tileLayerSelect] = obj_tiles_sheet.xVal[other.a,other.b] - obj_tiles_sheet.x;
							yVal[tileLayerSelect] = obj_tiles_sheet.yVal[other.a,other.b] - obj_tiles_sheet.y;
							tempMaterial = global.sprMaterial;
						}
						
						hasTile[tileLayerSelect] = true;
						
						if tileLayerSelect % 2 != 0 {
							calculateSub = true;
						}
						
						passIn = true;
						
						break;
					}
				}
			}
			
			if mouse_check_button(mb_right) {
				hasTile[tileLayerSelect] = false;
				passIn = true;
			}
		}
	}
}

// Sort layers
if passIn {
	for (k = 0; k <= tileLayerCount; k += 2) { // Absolute
		for (k2 = 0; k2 <= tileLayerCount; k2 += 2) { // Arbitrary
			if layerOrder[k2] = k {
				hasTileDraw[k] = hasTile[k2];
				hasTileDraw[k+1] = hasTile[k2+1];
				
				trgId.hasTile[scr_array_xy(i,j,tileRowWidth),k] = hasTileDraw[k];
				trgId.hasTile[scr_array_xy(i,j,tileRowWidth),k+1] = hasTileDraw[k+1];
				
				layerVisibleDraw[k] = layerVisible[k2];
				trgId.layerVisible[k] = layerVisibleDraw[k];
				
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
	
	passIn = false;
}

trgId.sprMaterial = global.sprMaterial;
trgId.slope3MustUpdate = true;
