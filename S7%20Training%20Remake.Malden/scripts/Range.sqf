_Phone = _this select 0;
_Run = _this select 1;
_Type = _this select 2;
_Pl = _this select 3;

sleep (0.1);

_Spawned = (_Phone getVariable "Spawned");
_group = createGroup east;

if (_Run == "Stop") then {
	_Phone setVariable ["Stop",1,true];
};

if (_Run == "All") then {
	_Array = nearestObjects [_Phone, [_Type], 1000];
	{	_unit = objNull;
		_unit = (_group createUnit ["I_C_Soldier_Bandit_4_F", getPos _x, [], _Phone getDir getPos _x , "Form"]);
		_unit disableAI "ALL";
		_unit setPos getPos _x;
		if (isNil "_unit") then {} else {_Spawned = _Spawned + [_unit]};
	} forEach _Array;
};
if (_Run == "Remove") then {
		{
			{
				deleteVehicle _x;
				_Spawned deleteAt (_Spawned find _x);
			} forEach _Spawned;
		} forEach [1,2,3,4];
};
if (_Run == "Run") then {
	_Index = 0;
	_HitA = 0;
	_Phone setVariable ["Stop",0,true];
	_Array = nearestObjects [_Phone, [_Type], 1000];
	_Con = _Phone getVariable "Running";
	if (_Con == 0) then {_Phone setVariable ["Running",1,true];
		{
			systemChat str _x;
			sleep (1);
		} forEach [10,9,8,7,6,5,4,3,2,1];
	};
	hint (name _Pl + ": Starting rifle qual");
	while {_Con == 0} do {
		_C = _Phone getVariable "Stop";
		if (_Index>19) then {_C = 1; [(name _Pl + ": Hit "+str _HitA+"/20")] remoteExec ["fnc_Com",0]};
		if (_C == 0) then {
		_R = floor random (count _Array);
		_S = (_Array select _R);
		if (isNil "_S") then {
			_R = floor random (count _Array);
			_S = (_Array select _R)
		};
		_unit = (_group createUnit ["I_C_Soldier_Bandit_4_F", getPos _S, [], _Phone getDir getPos _S , "Form"]);
		_unit disableAI "ALL";
		_unit setPos getPos _S;
		_Index = _Index+1;
		_unit setOwner 0;
		sleep 4;
		if (alive _unit) then {[(name _Pl + " Missed "+str _Index)] remoteExec ["fnc_Com",0]} else {
			[((name _Pl) + " Hit "+str _Index)]	remoteExec ["fnc_Com",0];
			_HitA=_HitA+1;
			};
		deleteVehicle _unit;
		} else {_Con = 1;_Phone setVariable ["Running",0,true]};
	};
};


_Phone setVariable ["Spawned",_Spawned,true];
