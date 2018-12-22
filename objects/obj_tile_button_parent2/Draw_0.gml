/// @description Draw button
drawX = camera_get_view_x(obj_editor_gui.camera)+startX;
drawY = camera_get_view_y(obj_editor_gui.camera)+startY;

draw_sprite_ext(sprite_index,image_index,drawX,drawY,image_xscale,image_yscale,image_angle,col,image_alpha);

/*if flagOn = true {
	draw_sprite_ext(spr_flag_editor,0,mouse_x-string_length(flagStr)*5,mouse_y,string_length(flagStr)*5,1,0,c_white,1);
	draw_set_color(c_white);
	draw_text(mouse_x-string_length(flagStr)*5,mouse_y,flagStr);
}
