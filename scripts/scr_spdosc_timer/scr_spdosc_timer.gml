/// @description scr_spdosc_timer(vertical speed)
/// @function scr_spdosc_timer
/// @param vertical speed

//Horizontal
if argument0 == 0
var calc_speed = abs(frac(c_hspeed));
//Vertical
if argument0 == 1
var calc_speed = abs(frac(c_vspeed));

if calc_speed >= 0.1
return 10;

else
return 20;
