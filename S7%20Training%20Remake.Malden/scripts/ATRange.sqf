_Node = _this select 0;
_Stri = [];
sleep (0.1);

if (RHSR) then {
	_Stri = _Stri + ["rhs_tigr_msv","rhs_bmp1_msv","rhs_bmp2_msv","rhs_btr60_msv","rhs_btr70_msv","rhs_btr80_msv",
	"rhs_t80","rhs_t90a_tv"];
};

{
	_Text = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_A = _Node addAction ["Spawn "+_Text,{
		_Node = _this select 0;
		_TS = _Node getVariable str (_this select 2);
		_Veh = _TS createVehicle getPos ATT;
		[_Veh] call fnc_DonK;
	}];
	_Node setVariable [str _A,_x,true];
} forEach _Stri;