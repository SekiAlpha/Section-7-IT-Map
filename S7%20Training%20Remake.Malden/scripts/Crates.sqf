_Array = synchronizedObjects (_this select 0);

if (isServer) then {
	{
		_x allowDamage false;
		_x enableSimulation false;
		_x setPos [20,0,10];
	} forEach _Array;
};

SCrates = _Array;

sleep (0.1);

_action = ["spawnSupplys","Spawnsupplys","",{},{true},{(_this call fnc_VEHLIST)}] call ace_interact_menu_fnc_createAction;
["Sign_Arrow_Large_Pink_F", 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;