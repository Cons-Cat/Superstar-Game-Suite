/// @description 
/*for (i = 0; i < image_xscale; i += 1){
	for (j = 0; j < image_yscale; j += 1){
		var lay_id = layer_get_id("Tiles_1");
		var map_id = layer_tilemap_get_id(lay_id);
		var mx = tilemap_get_cell_x_at_pixel(map_id, x+i*20, y+j*20);
		var my = tilemap_get_cell_y_at_pixel(map_id, x+i*20, y+j*20);
		var data = tilemap_get(map_id, mx, my);
		var ind = tile_get_index(data);

		tileDraw[i,j] = ind;
		draw_tile(tls_whitebox,ind,0,x+i*20,y+j*20);
	}
}*/

layerColor = c_white;
// Draw walls
if width > 1 {
	for (i = 2; i < width; i += 1) {
		for (j = height; j < image_yscale; j += 1) {
			// Center fill
			draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[i,j],tileArrayDrawY[i,j],20,20,x+(i-1)*20,y+(j-1)*20,1,1,layerColor,1);
		}
	}
		
	for (j = height; j < image_yscale; j += 1) {
		// Left edge
		draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[1,j],tileArrayDrawY[1,j],20,20,x,y+(j-1)*20,1,1,layerColor,1);
		// Right edge
		draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[width,j],tileArrayDrawY[width,j],20,20,x+(width-1)*20,y+(j-1)*20,1,1,layerColor,1);
	}
} else {
	for (j = height; j < image_yscale; j += 1) {
		// Vertical beam center edge
		draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[1,j],tileArrayDrawY[1,j],20,20,x,y+(j-1)*20,1,1,layerColor,1);
	}
}
	
if width > 1 {
	for (i = 1; i < width; i += 1) {
		// Bottom edge
		draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[i,image_yscale],tileArrayDrawY[i,image_yscale],20,20,x+(i-1)*20,y+(image_yscale-1)*20,1,1,layerColor,1);
	}
		
	// Bottom left corner
	draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[1,image_yscale],tileArrayDrawY[1,image_yscale],20,20,x,y+(image_yscale-1)*20,1,1,layerColor,1);
	// Bottom right corner
	draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[width,image_yscale],tileArrayDrawY[width,image_yscale],20,20,x+(width-1)*20,y+(image_yscale-1)*20,1,1,layerColor,1);
} else {
	// Vertical beam bottom edge
	draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[1,image_yscale],tileArrayDrawY[1,image_yscale],20,20,x,y+(image_yscale-1)*20,1,1,layerColor,1);
}
	
// Draw floor
if width > 1 && height > 1 {
	// Four corners
	draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[1,1],tileArrayDrawY[1,1],20,20,x,y,1,1,layerColor,1);
	draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[width,1],tileArrayDrawY[width,1],20,20,x+(width-1)*20,y,1,1,layerColor,1);
	draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[1,height],tileArrayDrawY[1,height],20,20,x,y+(height-1)*20,1,1,layerColor,1);
	draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[width,height],tileArrayDrawY[width,height],20,20,x+(width-1)*20,y+(height-1)*20,1,1,layerColor,1);
		
	for (i = 1; i < width; i += 1) {
		// Top edge
		draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[i,1],tileArrayDrawY[i,1],20,20,x+(i-1)*20,y,1,1,layerColor,1);
		// Bottom edge
		draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[i,height],tileArrayDrawY[i,height],20,20,x+(i-1)*20,y+(height-1)*20,1,1,layerColor,1);
	}
	for (j = 1; j < height; j += 1) {
		// Left edge
		draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[1,j],tileArrayDrawY[1,j],20,20,x,y+(j-1)*20,1,1,layerColor,1);
		// Right edge
		draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[width,j],tileArrayDrawY[width,j],20,20,x+(width-1)*20,y+(j-1)*20,1,1,layerColor,1);
	}
	for (i = 2; i < width; i += 1) {
		for (j = 2; j < height; j += 1) {
			// Center fill
			draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[i,j],tileArrayDrawY[i,j],20,20,x+(i-1)*20,y+(j-1)*20,1,1,layerColor,1);
		}
	}
} else if width = 1 && height > 1 {
	// Vertical line
	for (j = 1; j < height; j += 1) {
		draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[1,j],tileArrayDrawY[1,j],20,20,x,y+(j-1)*20,1,1,layerColor,1);
	}
	draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[1,1],tileArrayDrawY[1,1],20,20,x,y,1,1,layerColor,1);
	draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[1,height],tileArrayDrawY[1,height],20,20,x,y+(height-1)*20,1,1,layerColor,1);
} else if width > 1 && height = 1 {
	// Horizontal line
	for (i = 1; i < width; i += 1) {
		draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[i,1],tileArrayDrawY[i,1],20,20,x+(i-1)*20,y,1,1,layerColor,1);
	}
	draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[1,1],tileArrayDrawY[1,1],20,20,x,y,1,1,layerColor,1);
	draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[width,1],tileArrayDrawY[width,1],20,20,x+(width-1)*20,y,1,1,layerColor,1);
} else {
	// Single space
	for (i = 1; i <= width; i += 1) { // Center fill
		for (j = 1; j <= height; j += 1) {
			draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[i,j],tileArrayDrawY[i,j],20,20,x+(i-1)*20,y+(j-1)*20,1,1,layerColor,1);
		}
	}
}
// Draw perimeter
for (i = 1; i <= width; i += 1) {
	draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[i,0],tileArrayDrawY[i,0],20,20,x+(i-1)*20,y-20,1,1,layerColor,1);
}
for (j = 1; j <= height; j += 1) {
	draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[0,j],tileArrayDrawY[0,j],20,20,x-20,y+(j-1)*20,1,1,layerColor,1);
	draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[width+1,j],tileArrayDrawY[width+1,j],20,20,x+(width)*20,y+(j-1)*20,1,1,layerColor,1);
}
draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[0,0],tileArrayDrawY[0,0],20,20,x-20,y-20,1,1,layerColor,1);
draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[width+1,0],tileArrayDrawY[width+1,0],20,20,x+(width)*20,y-20,1,1,layerColor,1);
draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[0,height+1],tileArrayDrawY[0,height+1],20,20,x-20,y+(height)*20,1,1,layerColor,1);
draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[width+1,height+1],tileArrayDrawY[width+1,height+1],20,20,x+(width)*20,y+(height)*20,1,1,layerColor,1);
