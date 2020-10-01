///@description Initialize variables
event_inherited();

dir = 0;
canMove = true; // REDUNDANT!! 
trg = -1;

if room != room_leveleditor {
	if !instance_exists(obj_camera) {
		instance_create_layer(x,y,"Hud",obj_camera);
	}
}

image_speed = 0.15;

sprD = spr_lucy_down;
sprDDR = spr_lucy_ddownright;
sprDR = spr_lucy_downright;
sprDRR = spr_lucy_rdownright;
sprR = spr_lucy_right;
sprURR = spr_lucy_rupright;
sprUR = spr_lucy_upright;
sprUUR = spr_lucy_uupright;
sprU = spr_lucy_up2;

sprDJ = spr_lucy_down_jump;
sprDRJ = spr_lucy_downright_jump;
sprRJ = spr_lucy_right_jump;
sprURJ = spr_lucy_upright_jump;
sprUJ = spr_lucy_up_jump;

sprDWalk = spr_lucy_walk_down;
sprDDRWalk = spr_lucy_walk_ddownright;
sprDRWalk = spr_lucy_walk_downright;
sprDRRWalk = spr_lucy_walk_rdownright2;
sprRWalk = spr_lucy_walk_right;
sprURRWalk = spr_lucy_walk_rupright;
sprURWalk = spr_lucy_walk_upright;
sprUURWalk = spr_lucy_walk_uupright;
sprUWalk = spr_lucy_walk_up;

spr = sprDR;

tempRotSpr = -1;
keysPressed = 0;
dirIso = 6; // South
rotSpd = 0.5;
rotFin = 0; // South
rotDir = 1;
rotationInputDirection = 270;

glideDelayMax = 12.5;
glideDelay = glideDelayMax;
/*boosting = false;
boostSpeed = 3.5;
boostDistance = 40;*/

debugCol = c_white;
