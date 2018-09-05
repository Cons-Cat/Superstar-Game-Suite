/// @description Draw button
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,col,image_alpha);

if flagOn = true {
	draw_sprite_ext(spr_flag_editor,0,mouse_x-string_length(flagStr)*5,mouse_y,string_length(flagStr)*5,1,0,c_white,1);
	draw_set_color(c_white);
	draw_text(mouse_x-string_length(flagStr)*5,mouse_y,flagStr);
}
