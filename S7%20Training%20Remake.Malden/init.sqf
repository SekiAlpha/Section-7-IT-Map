if !(isMultiplayer) then {
	{
		if(! (isPlayer _x) ) then {
			deleteVehicle _x;
		};
	} foreach switchableUnits;
};

if (isServer) then {
	PA = [];
	TPN = [];
	TPA = [];
	RHSR = isClass(configfile >> "CfgVehicles" >> "rhs_bmp2_vv");
	RHSA = isClass(Configfile >> "CfgVehicles" >> "RHS_A10");
	RHSU = isClass(configfile >> "CfgVehicles" >> "RHS_M2A2");
	PIDOP = 50;
	ParaQ = [];
	ParaH = 1000;
	PIDC = createGroup [civilian,false];
	PIDO = createGroup [East,false];
	AV = ["rhsusf_m1025_w","rhsusf_m1025_w_m2","rhsusf_m1025_w_mk19","rhsusf_m998_w_2dr","rhsusf_m998_w_4dr","rhsusf_rg33_d","rhsusf_rg33_m2_d"];
	publicVariable "PA";
	publicVariable "TPN";
	publicVariable "TPA";
	publicVariable "RHSR";
	publicVariable "RHSA";
	publicVariable "RHSU";
	publicVariable "PIDOP";
	publicVariable "ParaQ";
	publicVariable "ParaH";
	publicVariable "PIDO";
	publicVariable "PIDC";
	publicVariable "AV";
};

fnc_GunTake = {
	_Obj = _this select 1;
	_SObj = _this select 0;
	_SObj setVariable ["Obj",_Obj];
	
	_TStri = typeOf _Obj;
	_Text = getText (configFile >> "CfgVehicles" >> _TStri >> "displayName");
	_SObj addAction ["Take "+_Text,{
		_SObj = _this select 0;
		_Obj = _SObj getVariable "Obj";
		_Pl = _this select 1;
		_TStri = typeOf _Obj;
		_weaponCargo = getWeaponCargo _Obj;
		_weapon = _weaponCargo select 0;
		_count = _weaponCargo select 1;
		_Pl addWeapon (_weapon select 0);
		sleep (0.1);
		{
			_info = _x;
			_type = _info select 0;
			_ammoCount = _info select 1;
			
			_Pl addMagazine _type;
		} foreach (magazinesAmmoCargo _Obj);
		
		_itemCargo = getItemCargo _Obj;
		_items = _itemCargo select 0;
		_counts = _itemCargo select 1;
		{
			_item = _x;
			_count = _counts select _forEachIndex;
			_Pl addItemCargoGlobal [_item, _count];
		} foreach _items;
}];

};

fnc_Com = {
	_Text = _this select 0;
	sleep 0.1;
	if !(isNil "_Text") then {
		systemChat (_Text);
	};
};

fnc_DonK = {
	_Veh = _this select 0;
	_Veh addEventHandler ["killed", {
		_T = _this select 0;
		_TStri = typeOf _T;
		_Text = getText (configFile >> "CfgVehicles" >> _TStri >> "displayName");
		[(_Text+" Killed!")] remoteExec ["fnc_Com",0];
		deleteVehicle (_T);
	}];
};

fnc_GR = {
	_NPC = _this select 0;
	_AA = _NPC getVariable "AA";
	{
		_NPC removeAction _x;
		_NPC setVariable [str _x,nil,true];
	} forEach _AA;
	_AA = [];
	_GC = _NPC getVariable "GC";
	_Srt = _NPC getVariable "Srt";
	{
		_I = _forEachIndex;
		_TStri = _Srt select _I;
		_TGC = _GC select _I;
		_Text = getText (configFile >> "CfgVehicles" >> _TStri >> "displayName");
		
		_A = _NPC addAction ["Retreive "+_Text+" x"+str _TGC,{
			_NPC = _this select 0;
			_T = _NPC getVariable str (_this select 2);
			_TP = _NPC getVariable "Place";
			_V = _T createVehicle getPos _TP;
			[_V] call fnc_DonK;
			_DirE = _NPC getVariable "DirE";
			_V setDir _DirE;
			_GC = _NPC getVariable "GC";
			_Srt = _NPC getVariable "Srt";
			_Spot = _Srt find _T;
			_C = ((_GC select _Spot)-1);
			if (_C > 0) then {
				_GC set [_Spot,_C];
			} else {
				_GC deleteAt _Spot;
				_Srt deleteAt _Spot;
			};
			[_NPC] call fnc_GR;
		}];
		
		_AA = _AA + [_A];
		_NPC setVariable [str _A,_TStri,true];
		_NPC setVariable ["AA",_AA,true];
		_NPC setVariable ["Srt",_Srt,true];
		_NPC setVariable ["GC",_GC,true];
	} forEach _GC;
};

FMR = {
	_Obj = _this select 0;
	_Mines = _Obj getVariable "Mines";
	{
		deleteVehicle _x;
	} forEach _Mines;
};

FMP = {
	_Obj = _this select 0;
	_Mines = _Obj getVariable "Mines";
	_Type = _Obj getVariable "Mine";
	_Amount = _Obj getVariable "Amount";
	{
		deleteVehicle _x;
	} forEach _Mines;
	_Mines = [];
	for "_i" from 1 To _Amount do {
		_Mine = createMine [_Type, getMarkerPos "Mine", [], 150];
		_Mine setOwner 0;
		_Mines = _Mines + [_Mine];
	};
	_Obj setVariable ["Mines",_Mines,true];
};

ACER = {
	_Obj = _this select 0;
	_NPC = _Obj getVariable "NPC";
	_Array = _Obj getVariable "Array";
	{
		deleteVehicle _x;
	} forEach _NPC;
	
	_NPC = [];
	
	{
		_unit = "C_man_1" createVehicle getPosATL _x;
		_NPC = _NPC + [_unit];
		_unit disableAI "ALL";
	} forEach _Array;
	
	_Obj setVariable ["NPC",_NPC,true];
};

fnc_LoadPara = {
	_Veh = _this select 0;
	_Que = _this select 1;
	{
		_x moveInCargo _Veh;
	} forEach _Que;
	ParaQ = [];
	publicVariable "ParaQ";
};

[] execVM "scripts\BasicLoadout.sqf";