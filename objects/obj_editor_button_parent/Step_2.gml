/// @description 
if instance_exists(trg) {
	trg.canSelect = true;
} else {
	instance_destroy();
}

if instance_exists(obj_trigger_widget_parent) {
	select = false;
}

canSelect = true;
