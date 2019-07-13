var zz = argument0;
var r=0,b=0,g=0;

var waterLevel = 60;

if(zz < waterLevel){
    b = 50 + (zz / waterLevel) * 200;
}else{
    g = 50 + ((zz - waterLevel) / (100-waterLevel)) * 200;
}

return make_color_rgb(r,g,b);
