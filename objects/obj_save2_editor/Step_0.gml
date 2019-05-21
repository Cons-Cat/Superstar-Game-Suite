/// @description 
if select = 1 {
var saveFile;
//roomId = rL+rL+rL+rN+rL+rL+rN+rN+"A"//+rN+rN+rN+rN+"-"+rN+rL+rL+rN+"-"+rN+rN+rN+rN+rL+rN+rN+rL+rN+rN+rN+rL;
roomId[0] = ""; // ID at the top of the file
roomId[1] = ""; // ID at the bottom of the file
roomId[2] = ""; // ID for views
roomId[3] = ""; // ID for view[0]
roomId[4] = ""; // ID for view[1]
roomId[5] = ""; // ID for view[2]
roomId[6] = ""; // ID for view[3]
roomId[7] = ""; // ID for view[4]
roomId[8] = ""; // ID for view[5]
roomId[9] = ""; // ID for view[6]
roomId[10] = ""; // ID for view[7]
roomId[11] = ""; // ID physics
roomId[12] = ""; // ID view settings
textWrite = "";

// Generate a hexadecimal key
for (j = 0; j <= 12; j += 1) {
	for (i = 0; i < 36; i += 1) {
		if i = 8 || i = 13 || i = 18 || i = 23 {
			roomId[j] = roomId[j] + "-";
		} else {
			roomId[j] = roomId[j] + choose("a","b","c","d","e","f","0","1","2","3","4","5","6","7","8","9");
		}
	}
}
			
layerId[0] = "Hud"
layerId[0] = "Instances"

// Generate a hexadecimal key
for (j = 0; j <= 2; j += 1) {
	layerId[j] = "";
	for (i = 0; i < 36; i += 1) {
		if i = 8 || i = 13 || i = 18 || i = 23 {
			layerId[j] = layerId[j] + "-";
		} else {
			layerId[j] = layerId[j] + choose("a","b","c","d","e","f","0","1","2","3","4","5","6","7","8","9");
		}
	}
}

// Save level
saveFile = get_save_filename_ext("Game Maker Format|*.yy", "", working_directory + "\Room Saves\ ", "README: MUST BE NAMED: " + obj_room_editor.str);
if saveFile != "" {
export = file_text_open_write(saveFile);

// Write room name
textWrite = textWrite + string_hash_to_newline("#{#"+chr(9)+chr(34)+"name"+chr(34)+": "+chr(34)+obj_room_editor.str+chr(34)+",");
				
// Write room id
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(34)+"id"+chr(34)+": "+chr(34)+roomId[0]+chr(34)+",");
				
// Write empty creation coded
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(34)+"creationCodeFile"+chr(34)+": "+chr(34)+chr(34)+",");
				
// Write empty inheritance
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(34)+"inheritCode"+chr(34)+": false,");
			
// Write empty creation order
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(34)+"inheritCreationOrder"+chr(34)+": false,");
			
// Write empty layer inheritance
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(34)+"inheritLayers"+chr(34)+": false,");
			
// Write instance creation order IDs
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(34)+"instanceCreationOrderIDs"+chr(34)+": [");
if instance_number(obj_editor_terrain) = 0 {
	textWrite = textWrite + string_hash_to_newline("#");
} else {
	for (i = 0; i < instance_number(obj_editor_terrain); i += 1) {
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+instance_find(obj_editor_terrain,i).instId2+chr(34)+","); // Graphics terrain
		if instance_find(obj_editor_terrain,i).zfloor > 0 {
			textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+instance_find(obj_editor_terrain,i).instId5[0]+chr(34)+","); // Front walls terrain
			textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+instance_find(obj_editor_terrain,i).instId5[3]+chr(34)+","); // Back walls terrain
			textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+instance_find(obj_editor_terrain,i).instId5[1]+chr(34)+","); // Left side walls terrain
			textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+instance_find(obj_editor_terrain,i).instId5[2]+chr(34)+","); // Right side walls terrain
		}
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+instance_find(obj_editor_terrain,i).instId5[4]+chr(34)); // Floor terrain
		
		if i < instance_number(obj_editor_terrain) - 1 {
				textWrite = textWrite + ",";
		}
	}
}

// Close instance creation order IDs
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+"],");

// Disable drag and drop
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(34)+"IsDnD"+chr(34)+": false,");

// Write layers
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(34)+"layers"+chr(34)+": [");

