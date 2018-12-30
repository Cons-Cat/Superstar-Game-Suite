///The bulk of the custom movement system
col = argument0; //Determines if we should check for collisions or not
cmove_steps += 1; //Adds 1 to the step counter
editing = argument1;

//---
//Fake subpixel system
if scr_decconv(abs(frac(c_hspeed))) != 0 {
    subpix_cap_h = scr_spdosc_timer(0)/scr_decconv(abs(frac(c_hspeed)));
}
if scr_decconv(abs(frac(c_vspeed))) != 0 {
    subpix_cap_v = scr_spdosc_timer(1)/scr_decconv(abs(frac(c_vspeed)));
}

subpix_cap_h = round(subpix_cap_h);
subpix_cap_v = round(subpix_cap_v);

//h
if subpix_timer_h > 0
 {
 subpix_move_h = 0;
 subpix_timer_h--;
 
 if subpix_timer_h > subpix_cap_h
 subpix_timer_h = subpix_cap_h;
 }

else
 {
 if abs(frac(c_hspeed)) > 0
 subpix_move_h = sign(c_hspeed);
 
 subpix_timer_h = subpix_cap_h;
 }
 
//v
if subpix_timer_v > 0
 {
 subpix_move_v = 0;
 subpix_timer_v -= 1;
 
 if subpix_timer_v > subpix_cap_v
 subpix_timer_v = subpix_cap_v;
 }

else
 {
 if abs(frac(c_vspeed)) > 0
 subpix_move_v = sign(c_vspeed);
 
 subpix_timer_v = subpix_cap_v;
 }

// Fix potential -0 bugs
if c_hspeed == -0 {
	c_hspeed = 0;
}

//Determines the number of pixels to move
add_x = c_hspeed+c_hspeed_misc+subpix_move_h+c_hspeed_slope;
add_y = c_vspeed+c_vspeed_misc+subpix_move_v;

//Gravity
if not c_vspeed_fr
&& editing = 0
c_vspeed += c_gravity;

//Store the speed variables before the collision
c_hspeed_last = c_hspeed;
c_vspeed_last = c_vspeed;

//Horizontal movement
for(var mv_h = 0;mv_h < floor(abs(add_x));mv_h++)
 {
 cmove_substeps += 1;
 
 if col == 1 {
	scr_collision();
 }
 x += sign(add_x);
 }

//Vertical movement
for(var mv_v = 0;mv_v < floor(abs(add_y));mv_v++)
 {
 cmove_substeps += 1;
 
 if col == 1
 && editing == 0
 scr_collision();
 
 y += sign(add_y);
 }

//Failsafe collision for if the player isn't moving
if col == 1
&& editing = 0
scr_collision();
