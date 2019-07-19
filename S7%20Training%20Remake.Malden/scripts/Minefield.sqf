_Obj = _this select 0;

if (isServer) then {
	_Obj setVariable ["Mine","TrainingMine",true];
	_Obj setVariable ["Mines",[],true];
	_Obj setVariable ["Amount",100,true];
};

sleep (1);

{
	_N = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_Obj addAction [_N+" mine",{_this select 0 setVariable ["Mine",_this select 3,true]},_x];
	sleep (0.1);
} forEach ["ATMine","APERSMine","APERSBoundingMine","SLAMDirectionalMine","APERSTripMine","Claymore_F","IEDLandBig_F","IEDLandSmall_F","TrainingMine_01_F"];

{
	_Obj addAction [str _x+"x mines",{_this select 0 setVariable ["Amount",_this select 3,true]},_x];
	sleep (0.1);
} forEach [10,50,100,150,200,300,400,500];


_Obj addAction ["Remove mines",{_this call fnc_FMR}];
_Obj addAction ["Spawn mines",{_this call fnc_FMP}];
