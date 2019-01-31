/// @description Insert description here
event_inherited();

// Spawn collision mask
with instance_create_layer(x,y,"Instances",obj_npc_mask_vert) {
	trg = other.id;
}
