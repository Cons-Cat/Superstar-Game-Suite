/// @description Calculate raster co-ordinates
x1 = x;
y1 = y;
yy1 = y1 + altH;
x2 = x1 + lengthdir_x( staircaseL, ang );
y2 = y1 + lengthdir_y( staircaseL, ang );
yy2 = y2 + altH;
x3 = x1 + lengthdir_x( staircaseN, normalAng );
y3 = y1 + lengthdir_y( staircaseN, normalAng ) + (zfloor-zcieling)*20;
yy3 = y3 + altH;
x4 = x2 + lengthdir_x( staircaseN, normalAng );
y4 = y2 + lengthdir_y( staircaseN, normalAng ) + (zfloor-zcieling)*20;
yy4 = y4 + altH;

staircaseRasterX0 = floor(min(x1, x2, x3, x4)) - 1;
staircaseRasterY0 = floor(min(y1, y2, y3, y4, yy1, yy2, yy3, yy4));
