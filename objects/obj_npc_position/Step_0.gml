/// @description 
event_inherited();

// Dimensional manipulation
if spawnButtons {
	spawnButtons = false;
	
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_drag) {
		trg = other.id;
	}
	with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z3) {
		trg = other.id;
	}
	with instance_create_layer(x,y+20,"Instances",obj_x_editor) {
		trg = other.id;
	}
	with instance_create_layer(x+20,y+20,"Instances",obj_info_editor) {
		trg = other.id;
	}
}

// Find relevant floor object
trgFinalTemp = 0;

for (i = 0; i < instance_number(obj_editor_terrain); i += 1) {
	trgScr = instance_find(obj_editor_terrain,i).id;
	if trgScr.zfloor*20 <= self.zfloor*20 {
		if collision_point(x,y,trgScr,true,true) {
			trgLayer[i] = trgScr.zfloor;
			for (a = 0; a <= i; a += 1) {
				if trgLayer[a] >= trgFinalTemp {
					trgFinal = trgScr;
					trgFinalTemp = trgLayer[a];
				}
			}
			
			platOn = trgFinal.zfloor*20;
		}
	}
}

if instance_exists(trgFinal) {
	if trgFinal.zfloor = self.zfloor {
		fallSearch = false; // Cancel fall if standing on a platform
		onGround = true;
		//depth = - (trgFinal.y + trgFinal.image_yscale*20 + (trgFinal.zfloor - trgFinal.zcieling)*20) - self.platOn - 1;
	}
}

zcieling = zfloor;

if orangeAnyways {
	layerColor = c_orange;
}
