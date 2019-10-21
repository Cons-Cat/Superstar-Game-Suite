/// @description Handle scrollbars
if scrollHorRightBound > 136 {
	x = floor((scrollHorRightBound + scrollVerRightBound) / 2);
} else {
	x = scrollHorRightBound - 60;
}

onBase = obj_panel_left.onBase;

// Scrollbars
scrollHorLeftBound = obj_panel_left.scrollHorLeftBound;
scrollHorRightBound = obj_panel_left.scrollHorRightBound;

scrollVerLeftBound = room_width;
scrollVerRightBound = room_width + 15;
scrollVerTopBound = y + 5;
scrollVerBotBound = obj_panel_bot.y - 1;

// Fold scrollbars with the panel
if obj_panel_left.relativeX <= 16 {
	obj_subpanel_left.scrollVerRightBound = obj_panel_left.x-1;
}

event_inherited();
