
comment "Exported from Arsenal by OP Horner";

comment "[!] UNIT MUST BE LOCAL [!]";
if (!local player) exitWith {};

comment "Remove existing items";
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

comment "Add containers";
player forceAddUniform "VSM_Multicam_Crye_tan_pants_Camo";
for "_i" from 1 to 15 do {player addItemToUniform "ACE_elasticBandage";};
for "_i" from 1 to 15 do {player addItemToUniform "ACE_quikclot";};
for "_i" from 1 to 3 do {player addItemToUniform "ACE_tourniquet";};
for "_i" from 1 to 15 do {player addItemToUniform "ACE_packingBandage";};
for "_i" from 1 to 2 do {player addItemToUniform "ACE_EarPlugs";};
for "_i" from 1 to 3 do {player addItemToUniform "ACE_epinephrine";};
for "_i" from 1 to 3 do {player addItemToUniform "ACE_morphine";};
player addItemToUniform "ACE_personalAidKit";
player addVest "VSM_CarrierRig_Operator_Multicam";
player addItemToVest "ItemcTabHCam";
player addItemToVest "ACE_Flashlight_XL50";
player addItemToVest "ACE_EntrenchingTool";
for "_i" from 1 to 12 do {player addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
for "_i" from 1 to 3 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 3 do {player addItemToVest "HandGrenade";};
player addBackpack "VSM_Multicam_Backpack_Kitbag";
player addItemToBackpack "NVGoggles_OPFOR";
player addHeadgear "VSM_Mich2000_2_Multicam";

comment "Add weapons";
player addWeapon "rhs_weap_hk416d145";
player addPrimaryWeaponItem "SMA_eotech552";
player addWeapon "Rangefinder";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "TFAR_anprc152";
player linkItem "ItemcTab";
