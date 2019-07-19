_Obj = _this select 0;
_Array = _this select 1;
_Base = _Obj getVariable "Base";

_Obj addAction ["Reset",{
	this = _this select 0;
	removeAllActions this;
	this addAction ["Desert Vehs",{}];
	[this,DVA,"Land_JumpTarget_F"] execVM "VehG.sqf";
}];

if (isNil "_Base") then {
	_Base = nearestObject [_Obj, "Land_JumpTarget_F"];
	_Obj setVariable ["Base",_Base];
};
removeAllActions _Obj;
sleep (0.5);

_Obj addAction ["Delete nearest vehicle",{
	_Obj = _this select 0;
	_Player = _this select 1;
	if !(true) then {//getPlayerUID _Player in OP
		hint format ["Your a level one scripter. Rank up first!",_Player];
	} else {
		_D = 999;
		_Del = objNull;
		_Base = _Obj getVariable "Base";
		_DelA = nearestObjects [_Base, ["Air","Land"],10];
		{
			if !((isPlayer _x) or (_x isKindOf "GroundWeaponHolder")) exitWith {
			_Del = _x;
		};
		} forEach _DelA;
		sleep (0.1);
		if !(isNil "_Del") then {
			_Text = getText (configFile >> "CfgVehicles" >> (typeOf _Del) >> "displayName");
			deleteVehicle _Del;
			[name _Player+" has deleted a "+_Text] remoteExec ["fnc_Com",0];
		};
	};
}];

{	
	_Text = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_A = _Obj addAction ["Retreive "+_Text,{
		_Obj = _this select 0;
		_Player = _this select 1;
		if !(true) then {//getPlayerUID _Player in OP
			hint format ["Your a level one scripter. Rank up first!",_Player];
		} else {
			_A = _this select 2;
			_Base = _Obj getVariable "Base";
			_Type = _Obj getVariable str _A;
			_VA = nearestObjects [_Base, ["Air","Land"],10];
			_Go = true;
			{
				if !((isPlayer _x) or (_x isKindOf "GroundWeaponHolder")) exitWith {_Go = false};
			} forEach _VA;
			
			if (_Go) then {
				_Veh = _Type createVehicle position _Base;
				sleep (0.1);
				_Veh setDir (getDir _Obj);
				_Text = getText (configFile >> "CfgVehicles" >> (typeOf _Veh) >> "displayName");
				[name _Player+" has spawned a "+_Text] remoteExec ["fnc_Com",0];
			} else {
				hint "Cannot place area full";
			};
		};
	}];
	_Obj setVariable [str _A,_x];
} forEach _Array;