_Obj = _this select 0;

removeAllActions _Obj;

if (isServer) then {
	_Obj setVariable ["Mine","TrainingMine_01_F",true];
	_Obj setVariable ["Mines",[],true];
	_Obj setVariable ["Amount",100,true];
};

_Obj addAction ["Training mines",{
	_this select 0 setVariable ["Mine","TrainingMine_01_F",true];
}];
_Obj addAction ["APERS mines",{
	_this select 0 setVariable ["Mine","Mine_APERSMine_F",true];
}];
_Obj addAction ["APERS bounding mines",{
	_this select 0 setVariable ["Mine","Mine_APERSBoundingMine_F",true];
}];
_Obj addAction ["5 mines",{
	_this select 0 setVariable ["Amount",5,true];
}];
_Obj addAction ["10 mines",{
	_this select 0 setVariable ["Amount",10,true];
}];
_Obj addAction ["50 mines",{
	_this select 0 setVariable ["Amount",50,true];
}];
_Obj addAction ["100 mines",{
	_this select 0 setVariable ["Amount",100,true];
}];
_Obj addAction ["200 mines",{
	_this select 0 setVariable ["Amount",200,true];
}];
_Obj addAction ["300 mines",{
	_this select 0 setVariable ["Amount",300,true];
}];
_Obj addAction ["400 mines",{
	_this select 0 setVariable ["Amount",400,true];
}];
_Obj addAction ["500 mines",{
	_this select 0 setVariable ["Amount",500,true];
}];


_Obj addAction ["Remove mines","fnc_FMR"];
_Obj addAction ["Spawn mines","fnc_FMP"];
