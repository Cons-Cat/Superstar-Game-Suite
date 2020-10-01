/// @description Collision
if obj_editor_gui.mode = 2 {
	collMaskTrg.x = round(self.x);
	collMaskTrg.y = round(self.y);
	tmpX = collMaskTrg.x;
	tmpY = collMaskTrg.y;
	collMaskTrg.c_hspeed = c_hspeed;
	collMaskTrg.c_vspeed = c_vspeed;
	
	if collMaskTrg.x != tmpX || collMaskTrg.y != tmpY {
		x = collMaskTrg.x;
		y = collMaskTrg.y;
	}
	
	if onStaircase {
		// Override depth algorithm.
		depth = trgFinal.depth - 1;
	} else {
		if platOn = self.jumpHeight {
			depth = obj_editor_gui.depth - trgFinal.y - 20 - trgFinal.zfloor - 3;
		}
	}
}
