/// @description Insert description here
event_inherited();

panelOffset = 0;
botPanelY = 0;
baseY = 420;
dragY = baseY;
moveToY = baseY;
moveToDeccel = 2.45;
moveToSpd = 0;
moveToSpdMin = 0.5;
mouseClickOff = 0;
moveDirection = 1;
doubleClickCounter = 0;
trg = -1;
trgXOrigin = 0;
cameraViewOn = 4;

panelWidth = 0;
panelHeight = 0;

scrollRegionDefault = false;
scrollHorX = 0;
scrollVerY = 0;
scrollHorPartition = 0;
scrollVerPartition = 0;
scrollHorFactor = 1;
scrollVerFactor = 1;
scrollHorSelect = false;
scrollVerSelect = false;
scrollPanelHorDefined = true;
scrollPanelVerDefined = false;
scrollHorWidth = panelWidth;
scrollVerHeight = panelHeight;

scrollHorLeftBound = 192;
scrollHorRightBound = view_wport[1]-192;

scrollVerLeftBound = 3;
scrollVerRightBound = 20;
scrollVerBotBound = view_hport[1] - 4;

rows = 0;
selectRow[0] = false;
cutsceneInstanceId = -1;
rowLength[0] = 0;
hasRowSelected = false;
changeRowSelectTo = -1;

totalActions = 0;
actionInd[0] = -1; // Null action
actionRowInd[0] = 0;
addClick = -1;
actionDoubleClick = 0;
cutsceneInstanceId = -1;
isPlayingScene = false;

col[0] = make_color_rgb(63,70,87); // Light
col[1] = make_color_rgb(35,38,45); // Medium
col[2] = make_color_rgb(29,32,38); // Dark

col[3] = make_color_rgb(38,43,50); // Medium bar
col[4] = make_color_rgb(30,32,37); // Dark bar

col[5] = make_color_rgb(29,32,38); // Medium outline
col[6] = make_color_rgb(28,30,36); // Dark outline

actionColInd[0] = make_color_rgb(113,45,95); // Violet
actionColInd[1] = make_color_rgb(57,113,43); // Green
actionColInd[2] = make_color_rgb(113,84,45); // Gold
actionColInd[3] = make_color_rgb(65,160,160); // Cyan
actionColInd[5] = make_color_rgb(163,178,0); // Light green
actionColInd[6] = make_color_rgb(194,94,152); // Cute magenta

mapBackCol = make_color_rgb(54,70,128);

mapCenterX = 0;
mapCenterY = 0;
mapWidth = 20;
mapHeight = 20;
tempMapWidth = mapWidth;
tempMapHeight = mapHeight;
mapFoldOff = 0;
mapSurface = surface_create(mapWidth,mapHeight);
mapSelect = false;

depth = obj_editor_gui.depth - 4;
image_angle = 90;
y = baseY;

fontLight = obj_editor_gui.font;
fontDark = obj_editor_gui.fontDark;
draw_set_font(fontLight);
