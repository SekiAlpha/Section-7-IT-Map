_Array = synchronizedObjects (_this select 0);
_Phone = (_Array select {typeOf _x != "VR_Area_01_square_1x1_yellow_F"}) select 0;
_Array = _Array select {typeOf _x == "VR_Area_01_square_1x1_yellow_F"};
// do not put more than one "Phone" or objects other than "VR_Area_01_square_1x1_yellow_F"

if (isServer) then {
	{
		_x hideObjectGlobal true;
	} forEach _Array;
	_Phone setVariable ["Spawned",[],true];  
	_Phone setVariable ["Running",0,true];  
	_Phone setVariable ["Stop",0,true];
	_Phone setVariable ["Array",_Array,true];
	_G = createGroup [east,false];
	_Phone setVariable ["G",_G,true];
	_LookDir = (round((_Array select 0 getDir _Phone)/90)*90);
	_Phone setVariable ["LookDir",_LookDir,true];
};

_Phone addAction ["Remove targets",{
	_Phone = _this select 0;
	_G = _Phone getVariable "G";
	{
		deleteVehicle _x;
	} forEach units _G;
}];

_Phone addAction ["All targets",{
	_Phone = _this select 0;
	_Array = _Phone getVariable "Array";
	_G = _Phone getVariable "G";
	_LookDir = _Phone getVariable "LookDir";
	{
		_unit = (_G createUnit ["I_C_Soldier_Bandit_4_F", getPos _x, [], _LookDir , "Form"]);
		_unit disableAI "ALL";
		_unit setDir _LookDir;
		_unit setPos getPos _x;
	} forEach _Array;
}];

sleep(0.1);

_Phone addAction ["Start",{_this call fnc_RQStart}];
_Phone addAction ["Stop",{_this select 0 setVariable ["Stop",1,true];hint format ["Qual stopped",_this select 1];}];