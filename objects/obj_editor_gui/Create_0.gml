/// @description 
cameraRealGame = camera_create_view(room_width,room_height,512,288,0,obj_camera_editor,-1,-1,512/2+20,288/2+20);
//camera = camera_create_view(1024,576,1024,576,0,-1,-1,-1,1024/2+20,576/2+20);
view_set_camera(0, cameraRealGame);
//view_set_camera(1, camera);
camera_set_view_pos(view_camera[0], 0, 580);
camera_set_view_size(view_camera[0], 512, 288);
//camera_set_view_pos(view_camera[1], 0, 0);
//camera_set_view_size(view_camera[1], 1024, 576);
surf = 0;
surf2 = 0;

depth = -room_height - 200;

font = font_add_sprite_ext(spr_font,"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!?,'. ",true,1);
draw_set_font(font);

mode = 0;
sidePanelCtrl = -1;
spawnedCollisions = false;
iTemp = 0;
rows = 0;

materialsImported = 0;
sprMaterialDirectoryList[0] = "";
sprMaterialDirectoryList[1] = "";
materialDirectorySprite[0] = "";
materialDirectorySprite[1] = "";
hasMaterials = false;

global.pieceSelected = -1;
global.sprMaterial = spr_tls_rectangle_default;
