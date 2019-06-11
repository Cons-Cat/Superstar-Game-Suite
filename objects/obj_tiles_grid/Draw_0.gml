/// @description
draw_self();

for (k = 0; k <= tileLayerCount; k += 1) {
	if layerVisible[k div 2] {
		if hasTile[scr_array_xy(i,j,tileRowWidth),k] {
			draw_sprite_part(tempMaterial,0,xVal[k],yVal[k],20,20,x,y);
		}
	}
}
