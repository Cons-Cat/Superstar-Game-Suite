/// @description Draw interface
draw_set_color(c_dkgray)
draw_rectangle(camera_get_view_x(camera)+camera_get_view_width(camera)-48,camera_get_view_y(camera),camera_get_view_x(camera)+camera_get_view_width(camera),camera_get_view_y(camera)+camera_get_view_height(camera),false);

// Draw tile GUI
if mode = 3 {
	if global.pieceSelected != -1 {
		draw_rectangle(camera_get_view_x(camera)+5,camera_get_view_y(camera)+5,camera_get_view_x(camera)+camera_get_view_width(camera)-5,camera_get_view_y(camera)+camera_get_view_height(camera)-5,false);
	}
}
