/// @description 
draw_set_color(c_red);

gpu_set_blendmode_ext(bm_dest_color, bm_zero); // Multiply blend mode
draw_ellipse(x1+thresholdRadius*20,y1-thresholdRadius*20,x2-thresholdRadius*20,y2+thresholdRadius*20,false);

draw_set_alpha(0.3);
gpu_set_blendmode(bm_normal);
draw_ellipse(x1,y1,x2,y2,false);

draw_set_alpha(1);

draw_set_color(c_black);
draw_ellipse(x1+thresholdRadius*20,y1-thresholdRadius*20,x2-thresholdRadius*20,y2+thresholdRadius*20,true);
draw_ellipse(x1,y1,x2,y2,true);
