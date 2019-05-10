_Type = _this select 0;

_Op = 0;
_Civ = 0;
_nearenemies = [];
_Group = grpNull;
_TType = "";
_unit = objNull;

if (_Type == "Start") then {
	_list = PID nearEntities ["Man", 75];
	{
		if (side _x != blufor) then {
			_nearenemies = _nearenemies + [_x];
		};
	} forEach _list;
	
	PIDG = createGroup independent;
	{
		_x disableAI "All";
		_x enableSimulation false;
		_x setPos (getPos _x vectorAdd [0,0,-20]); 
	} forEach _nearenemies;
	_nearenemies joinSilent PIDG;
	publicVariable "PIDG";
};

if (_Type == "BLUE") then {
	{	
		if (alive _x) then {} else {
			_Side = side _x; 
			if (_Side != east) then {_Op = _Op+1};
			if (_Side == east) then {_Civ = _Civ+1};
		};
		deleteVehicle _x;
	} forEach (units PIDC + units PIDO);
	sleep (0.1);
	[("PID done dead opfor:"+str _Op+" dead civs:"+str _Civ)] remoteExec ["fnc_Com",0];
};

if (_Type == "OP") then {
	{ 
		_Op = _Op+1;
	} forEach units PIDO;
	{ 
		_Civ = _Civ+1;
	} forEach units PIDC;
	
	[("PID started opfor:"+str _Op+" civs:"+str _Civ)] remoteExec ["fnc_Com",0];
};

if (_Type == "Spawn") then {
	{
		deleteVehicle _x;
	} forEach units PIDC + units PIDO;
	
	{
		_R = random 100;
		if (_R < PIDOP) then {
			_TType = "O_Soldier_F";
			_Group = PIDO;
		} else {
			_TType = "C_man_1";
			_Group = PIDC;
		};
		_unit = (_TType createUnit [(getPos _x) vectorAdd [0,0,21],_Group,"this disableAI 'MOVE'"]);
	} forEach (units PIDG);
};