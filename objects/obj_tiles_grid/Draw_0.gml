/// @description
draw_self();

for (k = 0; k <= tileLayerCount; k += 2) { // Iterate through absolute
	if layerVisibleAbsolute[k] {
		if hasTileAbsolute[k] {
			if !hasTileAbsolute[k+1] {
				if layerTypeAbsolute[k] = 0 { // Tile layer
					draw_sprite_part(tileDrawSpr,0,xValDraw[k],yValDraw[k],20,20,x,y);
				}
				
				if layerTypeAbsolute[k] = 1 { // Marble layer
					if surface_exists(marbleSurface) {
						draw_surface(marbleSurface,x,y);
					}
				}
			} else {
				surface_set_target(tileSurface);
				
				draw_clear_alpha(c_white,0);
				draw_sprite_part(tileDrawSpr,0,xValDraw[k],yValDraw[k],20,20,0,0);
				
				gpu_set_blendmode(bm_subtract);
				draw_sprite_part(tileDrawSpr,0,xValDraw[k+1],yValDraw[k+1],20,20,0,0);
				gpu_set_blendmode(bm_normal);
				
				// Add subtracted layer to a surface
				if surface_exists(surfaceSubtract[k]) {
					draw_surface(surfaceSubtract[k],0,0);
				}
				
				surface_reset_target();
				
				// Draw subtracted layer
				draw_surface(tileSurface,x,y);
				
				// Draw subtraction mask over tile when sub-layer is selected
				if tileLayerSelect = k+1 {
					draw_sprite_part(tileDrawSpr,0,xValDraw[k+1],yValDraw[k+1],20,20,x,y);
				}
			}
		}
	}
}
