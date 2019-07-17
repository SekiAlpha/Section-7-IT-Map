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
	AVA = ["RHS_AH64D","RHS_AH64DGrey","RHS_CH_47F_10","RHS_CH_47F_light","RHS_UH60M_ESSS_d","RHS_UH60M_ESSS2_d","RHS_UH60M_MEV_d","RHS_UH60M2","RHS_UH60M_MEV2","RHS_UH60M","RHS_MELB_AH6M","RHS_MELB_MH6M","RHS_MELB_H6M","RHS_AH1Z","rhsusf_CH53E_USMC_D","RHS_UH1Y_FFAR_d","RHS_UH1Y_d","RHS_UH1Y_UNARMED_d"];
	DVA = ["rhsusf_m113d_usarmy_supply","rhsusf_m113d_usarmy","rhsusf_m113d_usarmy_M240","rhsusf_m113d_usarmy_medical","rhsusf_m113d_usarmy_MK19","rhsusf_m113d_usarmy_unarmed","rhsusf_m109d_usarmy","RHS_M119_D","rhsusf_M142_usarmy_D","RHS_M252_D","rhsusf_m1025_d_m2","rhsusf_m1025_d_Mk19","rhsusf_m1025_d","rhsusf_m1043_d_m2","rhsusf_m1043_d_mk19","rhsusf_m1043_d","rhsusf_m1045_d","rhsusf_m998_d_2dr_fulltop","rhsusf_m998_d_2dr_halftop","rhsusf_m998_d_2dr","rhsusf_m998_d_4dr_fulltop","rhsusf_m998_d_4dr_halftop","rhsusf_m998_d_4dr","rhsusf_m966_d","RHS_M2A2","RHS_M2A2_BUSKI","RHS_M2A3","RHS_M2A3_BUSKI","RHS_M2A3_BUSKIII","RHS_M6","rhsusf_M1117_D","rhsusf_M1117_O","rhsusf_M1220_usarmy_d","rhsusf_M1220_M153_M2_usarmy_d","rhsusf_M1220_M2_usarmy_d","rhsusf_M1220_MK19_usarmy_d","rhsusf_M1230_M2_usarmy_d","rhsusf_M1230_MK19_usarmy_d","rhsusf_M1230a1_usarmy_d","rhsusf_M1232_usarmy_d","rhsusf_M1232_M2_usarmy_d","rhsusf_M1232_MK19_usarmy_d","rhsusf_M1237_M2_usarmy_d","rhsusf_M1237_MK19_usarmy_d","rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy","rhsusf_M1078A1P2_D_fmtv_usarmy","rhsusf_M1078A1P2_D_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_B_D_fmtv_usarmy","rhsusf_M1078A1P2_B_D_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_D_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_D_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_B_D_CP_fmtv_usarmy","rhsusf_M1083A1P2_D_fmtv_usarmy","rhsusf_M1083A1P2_D_flatbed_fmtv_usarmy","rhsusf_M1083A1P2_B_D_fmtv_usarmy","rhsusf_M1083A1P2_B_D_flatbed_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_D_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_D_flatbed_fmtv_usarmy","rhsusf_M1084A1P2_D_fmtv_usarmy","rhsusf_M1084A1P2_B_D_fmtv_usarmy","rhsusf_M1084A1P2_B_M2_D_fmtv_usarmy","rhsusf_M1085A1P2_B_D_Medical_fmtv_usarmy","rhsusf_M977A4_usarmy_d","rhsusf_M977A4_AMMO_usarmy_d","rhsusf_M977A4_REPAIR_usarmy_d","rhsusf_M977A4_AMMO_BKIT_usarmy_d","rhsusf_M977A4_AMMO_BKIT_M2_usarmy_d","rhsusf_M977A4_BKIT_usarmy_d","rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_d","rhsusf_M977A4_BKIT_M2_usarmy_d","rhsusf_M977A4_REPAIR_BKIT_usarmy_d","rhsusf_M978A4_usarmy_d","rhsusf_M978A4_BKIT_usarmy_d","RHS_Stinger_AA_pod_D","RHS_M2StaticMG_D","RHS_M2StaticMG_MiniTripod_D","RHS_TOW_TriPod_D","RHS_MK19_TriPod_D"];
	WVA = ["rhsusf_m113_usarmy_supply","rhsusf_m113_usarmy","rhsusf_m113_usarmy_M2_90","rhsusf_m113_usarmy_M240","rhsusf_m113_usarmy_medical","rhsusf_m113_usarmy_MK19","rhsusf_m113_usarmy_MK19_90","rhsusf_m113_usarmy_unarmed","rhsusf_M142_usarmy_WD","rhsusf_m109_usarmy","RHS_M119_WD","RHS_M252_WD","rhsusf_m1025_w_m2","rhsusf_m1025_w_mk19","rhsusf_m1025_w","rhsusf_m1043_w_m2","rhsusf_m1043_w_mk19","rhsusf_m1043_w","rhsusf_m1045_w","rhsusf_m998_w_2dr_fulltop","rhsusf_m998_w_2dr_halftop","rhsusf_m998_w_2dr","rhsusf_m998_w_4dr_fulltop","rhsusf_m998_w_4dr","rhsusf_m966_w","RHS_M2A2_wd","RHS_M2A2_BUSKI_WD","RHS_M2A3_wd","RHS_M2A3_BUSKI_wd","RHS_M2A3_BUSKIII_wd","RHS_M6_wd","rhsusf_M1117_W","rhsusf_M1220_usarmy_wd","rhsusf_M1220_M153_M2_usarmy_wd","rhsusf_M1220_M2_usarmy_wd","rhsusf_M1220_MK19_usarmy_wd","rhsusf_M1230a1_usarmy_wd","rhsusf_M1232_usarmy_wd","rhsusf_M1232_M2_usarmy_wd","rhsusf_M1232_MK19_usarmy_wd","rhsusf_M1237_M2_usarmy_wd","rhsusf_M1237_MK19_usarmy_wd","rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy","rhsusf_M1078A1P2_WD_fmtv_usarmy","rhsusf_M1078A1P2_WD_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_B_WD_fmtv_usarmy","rhsusf_M1078A1P2_B_WD_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_WD_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_WD_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_B_WD_CP_fmtv_usarmy","rhsusf_M1083A1P2_WD_fmtv_usarmy","rhsusf_M1083A1P2_WD_flatbed_fmtv_usarmy","rhsusf_M1083A1P2_B_WD_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_WD_flatbed_fmtv_usarmy","rhsusf_M1084A1P2_WD_fmtv_usarmy","rhsusf_M1084A1P2_B_WD_fmtv_usarmy","rhsusf_M1084A1P2_B_M2_WD_fmtv_usarmy","rhsusf_M1085A1P2_B_WD_Medical_fmtv_usarmy","rhsusf_M977A4_usarmy_wd","rhsusf_M977A4_AMMO_usarmy_wd","rhsusf_M977A4_REPAIR_usarmy_wd","rhsusf_M977A4_BKIT_usarmy_wd","rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_wd","rhsusf_M977A4_AMMO_BKIT_usarmy_wd","rhsusf_M977A4_BKIT_M2_usarmy_wd","rhsusf_M977A4_AMMO_BKIT_M2_usarmy_wd","rhsusf_M977A4_AMMO_BKIT_usarmy_wd","rhsusf_M977A4_BKIT_M2_usarmy_wd","rhsusf_M977A4_AMMO_BKIT_M2_usarmy_wd","rhsusf_M977A4_REPAIR_BKIT_usarmy_wd","rhsusf_M978A4_usarmy_wd","rhsusf_M978A4_BKIT_usarmy_wd","RHS_Stinger_AA_pod_WD","RHS_M2StaticMG_WD","RHS_M2StaticMG_MiniTripod_WD","RHS_TOW_TriPod_WD","RHS_MK19_TriPod_WD"];
	publicVariable "AVA";
	publicVariable "DVA";
	publicVariable "WVA";
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

fnc_FMR = {
	_Obj = _this select 0;
	_Mines = _Obj getVariable "Mines";
	{
		deleteVehicle _x;
	} forEach _Mines;
	_Obj setVariable ["Mines",[],true];
};

fnc_FMP = {
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

[true,10,false,true,30,10,true,[],["Helicopter"]] execVM "WerthlesHeadless.sqf";
//CHVD_maxView = 7500;
//CHVD_maxObj = 5000;
CHVD_minView = 300;
CHVD_minObj = 300;
CHVD_allowNoGrass = false;
ACE_maxWeightDrag = 6000;
ACE_maxWeightCarry = 2000;

execVM "show_fps.sqf";