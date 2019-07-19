["Initialize"] call BIS_fnc_dynamicGroups;

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
AVA = ["RHS_AH1Z","RHS_AH64D","RHS_AH64DGrey","RHS_MELB_AH6M","RHS_CH_47F_10","RHS_CH_47F_light","rhsusf_CH53E_USMC_D","RHS_MELB_MH6M","RHS_MELB_H6M","RHS_UH1Y_FFAR_d","RHS_UH1Y_d","RHS_UH1Y_UNARMED_d","RHS_UH60M","RHS_UH60M_ESSS_d","RHS_UH60M_ESSS2_d","RHS_UH60M2","RHS_UH60M_MEV2","RHS_UH60M_MEV_d"];
DVA = ["RHS_Stinger_AA_pod_D","rhsusf_m1025_d_m2","rhsusf_m1025_d_Mk19","rhsusf_m1025_d","rhsusf_m1043_d_m2","rhsusf_m1043_d_mk19","rhsusf_m1043_d","rhsusf_m1045_d","rhsusf_M1078A1P2_D_fmtv_usarmy","rhsusf_M1078A1P2_D_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_B_D_fmtv_usarmy","rhsusf_M1078A1P2_B_D_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_D_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_D_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_B_D_CP_fmtv_usarmy","rhsusf_M1083A1P2_D_fmtv_usarmy","rhsusf_M1083A1P2_D_flatbed_fmtv_usarmy","rhsusf_M1083A1P2_B_D_fmtv_usarmy","rhsusf_M1083A1P2_B_D_flatbed_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_D_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_D_flatbed_fmtv_usarmy","rhsusf_M1084A1P2_D_fmtv_usarmy","rhsusf_M1084A1P2_B_D_fmtv_usarmy","rhsusf_M1084A1P2_B_M2_D_fmtv_usarmy","rhsusf_M1085A1P2_B_D_Medical_fmtv_usarmy","rhsusf_m998_d_2dr_fulltop","rhsusf_m998_d_2dr_halftop","rhsusf_m998_d_2dr","rhsusf_m998_d_4dr_fulltop","rhsusf_m998_d_4dr_halftop","rhsusf_m998_d_4dr","rhsusf_m109d_usarmy","rhsusf_M1117_D","rhsusf_M1117_O","rhsusf_m113d_usarmy_supply","rhsusf_m113d_usarmy","rhsusf_m113d_usarmy_M240","rhsusf_m113d_usarmy_medical","rhsusf_m113d_usarmy_MK19","rhsusf_m113d_usarmy_unarmed","RHS_M119_D","rhsusf_M1220_usarmy_d","rhsusf_M1220_M153_M2_usarmy_d","rhsusf_M1220_M2_usarmy_d","rhsusf_M1220_MK19_usarmy_d","rhsusf_M1230_M2_usarmy_d","rhsusf_M1230_MK19_usarmy_d","rhsusf_M1230a1_usarmy_d","rhsusf_M1232_usarmy_d","rhsusf_M1232_M2_usarmy_d","rhsusf_M1232_MK19_usarmy_d","rhsusf_M1237_M2_usarmy_d","rhsusf_M1237_MK19_usarmy_d","rhsusf_M142_usarmy_D","rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy","RHS_M252_D","RHS_M2A2","RHS_M2A2_BUSKI","RHS_M2A3","RHS_M2A3_BUSKI","RHS_M2A3_BUSKIII","RHS_M2StaticMG_D","RHS_M2StaticMG_MiniTripod_D","RHS_TOW_TriPod_D","RHS_M6","rhsusf_m966_d","rhsusf_M977A4_usarmy_d","rhsusf_M977A4_AMMO_usarmy_d","rhsusf_M977A4_REPAIR_usarmy_d","rhsusf_M977A4_AMMO_BKIT_usarmy_d","rhsusf_M977A4_AMMO_BKIT_M2_usarmy_d","rhsusf_M977A4_BKIT_usarmy_d","rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_d","rhsusf_M977A4_BKIT_M2_usarmy_d","rhsusf_M977A4_REPAIR_BKIT_usarmy_d","rhsusf_M978A4_usarmy_d","rhsusf_M978A4_BKIT_usarmy_d","RHS_MK19_TriPod_D"];
WVA = ["RHS_Stinger_AA_pod_WD","rhsusf_m1025_w_m2","rhsusf_m1025_w_mk19","rhsusf_m1025_w","rhsusf_m1043_w_m2","rhsusf_m1043_w_mk19","rhsusf_m1043_w","rhsusf_m1045_w","rhsusf_M1078A1P2_WD_fmtv_usarmy","rhsusf_M1078A1P2_WD_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_B_WD_fmtv_usarmy","rhsusf_M1078A1P2_B_WD_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_WD_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_WD_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_B_WD_CP_fmtv_usarmy","rhsusf_M1083A1P2_WD_fmtv_usarmy","rhsusf_M1083A1P2_WD_flatbed_fmtv_usarmy","rhsusf_M1083A1P2_B_WD_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_WD_flatbed_fmtv_usarmy","rhsusf_M1084A1P2_WD_fmtv_usarmy","rhsusf_M1084A1P2_B_WD_fmtv_usarmy","rhsusf_M1084A1P2_B_M2_WD_fmtv_usarmy","rhsusf_M1085A1P2_B_WD_Medical_fmtv_usarmy","rhsusf_m998_w_2dr_fulltop","rhsusf_m998_w_2dr_halftop","rhsusf_m998_w_2dr","rhsusf_m998_w_4dr_fulltop","rhsusf_m998_w_4dr","rhsusf_m109_usarmy","rhsusf_M1117_W","rhsusf_m113_usarmy_supply","rhsusf_m113_usarmy","rhsusf_m113_usarmy_M2_90","rhsusf_m113_usarmy_M240","rhsusf_m113_usarmy_medical","rhsusf_m113_usarmy_MK19","rhsusf_m113_usarmy_MK19_90","rhsusf_m113_usarmy_unarmed","RHS_M119_WD","rhsusf_M1220_usarmy_wd","rhsusf_M1220_M153_M2_usarmy_wd","rhsusf_M1220_M2_usarmy_wd","rhsusf_M1220_MK19_usarmy_wd","rhsusf_M1230a1_usarmy_wd","rhsusf_M1232_usarmy_wd","rhsusf_M1232_M2_usarmy_wd","rhsusf_M1232_MK19_usarmy_wd","rhsusf_M1237_M2_usarmy_wd","rhsusf_M1237_MK19_usarmy_wd","rhsusf_M142_usarmy_WD","rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy","RHS_M252_WD","RHS_M2A2_wd","RHS_M2A2_BUSKI_WD","RHS_M2A3_wd","RHS_M2A3_BUSKI_wd","RHS_M2A3_BUSKIII_wd","RHS_M2StaticMG_WD","RHS_M2StaticMG_MiniTripod_WD","RHS_TOW_TriPod_WD","RHS_M6_wd","rhsusf_m966_w","rhsusf_M977A4_usarmy_wd","rhsusf_M977A4_AMMO_usarmy_wd","rhsusf_M977A4_REPAIR_usarmy_wd","rhsusf_M977A4_BKIT_usarmy_wd","rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_wd","rhsusf_M977A4_AMMO_BKIT_usarmy_wd","rhsusf_M977A4_AMMO_BKIT_usarmy_wd","rhsusf_M977A4_BKIT_M2_usarmy_wd","rhsusf_M977A4_BKIT_M2_usarmy_wd","rhsusf_M977A4_AMMO_BKIT_M2_usarmy_wd","rhsusf_M977A4_AMMO_BKIT_M2_usarmy_wd","rhsusf_M977A4_REPAIR_BKIT_usarmy_wd","rhsusf_M978A4_usarmy_wd","rhsusf_M978A4_BKIT_usarmy_wd","RHS_MK19_TriPod_WD"];

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



