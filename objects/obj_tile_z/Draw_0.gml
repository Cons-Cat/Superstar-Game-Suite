/// @description 
if z >= 0 {
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,colZ[floor(z) % 8],image_alpha);
	draw_set_color(c_white);
	draw_text(x+20,y,floor(z));
} else {
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_white,image_alpha);	
}

draw_sprite_ext(spr_arrow_editor,0,x+20,y-2,1,1,0,col1,1);
draw_sprite_ext(spr_arrow_editor,0,x+20,y+22,1,-1,0,col2,1);
