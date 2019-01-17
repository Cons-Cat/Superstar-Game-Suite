/// @description 
if instance_exists(trg) {
	trg.canSelect = true;
} else {
	instance_destroy();
}

if instance_exists(obj_cutscene_actor_getter_dialogue_target) || instance_exists(obj_cutscene_actor_getter_walk_target) {
	select = false;
	canSelect = false;
}
