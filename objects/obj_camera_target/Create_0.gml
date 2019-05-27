/// @description Initialize values
relativeMouseX = 0;
relativeMouseY = 0;
zfloor = 0;
canPlace = false;
canDrag = false;
canDragDelayed = false;
deleting = false;
vertexToInd = -1;
vertexToId = -1;
mouseXOff = 0;
mouseYOff = 0;
tempX = x;
tempY = y;
trgX = -1;
trgY = -1;

with obj_trigger_region_parent {
	if select {
		self.anchorId = other.id;
		other.trg = self.id;
		other.canPlace = true;
		other.canDragDelayed = true;
		other.trgXOff = other.x - self.x;
		other.trgYOff = other.y - self.y;
		
		visible = true;
		break;
	}
}

image_speed = 0;
