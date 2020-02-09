/// @description Generic variable initialization
width = 1;
height = 1;
tileLayerCount = 0;
tileArrayHeight = 0;
layerVisible[0] = true;
layerOrder[0] = 0;
layerVisible[0] = true;
layerName[0,0] = "layer_0";
layerName[0,1] = "sublayer_0";
surfaceResize = false;
tileDefaultSpr = "spr_tls_rectangle_default";
tileDrawSpr = asset_get_index(tileDefaultSpr)
lastX = -1;
lastY = -1;
lastWidth = -1;
lastCieling = -1;
marbleRecursionI = 0;

marbleSurface = surface_create(20,20);
tileSurfaceDraw = surface_create(20,20);

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

depthIterate = 0;
spawnButtons = false;
spawnTriggers = false;
canSpawnTriggers = false;

blankCol = c_white;
blankColDark = c_dkgray
layerColor = blankCol;
layerColorLine = blankCol;
layerColorShadow = blankColDark;

// Base colors
col[0] = make_color_rgb(204,53,78); // Red
col[1] = make_color_rgb(212,100,56); // Dark orange
col[2] = make_color_rgb(219,164,37); // Yellow
col[3] = make_color_rgb(162,216,44); // Light green
col[4] = make_color_rgb(102,142,27); // Dark green
col[5] = make_color_rgb(0,180,108); // Aqua
col[6] = make_color_rgb(56,107,203); // Blue
col[7] = make_color_rgb(147,71,198); // Purple
col[8] = make_color_rgb(214,79,196); // Pink

// Wireframe shadow colors
col[9] = make_color_rgb(122,26,29); // Red
col[10] = make_color_rgb(150,43,19); // Dark orange
col[11] = make_color_rgb(153,81,13); // Light orange
col[12] = make_color_rgb(40,118,19); // Light green
col[13] = make_color_rgb(30,97,50); // Dark green
col[14] = make_color_rgb(4,86,77); // Teal
col[15] = make_color_rgb(0,65,119); // Blue
col[16] = make_color_rgb(74,27,107); // Purple
col[17] = make_color_rgb(119,19,93); // Pink

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
canSpawnTiles = false;
spawnTiles = canSpawnTiles;

// Marble values
streakNetIterations = 0;
marbleSampleGirth[streakNetIterations] = 0;
edgeStreakCountRead = 0;
transfusedDistributionX[edgeStreakCountRead] = -1;
transfusedDistributionY[edgeStreakCountRead] = -1;
genMarble = false;
bakeMarble = false;
marbleLostResize = false; // If the marble is deleted when resizing the window
hasMarble = false;
marbleHasBeenWiped = false;

marbleDebugPixelCount = 0;

hasAdjacentLeft = false;
hasAdjacentRight = false;
hasAdjacentLeftAbove = false;
hasAdjacentRightAbove = false;
hasAdjacentUp = false;
hasAdjacentDown = false;
hasAdjacentUpAbove = false;
hasAdjacentDownAbove = false;

// Marble colors ( lightest to darkest )
marbleCol[0] = make_color_rgb(242,242,242);
marbleCol[1] = make_color_rgb(197,198,197);
marbleCol[2] = make_color_rgb(183,183,183);
marbleCol[3] = make_color_rgb(155,155,155);
marbleCol[4] = make_color_rgb(140,141,145);
marbleCol[5] = make_color_rgb(128,130,132);
marbleCol[6] = make_color_rgb(114,114,117);
marbleCol[7] = c_red;
marbleCol[8] = c_blue;

alarm[0] = 2;
