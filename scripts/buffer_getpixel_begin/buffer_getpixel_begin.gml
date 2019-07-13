/// @description
/// @param {real} surface
var ww = surface_get_width(argument0);
var hh = surface_get_height(argument0);

var buff1 = buffer_create(((ww*hh)*4),buffer_grow,1);
buffer_get_surface(buff1,argument0,0,0,0)

return buff1;