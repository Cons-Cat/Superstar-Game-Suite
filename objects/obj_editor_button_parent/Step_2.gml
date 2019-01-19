/// @description 
if instance_exists(trg) {
	trg.canSelect = true;
} else {
	instance_destroy();
}

if instance_exists(obj_cutscene_actor_getter_target_parent) {
	select = false;
	canSelect = false;
}
