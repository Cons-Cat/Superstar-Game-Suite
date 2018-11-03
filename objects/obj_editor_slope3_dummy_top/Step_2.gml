/// @description 
if instance_exists(trg) {
	x = trg.x;
	y = trg.y - 20;

	width = trg.width;
	flip = trg.flip;
	zfloor = trg.zfloor;
	zcieling = trg.zcieling;
	sprMaterial = trg.sprMaterial;
	depthOffset = trg.depthOffset;

	depth = -(y + zfloor*20) - zfloor + depthOffset;
} else {
	instance_destroy();
}

if (obj_editor_gui.mode = 2 || obj_editor_gui.mode = 3 || obj_editor_gui.mode = 4) && !flip {
	visible = true;
} else {
	visible = false;
}
