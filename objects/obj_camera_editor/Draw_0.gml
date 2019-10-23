/// @description 
draw_set_color(c_black);
draw_rectangle(leftQuarter,upQuarter,rightQuarter,downQuarter,false);

draw_text(leftQuarter,downQuarter+10,accelX);

draw_set_color(c_red);
draw_rectangle(centerX,centerY,centerX,centerY,false);

draw_sprite(sprite_index,0,x,y);
