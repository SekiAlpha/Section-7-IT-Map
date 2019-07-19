_Array = synchronizedObjects (_this select 0);
_Obj = (_Array select {typeOf _x != "TargetP_Inf2_F"}) select 0;
_Array = (_Array select {typeOf _x == "TargetP_Inf2_F"});

sleep (1);

_Obj addAction ["Activate auto pop-up",{
	params ["_Obj","_Caller","_ID","_Array"];
	{
		_x setVariable ["nopop", false];
		_x animate["terc", 0];
	} forEach _Array;
	hint format ["Enabled auto pop-up",_Caller];
},_Array];

_Obj addAction ["Deactivate auto pop-up",{
	params ["_Obj","_Caller","_ID","_Array"];
	{
		_x setVariable ["nopop", true];
	} forEach _Array;
	hint format ["Deactivated auto pop-up",_Caller];
},_Array];

_Obj addAction ["Targets up",{
	params ["_Obj","_Caller","_ID","_Array"];
	{
		_x animate["terc", 0];
	} forEach _Array;
	hint format ["Targets put up",_Caller];
},_Array];

_Obj addAction ["Targets down",{
	params ["_Obj","_Caller","_ID","_Array"];
	{
		_x animate["terc", 1];
	} forEach _Array;
	hint format ["Targets put down",_Caller];
},_Array];