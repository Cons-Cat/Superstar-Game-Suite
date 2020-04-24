/// @description Insert description here
relativeMouseX = 0;
relativeMouseY = 0;
timeIndex = 0;
mouseYOff = 0;

angleCalc = 0;
radius = 20;
run = 0;
rise = 0;
mirror = false;
flip = false;
xTo = x;
yTo = y;
originXNet = x;
originYNet = y;
calcAngleVals = true;
initPosition = true;

canDrag = false;
canDel = false;
canRelease = false;
gone = false;
mouseHover = false;
placed = true;
trg = -1;

if instance_exists(obj_trigger_region_parent) {
	obj_trigger_region_parent.canDeSelect = false;
}

image_speed = 0;
