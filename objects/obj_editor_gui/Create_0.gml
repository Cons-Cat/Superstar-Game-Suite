/// @description 
cameraRealGame = camera_create_view(room_width,room_height,512,288,0,obj_camera_editor,-1,-1,512/2+20,288/2+20);
camera = camera_create_view(1024,576,1024,576,0,-1,-1,-1,1024/2+20,576/2+20);
cameraLeftPanel = camera_create_view(1024,0,200,576,0,-1,-1,-1,-1,-1);
cameraLeftSubPanel = camera_create_view(1024,0,200,200,0,-1,-1,-1,-1,-1);
cameraRightPanel = camera_create_view(1024,0,200,200,0,-1,-1,-1,-1,-1);
cameraBotPanel = camera_create_view(1025,453,642,120,0,-1,-1,-1,-1,-1);

view_set_camera(0, cameraRealGame);
view_set_camera(2, cameraLeftPanel);
view_set_camera(3, cameraRightPanel);
view_set_camera(4, cameraBotPanel);
view_set_camera(5, cameraLeftSubPanel);

camera_set_view_pos(cameraLeftPanel,15,86);
camera_set_view_pos(cameraLeftSubPanel,15,362);
camera_set_view_pos(cameraRightPanel,1008,86);
camera_set_view_pos(cameraBotPanel,1025,453);

view_set_xport(2,15);
view_set_yport(2,86);
view_set_yport(3,86);
view_set_yport(4,453);
view_set_xport(5,15);
view_set_yport(5,362);

tempResWidth = 0;
tempResHeight = 0;

depth = 0;

mode = 0;
/*
0 - Collision
1 - Wireframe
2 - Play
3 - Tiling
4 - Triggers
*/
modeGridSpr = spr_grid_editor;
sidePanelCtrl = -1;
spawnedCollisions = false;
rows = 0;

materialsImported = 0;
sprMaterialDirectoryList[0] = "";
sprMaterialDirectoryList[1] = "";
materialDirectorySprite[0] = "";
materialDirectorySprite[1] = "";
hasMaterials = false;

selectInstance = -1;
canChangeSelect = true;
tempDepth = 0;

global.pieceSelected = -1;
global.sprMaterial = spr_tls_rectangle_default;
window_set_fullscreen(false);
font = font_add_sprite_ext(spr_font_new,"abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ!?,'._-1234567890",true,0);
fontDark = font_add_sprite_ext(spr_font_dark,"abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ!?,'._-1234567890",true,0);

colLight = make_color_rgb(35,38,45);
colMid = make_color_rgb(31,34,40);
colDark = make_color_rgb(28,30,36);
outlineDark = make_color_rgb(63,70,87);
outlineLight = make_color_rgb(196,196,196);

global.drawMarble = false;
