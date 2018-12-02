/// @description Draw sprite and shadow
draw_sprite(spr_shadow_small,0,x,y-(platOn));
draw_sprite_ext(spr,imgIndex,x,y-jumpHeight,image_xscale,image_yscale,image_angle,debugCol,1);

draw_rectangle(x,y,x,y,false);
