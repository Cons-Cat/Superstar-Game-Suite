for (var i = 0; i < ds_list_size(draw_stack_docked); i++)
{
	if (!surface_exists(draw_stack_docked[| i ].surface))
	{
		draw_stack_docked[| i ].update_pane_surface();
	}

	draw_surface(draw_stack_docked[| i ].surface, draw_stack_docked[| i ].xport, draw_stack_docked[| i ].yport);
}
