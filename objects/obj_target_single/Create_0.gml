/// @description 
for (i = 0; i < instance_number(obj_enemy_parent); i += 1){
	index[i] = instance_find(obj_enemy_parent,i);
	maxSize = i;
}

target = 0;
depth = -100;
