/// @description Depth calculation
event_inherited();

if instance_exists(obj_editor_button_parent) {
	depth = obj_editor_button_parent.depth - 1;
}
