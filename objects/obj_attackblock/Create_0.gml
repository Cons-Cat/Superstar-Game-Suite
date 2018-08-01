/// @description 
blockx[0] = 33;
blocky[0] = 0;

blockx[2] = 40;
blocky[2] = 12;

blockx[4] = 22;
blocky[4] = 22;

blockx[6] = 3;
blocky[6] = 12;

blockx[8] = 11;
blocky[8] = 0;

spr = spr_orb_jump_lucy;
image_speed = 0;

img = 0;
space = 0;
spaceTemp = 0;
spd = 4;
txt = "Test";
spawn = 0;
raise = 0;
moving = false;
event = false;

_select = ord("X");
_back = ord("Z");

with instance_create_layer(x,y,"Instances",obj_attackblock_shadow){
	trg = other.id;
}
