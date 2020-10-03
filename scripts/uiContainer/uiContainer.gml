function uiContainer(_width, _height) constructor
{
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

	surface = surface_create(width, height);
	pane_tabs = ds_list_create();
	current_tab = 0;
	ds_list_add(pane_tabs, new uiPane());

	folds = ds_list_create();
	ds_list_add(folds, new uiFold(1,1), new uiFold(-1,1), new uiFold(1,-1), new uiFold(-1,-1));

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
		surface_set_target(surface);

		for (var i = 0; i < 4; i++)
		{
			if (!surface_exists(folds[| i].surface))
			{
				folds[| i].update_surface();
			}
			
			draw_surface(folds[| i].surface, folds[| i].dock_hor * width/2 + width/2 - (folds[| i].dock_hor == 1) * 10, folds[| i].dock_ver * height/2 + height/2 - (folds[| i].dock_ver == 1) * 10);
		}

		surface_reset_target();
	}

	recurse_coord_in_bounds = function(_x, _y)
	{
		if (!(_x < child.xport || _x > child.xport + child.wport || _y < child.yport || _y > child.yport + hport))
		{
			return child.recurse_coord_in_bounds(_x, _y);
		} else {
			return pane_tabs[| current_tab].recurse_coord_in_bounds(_x, _y);
		}
	}

	#endregion
}
