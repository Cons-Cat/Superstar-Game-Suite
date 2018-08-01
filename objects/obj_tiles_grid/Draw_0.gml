/// @description 
draw_self();

/*if sprMaterial = "" {
	// Draw floor
	if tileEdge = "floor" {
		draw_sprite(spr_terrain_editor,tileDefaultSpr,x,y);
	}
	// Draw wall
	if tileEdge = "wall" {
		draw_sprite(spr_walls_editor,tileDefaultSpr,x,y);
	}
} else {
	draw_sprite_part(sprMaterial,0,xVal,yVal,20,20,x,y);
}
*/
draw_sprite_part(tempMaterial,0,xVal,yVal,20,20,x,y);
