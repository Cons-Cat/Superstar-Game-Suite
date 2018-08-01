/// @description
moving = false;

for (i = 0; i < instance_number(obj_attackblock); i += 1){
	block[i] = instance_find(obj_attackblock,i);
	
	if block[i].moving = true{
		self.moving = true;
	}
}

if !instance_exists(obj_target){
	if keyboard_check(vk_right){
		if moving = false{
			with obj_attackblock{
				space += 2;
				moving = true;
			}
		}
	}
	if keyboard_check(vk_left){
		if moving = false{
			with obj_attackblock{
				space -= 2;
				moving = true;
			}
		}
	}
}
