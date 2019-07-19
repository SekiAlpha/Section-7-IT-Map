fnc_GunTake = {//addaction for taking a gun
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
fnc_Com = {//mostly used for broadcasting to all on systemchat
	_Text = _this select 0;
	sleep 0.1;
	if !(isNil "_Text") then {
		systemChat (_Text);
	};
};
fnc_DonK = {//prints when a unit is kill
	_Veh = _this select 0;
	_Veh addEventHandler ["killed", {
		_T = _this select 0;
		_TStri = typeOf _T;
		_Text = getText (configFile >> "CfgVehicles" >> _TStri >> "displayName");
		[(_Text+" Killed!")] remoteExec ["fnc_Com",0];
		deleteVehicle (_T);
	}];
};
fnc_GR = {//addactions for retreving vehicles
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
		}];
		
		_AA = _AA + [_A];
		_NPC setVariable [str _A,_TStri,true];
		_NPC setVariable ["AA",_AA,true];
		_NPC setVariable ["Srt",_Srt,true];
		_NPC setVariable ["GC",_GC,true];
	} forEach _GC;
};
fnc_FMR = {//removes mines
	_Obj = _this select 0;
	_Mines = _Obj getVariable "Mines";
	{
		deleteVehicle _x;
	} forEach _Mines;
	_Obj setVariable ["Mines",[],true];
	hint format ["Mines removed",_this select 1];
};
fnc_FMP = {//places mines
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
	hint format [str _Amount + " Mines placed of type "+_Type,_this select 1];
};
fnc_LoadPara = {//moves everyone into cargo on paradrop
	_Veh = _this select 0;
	_Que = _this select 1;
	{
		_x moveInCargo _Veh;
	} forEach _Que;
	ParaQ = [];
	publicVariable "ParaQ";
};
fnc_Targetmove = {//moves target on at range
	_Node = _this select 0;
	_Tar = _Node getVariable "Tar";
	_Range = (_this select 3);
	_Tar setPos ((getPos _Node) vectorAdd [_Range,0,0]);
	hint format ["Move spawner "+str _Range+"M away",_this select 1];
};
fnc_RQStart = {//startes rifle qual
	params ["_Phone","_Caller"];
	_G = _Phone getVariable "G";
	_LookDir = _Phone getVariable "LookDir";
	_Array = _Phone getVariable "Array";
	{
		deleteVehicle _x;
	} forEach units _G;
	_Phone setVariable ["Spawned",[],true];  
	_Phone setVariable ["Running",1,true];  
	_Phone setVariable ["Stop",0,true];
	_Phone setVariable ["RQS",objNull,true];
	{
		hint format ["Starting in " + str _x,_Caller];
		sleep 1;
	} forEach [10,9,8,7,6,5,4,3,2,1];
	hint format ["Good Luck",_Caller];
	[_Phone,_Caller,_Array,_G,20,_LookDir] call fnc_RQLoop;
};
fnc_RQLoop = {//loop for rilfe qual
	params ["_Phone","_Caller","_Array","_G","_Times","_LookDir"];
	_TimesL = 0;
	_Hit = 0;
	while {_TimesL <= _Times} do {
		[_Phone,_Array,_G,_LookDir] call fnc_RQSpawn;
		sleep 4;
		_unit = _Phone getVariable "RQS";
		_Stri = "";
		_A = ((alive _unit) and !(_unit getVariable ["ACE_isUnconscious", false]));
		deleteVehicle _unit;
		if (_A) then {
			_Stri = "Miss";
		} else {
			_Stri = "Hit";
			_Hit = _Hit + 1;
		};
		hint format ["Round:"+str _TimesL +"\n"+_Stri+"\n"+str _Hit+"/"+str (_TimesL-_Hit)+"/"+str _Times+"\n Hit/Miss/Times",_Caller];
		_TimesL = _TimesL + 1;
		if (_Phone getVariable "Stop" == 1) exitWith {};
	};
	//loop or qual is over
	if (_TimesL == 20) then {
		[(name _Caller) + " Hit "+str _Hit+"/"+str _Times] remoteExec ["fnc_Com",0];
	} else {
		hint format ["Qual stopped \n"+str _Hit+"/"+str _TimesL,_Caller];
	};
};
fnc_RQSpawn = {//spawns ai for rifle qual
	params ["_Phone","_Array","_G","_LookDir"];
	_R = floor random ((count _Array)-1);
	_S = (_Array select _R);
	_unit = (_G createUnit ["I_C_Soldier_Bandit_4_F", getPos _S, [], _LookDir , "Form"]);
	_unit setDir _LookDir;
	_unit disableAI "ALL";
	_unit setPos getPos _S;
	_Phone setVariable ["RQS",_unit,true];
};
fnc_VEHLIST = {//Veh list for supply crates
	params ["_Obj","_Caller"];
	private ["_vehicles","_Action","_Actions","_ENDActions","_Statement","_icon","_name","_Space","_Size"];
	_vehicles = _Obj nearObjects ["AllVehicles", 20];
	_vehicles = _vehicles select {(_x != _Obj) && {!(_x isKindOf "CAManBase")} && {[_x] call fnc_ACEGETSPACE >= 1} && {simulationEnabled _x}};
	_Action = [];
	_Actions = [];
	_ENDActions = [];
	_Statement = {
		params ["_Obj","_Caller","_Param"];
		private ["_Crate","_Veh","_Dif","_Space","_Size","_NCrate","_TF"];
		_Crate = _Param select 0;_Veh = _Param select 1;
		_Size = [_Crate] call fnc_ACEGETSIZE;
		_Space = [_Veh] call fnc_ACEGETSPACE;
		_Dif = _Size - _Space;
		if (_Dif > 0) then {hint format ["Not enough space need "+str _Dif+" more cargo space",_Caller];} else {
			_NCrate = (typeOf _Crate) createVehicle getPos _Veh;
			[_Crate,_NCrate] call fnc_COPYACE;
			[_Crate,_NCrate] call fnc_COPYINV;
			_NCrate setpos getPos _Veh;
			_TF = ([_NCrate,_Veh] call ace_cargo_fnc_loadItem);
			if (_TF) then {hint format ["Loaded " + str -_Dif + " Cargo left",_Caller];} else {
				hint format ["Something went wrong try again",_Caller];
				deleteVehicle _NCrate;
			};
		};
	};
	{	
		_Veh = _x;
		_name = (str round(getPos _x distance getPos _Obj)+"M "+getText(configFile >> "CfgVehicles" >> typeOf _x >> "displayName"));
		_icon = getText(configFile >> "CfgVehicles" >> typeOf _x >> "icon");
		_Action = [_Veh,_name,_icon,{true},{true}] call ace_interact_menu_fnc_createAction;
		_Actions = [];
		_BoxAction = [];
		{
			_Size = [_x] call fnc_ACEGETSIZE;
			_name = ((_x getVariable "Displayname") + " Size:" + str _Size);
			_BoxAction = [_x, _name, "", _Statement, {true}, {}, [_x,_Veh]] call ace_interact_menu_fnc_createAction;
			_Actions pushBack [_BoxAction,[],_Obj];
		} forEach SCrates;
		_ENDActions pushBack [_Action, _Actions, _Obj];
	} foreach _vehicles;
	
	_ENDActions
};
fnc_COPYINV = {//Copys a obj inv to anouther
	params ["_Obj","_NObj"];
	_WC = weaponCargo _Obj; if (isnil "_WC") then {_WC = [];};
	_MC = magazineCargo _Obj; if (isnil "_MC") then {_MC = [];};
	_IC = itemCargo _Obj; if (isnil "_IC") then {_IC = [];};
	_BC = getBackpackCargo _Obj; if (isnil "_BC") then {_BC = [];};
	if !(_WC isEqualTo []) then {
		clearWeaponCargoGlobal _NObj;
		{
			_NObj addWeaponCargoGlobal [_x,1];
		} foreach _WC;	
	};
	if !(_MC isEqualTo []) then {
		clearMagazineCargoGlobal _NObj;
		{
			_NObj addMagazineCargoGlobal [_x,1];
		} foreach _MC;
	};
	if !(_IC isEqualTo []) then {
		clearItemCargoGlobal _NObj;
		{
			_NObj addItemCargoGlobal [_x,1];
		} foreach _IC;
	};
	if !(_BC isEqualTo []) then {
		clearBackpackCargoGlobal _NObj;
		{
			_NObj addBackpackCargoGlobal [_x,1];
		} foreach _BC;
	};
};
fnc_COPYACE = {//Copys a few ace settings from one obj to anouther
	params ["_Obj","_NObj"];
	[_NObj,[_Obj] call fnc_ACEGETSIZE] call ace_cargo_fnc_setSize;
	[_NObj,[_Obj] call fnc_ACEGETSPACE] call ace_cargo_fnc_setSpace;
	if (_Obj getVariable ["ace_dragging_candrag",false]) then {[_NObj,true,_Obj getVariable "ace_dragging_carryposition",_Obj getVariable "ace_dragging_dragdirection"] call ace_dragging_fnc_setDraggable};

	
};
fnc_ACEGETSIZE = {//gets size of a obj
	params ["_Obj"];
	_Size = _Obj getVariable ["ace_cargo_size",-1];
	if (_Size == -1) then {
		_CFG = configfile >> "CfgVehicles" >> typeOf _Obj >> "ace_cargo_size";
		if (isNumber _CFG) then {_Size = getNumber _CFG};
	};
	_Size
};
fnc_ACEGETSPACE = {//gets space of a obj 
	params ["_Obj"];
	_Space = _Obj getVariable ["ace_cargo_space",-1];
	if (_Space == -1) then {
		_CFG = configfile >> "CfgVehicles" >> typeOf _Obj >> "ace_cargo_space";
		if (isNumber _CFG) then {_Space = getNumber _CFG};
	};
	_Space
};


