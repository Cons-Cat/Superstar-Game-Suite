/// @description Draw interface

// Draw room grid
for(i = 0; i < room_width; i += 20) {
	for(j = 576; j < room_height; j += 20) {
		draw_sprite(modeGridSpr,0,i,j);
	}
}

// Draw transparent darkness outside of real-game view
draw_set_alpha(0.5451);
draw_set_color(make_color_rgb(28,28,25));
gpu_set_blendmode(bm_inv_src_color);

draw_rectangle(0+0,0+71,0+191,0+576,false);
draw_rectangle(0+833,0+71,0+1024,0+576,false);
draw_rectangle(0+192,0+0,0+832,0+59,false);
draw_rectangle(0+192,0+421,0+832,0+576,false);

draw_set_alpha(1);
gpu_set_blendmode(bm_normal)
draw_sprite(spr_editor_gui_frame_outline,0,0,0);
