sleep (1);
_Pole = _this select 0;
_Name = _this select 1;
_Pole setVariable ["Name",_Name];

{
	_A = _x addAction ["Go to "+_Name,{
		_Obj = _this select 0;
		_Pole = _Obj getVariable str (_this select 2);
		_this select 1 setPos getPos _Pole;
	}];
	
	_x setVariable [str _A,_Pole];
	_NN = _x getVariable "Name";
	
	_A = _Pole addAction ["Go to "+_NN,{
		_Obj = _this select 0;
		_Pole = _Obj getVariable str (_this select 2);
		_this select 1 setPos getPos _Pole;
	}];
	
	_Pole setVariable [str _A,_x];
} forEach TPA;
TPA = TPA + [_Pole];
TPN = TPN + [_Name];