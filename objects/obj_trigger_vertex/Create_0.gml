/// @description Initialize values
relativeMouseX = 0;
relativeMouseY = 0;
zfloor = 0;
edgeState = 0;
hasThreshold = false;
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
tempXDrag = x;
tempYDrag = y;

vertexInd = instance_number(obj_trigger_vertex);
edgeCol = c_white;
edgeColTemp = edgeCol;
edgeDeleteState = 0;
edgeHover = false;
edgeSelect = false;
thresholdX = 0;
thresholdY = 0;
girth = 0;
tempGirth = 0;
girthX = 0;
girthY = 0;
normal = 0;
w = 0;
c = 0;
recalculate = false;
recalculate2 = false;

list = ds_list_create();
polygon = ds_list_create();
polygonCol = make_color_rgb(224,147,168);

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
