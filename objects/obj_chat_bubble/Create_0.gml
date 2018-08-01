/// @description Initialize variables
event_inherited();

width = 7;
height = 3;
placex = x;
placey = y;

time = 1;
corner = 8;
speakerHeightY = 0;
trg = -1;

green = make_color_rgb(148,175,65);
red = make_color_rgb(210,74,84);
pink = make_color_rgb(172,85,209);
blue = make_color_rgb(64,139,209);

self.canMove = false;

//layer = layer_get_id("Hud");
depth = -room_height; // Draw on top of all terrain

alarm[0] = 2;
