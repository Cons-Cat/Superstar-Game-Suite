/// @description Draw interface
/*if !surface_exists(surf) {
	surf = surface_create(512, 288);
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	surface_reset_target();
	view_surface_id[0] = surf;
}

var _vx = 0;
var _vy = 0;
draw_surface_ext(surf, _vx, _vy,1,1,0,c_white,1);

if !surface_exists(surf2) {
	surf2 = surface_create(1025, 576);
	surface_set_target(surf2);
	draw_clear_alpha(c_black, 0);
	surface_reset_target();
	view_surface_id[1] = surf2;
}

draw_surface_ext(surf2, _vx, _vy,1,1,0,c_white,1);
*/

// Draw room grid
for(i = 0; i < room_width; i += 20) {
	for(j = 576; j < room_height; j += 20) {
		draw_sprite(spr_grid_editor,0,i,j);
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
draw_sprite(spr_editor_gui_frame,0,0,0);

// Draw tile GUI
if mode = 3 {
	if global.pieceSelected != -1 {
		//draw_rectangle(0+5,0+5,0+camera_get_view_width(camera)-5,0+camera_get_view_height(camera)-5,false);
	}
}
