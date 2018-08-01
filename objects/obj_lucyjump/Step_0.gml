/// @description 
event_inherited();

if event = true{
	if !instance_exists(obj_target_single){
		if obj_lucy_battle.attackScr = 0{
			instance_create_layer(0,0,"Instances",obj_target_single); //Select jump attack
		}
	} else { //Execute jump attack
		obj_lucy_battle.state = 1;
		obj_lucy_battle.attackScr = scr_jumplucy;
		obj_lucy_battle.attackScrInit = scr_jumplucy_init;
		obj_lucy_battle.attackTarget = obj_target.index[obj_target.target];
		
		with obj_target{
			instance_destroy();
		}
	}
	
	event = false;
}
