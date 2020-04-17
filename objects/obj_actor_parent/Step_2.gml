/// @description Collision
collMaskTrg.x = round(self.x);
collMaskTrg.y = round(self.y);
tmpX = collMaskTrg.x;
tmpY = collMaskTrg.y;
collMaskTrg.c_hspeed = c_hspeed;
collMaskTrg.c_vspeed = c_vspeed;
collMaskTrg.collisionCoeffX = collisionCoeffX;
collMaskTrg.collisionCoeffY = collisionCoeffY;

with collMaskTrg {
	depth = obj_editor_gui.depth - 100;
	scr_collision();
}

if collMaskTrg.x != tmpX || collMaskTrg.y != tmpY {
	x = collMaskTrg.x;
	y = collMaskTrg.y;
}
