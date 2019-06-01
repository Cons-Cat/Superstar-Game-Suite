/// @description Insert description here
draw_set_color(colLight);
draw_rectangle(obj_panel_left.baseX + 10,0,obj_panel_right.baseX - 11,y,false);

draw_set_color(colMid);
draw_rectangle(obj_panel_left.baseX + 10,y - 3,obj_panel_right.baseX - 11,y,false);

draw_set_color(colDark);
draw_rectangle(obj_panel_left.baseX + 10,y - 2,obj_panel_right.baseX - 11,y,false);

draw_rectangle(obj_panel_left.baseX - 2,4,obj_panel_left.baseX - 1,y - 6,false);
draw_rectangle(obj_panel_left.baseX + 289,4,obj_panel_left.baseX + 290,y - 6,false);
draw_rectangle(obj_panel_right.baseX - 2,4,obj_panel_right.baseX - 1,y - 6,false);

draw_set_color(barCol);
draw_rectangle(obj_panel_left.baseX,4,obj_panel_left.baseX + 1,y - 6,false);
draw_rectangle(obj_panel_left.baseX + 291,4,obj_panel_left.baseX + 292,y - 6,false);
draw_rectangle(obj_panel_right.baseX,4,obj_panel_right.baseX + 1,y - 6,false);

draw_set_color(outlineDark);
draw_rectangle(obj_panel_left.baseX + 10,y,obj_panel_right.baseX - 11,y,false);

draw_self();
