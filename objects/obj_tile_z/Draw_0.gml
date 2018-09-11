/// @description 
drawX = camera_get_view_x(obj_editor_gui.camera)+startX;
drawY = camera_get_view_y(obj_editor_gui.camera)+startY;

if z >= 0 {
	draw_sprite_ext(sprite_index,image_index,drawX,drawY,image_xscale,image_yscale,image_angle,colZ[floor(z) % 8],image_alpha);
	draw_set_color(c_white);
	draw_text(x+20,y,floor(z));
} else {
	draw_sprite_ext(sprite_index,image_index,drawX,drawY,image_xscale,image_yscale,image_angle,c_white,image_alpha);
}

draw_sprite_ext(spr_arrow_editor,0,drawX+20,drawY-2,1,1,0,col1,1);
draw_sprite_ext(spr_arrow_editor,0,drawX+20,drawY+22,1,-1,0,col2,1);
