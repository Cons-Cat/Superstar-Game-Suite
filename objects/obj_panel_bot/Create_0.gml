/// @description Insert description here
event_inherited();

botPanelY = 0;
baseY = 420;
dragY = baseY;
moveToY = baseY;
moveToDeccel = 2.45;
moveToSpd = 0;
moveToSpdMin = 0.5;
select = false;
mouseClickOff = 0;
moveDirection = 1;
doubleClickCounter = 0;
trg = -1;
trgXOrigin = 0;
cameraViewOn = 4;

scrollPanelSquish = 0;
panelWidth = 0;
panelHeight = 0;
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
scrollHorRightBound = 832;

scrollVerLeftBound = 3;
scrollVerRightBound = 20;
scrollVerBotBound = 572;

rows = 0;
selectRow[0] = false;
cutsceneInstanceId = -1;
rowLength[0] = 0;
hasRowSelected = false;

totalActions = 0;
actionInd[0] = -1; // Null action
actionRowInd[0] = 0;
addClick = -1;
actionDoubleClick = 0;

depth = obj_editor_gui.depth - 4;
image_angle = 90;
y = baseY;

fontLight = obj_editor_gui.font;
fontDark = obj_editor_gui.fontDark;
draw_set_font(fontLight);
