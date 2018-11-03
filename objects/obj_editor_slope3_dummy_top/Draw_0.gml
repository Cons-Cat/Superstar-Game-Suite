// Tile painting mode / Play testing mode
if obj_editor_gui.mode = 2 || obj_editor_gui.mode = 3 || obj_editor_gui.mode = 4 {
	layerColor = trg.layerColor;
	
	// Draw walls
	for (j = zfloor + 2; j >= zfloor; j -= 1) {
		// Iterate across the z height
		for (i = 0; i <= width + 1; i += 1) {
			// Iterate across the width diagonally
			draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[i,j],tileArrayDrawY[i,j],20,20,x+(i-1)*20,y+(zfloor-zcieling)*20-(j)*20+20,1,1,layerColor,1);
		}
	}
}
