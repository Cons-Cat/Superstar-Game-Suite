/// @description Draw terrain
if obj_editor_gui.mode = 0 {
	draw_surface(canSelect ? bakedStaircaseSelect : bakedStaircase, staircaseRasterX0, staircaseRasterY0);
} else if obj_editor_gui.mode = 1 {
	var zOff =  (zfloor - zcieling) * 20;
	
	if canSelect {
		layerColorShadow = obj_editor_gui.colOrangeShadow;
	} else {
		if zcieling > 0 {
			layerColorShadow = colDark[ abs( (zcieling-1) % 9) ];
		} else {
			layerColorShadow = c_gray;
		}
	}
	
	draw_set_color(layerColorShadow);
	draw_set_alpha(0.35);
	
	draw_triangle(x1,y1+zOff,x2,y2+zOff,x3,y3,false);
	draw_triangle(x3,y3,x2,y2+zOff,x4,y4,false);
	
	draw_set_alpha(1);
	
	draw_surface(canSelect ? bakedStaircaseWireframeSelect : bakedStaircaseWireframe, staircaseRasterX0, staircaseRasterY0);
} else if obj_editor_gui.mode = 3 {
	for (i = 0; i < tilingWidth; i++) {
		for (j = 0; j < tilingHeight; j++) {
			for (k = 0; k <= tileLayerCount; k += 2) {
				//show_debug_message(string(k) + ", " + string(tileLayerCount));
				
				if hasTile[scr_array_xy(i,j,tileArrayHeight),0] && layerVisible[k] {
					show_debug_message("HIT");
					break;
				} else if k = tileLayerCount {
					draw_sprite_part(backdropSpr, 0, i*20, j*20, 20, 20, staircaseRasterX0 + i*20 - 20, staircaseRasterY0 + j*20 - 20);
				}
			}
		}
	}
}

event_inherited();
