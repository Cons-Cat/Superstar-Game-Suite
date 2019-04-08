/// @description Initialize values
relativeMouseX = 0;
relativeMouseY = 0;
zfloor = 0;
edgeState = 0;
canPlace = true;
canDrag = false;
vertexToId = -1;

with obj_trigger_region_parent {
	if select {
		other.trg = self.id;
		self.vertexCount += 1;
		self.vertexInstanceId[vertexCount] = other.id;
		other.vertexId = self.vertexCount;
		
		break;
	}
}

image_speed = 0;
