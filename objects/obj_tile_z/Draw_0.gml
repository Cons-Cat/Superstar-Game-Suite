/// @description 
if z >= 0 {
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,colZ[floor(z) % 9],image_alpha);
	draw_set_color(c_white);
} else {
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_white,image_alpha);
}

draw_sprite_ext(spr_arrow_editor,buttonIndex[0],x+81,y+12,1,1,0,c_white,1);
draw_sprite_ext(spr_arrow_editor,buttonIndex[1],x+81,y+12,1,-1,0,c_white,1);
