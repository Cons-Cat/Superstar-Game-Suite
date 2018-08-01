/// @description 
event_inherited();

if activated {
	instance_create_layer(mouse_x,mouse_y,"Instances",obj_cutscene_actor_getter_walk_target);
	obj_cutscene_actor_getter_walk_target.i = self.i;
	
	instance_destroy();
}