for (i = 0; i <= 2; i += 1) {
	if i = 0 { // Hud
		layerType = "GMRInstanceLayer_Model:#YoYoStudio.MVCFormat";
		layerName = "Hud";
		modelName = "GMRInstanceLayer";
		depthWrite = "0";
	}
	if i = 1 { // Instances
		layerType = "GMRInstanceLayer_Model:#YoYoStudio.MVCFormat";
		layerName = "Instances";
		modelName = "GMRInstanceLayer";
		depthWrite = "100";
	}
	if i = 2 { // Background
		layerType = "GMRBackgroundLayer_Model:#YoYoStudio.MVCFormat";
		layerName = "Background";
		modelName = "GMRBackgroundLayer";
		depthWrite = "1000";
	}
	
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+"{");
	textWrite = textWrite + string_hash_to_newline("#")+chr(9)+chr(9)+chr(9)+chr(34)+"_type"+chr(34)+": "+chr(34)+layerType+chr(34)+",";
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"name"+chr(34)+": "+chr(34)+layerName+chr(34)+",");
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"id"+chr(34)+": "+chr(34)+layerId[i]+chr(34)+",");
	if i = 2 {
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"animationFPS"+chr(34)+": 15,");
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"animationSpeedType"+chr(34)+": "+chr(34)+"0"+chr(34)+",");
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"colour"+chr(34)+": { "+chr(34)+"Value"+chr(34)+": "+"4278190080 },");
	}
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"depth"+chr(34)+": "+depthWrite+",");
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"grid_x"+chr(34)+": "+"20,");
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"grid_y"+chr(34)+": "+"20,");
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"hierarchyFrozen"+chr(34)+": false,");
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"hierarchyVisible"+chr(34)+": true,");
	if i = 2 {
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"hspeed"+chr(34)+": 0,");
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"htiled"+chr(34)+": false,");
	}
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"inheritLayerDepth"+chr(34)+": false,");				
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"inheritLayerSettings"+chr(34)+": false,");
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"inheritSubLayers"+chr(34)+": false,");
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"inheritVisibility"+chr(34)+": false,");
	if i != 2 {
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"instances"+chr(34)+": [");
		// Write layer instances
		if i = 1 { // "Instances" layer
			// Iterate across all collision objects
			if instance_exists(obj_editor_terrain) {
				for (i = 0; i < instance_number(obj_editor_terrain); i += 1) {
					textWrite = textWrite + instance_find(obj_editor_terrain,i).exportString;
					textWrite = textWrite + instance_find(obj_editor_terrain,i).exportStringFloor;
					if instance_find(obj_editor_terrain,i).zfloor > 0 {
						textWrite = textWrite + instance_find(obj_editor_terrain,i).exportStringSideF;
						textWrite = textWrite + instance_find(obj_editor_terrain,i).exportStringSideB;
						textWrite = textWrite + instance_find(obj_editor_terrain,i).exportStringSideL;
						textWrite = textWrite + instance_find(obj_editor_terrain,i).exportStringSideR;
					}
				}
			} else {
				textWrite = textWrite + string_hash_to_newline("#");
			}
		} else {
				textWrite = textWrite + string_hash_to_newline("#");
		}
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+"],");
	}
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"layers"+chr(34)+": [##"+chr(9)+chr(9)+chr(9)+"],");
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"m_parentID"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+",");
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"m_serialiseFrozen"+chr(34)+": false,");
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"modelName"+chr(34)+": "+chr(34)+modelName+chr(34)+",");
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+",");
	if i = 2 {
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"spriteId"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+",");
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"stretch"+chr(34)+": false,");
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"userdefined_animFPS"+chr(34)+": false,");
	}
	textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"userdefined_depth"+chr(34)+": false,");
	if i != 2 {
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"visible"+chr(34)+": true");
	} else {
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"visible"+chr(34)+": true,");
	}
	if i = 2 {
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"vspeed"+chr(34)+": 0,");
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"vtiled"+chr(34)+": false,");
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"x"+chr(34)+": 0,");
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(9)+chr(34)+"y"+chr(34)+": 0");
	}
	if i != 2 {
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+"},");
	} else {
		textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+"}");
	}
}
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+"],");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRoom"+chr(34)+",");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(34)+"parentId"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+",");

