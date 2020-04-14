/// @description
draw_self();

if (backdropSpr != -1) {
	draw_sprite_part_ext(backdropSpr, 0, i*20, j*20, 20, 20, x, y, 1, 1, c_white,tilesCount > 0 ? 0.5 : 1);
}

for (k = 0; k <= tileLayerCount; k += 2) { // Iterate through absolute
	if layerVisibleAbsolute[k] || tileLayerSelect = k {
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
				
				if layerTypeAbsolute[k] = 0 { // Tile layer
					draw_sprite_part(tileDrawSpr,0,xValDraw[k],yValDraw[k],20,20,0,0);
				}
				if layerTypeAbsolute[k] = 1 { // Marble layer
					if surface_exists(marbleSurface) {
						draw_surface(marbleSurface,0,0);
					}
				}
				
				// Subtract mask from surface
				gpu_set_blendmode(bm_subtract);
				draw_sprite_part(tileDrawSpr,0,xValDraw[k+1],yValDraw[k+1],20,20,0,0);
				gpu_set_blendmode(bm_normal);
				
				surface_reset_target();
				
				// Draw this surface
				draw_surface(tileSurface,x,y);
				
				// Draw subtraction mask silhouette over tile when sub-layer is selected
				if tileLayerSelect = k+1 {
					gpu_set_fog(true,c_black,0,1);
					draw_sprite_part(tileDrawSpr,0,xValDraw[k+1],yValDraw[k+1],20,20,x,y);
					gpu_set_fog(false,c_black,0,1);
				}
			}
		}
	}
}
