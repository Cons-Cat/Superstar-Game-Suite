/// @description Define parameters
event_inherited();

cameraViewOn = 5;
baseY = obj_panel_bot.y - 144;
dragY = baseY;
moveToY = baseY;
moveToDeccel = 2.45;
moveToSpd = 0;
moveToSpdMin = 0.5;
select = false;
mouseClickOff = 0;
moveDirection = 1;
doubleClickCounter = 0;
trgXOrigin = 0;
mousePeek = 0;
calculateHeight = false;
tempY = -1;
longestPanelRightButton = 0;
longestSprWidth = 0;
anchored = false;

panelWidth = 0;
panelHeight = 0;

scrollHorX = 0;
scrollVerY = 0;
scrollHorPartition = 0;
scrollVerPartition = 0;
scrollHorSelect = false;
scrollVerSelect = false;
scrollPanelHorDefined = false;
scrollPanelVerDefined = false;
scrollPanelDefined = false;
scrollHorWidth = panelWidth;
scrollVerHeight = panelHeight;
tilesWidthIterate = 0;

scrollHorLeftBound = 16;
scrollHorRightBound = x - 1;
scrollHorTopBound = 70;
scrollHorBotBound = 85;

scrollVerLeftBound = 0;
scrollVerRightBound = 15;
scrollVerTopBound = 86;
scrollVerBotBound = 419;

hasScrollHor = false;

depth = obj_editor_gui.depth - 3;
image_angle = 90;
y = baseY;
