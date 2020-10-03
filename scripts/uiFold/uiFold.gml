function uiFold(_dock_hor, _dock_ver) constructor
{
	dock_hor = _dock_hor;
	dock_ver = _dock_ver;
	
	surface = surface_create(10, 10);
	
	update_surface = function()
	{
		surface_free(surface);
		surface = surface_create(10, 10);
		
		surface_set_target(surface);
		draw_sprite_ext(spr_ui_fold, 0, 5, 5, dock_hor, dock_ver, 0, c_white, 1);
		surface_reset_target();
	}
	
	update_surface();
}
