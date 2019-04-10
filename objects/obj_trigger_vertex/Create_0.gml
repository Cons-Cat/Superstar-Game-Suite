/// @description Initialize values
relativeMouseX = 0;
relativeMouseY = 0;
zfloor = 0;
edgeState = 0;
canPlace = false;
canDrag = false;
canDragDelayed = false;
deleting = false;
vertexToId = -1;

vertexId = instance_number(obj_trigger_vertex);

with obj_trigger_region_parent {
	if select {
		self.vertexInstanceId[other.vertexId] = other.id;
		other.trg = self.id;
		other.canPlace = true;
		other.canDragDelayed = true;
		
		break;
	}
}

image_speed = 0;
