uiContainer = function(_width, _height) constructor
{
	/************************
	* INITIALIZE VARIABLES *
	************************/ 
	#region

	child = undefined;
	docked = true;

	wport = 0;
	hport = 0;
	width = _width;
	height = _height;

	surface = undefined;
	pane_tabs = ds_list_create();
	current_tab = 0;

	#endregion

	/************************
	* FUNCTION DEFINITIONS *
	************************/
	#region

	split_container = function(_dock_hor, _dock_ver)
	{
		// -1 results in top/left dock, 1 results in bottom/right dock.
		child = uiContainer(_dock_hor * width / 2 + width / 2, _dock_ver * height / 2 + height / 2);
		update_corners();
		update_pane_surface();
	}

	update_corners = function() 
	{
	}

	update_pane_surface = function()
	{
		surface = pane_tabs[| current_tab].render_surface(width, height);
	}

	#endregion
}
