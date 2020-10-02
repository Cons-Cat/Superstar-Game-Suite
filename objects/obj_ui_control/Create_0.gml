scr_ui_container();
gc_enable(false);

draw_stack_docked = ds_list_create();
super_container = new uiContainer(room_width, room_height);
ds_list_add(draw_stack_docked, super_container);
