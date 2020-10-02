enum PANE_TYPE
{
	view,
	inspector,
	dope
}

uiPane = function() constructor
{
	pane_type = PANE_TYPE.view;

	render_surface(_width, _height)
	{
		var return_surface = surface_create(_width, _height);
		surface_set_target(return_surface);

		draw_clear(c_red);

		surface_reset();
		return return_surface;
	}
}
