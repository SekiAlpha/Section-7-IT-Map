_Type = _this select 1;
_Player = _this select 0;

_Player removeMagazine secondaryWeaponMagazine _Player;
_Player removeWeapon secondaryWeapon _Player;

if (RHSR) then {
	if (_Type == "HEAT") then {
		_Player addWeapon "rhs_weap_M136";
		_Player addMagazine "rhs_m136_mag";
		hint format ["HEAT rocket given",_Player];
	};
	if (_Type == "HP") then {
		_Player addWeapon "rhs_weap_M136_hp";
		_Player addMagazine "rhs_m136_hp_mag";
		hint format ["HP rocket given",_Player];
	};
	if (_Type == "HEDP") then {
		_Player addWeapon "rhs_weap_M136_hedp";
		_Player addMagazine "rhs_m136_hedp_mag";
		hint format ["HEDP rocket given",_Player];
	};
};