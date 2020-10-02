enum PANE_TYPE
{
	view,
	inspector,
	dope
}

uiPane = function() constructor
{
	pane_type = PANE_TYPE.view;

	render_surface = function(_width, _height)
	{
		var return_surface = surface_create(_width, _height);
		surface_set_target(return_surface);

		draw_clear(c_red);

		// Draw folds
		draw_sprite_ext(spr_ui_fold, 0, 0, 0, 1, 1, 0, c_white, 1);
		draw_sprite_ext(spr_ui_fold, 0, _width, 0, -1, 1, 0, c_white, 1);
		draw_sprite_ext(spr_ui_fold, 0, 0, _height, 1, -1, 0, c_white, 1);
		draw_sprite_ext(spr_ui_fold, 0, _width, _height, -1, -1, 0, c_white, 1);

		surface_reset_target();
		return return_surface;
	}
}
