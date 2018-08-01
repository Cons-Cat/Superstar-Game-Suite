/// @description Initialize Variables
dmg = 0; //Damage
hp = 1; //Health
mana = 0; //PP
qck = 0; //Speed
def = 0; //Defense
char = 0; //Cool

initiative = 0; //Which turn is yours
ally = true; //True for player units, false for enemy units
state = 0; //0 selects attack, 1 executes attack, 2 defends from attack
attackSel = 0; //Script index of attack to use
target = 0; //Object index of character to attack

attackScr = 0; //Script chosen to execute as attack
attackScrInit = 0;
attackInited = 0;

attackList[0] = 0; //Enemy attack script reportoire index
attackListInit[0] = 0;
attackListSize = 0; //Size of said reportoire

if x < room_width/2{
	xscaleFlip = 1;
}
if x > room_width/2{
	xscaleFlip = -1;
}

/*
VARIABLES
 * Initiative (array value based on speed)
 * Allegiance (boolean for ally or enemy)
 * State (0 for choosing attack, 1 for attacking, 2 for defending, 3 for death)
 * Attack list (array of scripts)
 
 * Turn (held in control object, unit with same initiative as the turn sets state to 0)
 
STATE 0
 * If allegienace is true, select rotating block
 * If allegiance is false, instantly select attack from list
 
   state = 1;
 
STATE 1
 * Execute selected attack script
 
   turn += 1;
 
STATE 2
 * If allegiance is false, do nothing
 * If allegiance is true, counter attack
 * If hp is 0, state is 3

STATE 3
 * If turn is initiative, turn += 1
 
