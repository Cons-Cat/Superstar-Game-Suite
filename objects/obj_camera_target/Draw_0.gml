/// @description 
if zfloor > 0 {
	// Draw shadow
	gpu_set_fog(true,c_black,0,0);
	draw_sprite_ext(sprite_index,0,x,y,1,1,0,c_white,0.65);
	gpu_set_fog(false,c_black,0,0);
}

draw_sprite(sprite_index,image_index,x,y - (zfloor * 20));
