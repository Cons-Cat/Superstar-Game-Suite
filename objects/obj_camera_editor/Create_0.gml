/// @description 
tempX = x;
tempY = y;

placeX = x;
placeY = y;
placeZ = 0;

accelX = 0;
accelY = 0;
accelZ = 0;

leftQuarter = 0;
upQuarter = 0;
rightQuarter = 0;
downQuarter = 0;
centerX = 0;
centerY = 0;

vm = matrix_build_lookat(x,y,-10,x,y,-0,0,1,0);
pm = matrix_build_projection_ortho(512,288,1,10000);

camera_set_view_mat(obj_editor_gui.cameraRealGame,vm);
camera_set_proj_mat(obj_editor_gui.cameraRealGame,pm);

follow = obj_player_overworld;
xTo = x;
yTo = y;

spasmX[0] = 0;
spasmX[1] = 0;
spasmX[2] = 1;
spasmFix = false;

i = 0;
moving[0] = false;
panAngle = 0;
panAngleTemp = 0;
panMagnitude = 0;
panMagnitudeTemp = panMagnitude;
panMagnitudeSpd = 0;
trgRegion = -1;

view_visible[2] = false;
view_visible[3] = false;
