/// @description Draw sprite and shadow
gpu_set_blendmode(bm_dest_color);
draw_sprite_ext(spr_shadow_small,0,x,y-(platOn),1,1,0,c_white,0.75); // Shadow

gpu_set_blendmode(bm_normal);
draw_sprite_ext(spr,imgIndex,x,y-jumpHeight,image_xscale,image_yscale,image_angle,debugCol,1);

draw_rectangle(x,y,x,y,false);
