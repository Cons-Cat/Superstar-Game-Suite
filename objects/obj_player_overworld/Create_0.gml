///@description Initialize variables
event_inherited();

phy_walkspeed = 1;
phy_runspeed = 1.25;
phy_acceleration = 0.375;
phy_deceleration = 0.2825;
slowSpd = false;
max_speed = phy_runspeed;

dir = 0;
canMove = true;
floorTrg = 0;
trgFinal = obj_floor;
trgFinalTemp = -1;
trg = -1;
isFalling = false;

imgSpd = 4;
imgIndex = 0;

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

_left = vk_left;
_right = vk_right;
_up = vk_up;
_down = vk_down;
_A = ord("Z");
_B = ord("X");

tempRotSpr = -1;
keysPressed = 0;
dirIso = 6; // South
rotSpd = 0.5;
rotFin = 0; // South
rotDir = 1;
rotationInputDirection = 270;

moving = false;
jumpAnim = false;

jumpHeight = 0;
maxJumpHeight = 20;
jumpSpeed = 2.1;
jumping = false;
fallSearch = false;
falling = false;
jumpGrav = 0;
jumpGravVal = 0.36025;
jumpGravMax = 6;
platOn = 0;
jumpBoost = 0;
onGround = true;
onStaircase = false;

jumpDelayMax = 14;
jumpDelay = jumpDelayMax;
jumpTempHspd = 0;
jumpTempVspd = 0;
jumpPrepDecel = 2;

glideDelayMax = 12.5;
glideDelay = glideDelayMax;
/*boosting = false;
boostSpeed = 3.5;
boostDistance = 40;*/

debugCol = c_white;
