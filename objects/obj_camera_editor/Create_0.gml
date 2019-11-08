/// @description Initialize variables
gridAtX = 0;
gridAtY = 0;
curAtX = 0;
curAtY = 0;
gridGravX = 0;
gridGravY = 0;
barrierHor = 0;
barrierVer = 0;
consecutiveMovesHor = 0;
consecutiveMovesVer = 0;
gridSpeedHor = 0;
gridSpeedVer = 0;

tempX = x;
tempY = y;

placeX = x;
placeY = y;
placeZ = 0;
heavyFall = false;

accelX = 0;
accelY = 0;
accelZ = 0;

leftQuarter = 0;
upQuarter = 0;
rightQuarter = 0;
downQuarter = 0;
centerX = 0;
centerY = 0;

panX = 0;
panY = 0;

xTo = x;
yTo = y;
canInputMove = true;

i = 0;
trgRegion = -1;
anchored = false;

zoomLevel = 1;
zoomSpd = 0.065;
tempZoomLevel = zoomLevel;
baseZoomWidth = 512;
baseZoomHeight = 288;

view_visible[2] = false;
view_visible[3] = false;