// Superfluous box2D data
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(34)+"physicsSettings"+chr(34)+":     {");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"id"+chr(34)+": "+chr(34)+roomId[11]+chr(34)+",");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"inheritPhysicsSettings"+chr(34)+": false,");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRoomPhysicsSettings"+chr(34)+",");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"PhysicsWorld"+chr(34)+": false,");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"PhysicsWorldGravityX"+chr(34)+": 0,");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"PhysicsWorldGravityY"+chr(34)+": 10,");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"PhysicsWorldPixToMeters"+chr(34)+": 0.1,");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34));
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+"},");

// Room essential data
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(34)+"roomSettings"+chr(34)+":     {");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"id"+chr(34)+": "+chr(34)+roomId[1]+chr(34)+",");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"Height"+chr(34)+": "+string(room_height)+",");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"inheritRoomSettings"+chr(34)+": false,");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRoomSettings"+chr(34)+",");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"persistent"+chr(34)+": false,");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+",");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"Width"+chr(34)+": "+string(room_width));
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+"},");

textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+",");

// Views data
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(34)+"views"+chr(34)+": [");

textWrite = textWrite + string_hash_to_newline("#{"+chr(34)+"id"+chr(34)+": "+chr(34)+roomId[3]+chr(34)+","+chr(34)+"hborder"+chr(34)+": 320,"+chr(34)+"hport"+chr(34)+": 384,"+chr(34)+"hspeed"+chr(34)+": -1,"+chr(34)+"hview"+chr(34)+": 192,"+chr(34)+"inherit"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRView"+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+"552e159b-ec0e-43bf-862e-3cf9a2bdeecb"+chr(34)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"vborder"+chr(34)+": 320,"+chr(34)+"visible"+chr(34)+": true,"+chr(34)+"vspeed"+chr(34)+": -1,"+chr(34)+"wport"+chr(34)+": 684,"+chr(34)+"wview"+chr(34)+": 342,"+chr(34)+"xport"+chr(34)+": 0,"+chr(34)+"xview"+chr(34)+": 0,"+chr(34)+"yport"+chr(34)+": 0,"+chr(34)+"yview"+chr(34)+": 0},");
textWrite = textWrite + string_hash_to_newline("#{"+chr(34)+"id"+chr(34)+": "+chr(34)+roomId[4]+chr(34)+","+chr(34)+"hborder"+chr(34)+": 32,"+chr(34)+"hport"+chr(34)+": 768,"+chr(34)+"hspeed"+chr(34)+": -1,"+chr(34)+"hview"+chr(34)+": 768,"+chr(34)+"inherit"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRView"+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"vborder"+chr(34)+": 32,"+chr(34)+"visible"+chr(34)+": false,"+chr(34)+"vspeed"+chr(34)+": -1,"+chr(34)+"wport"+chr(34)+": 1024,"+chr(34)+"wview"+chr(34)+": 1024,"+chr(34)+"xport"+chr(34)+": 0,"+chr(34)+"xview"+chr(34)+": 0,"+chr(34)+"yport"+chr(34)+": 0,"+chr(34)+"yview"+chr(34)+": 0},");
textWrite = textWrite + string_hash_to_newline("#{"+chr(34)+"id"+chr(34)+": "+chr(34)+roomId[5]+chr(34)+","+chr(34)+"hborder"+chr(34)+": 32,"+chr(34)+"hport"+chr(34)+": 768,"+chr(34)+"hspeed"+chr(34)+": -1,"+chr(34)+"hview"+chr(34)+": 768,"+chr(34)+"inherit"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRView"+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"vborder"+chr(34)+": 32,"+chr(34)+"visible"+chr(34)+": false,"+chr(34)+"vspeed"+chr(34)+": -1,"+chr(34)+"wport"+chr(34)+": 1024,"+chr(34)+"wview"+chr(34)+": 1024,"+chr(34)+"xport"+chr(34)+": 0,"+chr(34)+"xview"+chr(34)+": 0,"+chr(34)+"yport"+chr(34)+": 0,"+chr(34)+"yview"+chr(34)+": 0},");
textWrite = textWrite + string_hash_to_newline("#{"+chr(34)+"id"+chr(34)+": "+chr(34)+roomId[6]+chr(34)+","+chr(34)+"hborder"+chr(34)+": 32,"+chr(34)+"hport"+chr(34)+": 768,"+chr(34)+"hspeed"+chr(34)+": -1,"+chr(34)+"hview"+chr(34)+": 768,"+chr(34)+"inherit"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRView"+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"vborder"+chr(34)+": 32,"+chr(34)+"visible"+chr(34)+": false,"+chr(34)+"vspeed"+chr(34)+": -1,"+chr(34)+"wport"+chr(34)+": 1024,"+chr(34)+"wview"+chr(34)+": 1024,"+chr(34)+"xport"+chr(34)+": 0,"+chr(34)+"xview"+chr(34)+": 0,"+chr(34)+"yport"+chr(34)+": 0,"+chr(34)+"yview"+chr(34)+": 0},");
textWrite = textWrite + string_hash_to_newline("#{"+chr(34)+"id"+chr(34)+": "+chr(34)+roomId[7]+chr(34)+","+chr(34)+"hborder"+chr(34)+": 32,"+chr(34)+"hport"+chr(34)+": 768,"+chr(34)+"hspeed"+chr(34)+": -1,"+chr(34)+"hview"+chr(34)+": 768,"+chr(34)+"inherit"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRView"+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"vborder"+chr(34)+": 32,"+chr(34)+"visible"+chr(34)+": false,"+chr(34)+"vspeed"+chr(34)+": -1,"+chr(34)+"wport"+chr(34)+": 1024,"+chr(34)+"wview"+chr(34)+": 1024,"+chr(34)+"xport"+chr(34)+": 0,"+chr(34)+"xview"+chr(34)+": 0,"+chr(34)+"yport"+chr(34)+": 0,"+chr(34)+"yview"+chr(34)+": 0},");
textWrite = textWrite + string_hash_to_newline("#{"+chr(34)+"id"+chr(34)+": "+chr(34)+roomId[8]+chr(34)+","+chr(34)+"hborder"+chr(34)+": 32,"+chr(34)+"hport"+chr(34)+": 768,"+chr(34)+"hspeed"+chr(34)+": -1,"+chr(34)+"hview"+chr(34)+": 768,"+chr(34)+"inherit"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRView"+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"vborder"+chr(34)+": 32,"+chr(34)+"visible"+chr(34)+": false,"+chr(34)+"vspeed"+chr(34)+": -1,"+chr(34)+"wport"+chr(34)+": 1024,"+chr(34)+"wview"+chr(34)+": 1024,"+chr(34)+"xport"+chr(34)+": 0,"+chr(34)+"xview"+chr(34)+": 0,"+chr(34)+"yport"+chr(34)+": 0,"+chr(34)+"yview"+chr(34)+": 0},");
textWrite = textWrite + string_hash_to_newline("#{"+chr(34)+"id"+chr(34)+": "+chr(34)+roomId[9]+chr(34)+","+chr(34)+"hborder"+chr(34)+": 32,"+chr(34)+"hport"+chr(34)+": 768,"+chr(34)+"hspeed"+chr(34)+": -1,"+chr(34)+"hview"+chr(34)+": 768,"+chr(34)+"inherit"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRView"+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"vborder"+chr(34)+": 32,"+chr(34)+"visible"+chr(34)+": false,"+chr(34)+"vspeed"+chr(34)+": -1,"+chr(34)+"wport"+chr(34)+": 1024,"+chr(34)+"wview"+chr(34)+": 1024,"+chr(34)+"xport"+chr(34)+": 0,"+chr(34)+"xview"+chr(34)+": 0,"+chr(34)+"yport"+chr(34)+": 0,"+chr(34)+"yview"+chr(34)+": 0},");
textWrite = textWrite + string_hash_to_newline("#{"+chr(34)+"id"+chr(34)+": "+chr(34)+roomId[10]+chr(34)+","+chr(34)+"hborder"+chr(34)+": 32,"+chr(34)+"hport"+chr(34)+": 768,"+chr(34)+"hspeed"+chr(34)+": -1,"+chr(34)+"hview"+chr(34)+": 768,"+chr(34)+"inherit"+chr(34)+": false,"+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRView"+chr(34)+","+chr(34)+"objId"+chr(34)+": "+chr(34)+"00000000-0000-0000-0000-000000000000"+chr(34)+","+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34)+","+chr(34)+"vborder"+chr(34)+": 32,"+chr(34)+"visible"+chr(34)+": false,"+chr(34)+"vspeed"+chr(34)+": -1,"+chr(34)+"wport"+chr(34)+": 1024,"+chr(34)+"wview"+chr(34)+": 1024,"+chr(34)+"xport"+chr(34)+": 0,"+chr(34)+"xview"+chr(34)+": 0,"+chr(34)+"yport"+chr(34)+": 0,"+chr(34)+"yview"+chr(34)+": 0}");

