uiContainer = function(_width, _height) constructor
{
	scr_ui_pane();

	/************************
	* INITIALIZE VARIABLES *
	************************/ 
	#region

	child = undefined;
	docked = true;

	xport = 0;
	yport = 0;
	wport = 0;
	hport = 0;
	width = _width;
	height = _height;

	pane_tabs = ds_list_create();
	current_tab = 0;
	ds_list_add(pane_tabs, new uiPane());
	surface = pane_tabs[| 0].render_surface(width, height);

	#endregion

	/************************
	* FUNCTION DEFINITIONS *
	************************/
	#region

	// Transformation subroutines are non-static, for speed.
	split_container = function(_dock_hor, _dock_ver)
	{
		// -1 results in top/left dock, 1 results in bottom/right dock.
		child = new uiContainer(_dock_hor * width / 2 + width / 2, _dock_ver * height / 2 + height / 2);
		update_pane_surface();
	}

	update_pane_surface = function()
	{
		if (surface_exists(surface))
		{
			// Wiping the surface first may be necessary.
			surface_free(surface);
		}

		surface = pane_tabs[| current_tab].render_surface(width, height);
	}

	#endregion
}
