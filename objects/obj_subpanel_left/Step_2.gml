/// @description 
if scrollHorRightBound > 136 {
	x = floor((scrollHorRightBound + scrollVerRightBound) / 2);
} else {
	x = scrollHorRightBound - 60;
}

event_inherited();
