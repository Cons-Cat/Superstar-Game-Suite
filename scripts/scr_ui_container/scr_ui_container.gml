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

	surface = 0;
	pane_tabs = ds_list_create();
	current_tab = 0;
	ds_list_add(pane_tabs, new uiPane());

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

	update_pane_surface = function(_surface)
	{
		if (surface_exists(_surface))
		{
			// Wiping the surface first may be necessary.
			surface_free(_surface);
		}

		_surface = pane_tabs[| current_tab].render_surface(width, height);

		surface_set_target(_surface)
		{
			// Draw folds
			draw_sprite_ext(spr_ui_fold, 0, 0, 0, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_ui_fold, 0, width, 0, -1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_ui_fold, 0, 0, height, 1, -1, 0, c_white, 1);
			draw_sprite_ext(spr_ui_fold, 0, width, height, -1, -1, 0, c_white, 1);
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
