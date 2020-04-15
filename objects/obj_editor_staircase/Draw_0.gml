/// @description Draw terrain
if obj_editor_gui.mode = 3 {
	for (i = 1; i < tilingWidth - 1; i++) {
		for (j = 1; j < tilingHeight; j++) {
			for (k = 0; k <= tileLayerCount; k += 2) {
				if hasTile[scr_array_xy(i,j,tileArrayHeight),k] && layerVisible[k] {
					break;
				} else if k = tileLayerCount {
					//draw_sprite_part_ext(backdropSpr, 0, i*20, j*20, 20, 20, staircaseRasterX0 + i*20 - 20, staircaseRasterY0 + j*20 - 20, 1, 1, canSelect ? c_orange : c_white, 1);
					draw_surface_part(canSelect ? bakedStaircaseSelect : bakedStaircase, (i-1)*20, (j-1)*20, 20, 20, staircaseRasterX0 + (i-1)*20, staircaseRasterY0 + (j-1)*20);
				}
			}
		}
	}
} else {
	// Draw the staircase bake in all modes besides tiling.
	draw_surface(canSelect ? bakedStaircaseSelect : bakedStaircase, staircaseRasterX0, staircaseRasterY0);
}

// Draw the wireframe shadow.
if obj_editor_gui.mode = 1 {
	var zOff =  (zfloor - zcieling) * 20;
	
	if canSelect {
		layerColorShadow = obj_editor_gui.colOrangeShadow;
	} else {
		if zcieling > 0 {
			layerColorShadow = colDark[ abs( (zcieling - 1) % 9) ];
		} else {
			layerColorShadow = c_gray;
		}
	}
	
	draw_set_color(layerColorShadow);
	draw_set_alpha(0.35);
	
	draw_triangle(x1,y1+zOff,x2,y2+zOff,x3,y3,false);
	draw_triangle(x3,y3,x2,y2+zOff,x4,y4,false);
	
	draw_set_alpha(1);
}

event_inherited();
