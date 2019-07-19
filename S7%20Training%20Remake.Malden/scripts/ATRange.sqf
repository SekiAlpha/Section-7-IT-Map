_Node = _this select 0;
_Stri = [];
sleep (0.1);

if (RHSR) then {
	_Stri = _Stri + ["rhs_tigr_msv","rhs_bmp1_msv","rhs_bmp2_msv","rhs_btr60_msv","rhs_btr70_msv","rhs_btr80_msv",
	"rhs_t80","rhs_t90a_tv"];
};

if (isServer) then {
	_Tar = ("VR_Area_01_circle_4_grey_F" createVehicle ((getPos _Node) vectorAdd [50,0,0]));
	_Node setVariable ["Tar",_Tar,true];
};

sleep 0.1;

_Node addAction ["50M",{_this call fnc_Targetmove},50];
_Node addAction ["100M",{_this call fnc_Targetmove},100];
_Node addAction ["150M",{_this call fnc_Targetmove},150];
_Node addAction ["200M",{_this call fnc_Targetmove},200];
_Node addAction ["250M",{_this call fnc_Targetmove},250];

{
	_Text = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_A = _Node addAction ["Spawn "+_Text,{
		_Node = _this select 0;
		_Tar = _Node getVariable "Tar";
		_TS = _Node getVariable str (_this select 2);
		_Veh = _TS createVehicle getPos _Tar;
		[_Veh] call fnc_DonK;
	}];
	_Node setVariable [str _A,_x,true];
} forEach _Stri;