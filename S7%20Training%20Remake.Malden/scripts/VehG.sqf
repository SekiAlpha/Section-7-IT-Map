params ["_Logi","_Array","_Stri"];
_Array1 = synchronizedObjects (_Logi);
_Obj = ((_Array1 select {typeOf _x != _Stri}) select 0);
_Base = ((_Array1 select {typeOf _x == _Stri}) select 0);

if (isServer) then {
	_Obj setVariable ["Base",_Base];
};
sleep (0.1);

_Obj addAction ["Delete nearest vehicle",{
	params ["_Obj","_Caller"];
	_D = 999;
	_Del = objNull;
	_Base = _Obj getVariable "Base";
	_DelA = nearestObjects [_Base, ["AllVehicles"],10];
	{
		if !((isPlayer _x) or (_x isKindOf "GroundWeaponHolder")) exitWith {
		_Del = _x;
	};
	} forEach _DelA;
	sleep (0.1);
	if (str _Del != str objNull) then {
		_Text = getText (configFile >> "CfgVehicles" >> (typeOf _Del) >> "displayName");
		deleteVehicle _Del;
		[name _Caller+" has deleted a "+_Text] remoteExec ["fnc_Com",0];
	} else {hint format ["Nothing to delete",_Caller]};
}];

{
	_Text = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_A = _Obj addAction ["Retreive "+_Text,{
		params ["_Obj","_Caller","_A","_Type"];
		_Base = _Obj getVariable "Base";
		_VA = nearestObjects [_Base, ["AllVehicles"],10];
		_Go = (_VA findIf {(!(isPlayer _x) and !(_x isKindOf "GroundWeaponHolder"))});
		
		if (_Go == -1) then {
			_Veh = _Type createVehicle [0,0,0];
			_Veh setPos getPos _Base;
			_Veh setDir (getDir _Base);
			_Text = getText (configFile >> "CfgVehicles" >> (typeOf _Veh) >> "displayName");
			[name _Caller+" has spawned a "+_Text] remoteExec ["fnc_Com",0];
		} else {
			hint format ["Cannot place area full",_Caller];
		};
	},_x];
} forEach _Array;