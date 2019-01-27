/// @description Insert description here
if gone {
	// Draw backdrop
	draw_set_color(col1);
	draw_rectangle(x-11,y-51,x+11,y-27,false);
	
	// Draw direction display
	draw_set_color(col2);
	draw_line(x,y-41,x+lengthdir_x(10,panAngle),y-41+lengthdir_y(10,panAngle));
	
	// Draw connection cable
	draw_sprite_ext(spr_interface_panel_line_ver,0,x,y,1,pointY-10-y,0,c_white,1);
	draw_sprite(spr_interface_panel_line_curve,0,x,pointY-10);
	draw_sprite_ext(spr_interface_panel_line_hor,0,x+5,pointY-7,pointX-15-x,1,0,c_white,1);
	
	// Draw menu
	draw_sprite(sprite_index,0,x,y);
	
	// Draw incrementation buttons
	for (i = 0; i <= 2; i += 1) {
		// Offsets
		if i = 0 {
			xOffButtons = 0;
			yOffButtons = 0;
		}
		if i = 1 {
			xOffButtons = 78;
			yOffButtons = 0;
		}
		if i = 2 {
			xOffButtons = 78;
			yOffButtons = 25;
		}
		
		draw_sprite(spr_camera_integer_button,arrowSelect[0,i],x-11+xOffButtons,y-21-yOffButtons);
		draw_sprite(spr_camera_integer_button,arrowSelect[1,i],x-3+xOffButtons,y-21-yOffButtons);
		draw_sprite(spr_camera_integer_button,arrowSelect[2,i],x+8+xOffButtons,y-21-yOffButtons);
		draw_sprite(spr_camera_integer_button,arrowSelect[3,i],x+16+xOffButtons,y-21-yOffButtons);
		
		draw_sprite_ext(spr_camera_integer_button,arrowSelect[4,i],x-11+xOffButtons,y-7-yOffButtons,1,-1,0,c_white,1);
		draw_sprite_ext(spr_camera_integer_button,arrowSelect[5,i],x-3+xOffButtons,y-7-yOffButtons,1,-1,0,c_white,1);
		draw_sprite_ext(spr_camera_integer_button,arrowSelect[6,i],x+8+xOffButtons,y-7-yOffButtons,1,-1,0,c_white,1);
		draw_sprite_ext(spr_camera_integer_button,arrowSelect[7,i],x+16+xOffButtons,y-7-yOffButtons,1,-1,0,c_white,1);
	}
	
	// Draw magnitude values
	draw_set_color(c_white);
	
	for (i = 0; i <= 2; i += 1) {
		// Offsets
		if i = 0 {
			xOffButtons = 0;
			yOffButtons = 0;
		}
		if i = 1 {
			xOffButtons = 78;
			yOffButtons = 0;
		}
		if i = 2 {
			xOffButtons = 78;
			yOffButtons = 25;
		}
		
		draw_text(x-14+xOffButtons,y-18-yOffButtons,val[0,i]);
		draw_text(x-6+xOffButtons,y-18-yOffButtons,val[1,i]);
		draw_text(x+5+xOffButtons,y-18-yOffButtons,val[2,i]);
		draw_text(x+13+xOffButtons,y-18-yOffButtons,val[3,i]);
	}
	
	// Draw easing values
	draw_sprite(spr_camera_slider,sliderSelect[0],x + 25 + (easeOutSliderVal/20)*34,y - 41);
	draw_sprite(spr_camera_slider,sliderSelect[1],x + 25 + (easeInSliderVal/20)*34,y - 16);
}
