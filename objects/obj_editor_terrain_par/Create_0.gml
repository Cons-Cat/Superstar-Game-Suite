/// @description Generic variable initialization
width = 1;
height = 1;
tileLayerCount = 0;
layerVisible[0] = true;
layerOrder[0] = 0;
layerVisible[0] = true;
layerName[0,0] = "layer_0";
layerName[0,1] = "sublayer_0";
surfaceResize = false;
tileDefaultSpr = "spr_tls_rectangle_default";
tileDrawSpr = asset_get_index(tileDefaultSpr)

mirror = false;
flip = false;
finite = true;
depthOffset = 0;
alpha = 1;
modeForSelect = false;
modeForSelectVal = 0;
longestPanelRightButton = 0;

blankCol = c_white;
blankColDark = c_dkgray
layerColor = blankCol;

col[0] = make_color_rgb(210,74,84); // Red
col[1] = make_color_rgb(212,106,55); // Dark orange
col[2] = make_color_rgb(209,160,75); // Light orange
col[3] = make_color_rgb(149,175,61); // Dark green
col[4] = make_color_rgb(177,209,75); // Light green
col[5] = make_color_rgb(0,184,132); // Teal
col[6] = make_color_rgb(64,139,209); // Blue
col[7] = make_color_rgb(147,71,198); // Purple
col[8] = make_color_rgb(225,86,204); // Pink

if obj_tile_z.z >= 0 {
	zfloor = obj_tile_z.z+1;
	zcieling = obj_tile_z.z;
} else {
	zfloor = 0;
	zcieling = 0;
}

select = true;
placed = 0;
buttonSelected = 0;
canDeSelect = true;

// Tile array values
resetArray = true;
sprMaterialDirectoryLoad = false;
sprMaterialDirectory = ""; // Must be a file directory
sprMaterial = spr_tls_rectangle_default;
tileArrayDrawX[0,0] = 0;
tileArrayDrawY[0,0] = 0;
canSpawnButtons = false;
spawnButtons = false;
canSpawnTiles = false;
spawnTiles = canSpawnTiles;
depthIterate = 0;

canSelect = true;

alarm[0] = 2;
