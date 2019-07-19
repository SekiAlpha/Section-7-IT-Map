private ["_Array","_Node","_Stri","_Tar","_Text","_A"];
_Array = synchronizedObjects (_this select 0);
_Node = (_Array select {typeOf _x != "VR_Area_01_circle_4_grey_F"}) select 0;
_Tar = (_Array select {typeOf _x == "VR_Area_01_circle_4_grey_F"}) select 0;

_Stri = [];
sleep (1);

if (RHSR) then {
	_Stri = _Stri + ["rhs_tigr_msv","rhs_bmp1_msv","rhs_bmp2_msv","rhs_btr60_msv","rhs_btr70_msv","rhs_btr80_msv",
	"rhs_t80","rhs_t90a_tv"];
};

if (isServer) then {
	_Tar setPos ((getPos _Node) vectorAdd [50,0,0]);
	_Node setVariable ["Tar",_Tar,true];
};

_Node addAction ["50M",fnc_Targetmove,50];
_Node addAction ["100M",fnc_Targetmove,100];
_Node addAction ["150M",fnc_Targetmove,150];
_Node addAction ["200M",fnc_Targetmove,200];
_Node addAction ["250M",fnc_Targetmove,250];

{
	_Text = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_A = _Node addAction ["Spawn "+_Text,{
		private ["_Node","_Tar","_TS","_Veh"];
		_Node = _this select 0;
		_Tar = _Node getVariable "Tar";
		_TS = _Node getVariable str (_this select 2);
		_Veh = _TS createVehicle getPos _Tar;
		[_Veh] call fnc_DonK;
	}];
	_Node setVariable [str _A,_x,true];
	sleep (0.1);
} forEach _Stri;