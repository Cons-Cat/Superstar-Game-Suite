/// @description Manipulating dimensions
event_inherited();

// Dimensional manipulation
if spawnButtons {
	spawnButtons = false;
	
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_drag) {
		trg = other.id;
	}
	with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z3) {
		trg = other.id;
	}
	with instance_create_layer(x,y+20,"Instances",obj_x_editor) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_right) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_left) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_info_editor) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_rotate_editor) {
		trg = other.id;
	}
	
	/*with instance_create_layer(x,y,"Instances",obj_arrow_editor_up) {
		trg = other.id;
	}
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_down) {
		trg = other.id;
	}*/
}

zcieling = zfloor;
