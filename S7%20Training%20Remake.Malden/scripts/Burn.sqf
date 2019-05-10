_Obj addAction ["Path",{
	_Pl = _this select 1;
	_Obj = _this select 0;
	_Obj removeAction (_this select 2);
	hint format ["SHIFT CLICK : start point
	ALT CLICK : end/delete point",_Pl];
	_Pl onMapSingleClick {
		if (_shift) then {
			if (_alt) then {
				_Obj setVariable ["End",_pos];
			} else {
				_Obj setVariable ["Start",_pos];
			};
		};
	};
	waitUntil {
		_ET = _Obj getVariable "End";
		_ST = _Obj getVariable "Start";
		if (_E
	};
	_Start = createMarker ["Start",
}];


this setVariable ["Spawned",[]];  
this setVariable ["Running",0];  
this setVariable ["Stop",0];  
this addAction ["Stop",{[_this select 0,"Stop"] execVM "Range.sqf"}];  
this addAction ["All LR",{_T = [_this select 0,"All","VR_Area_01_square_2x2_grey_F"] execVM "Range.sqf"}];  
this addAction ["All SR",{_T = [_this select 0,"All","VR_Area_01_square_1x1_yellow_F"] execVM "Range.sqf"}];  
this addAction ["Start LR",{_T = [_this select 0,"Run","VR_Area_01_square_2x2_yellow_F",_this select 1] execVM "Range.sqf"}];  
this addAction ["Start SR",{_T = [_this select 0,"Run","VR_Area_01_square_1x1_yellow_F",_this select 1] execVM "Range.sqf"}];  
this addAction ["Remove All",{_T = [_this select 0,"Remove"] remoteExecCall ["Range.sqf",0]}];  
this addAction ["VRT 100M",{Target setPosAtl (getPos (_this select 0) vectorAdd [0,-100,0])}];  
this addAction ["VRT 200M",{Target setPosAtl (getPos (_this select 0) vectorAdd [0,-200,0])}];  
this addAction ["VRT 300M",{Target setPos (getPos (_this select 0) vectorAdd [0,-300,10])}];  
this addAction ["VRT 800M",{Target setPos (getPos (_this select 0) vectorAdd [0,-800,50])}];  
this addAction ["VRT Away",{Target setPos (getPos (_this select 0) vectorAdd [0,0,-50])}];

this setVariable ["Spawned",[]]; 
this setVariable ["Running",0]; 
this setVariable ["Stop",0]; 
this addAction ["Stop",{[_this select 0,"Stop"] execVM "Range.sqf"}]; 
this addAction ["All LR",{_T = [_this select 0,"All","VR_Area_01_square_2x2_grey_F"] execVM "Range.sqf"}]; 
this addAction ["All SR",{_T = [_this select 0,"All","VR_GroundIcon_01_F"] execVM "Range.sqf"}]; 
this addAction ["Start LR",{_T = [_this select 0,"Run","VR_Area_01_square_2x2_yellow_F",_this select 1] execVM "Range.sqf"}]; 
this addAction ["Start SR",{_T = [_this select 0,"Run","VR_GroundIcon_01_F",_this select 1] execVM "Range.sqf"}]; 
this addAction ["Remove All",{_T = [_this select 0,"Remove"] execVM "Range.sqf"}]; 
this addAction ["VRT 100M",{Target setPosAtl (getPos (_this select 0) vectorAdd [0,-100,0])}]; 
this addAction ["VRT 200M",{Target setPosAtl (getPos (_this select 0) vectorAdd [0,-200,0])}]; 
this addAction ["VRT 300M",{Target setPos (getPos (_this select 0) vectorAdd [0,-300,10])}]; 
this addAction ["VRT 800M",{Target setPos (getPos (_this select 0) vectorAdd [0,-800,50])}]; 
this addAction ["VRT Away",{Target setPos (getPos (_this select 0) vectorAdd [0,0,-50])}]; 
