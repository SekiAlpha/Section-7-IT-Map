_Obj = _this select 0;
sleep (0.1);
if (isServer) then {
_Array = _Obj nearObjects ["VR_3DSelector_01_incomplete_F",200];
_Obj setVariable ["Array",_Array,true];
_Obj setVariable ["NPC",[],true];
_Obj setVariable ["Damage",0,true];
};

_Obj addAction ["Reset",{
	_Obj = _this select 0;
	_NPC = _Obj getVariable "NPC";
	_Array = _Obj getVariable "Array";
	{
		deleteVehicle _x;
	} forEach _NPC;
	
	_NPC = [];
	
	{
		_unit = "C_man_1" createVehicle getPosATL _x;
		_NPC = _NPC + [_unit];
		_unit disableAI "ALL";
	} forEach _Array;
	
	_Obj setVariable ["NPC",_NPC,true];
}];

_Obj addAction ["Remove",{
	_Obj = _this select 0;
	_NPC = _Obj getVariable "NPC";
	_Array = _Obj getVariable "Array";
	{
		deleteVehicle _x;
	} forEach _NPC;
	_Obj setVariable ["NPC",[]];
}];

_Obj addAction ["Set damage 0",{
	_this select 0 setVariable ["Damage",0,true];
}];
_Obj addAction ["Set damage 0.25",{
	_this select 0 setVariable ["Damage",0.25,true];
}];
_Obj addAction ["Set damage 0.5",{
	_this select 0 setVariable ["Damage",0.5,true];
}];
_Obj addAction ["Set damage 0.75",{
	_this select 0 setVariable ["Damage",0.75,true];
}];
_Obj addAction ["Set damage 1",{
	_this select 0 setVariable ["Damage",1,true];
}];

_Obj addAction ["Head damage",{
	_Obj = _this select 0;
	_NPC = _Obj getVariable "NPC";
	_Damage = _Obj getVariable "Damage";
	{
		_damageHead = _Damage;
		[_x, _damageHead, "head" , "bullet"] remoteExecCall ["ace_medical_fnc_addDamageToUnit",2];
	} foreach _NPC
}];

_Obj addAction ["Body damage",{
	_Obj = _this select 0;
	_NPC = _Obj getVariable "NPC";
	_Damage = _Obj getVariable "Damage";
	{
		_damageHead = _Damage;
		[_x, _damageHead, "body" , "bullet"] remoteExecCall ["ace_medical_fnc_addDamageToUnit",2]
	} foreach _NPC
}];

_Obj addAction ["Right arm damage",{
	_Obj = _this select 0;
	_NPC = _Obj getVariable "NPC";
	_Damage = _Obj getVariable "Damage";
	{
		_damageHead = _Damage;
		[_x, _damageHead, "hand_r" , "bullet"] remoteExecCall ["ace_medical_fnc_addDamageToUnit",2]
	} foreach _NPC
}];

_Obj addAction ["Left arm damage",{
	_Obj = _this select 0;
	_NPC = _Obj getVariable "NPC";
	_Damage = _Obj getVariable "Damage";
	{
		_damageHead = _Damage;
		[_x, _damageHead, "hand_l" , "bullet"] remoteExecCall ["ace_medical_fnc_addDamageToUnit",2]
	} foreach _NPC
}];

_Obj addAction ["Right leg damage",{
	_Obj = _this select 0;
	_NPC = _Obj getVariable "NPC";
	_Damage = _Obj getVariable "Damage";
	{
		_damageHead = _Damage;
		[_x, _damageHead, "leg_r" , "bullet"] remoteExecCall ["ace_medical_fnc_addDamageToUnit",2]
	} foreach _NPC
}];

_Obj addAction ["Left leg damage",{
	_Obj = _this select 0;
	_NPC = _Obj getVariable "NPC";
	_Damage = _Obj getVariable "Damage";
	{
		_damageHead = _Damage;
		[_x, _damageHead, "leg_l" , "bullet"] remoteExecCall ["ace_medical_fnc_addDamageToUnit",2]
	} foreach _NPC
}];