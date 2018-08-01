/// @description 
x = index[target].x - 6;
y = index[target].y - 38;

if keyboard_check_pressed(vk_up){
	target -= 1;
}
if keyboard_check_pressed(vk_down){
	target += 1;
}

if target > maxSize{
	target = 0;
}
if target < 0{
	target = maxSize;
}
