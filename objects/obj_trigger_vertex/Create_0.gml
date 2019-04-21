/// @description Initialize values
relativeMouseX = 0;
relativeMouseY = 0;
zfloor = 0;
edgeState = 0;
canPlace = false;
canDrag = false;
canDragDelayed = false;
deleting = false;
vertexToInd = -1;
vertexToId = -1;

vertexInd = instance_number(obj_trigger_vertex);
edgeCol = make_color_rgb(29,0,92); // Dark purple;
edgeDeleteState = 0;
edgeHover = false;

with obj_trigger_region_parent {
	if select {
		self.vertexInstanceId[other.vertexInd] = other.id;
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
