/// @description Collision
collMaskTrg.x = round(self.x);
collMaskTrg.y = round(self.y);
tmpX = collMaskTrg.x;
tmpY = collMaskTrg.y;
collMaskTrg.c_hspeed = c_hspeed;
collMaskTrg.c_vspeed = c_vspeed;

/*with collMaskTrg {
	depth = obj_editor_gui.depth - 100;
	scr_collision_mask();
}*/

if collMaskTrg.x != tmpX || collMaskTrg.y != tmpY {
	x = collMaskTrg.x;
	y = collMaskTrg.y;
}