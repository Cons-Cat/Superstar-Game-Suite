// Initialize variables
var x1 = argument[0];
var y1 = argument[1];
var x2 = argument[2];
var y2 = argument[3];
var selState = argument[4];

var colInside;
var colOutLine;
var colInLine;
var colHighlight
var colShadow;

var subImg;

// Pass in colors
if selState = 0 {
	colInside = obj_editor_gui.colBlue;
	colOutLine = obj_editor_gui.outlineDark;
	colInLine = obj_editor_gui.colDark;
	colHighlight = obj_editor_gui.colBlueBright;
	colShadow = obj_editor_gui.colBlueShadow;
	
	subImg = 0;
}

if selState = 1 {
	colInside = obj_editor_gui.colOrange;
	colOutLine = obj_editor_gui.outlineDark;
	colInLine = obj_editor_gui.colDark;
	colHighlight = obj_editor_gui.colOrangeBright;
	colShadow = obj_editor_gui.colOrangeShadow;
	
	subImg = 0;
}

if selState = 2 {
	colInside = obj_editor_gui.colOrange;
	colOutLine = obj_editor_gui.colOffWhite;
	colInLine = obj_editor_gui.outlineOrange;
	colHighlight = obj_editor_gui.colOrangeBright;
	colShadow = obj_editor_gui.colOrangeShadow;
	
	subImg = 1;
}

// Inside fill
draw_set_color(colInside);
draw_rectangle(x1+3,y1+1,x2-2,y2-3,false);

draw_set_color(colHighlight);
draw_rectangle(x1+3,y1+1,x2-2,y1+3,false);

draw_set_color(colShadow);
draw_rectangle(x1+3,y2-2,x2-2,y2-3,false);
draw_rectangle(x1+3,y1+4,x1+3,y2-4,false);
draw_rectangle(x2-2,y1+4,x2-2,y2-4,false);

// Outside outline
draw_set_color(colOutLine);
draw_rectangle(x1+2,y1,x2-1,y1,false);
draw_rectangle(x1+2,y2-1,x2-1,y2-1,false);

draw_rectangle(x1+1,y1+1,x1+1,y2-2,false);
draw_rectangle(x2,y1+1,x2,y2-2,false);

// Inside outline
draw_set_color(colInLine);
draw_rectangle(x1+3,y1+1,x2-2,y1+1,false);
draw_rectangle(x1+3,y2-2,x2-2,y2-2,false);

draw_rectangle(x1+2,y1+2,x1+2,y2-3,false);
draw_rectangle(x2-1,y1+2,x2-1,y2-3,false);

// Corners
draw_sprite(spr_button_corner,subImg,x1+3,y1+2);
draw_sprite_ext(spr_button_corner,subImg,x1+3,y2-2,1,-1,0,c_white,1);
draw_sprite_ext(spr_button_corner,subImg,x2-1,y1+2,-1,1,0,c_white,1);
draw_sprite_ext(spr_button_corner,subImg,x2-1,y2-2,-1,-1,0,c_white,1);
