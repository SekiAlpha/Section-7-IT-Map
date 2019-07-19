if !(isMultiplayer) then {
	{
		if(!(isPlayer _x) ) then {
			deleteVehicle _x;
		};
	} foreach switchableUnits;
};//deletes non player playable units when in sp

[] execVM "FNC.sqf";

[] execVM "scripts\BasicLoadout.sqf";

[true,10,false,true,30,10,true,[],["Helicopter"]] execVM "WerthlesHeadless.sqf";
//CHVD_maxView = 7500;
//CHVD_maxObj = 5000;
CHVD_minView = 300;
CHVD_minObj = 300;
CHVD_allowNoGrass = false;
ACE_maxWeightDrag = 6000;
ACE_maxWeightCarry = 2000;

execVM "show_fps.sqf";