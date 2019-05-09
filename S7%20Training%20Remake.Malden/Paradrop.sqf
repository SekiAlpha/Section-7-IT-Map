_Obj = _this select 0;

sleep (0.1);

removeAllActions _Obj;

_Obj addAction ["Leave Que for paradrop",{
	_Pl = _this select 1;
	if (_Pl in ParaQ) then {
		_Slot = ParaQ find _Pl;
		_T = ParaQ deleteAt _Slot;
		publicVariable "ParaQ";
	};
}];

_Obj addAction ["Que for paradrop",{
	_Pl = _this select 1;
	if (_Pl in ParaQ) then {} else {
		ParaQ = ParaQ + [_Pl];
		publicVariable "ParaQ";
	};
}];

_Obj addAction ["Set travel height to 500",{
	ParaH = 500;
	publicVariable "ParaH";
}];
_Obj addAction ["Set travel height to 1000",{
	ParaH = 1000;
	publicVariable "ParaH";
}];
_Obj addAction ["Set travel height to 1500",{
	ParaH = 1500;
	publicVariable "ParaH";
}];
_Obj addAction ["Set travel height to 2000",{
	ParaH = 2000;
	publicVariable "ParaH";
}];
_Obj addAction ["Set travel height to 2500",{
	ParaH = 2500;
	publicVariable "ParaH";
}];
_Obj addAction ["Set travel height to 3000",{
	ParaH = 3000;
	publicVariable "ParaH";
}];
_Obj addAction ["Set travel height to 3500",{
	ParaH = 3500;
	publicVariable "ParaH";
}];
_Obj addAction ["Set travel height to 4000",{
	ParaH = 4000;
	publicVariable "ParaH";
}];
_Obj addAction ["Set travel height to 4500",{
	ParaH = 4500;
	publicVariable "ParaH";
}];
_Obj addAction ["Set travel height to 5000",{
	ParaH = 5000;
	publicVariable "ParaH";
}];

_Obj addAction ["Start paradrop",{
	_Obj = _this select 0;
	_Height = ParaH;
	_Veh = createVehicle ["B_T_VTOL_01_infantry_F",MarkerPos "PDS" vectorAdd [0,0,_Height], [], 0, "Fly"];
	_Veh setPos (getPosASL _Veh vectorAdd [0,0,_Height + 500]);
	_Veh setDir (_Veh getDir markerpos "PDE");
	createVehicleCrew _Veh;
	sleep (0.1);
	_WP = group (crew _Veh select 0) addWaypoint [getMarkerPos "PDE" vectorAdd [0,0,_Height], 0];
	_WP setWaypointCompletionRadius 30;
	_WP setWaypointStatements ["true", "deleteVehicle (vehicle this); {deleteVehicle _x} forEach thisList"];
	_Veh flyInHeightASL [_Height,_Height,_Height];
	[_Veh,ParaQ] remoteExecCall ["fnc_LoadPara",2];
}];