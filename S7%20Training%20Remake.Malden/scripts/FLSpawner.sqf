params ["_Veh"];
_Veh lock true; 
_Veh enableSimulation false; 
_Veh addAction ["Spawn",{
	params ["_Veh","_Caller"]; 
	_NVeh = typeOf _Veh createVehicle getPos _Veh; 
	_Caller moveInDriver _NVeh; 
	[_Veh,_NVeh] call fnc_COPYACE;
	_NVeh setDir getDir _Veh;
	sleep 0.5;
	["ACE_Wheel", _NVeh, 1] call ace_cargo_fnc_removeCargoItem;
}];