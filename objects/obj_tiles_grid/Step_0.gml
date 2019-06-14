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
	rowEnd = false;
	
	while totalPixels < 400 - emptyPixels {
		show_message("Pixels remaining: " + string(400 - emptyPixels - totalPixels));
		
		// Attempt to increase width
		currentWidth += 1;
		
		if currentPixelX + currentWidth >= 20 {
			show_message("HIT HOR BOUND");
			
			currentWidth -= 1;
			canIncHor = false;
			rowEnd = true;
		}
		
		if canIncHor {
			for (a = currentPixelY; a < currentPixelY + currentHeight; a += 1) {
				if !subMask[currentPixelX + currentWidth,a] || passedPixel[currentPixelX + currentWidth,a] {
					show_message("STOPPED HOR at" + string(a));
					
					if !subMask[currentPixelX + currentWidth,a] {
						currentPixelX += currentWidth - 1;
						
						show_message("MASK EMPTY");
					} else if passedPixel[currentPixelX + currentWidth,a] {
						currentWidth += 1;
						
						show_message("PASSED PIXEL");
					}
					
					canIncHor = false;
					canIncVer = false;
					
					currentHeight = 0;
					currentWidth = 0;
					
					break;
				}
			}
			
			if canIncHor {
				//tempPixX = currentPixelX;
				//tempPixWidth = currentWidth;
				
				// Increment right one pixel
				show_message("Horizontally. " + "currentPixelX: " + string(currentPixelX + currentWidth) + ", currentPixelY: " + string(currentPixelY + currentHeight) + ", totalPixels: " + string(totalPixels));
				totalPixels += currentHeight;
			}
		}
		
		// Attempt to increase height
		currentHeight += 1;
		
		if currentPixelY + currentHeight >= 20 {
			show_message("HIT VER BOUND");
			
			currentHeight -= 1;
			canIncVer = false;
		}
		
		if canIncVer {
			for (a = currentPixelX; a < currentPixelX + currentWidth; a += 1) {
				if !subMask[a,currentPixelY + currentHeight] || passedPixel[a,currentPixelY + currentHeight] {
					show_message("STOPPED VER at" + string(a));
					
					if !subMask[a,currentPixelY + currentHeight] {
						show_message("MASK EMPTY");
					}
					if passedPixel[a,currentPixelY + currentHeight] {
						show_message("PASSED PIXEL");
					}
					
					canIncVer = false;
					
					currentPixelX += currentWidth - 1;
					currentHeight = 0;
					currentWidth = 0;
					
					break;
				}
			}
			
			if canIncVer {
				//tempPixY = currentPixelY;
				//tempPixHeight = currentHeight;
				
				// Increment down  one pixel
				show_message("Vertically. " + "currentPixelX: " + string(currentPixelX + currentWidth) + ", currentPixelY: " + string(currentPixelY + currentHeight) + ", totalPixels: " + string(totalPixels));
				totalPixels += currentWidth;
			}
		}
		
		// Update passed pixels
		tempPixX = currentPixelX;
		tempPixWidth = currentWidth;
		tempPixY = currentPixelY;
		tempPixHeight = currentHeight;
		
		for (a = tempPixX; a < tempPixX + tempPixWidth; a += 1) {
			for (b = tempPixY; b < tempPixY + tempPixHeight; b += 1) {
				passedPixel[a,b] = true;
				//show_message("Passed: " + string(a) + ", " + string(b));
			}
		}
		
		// Move on to new row if row and column have ended
		if !canIncHor && !canIncVer {
			if rowEnd {
				show_message("NEW LINE");
				currentPixelX = 0;
				currentPixelY += 1;
				
				currentWidth = 0;
				currentHeight = 0;
				
				rowEnd = false;
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
