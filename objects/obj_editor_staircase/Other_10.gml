/// @description Calculate raster co-ordinates
x1 = x;
y1 = y;
yy1 = y1 + altH;

var xComp = width * 20 * (angleRise);
var yComp = width * 20 * (-angleRun);

x2 = x1 + xComp;
y2 = y1 + yComp;
yy2 = y2 + altH;

xComp = angleRun * staircaseN;
yComp = angleRise * staircaseN;

x3 = x1 + xComp;
y3 = y1 + yComp + (zfloor-zcieling)*20;
yy3 = y3 + altH;

x4 = x2 + xComp;
y4 = y2 + yComp + (zfloor-zcieling)*20;
yy4 = y4 + altH;

staircaseRasterX0 = floor(min(x1, x2, x3, x4)) - 1;
staircaseRasterY0 = floor(min(y1, y2, y3, y4, yy1, yy2, yy3, yy4));
staircaseRasterXF = ceil(max(x1, x2, x3, x4));
staircaseRasterYF = ceil(max(y1, y2, y3, y4));

staircaseW = staircaseRasterXF - staircaseRasterX0 + 2;
staircaseH = staircaseRasterYF - staircaseRasterY0 + 1;
