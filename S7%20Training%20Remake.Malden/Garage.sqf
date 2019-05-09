_NPC = _this select 0;
_Place = _this select 1;
_Return = _this select 2;

sleep (1);
removeAllActions _NPC;
_NPC addAction ["Fix",{
	_NPC = _this select 0;
	_Return = _NPC getVariable "Return";
	_Place = _NPC getVariable "Place";
	[_NPC,_Place,_Return] execVM "Garage.sqf";
}];

_NPC setVariable ["Place",_Place,true];
_NPC setVariable ["Return",_Return,true];
_NPC setVariable ["AA",[],true];

_Srt = _Place getVariable "Srt";
_GC = _Place getVariable "GC";

_NPC addaction ["Return Vehicles",{
	_NPC = _this select 0;
	_Srt = _NPC getVariable "Srt";
	_GC = _NPC getVariable "GC";
	_Return = _NPC getVariable "Return";
	_Types = _NPC getVariable "TE";
	_Array = nearestObjects [getPos _Return, _Types, 20];
	
	{
		_Type = typeOf _x;
		_At = _Srt find _Type;
		if (_At == -1) then {
			_Srt = _Srt + [_Type];
			_GC = _GC + [1];
		} else {
			_C = _GC select _At;
			_GC set [_At,_C+1];
		};
		deleteVehicle _x;
		
		{
			unassignVehicle _x
		} forEach crew _x;
	} forEach _Array;
	
	_NPC setVariable ["Srt",_Srt,true];
	_NPC setVariable ["GC",_GC,true];
	[_NPC] remoteExecCall ["fnc_GR",0];
}];