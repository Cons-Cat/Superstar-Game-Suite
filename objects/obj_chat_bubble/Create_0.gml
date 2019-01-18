/// @description Initialize variables
event_inherited();

canScrawl = false;
time = 1;
corner = 8;
speakerHeightY = 0;
trg = -1;
scaleState = 0;
scale = 0.42;
arrowScale = 0.42;
rSide = 0;
lSide = 0;
tSide = 0;
bSide = 0;
outAlpha = 0.45;
inAlpha = 0.35;
bounceState = 0;
bounceYOff = 0;
bounceYSpd = -1.95;

black = make_color_rgb(22,22,20);
green = make_color_rgb(148,175,65);
red = make_color_rgb(210,74,84);
pink = make_color_rgb(172,85,209);
blue = make_color_rgb(64,139,209);

self.canMove = false;

alarm[0] = 2;
