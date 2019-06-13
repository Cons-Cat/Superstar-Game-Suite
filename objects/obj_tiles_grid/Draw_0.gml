/// @description
draw_self();

if gone {
for (k = 0; k <= tileLayerCount; k += 1) {
	if layerVisible[layerOrder[k]] {
		if hasTile[scr_array_xy(i,j,tileRowWidth),layerOrder[k]] {
			draw_sprite_part(tempMaterial,0,xVal[layerOrder[k]],yVal[layerOrder[k]],20,20,x,y);
		}
	}
}
}
