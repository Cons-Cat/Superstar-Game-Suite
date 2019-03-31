/// @description Define parameters
event_inherited();

baseX = 191;
dragX = baseX;
moveToX = baseX;
moveToDeccel = 2.45;
moveToSpd = 0;
moveToSpdMin = 0.5;
select = 0;
mouseClickOff = 0;
moveDirection = 1;
doubleClickCounter = 0;
trgXOrigin = 0;

scrollPanelSquish = 0;
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

depth = obj_editor_gui.depth - 2;
x = baseX;

instance_create_layer(x,y,"Instances",obj_subpanel_left);
