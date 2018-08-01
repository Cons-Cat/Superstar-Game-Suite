///Sets up variables used in the custom movement system
c_hspeed = 0; //Horizontal speed
c_vspeed = 0; //Vertical speed
c_hspeed_fr = 0; //If the object's horizontal speed is frozen
c_vspeed_fr = 0; //If the object's vertical speed is frozen
c_hspeed_last = 0; //The object's horizontal speed before collisions were evaluated
c_vspeed_last = 0; //The object's vertical speed before collisions were evaluated
c_hspeed_carry = 0; //When the object's horizontal speed is frozen, this stores what it was before the freeze
c_vspeed_carry = 0; //Same as c_hspeed_carry, but with vertical speed
c_hspeed_hascarry = 0; //Boolean that determines if the object already had its speed stored
c_vspeed_hascarry = 0; //Same as c_hspeed_hascarry
c_hspeed_misc = 0; //Horizontal speed for things like conveyor belts that move the object independently from the player's input
c_vspeed_misc = 0; //Same as c_hspeed_misc
c_hspeed_slope = 0; //Horizontal speed for steep slope that move the object independently from the player's input
c_gravity = 0; //Gravity
add_x = 0; //The total number of pixels to move the player horizontally, counting for both c_hspeed and c_hspeed_misc
add_y = 0; //Same as add_x
in_air = true; //If there is a surface below the player from which they can jump

//Timing stuff
cmove_steps = 0; //Number of steps elapsed
cmove_substeps = 0; //Number of "mini-steps" elapsed

subpix_cap_h = 10;
subpix_timer_h = 10;
subpix_move_h = 0;

subpix_cap_v = 10;
subpix_timer_v = 10;
subpix_move_v = 0;