textWrite = textWrite + string_hash_to_newline("#"+chr(9)+"],");

textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(34)+"viewSettings"+chr(34)+":     {");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"id"+chr(34)+": "+chr(34)+roomId[12]+chr(34)+",");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"clearDisplayBuffer"+chr(34)+": true,");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"clearViewBackground"+chr(34)+": false,");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"enableViews"+chr(34)+": true,");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"inheritViewSettings"+chr(34)+": false,");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"modelName"+chr(34)+": "+chr(34)+"GMRoomViewSettings"+chr(34)+",");
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+chr(9)+chr(34)+"mvc"+chr(34)+": "+chr(34)+"1.0"+chr(34));
textWrite = textWrite + string_hash_to_newline("#"+chr(9)+"}");

textWrite = textWrite + string_hash_to_newline("#}");

// Write string to external file
file_text_write_string(export,textWrite);
file_text_close(export);

// Write creation code files
if instance_exists(obj_editor_terrain) {
	for (i = 0; i < instance_number(obj_editor_terrain); i += 1) {
		file = file_text_open_write("InstanceCreationCode_"+string(instance_find(obj_editor_terrain,i).instId1[0])+".gml");
		// Terrain graphics
		writeData = "zfloor = "+string(instance_find(obj_editor_terrain,i).zfloor);
		trg = instance_find(obj_editor_terrain,i).id;
		for (a = 0; a < trg.width+3; a += 1) {
			for (b = 0; b < trg.height+3; b += 1) {
				writeData = writeData + string_hash_to_newline("#tileArrayDrawX[" + string(a) + "," + string(b) + "] = " + string(trg.tileArrayDrawX[a,b]));
				writeData = writeData + string_hash_to_newline("#tileArrayDrawY[" + string(a) + "," + string(b) + "] = " + string(trg.tileArrayDrawY[a,b]));
			}
		}
		writeData = writeData + string_hash_to_newline("#width = ") + string(trg.width) + string_hash_to_newline("#height = ") + string(trg.height);
		file_text_write_string(file,writeData);
		file_text_close(file);
		
		file = file_text_open_write("InstanceCreationCode_"+string(instance_find(obj_editor_terrain,i).instId1[5])+".gml");
		// Floor collision
		writeData = "zplace = "+string(instance_find(obj_editor_terrain,i).zfloor)+string_hash_to_newline("#zcieling = ")+string(instance_find(obj_editor_terrain,i).zcieling);
		file_text_write_string(file,writeData);
		file_text_close(file);
		
		if instance_find(obj_editor_terrain,i).zfloor > 0 {
			file = file_text_open_write("InstanceCreationCode_"+string(instance_find(obj_editor_terrain,i).instId1[2])+".gml");
			// Left collision
			writeData = "zplace = "+string(instance_find(obj_editor_terrain,i).zfloor)+string_hash_to_newline("#zcieling = ")+string(instance_find(obj_editor_terrain,i).zcieling)+string_hash_to_newline("#height = ")+string(instance_find(obj_editor_terrain,i).height);
			file_text_write_string(file,writeData);
			file_text_close(file);
			
			file = file_text_open_write("InstanceCreationCode_"+string(instance_find(obj_editor_terrain,i).instId1[3])+".gml");
			// Right collision
			writeData = "zplace = "+string(instance_find(obj_editor_terrain,i).zfloor)+string_hash_to_newline("#zcieling = ")+string(instance_find(obj_editor_terrain,i).zcieling)+string_hash_to_newline("#height = ")+string(instance_find(obj_editor_terrain,i).height);
			file_text_write_string(file,writeData);
			file_text_close(file);
			
			file = file_text_open_write("InstanceCreationCode_"+string(instance_find(obj_editor_terrain,i).instId1[4])+".gml");
			// Back collision
			writeData = "zplace = "+string(instance_find(obj_editor_terrain,i).zfloor)+string_hash_to_newline("#zcieling = ")+string(instance_find(obj_editor_terrain,i).zcieling);
			file_text_write_string(file,writeData);
			file_text_close(file);
			
			file = file_text_open_write("InstanceCreationCode_"+string(instance_find(obj_editor_terrain,i).instId1[1])+".gml");
			// Front collision
			writeData = "zplace = "+string(instance_find(obj_editor_terrain,i).zfloor)+string_hash_to_newline("#zcieling = ")+string(instance_find(obj_editor_terrain,i).zcieling);
			file_text_write_string(file,writeData);
			file_text_close(file);
		}
	}
}
}
}

select = 0;
col = c_white;
