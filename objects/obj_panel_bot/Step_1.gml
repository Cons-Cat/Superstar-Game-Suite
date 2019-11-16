/// @description Replace the map surface
event_inherited();

// Replace map
if !surface_exists(mapSurface) {
	mapSurface = surface_create(mapWidth,mapHeight);
}
