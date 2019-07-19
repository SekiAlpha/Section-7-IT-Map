_Trig = _this select 0;
_Array = synchronizedObjects (_Trig);
_Array = [_Array, [_Trig], {_input0 distance _x}, "ASCEND"] call BIS_fnc_sortBy;
{
	_Flag = _x;
	_Stri = (((typeOf _x) splitString "_") select 1);
	{
		_x addAction [_Stri,{
			params ["_x","_Caller","_ID","_Flag"];
			_Caller setPos getPos _Flag;
		},_Flag];
	} forEach ((_Array) select {_x != _Flag});
} forEach _Array;