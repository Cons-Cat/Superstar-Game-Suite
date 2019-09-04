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
					// Bake subtracted layer
					tileSurface = surface_create(20,20);
					surface_set_target(tileSurface);
					
					draw_sprite_part(tempMaterial,0,xValDraw[k],yValDraw[k],20,20,0,0);
					
					gpu_set_blendmode(bm_subtract);
					draw_sprite_part(tempMaterial,0,xValDraw[k+1],yValDraw[k+1],20,20,0,0);
					gpu_set_blendmode(bm_normal);
					
					// Add subtracted layer to a surface
					draw_surface(surfaceSubtract[k],0,0);
					
					surface_reset_target();
					surface_free(tileSurface);
					
					calculateSub = false;
				}
				
				if !calculateSub {
					if tileLayerSelect = k+1 {
						// Draw subtraction mask over tile
						draw_sprite_part(tempMaterial,0,xValDraw[k],yValDraw[k],20,20,x,y);
						draw_sprite_part(tempMaterial,0,xValDraw[k+1],yValDraw[k+1],20,20,x,y);
					} else {
						// Draw subtracted layer
						draw_surface(surfaceSubtract[k],x,y);
					}
				}
			}
		}
	}
}
