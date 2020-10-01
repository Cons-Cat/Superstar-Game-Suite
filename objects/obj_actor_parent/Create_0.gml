/// @description 
str = "actor";

subSteps = 2;
trgRegion = -1;
sceneStep = 0;
sceneLength = sceneStep;
depthPriority = false;

c_hspeed = 0;
c_vspeed = 0;

phy_walkspeed = 1;
phy_runspeed = 1.25;
phy_acceleration = 0.375;
phy_deceleration = 0.2825;
slowSpd = false;
max_speed = phy_runspeed;

phy_acceleration_imp = 0;
phy_deceleration_imp = 0;
phy_acceleration = 0;
phy_deceleration = 0;

spd = 0;
max_speed = 1.25;
imgSpd = 4;
imgIndex = 0;

dirIso = 6;
dirIsoDefault = 6;
tempX = x;
tempY = y;
zDisplace = 0;
rotationInputDirection = 90;

jumpHeight = 0;
maxJumpHeight = 20;
jumpSpeed = 2.1;
jumpBoost = 0;
jumpGrav = 0;
jumpGravVal = 0.36025;
jumpGravMax = 6;

jumpDelayMax = 14;
jumpDelay = jumpDelayMax;
jumpTempHspd = 0;
jumpTempVspd = 0;
jumpPrepDecel = 2;

platOn = 0;
floorTrg = 0;
trgFinal = obj_floor;
trgFinalTemp = -1;

fallSearch = false;
onGround = true;
onStaircase = false;

moving = false;
jumping = false;
jumpAnim = false;
falling = false;
isFalling = false; // Redundant?

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
