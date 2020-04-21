/// @description 
str = "actor";

trgRegion = -1;
sceneStep = 0;
sceneLength = sceneStep;
dir = -1;
activeInScene = false;

c_hspeed = 0;
c_vspeed = 0;
spd = 0;
max_speed = 1.25;
dirIso = 6;
dirIsoDef = dirIso;
zfloor = 0;
tempX = x;
tempY = y;
rotationInputDirection = 90;

moving = false;
jumping = false;

sprD = spr_ph_down;
sprDDR = spr_ph_ddownright;
sprDR = spr_ph_downright;
sprDRR = spr_ph_rdownright;
sprR = spr_ph_right;
sprURR = spr_ph_rupright;
sprUR = spr_ph_upright;
sprUUR = spr_ph_uupright;
sprU = spr_ph_up;

sprDWalk = spr_ph_down;
sprDDRWalk = spr_ph_ddownright;
sprDRWalk = spr_ph_downright;
sprDRRWalk = spr_ph_rdownright;
sprRWalk = spr_ph_right;
sprURRWalk = spr_ph_rupright;
sprURWalk = spr_ph_upright;
sprUURWalk = spr_ph_uupright;
sprUWalk = spr_ph_up;

spr = sprD;

collMaskTrg = instance_create_layer(x,y,"Instances",obj_collision_handler);
maskRadius = 8;
