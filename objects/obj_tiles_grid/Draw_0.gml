/// @description
draw_self();

for (k = 0; k <= tileLayerCount; k += 2) { // Iterate through absolute
	if layerVisibleDraw[k] {
		if hasTileDraw[k] {
			if !hasTileDraw[k+1] {
				// Tile layer
				draw_sprite_part(tempMaterial,0,xValDraw[k],yValDraw[k],20,20,x,y);
			} else {
				if calculateSub {
					// First step in baking clipping mask
					emptyPixels = 0;
					
					var tileSurface;
					tileSurface = surface_create(20,20);
					surface_set_target(tileSurface);
					
					draw_sprite_part(tempMaterial,0,xValDraw[k+1],yValDraw[k+1],20,20,0,0);
					
					for (a = 0; a < 20; a += 1) {
						for (b = 0; b < 20; b += 1) {
							//show_message(window_mouse_get_x() - (x + a2 - camera_get_view_x(obj_editor_gui.cameraLeftPanel) + 16 - 2) );
							//show_message(window_mouse_get_y() - (y + b2 - camera_get_view_y(obj_editor_gui.cameraLeftPanel) + view_yport[3] - 2) );
							findPixelX = view_xport[2] + (x - camera_get_view_x(obj_editor_gui.cameraLeftPanel)) + a;
							findPixelY = view_yport[2] + (y - camera_get_view_y(obj_editor_gui.cameraLeftPanel)) + b ;
							//show_message(draw_getpixel_ext(findPixelX,findPixelY));
							
							//if draw_getpixel_ext(findPixelX,findPixelY) = c_black {
							pixCol = surface_getpixel_ext (tileSurface,a,b);
							
							if (pixCol >> 24) && 255 {
								// Subtract pixel
								subMask[a,b] = true;
							} else {
								// Maintain pixel
								subMask[a,b] = false;
								emptyPixels += 1;
							}
							
							// Initialize passed pixels
							passedPixel[a,b] = false;
						}
					}
					
					surface_reset_target();
					surface_free(tileSurface);
				} else {
					// If the mask has been baked
					for (a = 0; a < clusterCount[k]; a += 1) {
						draw_sprite_part(tempMaterial,0,xValDraw[k] + clusterX[clusterCount[a],k],yValDraw[k] + clusterY[clusterCount[a],k],clusterWidth[clusterCount[a],k],clusterHeight[clusterCount[a],k],x,y);
					}
				}
			}
		}
	}
}
