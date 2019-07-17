_Obj = _this select 0;
removeAllActions _Obj;
_TStri = typeOf _Obj;
_Text = getText (configFile >> "CfgVehicles" >> _TStri >> "displayName");
_Pos = (getPosATL _Obj);
_SObj = typeOf _Obj createVehicle _Pos;

{
	_weaponCargo = getWeaponCargo _Obj;
	_weapon = _weaponCargo select 0;
	_count = _weaponCargo select 1;
	_SObj addWeapon (_weapon select 0);
	{
		_info = _x;
		_type = _info select 0;
		_ammoCount = _info select 1;
			
		_SObj addMagazine [_type, 1, _ammoCount];
	} foreach (magazinesAmmoCargo _Obj);
		
	_itemCargo = getItemCargo _Obj;
	_items = _itemCargo select 0;
	_counts = _itemCargo select 1;
	{
		_item = _x;
		_count = _counts select _i;
		_SObj addItemCargoGlobal [_item, _count];
	} foreach _items;
};
_SObj setDamage 1;

[_SObj,_Obj] remoteExec ["fnc_GunTake",0,true] spawn BIS_fnc_MP;

_Obj setPos [10,0,10];
_SObj setPos _Pos;
_SObj setDir getDir _Obj;
_SObj setVectorUp vectorUp _Obj;
_SObj setVectorDir vectorDir _Obj;
_SObj setDir getDir _Obj;
 