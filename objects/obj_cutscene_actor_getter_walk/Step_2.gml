/// @description 
event_inherited();

if activeInScene {
	instance_create_layer(mouse_x,mouse_y,"Instances",obj_cutscene_walk_target);
	obj_cutscene_walk_target.i = self.i;
	
	instance_destroy();
}
