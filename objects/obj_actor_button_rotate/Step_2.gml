/// @description 
event_inherited();

if select {
	select = false;
	
	if !instance_exists(obj_actor_rotate_target) {
		with instance_create_layer(trg.x+10,trg.y+10,"Instances",obj_actor_rotate_target) {
			canPlace = false;
			canDel = true;
			calcAngleVals = true;
			
			trg = other.trg; // obj_npc_editor
			
			zfloor = trg.zfloor;
			angle = other.angle;
		}
	}
}
