///arc_calc_xspeed(yspeed, gravity, spawn_x, spawn_y, impact_x, impact_y)
var t_yspeed = argument[0];
var t_grav = argument[1];
var t_spawn_x = argument[2];
var t_spawn_y = argument[3];
var t_impact_x = argument[4];
var t_impact_y = argument[5];

var t_y = t_spawn_y, t_yprev = t_y, time = 0;
do {
    time++;
    t_yprev = t_y;
    t_y += t_yspeed;
    t_yspeed += t_grav;
}
until (t_y >= t_impact_y && t_yprev < t_impact_y) || (t_yspeed > 0 && t_y > t_impact_y);

return (t_impact_x - t_spawn_x) / time;

///Credit 'DJ Coco'
