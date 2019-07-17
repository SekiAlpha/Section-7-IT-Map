_Obj = _this select 0;
sleep (0.1);
if (isServer) then {
	_Array = _Obj nearObjects ["VR_3DSelector_01_incomplete_F",100];
	_Obj setVariable ["Array",_Array,true];
	_Obj setVariable ["NPC",[],true];
	_Obj setVariable ["Damage",0,true];
	_Obj setVariable ["Loadout",[[],[],[],["U_C_Poloshirt_stripped",[]],[],[],"H_Cap_tan","",[],["ItemMap","","","ItemCompass","ItemWatch",""]],true];
	_Grp = createGroup [Civilian, false];
	_Grp setGroupId ["ACE GROUP"];
	_Obj setVariable ["Grp",_Grp];
};

_Obj addAction ["Reset",{
	_Obj = _this select 0;
	_Array = _Obj getVariable "Array";
	_Grp = _Obj getVariable "Grp";
	{
		deleteVehicle _x;
	} forEach units _Grp;
	
	_NPC = [];
	
	{
		_unit = "C_man_1" createVehicle getPosATL _x;
		_unit setUnitLoadout (_Obj getVariable "Loadout");
		[_unit] joinSilent _Grp;
		_NPC = _NPC + [_unit];
		_unit disableAI "ALL";
	} forEach _Array;
	
	_Obj setVariable ["NPC",_NPC,true];
}];

_Obj addAction ["Remove",{
	_Obj = _this select 0;
	_Grp = _Obj getVariable "Grp";
	{
		deleteVehicle _x;
	} forEach units _Grp;
	_Obj setVariable ["NPC",[],true];
}];

_Obj addAction ["Copy loadout",{
	(_this select 0) setVariable ["Loadout",(getUnitLoadout (_this select 1)),true];
}];
_Obj addAction ["Reset loadout",{
	(_this select 0) setVariable ["Loadout",[[],[],[],["U_C_Poloshirt_stripped",[]],[],[],"H_Cap_tan","",[],["ItemMap","","","ItemCompass","ItemWatch",""]],true];
}];

_Obj addAction ["Set damage 0",{
	(_this select 0) setVariable ["Damage",0,true];
}];
_Obj addAction ["Set damage 0.25",{
	(_this select 0) setVariable ["Damage",0.25,true];
}];
_Obj addAction ["Set damage 0.5",{
	(_this select 0) setVariable ["Damage",0.5,true];
}];
_Obj addAction ["Set damage 0.75",{
	(_this select 0) setVariable ["Damage",0.75,true];
}];
_Obj addAction ["Set damage 1",{
	(_this select 0) setVariable ["Damage",1,true];
}];

_Obj addAction ["Head damage",{
	_Obj = _this select 0;
	_NPC = _Obj getVariable "NPC";
	_Damage = _Obj getVariable "Damage";
	{
		[_x, _Damage, "head" , "bullet"] remoteExecCall ["ace_medical_fnc_addDamageToUnit",0];
	} foreach _NPC
}];

_Obj addAction ["Body damage",{
	_Obj = _this select 0;
	_NPC = _Obj getVariable "NPC";
	_Damage = _Obj getVariable "Damage";
	{
		[_x, _Damage, "body" , "bullet"] remoteExecCall ["ace_medical_fnc_addDamageToUnit",0]
	} foreach _NPC
}];

_Obj addAction ["Right arm damage",{
	_Obj = _this select 0;
	_NPC = _Obj getVariable "NPC";
	_Damage = _Obj getVariable "Damage";
	{
		[_x, _Damage, "hand_r" , "bullet"] remoteExecCall ["ace_medical_fnc_addDamageToUnit",0]
	} foreach _NPC
}];

_Obj addAction ["Left arm damage",{
	_Obj = _this select 0;
	_NPC = _Obj getVariable "NPC";
	_Damage = _Obj getVariable "Damage";
	{
		[_x, _Damage, "hand_l" , "bullet"] remoteExecCall ["ace_medical_fnc_addDamageToUnit",0]
	} foreach _NPC
}];

_Obj addAction ["Right leg damage",{
	_Obj = _this select 0;
	_NPC = _Obj getVariable "NPC";
	_Damage = _Obj getVariable "Damage";
	{
		[_x, _Damage, "leg_r" , "bullet"] remoteExecCall ["ace_medical_fnc_addDamageToUnit",0]
	} foreach _NPC
}];

_Obj addAction ["Left leg damage",{
	_Obj = _this select 0;
	_NPC = _Obj getVariable "NPC";
	_Damage = _Obj getVariable "Damage";
	{
		[_x, _Damage, "leg_l" , "bullet"] remoteExecCall ["ace_medical_fnc_addDamageToUnit",0]
	} foreach _NPC
}];