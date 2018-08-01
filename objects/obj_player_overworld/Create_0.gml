///@description Initialize variables
scr_cmove_init();
phy_walkspeed = 2;
phy_runspeed = 2.5;
phy_acceleration = 0.75;
phy_deceleration = 0.565;

c_gravity = 0;
dir1 = 1;
max_speed = phy_walkspeed;
raise_pixels = 0;
slopeVOff = 0;
dir = 0;
zplace = 0;
canMove = true;
floorTrg = 0;
trgFinal = obj_floor;
trgFinalTemp = -1;

if room != room_leveleditor {
	if !instance_exists(obj_camera) {
		instance_create_layer(x,y,"Hud",obj_camera);
	}
}

moving = false;
jumpAnim = false;

sprite_index = spr_point;
image_speed = 0.3;

sprD = spr_lucy_down;
sprDDR = spr_lucy_ddownright;
sprDR = spr_lucy_downright;
sprDRR = spr_lucy_rdownright;
sprR = spr_lucy_right;
sprURR = spr_lucy_rupright;
sprUR = spr_lucy_upright;
sprUUR = spr_lucy_uupright;
sprU = spr_lucy_up;

sprDJ = spr_lucy_down_jump;
sprDRJ = spr_lucy_downright_jump;
sprRJ = spr_lucy_right_jump;
sprURJ = spr_lucy_upright_jump;
sprUJ = spr_lucy_up_jump;

sprDWalk = spr_lucy_walk_down;
sprDDRWalk = spr_lucy_walk_ddownright;
sprDRWalk = spr_lucy_walk_downright;
sprDRRWalk = spr_lucy_walk_rdownright;
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

upKey = 0;
rightKey = 0;
downKey = 0;
leftKey = 0;

tempRotSpr = -1;
keysPressed = 0;
dirIso = 1;
rotSpd = 0.5;
rotFin = 0;
rotDir = 1;
rotationInputDirection = 270;

curLayerCol = -1;

check0 = 0;
check1 = 0;

jumpHeight = 0;
maxJumpHeight = 20;
jumpSpeed = 4.2;
jumping = false;
jumpGrav = 0;
jumpGravVal = 0.7205;
jumpGravMax = 12;
platOn = 0;
platOnTemp = platOn;
jumpBoost = 0;
onGround = true;

jumpDelayMax = 7;
jumpDelay = jumpDelayMax;
jumpTempHspd = 0;
jumpTempVspd = 0;
jumpPrepDecel = 4;

glideDelayMax = 25;
glideDelay = glideDelayMax;
boosting = false;
boostSpeed = 3.5;
boostDistance = 40;

debugCol = c_white;
