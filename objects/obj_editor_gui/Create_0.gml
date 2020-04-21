/// @description Initialize important fields.
depth = 0;

// Camera views.
#region

cameraRealGame = camera_create_view(room_width,room_height,512,288,0,obj_camera_editor,-1,-1,512/2+20,288/2+20);
camera = camera_create_view(1024,576,1024,576,0,-1,-1,-1,1024/2+20,576/2+20);
cameraLeftPanel = camera_create_view(1024,0,200,576,0,-1,-1,-1,-1,-1);
cameraLeftSubPanel = camera_create_view(1024,0,200,200,0,-1,-1,-1,-1,-1);
cameraRightPanel = camera_create_view(1024,0,200,200,0,-1,-1,-1,-1,-1);
cameraBotPanel = camera_create_view(1025,453,642,120,0,-1,-1,-1,-1,-1);
cameraBotPanelActors = camera_create_view(1025,453,642,120,0,-1,-1,-1,-1,-1);

view_set_camera(0, cameraRealGame);
view_set_camera(2, cameraLeftPanel);
view_set_camera(3, cameraRightPanel);
view_set_camera(4, cameraBotPanel);
view_set_camera(5, cameraLeftSubPanel);
view_set_camera(6, cameraBotPanelActors);

camera_set_view_pos(cameraLeftPanel,15,86);
camera_set_view_pos(cameraLeftSubPanel,15,362);
camera_set_view_pos(cameraRightPanel,1008,86);
camera_set_view_pos(cameraBotPanel,1025,453);
camera_set_view_pos(cameraBotPanelActors,1025,453);

view_set_xport(2,15);
view_set_yport(2,86);
view_set_yport(3,86);
view_set_yport(4,453);
view_set_xport(5,15);
view_set_yport(5,362);

#endregion

// Window.
#region

calcWindowWidth = window_get_width();
calcWindowHeight = window_get_height();

tempResWidth = 0;
tempResHeight = 0;

windowWRatio = 0;

is4K = false;
window_set_fullscreen(false);

#endregion

// Editor state.
#region

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

selectInstance = -1;
canChangeSelect = true;
tempDepth = 0;

global.pieceSelected = -1;
global.snapDimension = 20;

#endregion

// Aesthetics values.
#region

font = font_add_sprite_ext(spr_font,"abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ!?,'._-1234567890",true,0);
fontDark = font_add_sprite_ext(spr_font_dark,"abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ!?,'._-1234567890",true,0);

// Interface colors
colLight = make_color_rgb(35,38,45);
colMid = make_color_rgb(31,34,40);
colDark = make_color_rgb(28,30,36);
outlineDark = make_color_rgb(63,70,87);
outlineLight = make_color_rgb(196,196,196);
outlineOrange = make_color_rgb(38,15,14);

colOffWhite = make_color_rgb(200,210,243);
colOrangeBright = make_color_rgb(237,199,135);
colOrange = make_color_rgb(232,180,89);
colOrangeShadow = make_color_rgb(168,125,50);

colBlueBright = make_color_rgb(59,77,142);
colBlue = make_color_rgb(54,70,128);
colBlueShadow = make_color_rgb(46,60,109);

// Z Layer colors
col[0] = make_color_rgb(204,53,78); // Red
col[1] = make_color_rgb(212,100,56); // Dark orange
col[2] = make_color_rgb(219,164,37); // Yellow
col[3] = make_color_rgb(162,216,44); // Light green
col[4] = make_color_rgb(102,142,27); // Dark green
col[5] = make_color_rgb(0,180,108); // Aqua
col[6] = make_color_rgb(56,107,203); // Blue
col[7] = make_color_rgb(147,71,198); // Purple
col[8] = make_color_rgb(214,79,196); // Pink

#endregion

// Collision bakes.
#region

collMaskDict = ds_map_create();
collMaskDict[?"spr_coll_rect"] = spr_coll_rect;

#endregion
