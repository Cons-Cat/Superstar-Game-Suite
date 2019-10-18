/// @description Draw interface

// Draw room grid
for(i = 0; i < room_width; i += 20) {
	for(j = 0; j < room_height; j += 20) {
		draw_sprite(modeGridSpr,0,i,j);
	}
}

// Draw transparent darkness outside of real-game view
draw_set_alpha(0.5451);
draw_set_color(make_color_rgb(28,28,25));
gpu_set_blendmode(bm_inv_src_color);

// Left quadrant
draw_rectangle(room_width,obj_panel_top.y + 10,obj_panel_left.baseX,view_hport[1],false);
// Right quadrant
draw_rectangle(obj_panel_right.baseX,obj_panel_top.y + 10,room_width + view_wport[1],view_hport[1],false);
// Top quadrant
draw_rectangle(obj_panel_left.baseX+1,0,obj_panel_right.baseX-1,obj_panel_top.baseY,false);
// Bottom quadrant
draw_rectangle(obj_panel_left.baseX+1,obj_panel_bot.baseY,obj_panel_right.baseX-1,view_hport[1],false);

draw_set_alpha(1);
gpu_set_blendmode(bm_normal)

draw_set_color(colLight);
draw_rectangle(room_width,0,obj_panel_left.baseX,obj_panel_top.y + 6,false);
draw_rectangle(obj_panel_left.baseX+1,0,obj_panel_left.baseX+10,obj_panel_top.y - 4,false);

draw_rectangle(obj_panel_right.baseX,0,view_wport[1] + room_width,obj_panel_top.y + 6,false);
draw_rectangle(obj_panel_right.baseX-1,0,obj_panel_right.baseX-11,obj_panel_top.y - 4,false);

draw_set_color(colMid);
draw_rectangle(room_width,obj_panel_top.y + 7,obj_panel_left.baseX,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_left.baseX-2,obj_panel_top.y - 3,obj_panel_left.baseX,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_left.baseX-2,obj_panel_top.y - 3,obj_panel_left.baseX+10,obj_panel_top.y,false);

draw_rectangle(obj_panel_right.baseX-1,obj_panel_top.y + 7,view_wport[1] + room_width,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_right.baseX+1,obj_panel_top.y - 3,obj_panel_right.baseX-1,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_right.baseX+1,obj_panel_top.y - 3,obj_panel_right.baseX-12,obj_panel_top.y,false);

draw_set_color(colDark);
draw_rectangle(room_width,obj_panel_top.y + 8,obj_panel_left.baseX,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_left.baseX-1,obj_panel_top.y - 2,obj_panel_left.baseX,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_left.baseX-1,obj_panel_top.y - 2,obj_panel_left.baseX+10,obj_panel_top.y,false);

draw_rectangle(obj_panel_right.baseX-1,obj_panel_top.y + 8,view_wport[1] + room_width,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_right.baseX,obj_panel_top.y - 2,obj_panel_right.baseX-1,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_right.baseX,obj_panel_top.y - 2,obj_panel_right.baseX-12,obj_panel_top.y,false);

draw_set_color(outlineDark);
draw_rectangle(room_width,obj_panel_top.y + 10,obj_panel_left.baseX,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_left.baseX,obj_panel_top.y,obj_panel_left.baseX,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_left.baseX,obj_panel_top.y,obj_panel_left.baseX+10,obj_panel_top.y,false);
draw_rectangle(obj_panel_left.baseX+11,0,obj_panel_left.baseX+11,obj_panel_top.y,false);

draw_rectangle(obj_panel_right.baseX-1,obj_panel_top.y + 10,view_wport[1] + room_width,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_right.baseX-1,obj_panel_top.y,obj_panel_right.baseX-1,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_right.baseX-1,obj_panel_top.y,obj_panel_right.baseX-11,obj_panel_top.y,false);
draw_rectangle(obj_panel_right.baseX-12,0,obj_panel_right.baseX-12,obj_panel_top.y,false);

draw_set_color(c_white);
draw_rectangle(room_width,obj_panel_top.y + 11,obj_panel_left.baseX,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_left.baseX+12,0,obj_panel_left.baseX+12,obj_panel_top.y,false);

draw_rectangle(obj_panel_right.baseX-1,obj_panel_top.y + 11,view_wport[1] + room_width,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_right.baseX-12,0,obj_panel_right.baseX-12,obj_panel_top.y,false);

draw_set_color(outlineLight);
draw_rectangle(obj_panel_left.baseX-1,obj_panel_top.y + 11,obj_panel_left.baseX,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_left.baseX+12,obj_panel_top.y - 1,obj_panel_left.baseX+12,obj_panel_top.y,false);

draw_rectangle(obj_panel_right.baseX-1,obj_panel_top.y + 11,obj_panel_right.baseX,obj_panel_top.y + 11,false);
draw_rectangle(obj_panel_right.baseX-13,obj_panel_top.y - 1,obj_panel_right.baseX-13,obj_panel_top.y,false);
