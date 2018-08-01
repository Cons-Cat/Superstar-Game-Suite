/// @description 
if state = 0{
	if obj_battle_control.turn = self.initiative{
		attackInited = 0;
		
		if ally = true{
			//Select attack block
		
		}
		if ally = false {
			//AI chooses attack
			attackScrIndex = attackList[irandom(attackListSize)];
			attackScr = attackList[attackScrIndex];
			attackScrInit = attackList[attackScrIndex];
			attackTarget = irandom(instance_number(obj_ally_parent));
			
			for (i = 0; i < instance_number(obj_ally_parent); i += 1){
				if irandom(2) = 0{ //  1/3rd chance
					attackTarget = instance_nth_nearest(x,y,obj_ally_parent,i);
					state = 1;
				}
			}
		}
	}
}

if state = 1{
	if attackInited = 0{
		script_execute(attackScrInit,attackTarget);
		attackInited = 1;
	}
	
	script_execute(attackScr,attackTarget);
}

if state = 2{
	attackInited = 0;
	if ally = true{
		//Counter attack
	}
	if hp = 0{
		state = 3;
	}
}

if state = 3{
	if obj_battle_control.turn = self.initiative{
		obj_battle_control.turn += 1;
	}
}
