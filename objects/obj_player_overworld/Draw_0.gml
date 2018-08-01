/// @description Draw sprite and shadow
draw_sprite(spr_shadow_small,0,x,y-(platOn));
draw_sprite_ext(spr,image_index,x,y-jumpHeight,image_xscale,image_yscale,image_angle,debugCol,1);
//draw_sprite(mask_index,0,x,y);

/*	draw_text(x,y,"jumpTempHspd: " + string(jumpTempHspd));
draw_text(x,y+20,"jumpTempVspd: " + string(jumpTempVspd));
draw_text(x,y+40,"c_hspeed: " + string(c_hspeed));
draw_text(x,y+60,"c_vspeed: " + string(c_vspeed));
