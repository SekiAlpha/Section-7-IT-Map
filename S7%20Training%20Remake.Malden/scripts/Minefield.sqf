_Obj = _this select 0;

removeAllActions _Obj;

if (isServer) then {
	_Obj setVariable ["Mine","TrainingMine",true];
	_Obj setVariable ["Mines",[],true];
	_Obj setVariable ["Amount",100,true];
};

{
	_N = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_Obj addAction [_N+" mine",{_this select 0 setVariable ["Mine",_this select 3,true]},_x];
} forEach ["ATMine","APERSMine","APERSBoundingMine","SLAMDirectionalMine","APERSTripMine","Claymore_F","IEDLandBig_F","IEDLandSmall_F","TrainingMine_01_F"];

{
	_Obj addAction [str _x+"x mines",{_this select 0 setVariable ["Amount",_this select 3,true]},_x];
} forEach [10,50,100,150,200,300,400,500];


_Obj addAction ["Remove mines",{_this call fnc_FMR}];
_Obj addAction ["Spawn mines",{_this call fnc_FMP}];
