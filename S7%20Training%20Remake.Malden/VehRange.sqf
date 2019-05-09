_Type = _this select 0;
_Base = _this select 1;
_Veh = objNull;

if (_Type == "Down") then {
	_List = nearestObjects [getPos _Base, ["Air","Land"],10];
	{
		if (isPlayer driver _x) exitWith {
			_Veh = _x;
		};
	} forEach _List;
	if !(_Veh == objNull) then {
		_Started = _Veh getVariable "Start";
		if (isNil "_Started") then {
			_Down = _Veh setVariable ["Last","Down",true];
			_Veh setVariable ["Start",time,true];
			_Veh setVariable ["Up",[],true];
		} else {
			_Last = _Veh getVariable "Last";
			if (isNil "_Last") then {
				_Veh setVariable ["Down",[time],true];
				_Veh setVariable ["Last","Down",true];
			} else {
				if (_Last == "Up") then {
					_Veh setVariable ["Down",[time],true];
					_Veh setVariable ["Last","Down",true];
				};
			};
		};
	};
};

if (_Type == "Up") then {
	_List = nearestObjects [getPos _Base, ["Air","Land"],10];
	{
		if (isPlayer driver _x) exitWith {
			_Veh = _x;
		};
	} forEach _List;
	
	if !(_Veh == objNull) then {
		_Started = _Veh getVariable "Start";
		if (_Started > 0) then {
			_Last = _Veh getVariable "Last";
			_Up = _Veh getVariable "Up";
			_Veh setVariable ["Up",_Up + [time],true];
		} else {
			_Last = _Veh getVariable "Last";
			if (_Last == "Down") then {
				_Veh setVariable ["Up",[time],true];
				_Veh setVariable ["Last","Up",true];
			};
		};
		_Wave = _Veh getVariable "Waves";
		if (isNil "_Wave") then {
			_Veh setVariable ["Waves",1,true];
			_Wave = 1;
		} else {
			_Veh setVariable ["Waves",_Wave + 1,true];
			_Wave = _Wave+1;
		};
		if (_Wave < 3) then {
			["Spawn","VR_Area_01_square_4x4_grey_F",_Veh] execVM "VehRange.sqf";
		} else {
			
		};
	};
};

if (_Type == "Spawn") then {
	_Model = _this select 1;
	_Veh = _this select 2;
	_Array = nearestObjects [_Veh, [_Model], 1000];
	_R = round random (count _Array);
	_S = (_Array select _R);
	if (isNil "_S") then {
		_R = round random (count _Array);
		_S = (_Array select _R);
	};
	_Config = (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_squad");
	_Grp = ([getPos _S, east, _Config] call BIS_fnc_spawnGroup);
	{
		_x disableAI "WEAPONAIM	";
	} forEach units _Grp;
	_Alive = true;
	while {_Alive} do {
		_Alive = false;
		{
			if (alive _x) then {_Alive = true};
			sleep (0.5);
		} forEach units _Grp;
		if !(_Alive) then {
			[((name driver _Veh) + ", Your range has been cleared")] remoteExec ["fnc_Com",0];
			{
				deleteVehicle _x;
			} forEach units _Grp;
		};
	sleep (5);	
	};
};
