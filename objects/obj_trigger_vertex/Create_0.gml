/// @description Initialize values
relativeMouseX = 0;
relativeMouseY = 0;
zfloor = 0;
canPlace = true;
canDrag = false;

with obj_trigger_region_parent {
	if select {
		other.trg = self.id;
		break;
	}
}

image_speed = 0;
