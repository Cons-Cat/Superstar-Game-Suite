/// @description Initialize
depth = -3;
alarm[0] = 2;

tileLayerSelect = -1;
tileDefaultSpr = -1;
xValDraw[0] = 0;
yValDraw[0] = 0;
hasTileAbsolute[0] = false;
layerVisibleAbsolute[0] = false;
layerType[0] = 0;
layerTypeAbsolute[0] = 0;
tilesCount = 0; // Count how many layers have hasTile[k] as true.

z = 0;
passIn = false;
calculateSub = false;

tileSurface = surface_create(20,20);
marbleSurface = surface_create(20,20);
backdropSpr = -1;
