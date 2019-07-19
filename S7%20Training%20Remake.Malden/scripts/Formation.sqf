_Obj = _this select 0;

{
	_Obj addAction ["set formation : "+_x,{FormationGroup setFormation (_this select 3)},_x];
} forEach ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"];