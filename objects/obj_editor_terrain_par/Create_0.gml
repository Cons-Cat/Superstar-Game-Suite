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

select = true;
canSelect = true;
placed = 0;
buttonSelected = 0;
canDeSelect = true;
calculateSub = false; // Generate surface
surfaceResize = true; // Initialize surfaces

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
	// Cube
	zfloor = obj_tile_z.z+1;
	zcieling = obj_tile_z.z;
} else {
	// Flat floor
	zfloor = 0;
	zcieling = 0;
}

// Tile array values
resetArray = true;
sprMaterial = spr_tls_rectangle_default;
tileArrayDrawX[0,0] = 0;
tileArrayDrawY[0,0] = 0;
canSpawnButtons = false;
spawnButtons = false;
canSpawnTiles = false;
spawnTiles = canSpawnTiles;
depthIterate = 0;

// Marble values
marbleNetPixels = 0;
marbleSampleGirth[marbleNetPixels] = 0;
edgeStreakCountRead = 0;
transfusedDistributionX[edgeStreakCountRead] = -1;
transfusedDistributionY[edgeStreakCountRead] = -1;
genMarble = false;
bakeMarble = false;
marbleLostResize = false; // If the marble is deleted when resizing the window

hasAdjacentLeft = false;
hasAdjacentRight = false;

// Marble colors ( lightest to darkest )
marbleCol[0] = make_color_rgb(242,242,242);
marbleCol[1] = make_color_rgb(197,198,197);
marbleCol[2] = make_color_rgb(183,183,183);
marbleCol[3] = make_color_rgb(160,160,160);
marbleCol[4] = make_color_rgb(145,146,150);
marbleCol[5] = make_color_rgb(132,134,137);
marbleCol[6] = make_color_rgb(119,119,122);
marbleCol[7] = c_red;

alarm[0] = 2;
