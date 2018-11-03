/// @description 
camera = camera_create_view(room_width,room_height,320,180,0,obj_camera_editor,-1,-1,350,80);
view_set_camera(0, camera);
camera_set_view_pos(view_camera[0], 0, 0);
camera_set_view_size(view_camera[0], 460, 259);

depth = -room_height - 200;

font = font_add_sprite_ext(spr_font,"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!?,'. ",true,1);
draw_set_font(font);

mode = 0;
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
