//Pawn compiler 3.2.3668	 	 	Copyright (c) 1997-2006, ITB CompuPhase
/*
                      __,__               
             .--.  .-"     "-.  .--.
            / .. \/  .-. .-.  \/ .. \       
           | |  '|  /   Y   \  |'  | |    /	
           | \   \  \ 0 | 0 /  /   / |   /
            \ '- ,\.-"`` ``"-./, -' / 	  /
             `'-' /_   ^ ^   _\ '-'`   /
             .--'|  \._ _ _./  |'--.
           /`    \   \.-.  /   /    `\
          /       '._/  |-' _.'       \
         /          ;  /--~'   |       \
        /        .'\|.-\--.     \       \
       /   .'-. /.-.;\  |\|'~'-.|\       \
       \       `-./`|_\_/ `     `\'.      \
        '.      ;     ___)        '.`;    /
          '-.,_ ;     ___)          \/   /
           \   ``'------'\       \   `  /
            '.    \       '.      |   ;/_
          ___>     '.       \_ _ _/   ,  '--.
        .'   '.   .-~~~~~-. /     |--'`~~-.  \
       // / .---'/  .-~~-._/ / / /---..__.'  /
      ((_(_/    /  /      (_(_(_(---.__    .'
                | |     _              `~~`
                | |     \'.
                 \ '....' |
                  '.,___.'
*/
#include <a_samp>

main(){}
#pragma dynamic 3000000
#undef MAX_PLAYERS
#define MAX_PLAYERS 60

#undef MAX_VEHICLES
#define MAX_VEHICLES	 	(300)
#include <djson>
#include <a_mysql>
#include <core>
#include <float>
#include <zcmd>
#include <streamer>
#include <dini>
#include <sscanf2>
#include <foreach>
#include <airbreak>
#include <antibot>
#include <fuckcleo>
#include <gvar>
#include <mSelection>

#emit LOAD.S.alt djson_GameModeExit
#emit LOAD.S.alt djson_GameModeInit

#define SERVER_IP "server.zerotr.com:7777"
#define PVG->%0->%1[%2] GetPVar%0(%2,#%1)
#define PVS->%0->%1[%2]->%3; SetPVar%0(%2,#%1,%3);

#include "zero-News.pwn"
#include "zero-Admin.pwn"
#include "zero-House.pwn"
#include "zero-Cmds.pwn"
#include "zero-Hack.pwn"
#include "zero-Functions.pwn"
#include "zero-Vehicles.pwn"
#if defined RACEPASIF
#include "zero-Race.pwn"
#endif
#include "zero-Key.pwn"

#emit LOAD.S.alt lotoTimer
#emit LOAD.S.pri lotoSayi
public OnGameModeInit()
{
    SetTimer("settimed",1000,true);
	CreateBoostPickup(0, 2066.7661,1534.1908,11.0731);
	CreateBoostPickup(1, 2066.4077,1143.2833,10.6719);
	CreateBoostPickup(2, 2048.5928,1143.3745,10.6719);
	CreateBoostPickup(3, 2048.7544,1532.9647,10.6719);
	CreateBoostPickup(4, 2048.774658, 878.921020, 6.647594);
	CreateBoostPickup(5, 2066.577148, 879.454589, 6.659519);
	CreateBoostPickup(6, 2106.698242, 850.658691, 6.287023);
	CreateBoostPickup(7, 2107.099365, 833.854431, 6.286451);
	CreateBoostPickup(8, 1807.184692, 851.799194, 10.231333);
	CreateBoostPickup(9, 1788.393676, 851.273681, 10.231507);
	CreateBoostPickup(10, 1788.881958, 833.801269, 10.345898);
	CreateBoostPickup(11, 1806.783325, 835.299621, 10.350403);
	CreateBoostPickup(12, 2348.787109, 1193.138916, 10.422252);
	CreateBoostPickup(13, 2122.041748, 1193.312011, 10.236352);
	CreateBoostPickup(14, 2128.827880, 2003.718627, 10.236504);
	CreateBoostPickup(15, 2146.643066, 2012.806518, 10.247924);
	CreateBoostPickup(16, 2236.657958, 2150.257080, 10.235893);
	CreateBoostPickup(17, 2236.635986, 2137.347656, 10.235713);
	CreateBoostPickup(18, 2230.385498, 2549.754882, 10.386494);
	CreateBoostPickup(19, 2527.773437, 2234.166992, 10.628980);
	CreateBoostPickup(20, 2507.352294, 1931.065307, 10.243422);
	CreateBoostPickup(21, 2471.243652, 1612.913085, 10.236004);
	CreateBoostPickup(22, 2708.660400, 1473.040527, 13.299428);
	CreateBoostPickup(23, 2795.364990, 1473.730224, 10.580481);
	CreateBoostPickup(24, 2724.234863, 1313.054199, 13.347465);
    CreateBoostPickup(25, -2009.882690, 44.785461, 31.895990);
    CreateBoostPickup(26, -2003.817871, 45.268703, 31.834438);
    CreateBoostPickup(27, -2001.908203, 672.413696, 44.489284);
    CreateBoostPickup(28, -2000.927246, 669.317321, 43.930709);
    CreateBoostPickup(29, -2009.854492, 42.453018, 32.226158);
    CreateBoostPickup(30, -1631.852294, 416.000701, 6.832955);
    CreateBoostPickup(31, -1540.404663, 750.863098, 6.840291);
    CreateBoostPickup(32, -1649.024414, 932.969421, 19.659933);
    CreateBoostPickup(33, -1841.521606, 932.849121, 31.645816);
    CreateBoostPickup(34, -1730.422973, 1183.192382, 24.771331);
    CreateBoostPickup(35, -1893.395751, 1384.092895, 6.976942);
    CreateBoostPickup(36, -1976.541748, 1384.987304, 6.976929);
    CreateBoostPickup(37, -2675.713867, 1329.986083, 55.134986);

    v1 = LoadModelSelectionMenu("v1-v17/v1.txt");
    v2 = LoadModelSelectionMenu("v1-v17/v2.txt");
    v3 = LoadModelSelectionMenu("v1-v17/v3.txt");
    v4 = LoadModelSelectionMenu("v1-v17/v4.txt");
    v5 = LoadModelSelectionMenu("v1-v17/v5.txt");
	v6 = LoadModelSelectionMenu("v1-v17/v6.txt");
	v7 = LoadModelSelectionMenu("v1-v17/v7.txt");
	v8 = LoadModelSelectionMenu("v1-v17/v8.txt");
	v9 = LoadModelSelectionMenu("v1-v17/v9.txt");
	v10 = LoadModelSelectionMenu("v1-v17/v10.txt");
	v11 = LoadModelSelectionMenu("v1-v17/v11.txt");
	v12 = LoadModelSelectionMenu("v1-v17/v12.txt");
	v13 = LoadModelSelectionMenu("v1-v17/v13.txt");
	v14 = LoadModelSelectionMenu("v1-v17/v14.txt");
	v15 = LoadModelSelectionMenu("v1-v17/v15.txt");
	v16 = LoadModelSelectionMenu("v1-v17/v16.txt");
	v17 = LoadModelSelectionMenu("v1-v17/v17.txt");

#if defined TDMPASIF
/*race eski textdraw
	Sayac0 = TextDrawCreate(341.000000, 2.000000, "~r~~h~05:00 ~b~~h~- ~g~~h~~h~00:00");
	TextDrawBackgroundColor(Sayac0, 255);
	TextDrawFont(Sayac0, 1);
	TextDrawLetterSize(Sayac0, 0.200000, 1.000000);
	TextDrawColor(Sayac0, -1);
	TextDrawSetOutline(Sayac0, 0);
	TextDrawSetProportional(Sayac0, 1);
	TextDrawSetShadow(Sayac0, 1);
	TextDrawUseBox(Sayac0, 1);
	TextDrawBoxColor(Sayac0, 255);
	TextDrawTextSize(Sayac0, 392.000000, 0.000000);
	TextDrawSetSelectable(Sayac0, 0);
*/
	Sayac2 = TextDrawCreate(122.000000, 313.000000, "_");
	TextDrawBackgroundColor(Sayac2, 255);
	TextDrawFont(Sayac2, 1);
	TextDrawLetterSize(Sayac2, 0.500000, 2.099999);
	TextDrawColor(Sayac2, -1);
	TextDrawSetOutline(Sayac2, 0);
	TextDrawSetProportional(Sayac2, 1);
	TextDrawSetShadow(Sayac2, 1);
	TextDrawUseBox(Sayac2, 1);
	TextDrawBoxColor(Sayac2, 95);
	TextDrawTextSize(Sayac2, 61.000000, 11.000000);
	TextDrawSetSelectable(Sayac2, 0);

	Sayac3 = TextDrawCreate(66.000000, 311.000000, "NaN~n~NaN");
	TextDrawBackgroundColor(Sayac3, 862362111);
	TextDrawFont(Sayac3, 2);
	TextDrawLetterSize(Sayac3, 0.160000, 1.200000);
	TextDrawColor(Sayac3, -1);
	TextDrawSetOutline(Sayac3, 0);
	TextDrawSetProportional(Sayac3, 1);
	TextDrawSetShadow(Sayac3, 0);
	TextDrawSetSelectable(Sayac3, 0);
#endif
	LoadServerTextDraws();
	LoadTextDraws();
	SetTimer("Timer",1000,1);
	//SetTimer("BalanceBaslat", 350000, 0);
	//SetTimer("Reklamlar",250000,1);
	CreateDynamicObject(7996, -2036.22693, 358.92151, 30.63860,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8355, -2086.90283, 346.34561, 33.00000,   180.00000, 0.00000, 90.00000);
	CreateDynamicObject(8355, -2086.90283, 386.34561, 33.00000,   180.00000, 0.00000, 90.00000);
	CreateDynamicObject(11317, -2045.98987, 349.79013, 44.95000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3877, -2075.61377, 330.11551, 48.27410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3877, -2075.62061, 372.10083, 48.27410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3877, -2042.69287, 372.04224, 48.27410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3877, -2042.23535, 357.53705, 48.27410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3877, -2016.39380, 357.14676, 48.27410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3877, -2016.38074, 330.16599, 48.27410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1649, -2016.52258, 342.67606, 35.82000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2016.56897, 338.33121, 35.82000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2016.60315, 334.26770, 35.82000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2016.52258, 342.67609, 38.82000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2016.52979, 347.05966, 35.82000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2016.52979, 347.05969, 38.32000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2016.54102, 351.35605, 35.82000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2016.54102, 351.35599, 38.32000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2016.54102, 353.35599, 35.82000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2016.54102, 353.35599, 38.32000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2016.52979, 347.05969, 41.32000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2016.52258, 342.67609, 42.11000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2016.52979, 347.05969, 44.60000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2016.52979, 351.50000, 41.32000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3271,1971.46618600,1521.30187900,6.20312500,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18771,2017.92004300,1532.41394000,9.37031900,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18809,1946.05895900,1455.75000000,76.45683200,270.00000000,179.30371000,179.05371000); //
	CreateDynamicObject(18826,1961.68688900,1491.58532700,76.43495900,270.00000000,180.00000000,91.99917600); //
	CreateDynamicObject(18826,1994.21679600,1471.60290500,76.43495900,270.00000000,180.00146400,272.00109800); //
	CreateDynamicObject(18809,2009.85156200,1507.48571700,76.40682900,270.00000000,179.30236800,179.04968200); //
	CreateDynamicObject(18824,1997.90771400,1551.93969700,76.38272000,270.00000000,179.99987700,44.99990800); //
	CreateDynamicObject(18824,1958.67346100,1551.77783200,76.38272000,270.00000000,179.99853500,135.49847400); //
	CreateDynamicObject(18826,1960.92126400,1521.34655700,69.63491000,296.32061700,4.51446500,93.04769800); //
	CreateDynamicObject(18826,1960.74572700,1542.49841300,62.20494800,270.00000000,180.00000000,83.00091500); //
	CreateDynamicObject(18826,1957.99438400,1523.67395000,56.02497800,296.68566800,11.18542400,99.01867600); //
	CreateDynamicObject(18836,1973.14001400,1556.25195300,48.22145800,0.00000000,0.00000000,358.00000000); //
	CreateDynamicObject(18826,1989.66723600,1590.49621500,48.20491700,270.00000000,180.00149500,91.25317300); //
	CreateDynamicObject(18811,2006.11450100,1555.75036600,48.17401100,270.25024400,269.99938900,270.74938900); //
	CreateDynamicObject(18809,2006.35278300,1505.93066400,48.13178200,270.00000000,179.30236800,179.04968200); //
	CreateDynamicObject(18826,1991.79138100,1472.07385200,55.97497500,296.68029700,11.18408200,99.01428200); //
	CreateDynamicObject(18826,1991.94714300,1493.93505800,62.07994000,270.00000000,179.99450600,98.99624600); //
	CreateDynamicObject(18826,2026.23620600,1477.98559500,62.07994000,270.00000000,180.00152500,276.99926700); //
	CreateDynamicObject(18809,2039.87646400,1514.91723600,62.07179200,270.00000000,180.19032200,182.18756100); //
	CreateDynamicObject(18811,2038.70520000,1563.86865200,62.03387400,270.24719200,269.99450600,270.74707000); //
	CreateDynamicObject(18826,2021.95812900,1598.21496500,62.02993700,270.00000000,180.00000000,92.99905300); //
	CreateDynamicObject(18826,1990.91503900,1576.16149900,62.00493600,270.00000000,179.99853500,270.99780200); //
	CreateDynamicObject(18824,1963.83276300,1605.91589300,66.68770500,310.83416700,238.17481900,105.13845800); //
	CreateDynamicObject(18750,1921.33728000,1415.57031200,90.56396400,89.74975500,0.00000000,179.75000000); //
	CreateDynamicObject(19129,1895.91000000,1424.75000000,71.55000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1649, -2016.52979, 351.50000, 44.60000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2016.52979, 354.50000, 41.32000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2016.52979, 354.50000, 44.60000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, -2018.77295, 355.49268, 35.82000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1649, -2023.09998, 355.48999, 35.82000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1649, -2027.38403, 355.48999, 35.82000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1649, -2031.66797, 355.48999, 35.82000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1649, -2035.95203, 355.48999, 35.82000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1649, -2040.23596, 355.48999, 35.82000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1649, -2018.77295, 355.49271, 37.72400,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1649, -2023.09998, 355.48999, 37.72400,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1649, -2027.38403, 355.48999, 37.72400,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1649, -2031.66797, 355.48999, 37.72400,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1649, -2035.95203, 355.48999, 37.72400,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1649, -2040.23596, 355.48999, 37.72400,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3851, -2023.94031, 330.12061, 41.71990,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, -2037.07300, 330.16608, 41.71990,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, -2050.11694, 330.18945, 41.71990,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, -2050.20630, 330.12573, 36.00790,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, -2037.08789, 330.19415, 36.00790,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, -2023.94922, 330.44037, 36.00790,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3753, -2043.88635, 362.28403, 21.16670,   180.00000, 0.00000, 180.00000);
	CreateDynamicObject(2395, -2039.66687, 357.78079, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2037.08252, 357.79434, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2034.47766, 357.80923, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2031.79370, 357.82950, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2029.11658, 357.83194, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2026.39453, 357.79916, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2023.71277, 357.83276, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2021.02332, 357.78677, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2018.28186, 357.82590, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2016.50977, 358.08139, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2016.48425, 361.67120, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2016.47229, 365.35889, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2016.45068, 368.97293, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2019.16992, 368.98059, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2019.16992, 365.35889, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2019.08496, 361.57513, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2021.54993, 365.35889, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2021.54993, 368.98059, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2021.54993, 361.57510, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2024.29016, 361.58493, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2024.29016, 365.35889, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2024.29016, 368.98059, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2026.91650, 361.58865, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2026.91650, 365.35889, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2026.91650, 368.98059, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2029.57776, 361.56100, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2029.61780, 365.28354, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2029.56299, 368.96375, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2032.31104, 365.31860, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2032.31860, 361.60101, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2032.23022, 368.98605, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2034.94385, 368.99478, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2034.93506, 365.29907, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2034.97559, 361.50729, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2037.61963, 361.58420, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2037.57971, 365.37589, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2037.59375, 369.01187, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2040.07336, 369.02069, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2039.72339, 365.25644, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, -2039.63184, 361.45599, 46.35590,   -90.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, -2037.07300, 356.82211, 41.71990,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, -2023.94031, 356.82211, 41.71990,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2044.47864, 343.53110, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2047.81055, 343.53110, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2050.76660, 343.53110, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2052.59229, 345.20477, 40.19590,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3850, -2019.98621, 337.41171, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2023.41821, 337.41171, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2026.85095, 337.39474, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2030.18298, 337.39471, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2033.58997, 337.39471, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2036.99902, 337.39471, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2040.43079, 337.38647, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2043.84924, 337.38651, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2047.28918, 337.38651, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2050.74121, 337.38651, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2054.16968, 337.39444, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2057.57617, 337.40417, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2061.00781, 337.42245, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2064.39990, 337.42249, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2067.80005, 337.42249, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2072.01196, 337.42249, 40.19590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, -2069.67212, 337.42249, 40.19590,   0.00000, 0.00000, 90.00000);

//PARS MAPPÝNG SF HOSPÝTAL
new tmpobjid;
tmpobjid = CreateDynamicObjectEx(9593,-2673.791,639.969,39.610,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14710, "vgshm3int2", "HSV_3carpet2", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 19058, "xmasboxes", "wrappingpaper16", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 2, 6988, "vgnfremnt1", "casinolights6lit3_256", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 3, 19058, "xmasboxes", "wrappingpaper16", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 4, 19058, "xmasboxes", "wrappingpaper16", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 5, 19058, "xmasboxes", "wrappingpaper16", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 6, 19058, "xmasboxes", "wrappingpaper16", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 7, 19058, "xmasboxes", "wrappingpaper16", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 8, 19058, "xmasboxes", "wrappingpaper16", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 9, 19058, "xmasboxes", "wrappingpaper16", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 10, 14736, "whorerooms", "AH_bathbigblu", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 11, 14736, "whorerooms", "AH_bathbigblu", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 12, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 13, 19058, "xmasboxes", "wrappingpaper20", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 14, 19058, "xmasboxes", "wrappingpaper20", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 15, 19058, "xmasboxes", "wrappingpaper20", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19327,-2675.530,634.942,21.436,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "[Z]", 10, "Calibri", 20, 1, 0xFFFF0000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19327,-2674.099,634.942,21.436,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "ERO", 10, "Calibri", 20, 1, 0xFFFF0000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19327,-2676.670,634.942,20.566,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "MUL", 10, "Calibri", 20, 1, 0xFFFF0000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19327,-2674.449,634.942,20.566,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "TI", 10, "Calibri", 20, 1, 0xFFFF0000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19327,-2673.257,634.942,20.546,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "GA", 10, "Calibri", 20, 1, 0xFFFF0000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19327,-2671.895,634.942,20.586,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "ME", 10, "Calibri", 20, 1, 0xFFFF0000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19327,-2674.547,634.942,18.036,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "CaL", 10, "Calibri", 20, 1, 0xFFFF0000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19327,-2672.957,634.942,18.026,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "d", 10, "Calibri", 20, 1, 0xFFFF0000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19327,-2672.406,634.942,18.036,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "er", 10, "Calibri", 20, 1, 0xFF000000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19327,-2674.907,634.942,19.736,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "BUI", 10, "Calibri", 20, 1, 0xFFFF0000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19327,-2673.236,634.942,19.746,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "LD", 10, "Calibri", 20, 1, 0xFFFF0000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19327,-2671.505,634.942,18.006,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "oN", 10, "Calibri", 20, 1, 0xFF000000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(18981,-2699.391,578.682,13.552,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2755, "ab_dojowall", "ab_trellis", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2689.367,578.682,13.552,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2755, "ab_dojowall", "ab_trellis", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2644.171,578.712,13.552,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2755, "ab_dojowall", "ab_trellis", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2624.242,578.712,13.552,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2755, "ab_dojowall", "ab_trellis", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2612.101,590.802,13.552,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2755, "ab_dojowall", "ab_trellis", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2612.101,615.672,13.552,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2755, "ab_dojowall", "ab_trellis", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2612.101,623.352,13.552,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2755, "ab_dojowall", "ab_trellis", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2623.851,635.023,13.552,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2755, "ab_dojowall", "ab_trellis", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2711.831,590.801,13.552,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2755, "ab_dojowall", "ab_trellis", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19449,-2588.089,663.185,16.815,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18062, "ab_sfammuitems01", "ammo_gunboard", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19449,-2561.317,662.940,16.815,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18062, "ab_sfammuitems01", "ammu_gunboard2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(14781,-2666.127,607.151,14.302,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2594.991,629.492,10.132,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 3095, "a51jdrx", "sam_camo", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2594.991,650.933,10.132,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 3095, "a51jdrx", "sam_camo", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2582.230,663.875,10.132,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 3095, "a51jdrx", "sam_camo", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2557.458,663.875,10.132,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 3095, "a51jdrx", "sam_camo", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2553.967,663.885,10.132,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 3095, "a51jdrx", "sam_camo", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2541.167,651.045,10.132,0.000,0.000,540.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 3095, "a51jdrx", "sam_camo", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2541.167,629.874,10.132,0.000,0.000,540.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 3095, "a51jdrx", "sam_camo", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19357,-2594.325,635.101,16.473,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18064, "ab_sfammuunits", "gun_targetb", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19357,-2542.004,650.832,16.473,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18064, "ab_sfammuunits", "gun_targeta", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19357,-2594.325,643.312,16.473,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18064, "ab_sfammuunits", "gun_targetc", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19357,-2541.617,635.091,16.473,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18064, "ab_sfammuunits", "gun_targetb", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19357,-2541.784,643.312,16.473,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18064, "ab_sfammuunits", "gun_targetc", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19357,-2574.585,662.672,16.733,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18064, "ab_sfammuunits", "gun_targetb", 0x00000000);
SetDynamicObjectMaterialText(tmpobjid, 0, "TSK", 10, "Ariel", 20, 1, 0xFFFF0000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19357,-2594.466,650.832,16.473,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18064, "ab_sfammuunits", "gun_targetb", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18646,-2558.372,636.489,13.299,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18064, "ab_sfammuunits", "gun_targetb", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18646,-2558.372,653.040,13.299,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18064, "ab_sfammuunits", "gun_targetb", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18646,-2575.710,653.040,13.299,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18064, "ab_sfammuunits", "gun_targetb", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18646,-2575.710,635.509,13.299,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18064, "ab_sfammuunits", "gun_targetb", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2586.963,617.532,13.552,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2755, "ab_dojowall", "ab_trellis", 0x00000000);
tmpobjid = CreateDynamicObjectEx(18981,-2548.214,617.532,13.552,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2755, "ab_dojowall", "ab_trellis", 0x00000000);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    
    tmpobjid = CreateObject(3074, -280.10138, 1524.06128, 76.19785,   0.00000, 0.00000, 132.77997);
    SetObjectMaterialText(tmpobjid, "{FF0000}Zero \n{0000FF}Online", 0, OBJECT_MATERIAL_SIZE_512x512,
    "Arial", 140, 0, 0xFFFF8200, 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

    tmpobjid = CreateObject(3074, -1676.33411, 1556.94592, -0.21265,   0.00000, 0.00000, 89.40002);
    SetObjectMaterialText(tmpobjid, "{FF0000}Zero", 0, OBJECT_MATERIAL_SIZE_512x512,
    "Arial", 140, 0, 0xFFFF8200, 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

      tmpobjid = CreateObject(3074, -1712.15430, 1556.94592, -0.21260,   0.00000, 0.00000, 89.57997);
    SetObjectMaterialText(tmpobjid, "{0000FF}Online", 0, OBJECT_MATERIAL_SIZE_512x512,
    "Arial", 140, 0, 0xFFFF8200, 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

     tmpobjid = CreateObject(3074, 2649.77734, 589.20715, 13.07106,   0.00000, 0.00000, 138.30006);
    SetObjectMaterialText(tmpobjid, "{FF0000}Zero \n{0000FF}Online", 0, OBJECT_MATERIAL_SIZE_512x512,
    "Arial", 140, 0, 0xFFFF8200, 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

     tmpobjid = CreateObject(3074, -2683.10571, 587.89539, 13.07110,   0.00000, 0.00000, 44.16000);
    SetObjectMaterialText(tmpobjid, "{FF0000}Zero \n{0000FF}Online", 0, OBJECT_MATERIAL_SIZE_512x512,
    "Arial", 140, 0, 0xFFFF8200, 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

    tmpobjid = CreateObject(3074, 1329.84448, -249.19830, 28.65990,   0.00000, 50.00000, 199.13980);
    SetObjectMaterialText(tmpobjid, "{FF0000}Zero \n{0000FF}Online", 0, OBJECT_MATERIAL_SIZE_512x512,
    "Arial", 140, 0, 0xFFFF8200, 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
tmpobjid = CreateDynamicObjectEx(2068,-2590.430,657.996,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2583.999,657.996,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2577.290,657.996,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2570.430,657.996,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2562.989,657.996,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2555.889,657.996,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2548.618,657.996,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2548.618,647.925,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2555.968,647.925,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2563.760,647.925,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2571.112,647.925,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2577.993,647.925,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2584.924,647.925,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2591.574,647.925,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2589.694,637.685,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2579.854,637.685,19.303,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2571.143,637.685,19.503,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2563.352,637.685,19.503,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2554.662,637.685,19.503,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2068,-2548.281,637.685,19.503,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(3066,-2575.650,662.306,14.433,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18646,-2564.704,642.110,20.249,0.000,0.000,0.000,300.000,300.000);
//ÝBO DJ
tmpobjid = CreateDynamicObjectEx(19377,1964.701,1911.844,935.113,0.000,90.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper4-2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1969.856,1911.836,936.529,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1965.226,1916.666,936.529,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1965.226,1906.954,936.529,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(14387,1958.141,1914.312,934.198,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(14387,1958.141,1909.611,934.198,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1958.596,1906.952,936.529,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1958.596,1916.694,936.529,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1953.355,1912.204,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(14387,1958.001,1904.961,934.198,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1953.985,1902.112,936.529,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1953.835,1921.442,936.529,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1953.365,1922.704,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1953.365,1901.741,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1949.375,1926.214,936.529,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1949.284,1897.211,936.529,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1943.755,1901.741,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1943.725,1912.213,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1943.735,1922.704,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1944.575,1930.954,936.529,0.000,0.000,360.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1939.954,1931.295,936.529,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1943.747,1933.175,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1934.127,1933.175,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1934.127,1922.704,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1934.127,1912.254,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1934.127,1901.754,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1939.653,1897.211,936.529,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1930.033,1897.211,936.529,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1925.263,1902.121,936.529,0.000,0.000,360.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1920.343,1906.880,936.529,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1925.263,1921.341,936.529,0.000,0.000,360.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1925.263,1930.971,936.529,0.000,0.000,360.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1930.354,1931.295,936.529,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1924.497,1933.175,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1924.497,1922.695,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1924.497,1912.206,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1924.497,1901.726,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1920.993,1931.295,936.529,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19449,1952.358,1902.074,935.056,0.000,90.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper4-2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1950.664,1902.112,929.870,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1955.455,1906.822,929.870,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
tmpobjid = CreateDynamicObjectEx(12950,1953.299,1910.132,931.684,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19531,1949.878,1868.947,941.724,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19449,1945.828,1898.434,935.056,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper4-2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19449,1936.259,1898.434,935.056,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper4-2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19449,1926.696,1898.434,935.056,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper4-2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1918.123,1911.750,936.529,0.000,0.000,540.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1920.524,1916.571,936.529,0.000,0.000,630.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1914.938,1912.206,933.129,0.000,90.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1924.912,1914.895,933.129,0.000,0.000,540.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1919.876,1910.104,932.008,0.000,180.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1924.912,1914.895,945.569,0.000,0.000,540.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19387,1924.809,1908.475,934.725,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18641, "flashlight1", "metalblack1-2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1924.912,1905.534,941.698,0.000,0.000,540.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(12950,1923.068,1909.468,933.955,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1919.596,1914.854,937.218,0.000,270.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1950.664,1900.180,929.870,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1941.054,1900.180,929.870,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1931.435,1900.180,929.870,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1921.765,1900.180,929.870,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
tmpobjid = CreateDynamicObjectEx(970,1950.655,1902.228,935.625,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
tmpobjid = CreateDynamicObjectEx(970,1948.624,1900.158,935.625,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
tmpobjid = CreateDynamicObjectEx(970,1944.464,1900.158,935.625,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
tmpobjid = CreateDynamicObjectEx(970,1940.363,1900.158,935.625,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
tmpobjid = CreateDynamicObjectEx(970,1936.223,1900.158,935.625,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
tmpobjid = CreateDynamicObjectEx(970,1932.052,1900.158,935.625,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
tmpobjid = CreateDynamicObjectEx(12950,1926.078,1905.461,931.754,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(970,1928.832,1900.148,935.625,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1935.743,1930.954,936.529,0.000,0.000,360.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19387,1934.059,1926.155,934.725,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18641, "flashlight1", "metalblack1-2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1930.953,1926.202,941.469,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1927.713,1926.202,931.069,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1921.573,1926.202,941.429,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1940.593,1926.202,941.429,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19387,1937.359,1926.215,934.725,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18641, "flashlight1", "metalblack1-2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1943.784,1926.272,930.959,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 2627, "genintint_gym", "bench_test2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1930.194,1931.485,933.189,0.000,90.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19853, "mihouse1", "tilesswimmingpool2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1939.823,1931.485,933.189,0.000,90.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19853, "mihouse1", "tilesswimmingpool2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1930.364,1931.265,936.529,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1925.463,1931.041,936.529,0.000,0.000,360.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1930.953,1926.242,941.469,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1921.573,1926.232,941.429,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1927.713,1926.222,931.069,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1935.693,1931.014,936.529,0.000,0.000,360.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1935.783,1931.014,936.529,0.000,0.000,360.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1944.515,1931.004,936.529,0.000,0.000,360.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1943.784,1926.292,930.959,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1940.593,1926.232,941.469,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1502,1933.249,1926.187,933.215,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14489, "carlspics", "AH_picture3", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 10713, "gayclub_sfs", "CJ_PIZZA_DOOR", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1502,1936.540,1926.197,933.215,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14489, "carlspics", "AH_picture3", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 10713, "gayclub_sfs", "CJ_PIZZA_DOOR", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19449,1926.516,1921.454,935.056,0.000,90.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper4-2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19449,1927.796,1924.533,935.036,0.000,90.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper4-2", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1923.434,1916.661,929.870,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1928.226,1921.432,929.870,0.000,0.000,360.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1927.746,1922.802,929.870,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
tmpobjid = CreateDynamicObjectEx(12950,1925.536,1912.500,931.714,0.000,0.000,720.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 6871, "vegascourtbld", "marbletilewal1_256", 0x00000000);
tmpobjid = CreateDynamicObjectEx(970,1930.442,1922.798,935.625,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
tmpobjid = CreateDynamicObjectEx(970,1928.273,1920.677,935.625,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 18757, "vcinteriors", "dt_office_gls_text", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19449,1932.477,1924.318,930.230,91.300,360.000,-179.500,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
tmpobjid = CreateDynamicObjectEx(14537,1951.692,1922.523,934.995,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2292,1947.388,1901.130,933.215,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1946.993,1901.152,933.215,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1946.122,1901.152,933.215,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1945.252,1901.152,933.215,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1944.542,1901.152,933.215,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1943.622,1901.152,933.215,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1942.731,1901.152,933.215,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2292,1941.351,1901.095,933.215,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1823,1946.420,1902.244,933.215,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1823,1942.136,1902.471,933.215,0.000,0.000,21.899,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1934.541,1901.152,933.215,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1935.381,1901.152,933.215,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1936.272,1901.152,933.215,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1936.582,1903.352,933.215,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1936.582,1904.173,933.215,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1933.461,1903.142,933.215,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1933.461,1902.262,933.215,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1823,1934.792,1902.321,933.215,0.000,0.000,21.899,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2292,1928.807,1917.080,933.215,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1928.810,1917.471,933.215,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1928.810,1918.302,933.215,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1928.810,1919.162,933.215,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1928.810,1920.043,933.215,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1928.810,1920.893,933.215,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1928.660,1922.263,933.215,0.000,0.000,720.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1929.481,1922.263,933.215,0.000,0.000,720.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2291,1930.451,1922.263,933.215,0.000,0.000,720.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2292,1931.832,1922.305,933.215,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1823,1930.313,1917.107,933.215,0.000,0.000,21.899,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1823,1930.681,1920.078,933.215,0.000,0.000,21.899,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1723,1949.721,1897.828,935.142,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1723,1944.960,1897.828,935.142,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1723,1939.941,1897.828,935.142,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2315,1947.832,1899.599,935.142,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2315,1942.897,1899.602,935.142,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2315,1937.987,1899.602,935.142,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1724,1932.280,1898.852,935.142,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1724,1936.141,1900.032,935.142,0.000,0.000,270.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1433,1934.107,1899.452,935.292,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1724,1929.320,1897.682,935.142,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1724,1927.559,1897.682,935.142,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1724,1928.010,1919.001,935.142,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1724,1927.089,1922.312,935.142,0.000,0.000,360.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1433,1927.687,1920.582,935.292,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1724,1928.090,1925.513,935.142,0.000,0.000,360.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1724,1930.780,1925.513,935.142,0.000,0.000,360.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14738, "whorebar", "AH_cheapwindow", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2491,1945.978,1906.973,932.874,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2491,1942.268,1906.973,932.874,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2491,1937.737,1906.973,932.874,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
tmpobjid = CreateDynamicObjectEx(2491,1932.927,1906.973,932.874,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 19058, "xmasboxes", "wrappingpaper28", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1928.103,1930.941,941.389,0.000,0.000,540.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1923.253,1928.800,936.529,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19387,1928.094,1930.220,934.515,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19387,1928.044,1927.739,934.515,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1923.183,1931.191,934.909,0.000,0.000,630.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1941.373,1931.004,941.179,0.000,0.000,360.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19387,1941.387,1930.079,934.775,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19377,1946.213,1928.774,937.319,0.000,0.000,450.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19387,1941.427,1927.809,934.775,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "ceilingtiles4-128x128", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19357,1969.836,1911.841,936.719,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "vgncorpdoor1_512", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19329,1918.287,1913.756,940.595,-0.400,-39.400,88.100,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "DJ", 20, "Ariel", 20, 1, 0xFF0000A0, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19329,1918.303,1914.143,940.123,-0.400,-39.400,88.100,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "ChrisJake", 20, "Ariel", 20, 1, 0xFF0000A0, 0x00000000, 0);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
tmpobjid = CreateDynamicObjectEx(18648,1954.195,1918.742,941.915,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1954.195,1923.362,941.915,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1950.546,1926.014,941.595,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1945.406,1926.564,941.945,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1941.106,1926.564,941.945,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1936.406,1926.564,941.945,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1933.035,1926.564,941.945,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1929.715,1926.564,941.945,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1925.635,1926.564,941.945,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1924.935,1923.104,941.865,0.000,0.000,180.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1924.946,1913.413,942.065,0.000,0.000,180.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1924.935,1905.603,941.865,0.000,0.000,180.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1924.935,1898.823,941.865,0.000,0.000,180.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1929.165,1896.923,941.865,0.000,0.000,270.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1934.975,1896.923,941.865,0.000,0.000,270.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1941.485,1896.923,941.865,0.000,0.000,270.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1947.315,1896.923,941.865,0.000,0.000,270.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1951.155,1896.923,941.865,0.000,0.000,270.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1954.035,1898.883,941.865,0.000,0.000,360.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1954.035,1903.754,941.865,0.000,0.000,360.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(5992,1923.455,1913.497,943.944,0.000,0.000,270.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1955.775,1906.525,941.865,0.000,0.000,450.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1958.046,1906.525,941.865,0.000,0.000,450.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1962.366,1906.525,941.865,0.000,0.000,450.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1966.037,1906.525,941.865,0.000,0.000,450.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1967.546,1916.965,941.846,0.000,0.000,450.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1962.556,1916.965,941.846,0.000,0.000,450.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18648,1956.567,1916.965,941.846,0.000,0.000,450.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18655,1924.892,1909.873,936.495,0.000,0.000,180.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18655,1925.212,1917.293,936.495,0.000,0.000,180.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18102,1947.469,1917.841,941.675,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18102,1940.328,1917.841,941.675,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2773,1951.823,1906.604,935.635,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2773,1950.843,1905.464,935.635,0.000,0.000,180.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2773,1927.163,1916.924,935.635,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2773,1928.083,1917.965,935.635,0.000,0.000,180.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2773,1932.423,1924.435,935.635,0.000,0.000,180.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1716,1949.959,1917.354,933.215,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1716,1947.749,1917.354,933.215,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1716,1946.610,1918.784,933.215,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1716,1946.610,1920.544,933.215,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2524,1928.875,1930.530,933.275,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2524,1930.676,1930.530,933.275,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2524,1932.876,1930.530,933.275,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1929.669,1931.136,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1929.669,1931.136,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1929.669,1931.136,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1929.669,1931.136,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1929.669,1931.136,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1929.669,1931.136,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1929.669,1931.136,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1929.669,1931.136,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1929.669,1931.136,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1929.669,1931.136,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1929.669,1931.136,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1929.669,1931.136,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1929.669,1931.136,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2528,1926.160,1927.300,933.275,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2528,1926.160,1930.100,933.275,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1523,1928.026,1928.526,932.854,0.000,0.000,270.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1523,1928.026,1930.996,932.854,0.000,0.000,270.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(19159,1940.017,1914.949,941.454,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2525,1943.840,1930.267,933.255,0.000,0.000,270.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2525,1943.840,1927.176,933.255,0.000,0.000,270.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1523,1941.435,1929.371,933.275,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1523,1941.475,1926.979,933.275,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1937.830,1931.126,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1937.830,1931.126,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1937.830,1931.126,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1937.830,1931.126,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1937.830,1931.126,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1937.830,1931.126,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1937.830,1931.126,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1937.830,1931.126,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1937.830,1931.126,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18001,1937.830,1931.126,935.425,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2524,1936.835,1930.530,933.275,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2524,1938.265,1930.530,933.275,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2524,1940.155,1930.530,933.275,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1510,1946.836,1902.795,933.735,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1520,1947.125,1902.579,933.785,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1946.606,1902.663,933.815,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1951,1942.468,1903.199,933.895,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1951,1942.698,1903.199,933.895,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1942.152,1903.010,933.805,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1942.152,1902.800,933.805,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1935.562,1902.800,933.805,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1934.901,1903.131,933.805,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1934.901,1902.710,933.805,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1935.262,1903.381,933.805,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1951,1932.660,1906.590,934.925,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1932.802,1906.892,934.855,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1932.582,1906.892,934.855,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1937.352,1906.892,934.855,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1937.352,1906.682,934.855,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1937.562,1906.682,934.855,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1509,1941.960,1906.728,934.935,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1942.052,1906.882,934.855,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1520,1945.702,1906.638,934.845,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1520,1945.702,1906.949,934.845,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1520,1948.913,1899.489,935.675,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1520,1947.852,1899.489,935.675,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1949.056,1899.368,935.742,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1948.236,1899.368,935.742,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1944.256,1899.368,935.742,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1943.196,1899.368,935.742,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1951,1934.106,1899.468,935.962,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1934.355,1899.368,935.882,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1667,1933.765,1899.368,935.882,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1544,1930.879,1917.799,933.715,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1544,1930.518,1917.709,933.715,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1517,1930.823,1920.666,933.905,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(14391,1922.424,1913.361,937.984,0.000,0.000,180.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2229,1924.935,1910.771,936.865,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2229,1924.815,1915.722,936.865,0.000,0.000,90.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2240,1969.297,1916.105,935.679,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(2240,1969.297,1907.614,935.679,0.000,0.000,0.000,300.000,300.000);

tmpobjid = CreateDynamicObjectEx(5409,1919.167,-1777.129,16.992,0.000,0.000,360.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampwhite", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 2, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 4, 18996, "mattextures", "sampwhite", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 5, 18996, "mattextures", "sampwhite", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 6, 18996, "mattextures", "sampwhite", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 7, 18996, "mattextures", "sampwhite", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 8, 18996, "mattextures", "sampwhite", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 9, 18996, "mattextures", "sampwhite", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 10, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 11, 18996, "mattextures", "sampwhite", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 12, 18996, "mattextures", "sampwhite", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 13, 18996, "mattextures", "sampwhite", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 14, 18996, "mattextures", "sampwhite", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 15, 18996, "mattextures", "sampwhite", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1676,1942.096,-1768.045,14.052,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 2, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 3, 18996, "mattextures", "sampwhite", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 4, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 15, 18996, "mattextures", "sampwhite", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1676,1942.096,-1770.536,14.052,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 2, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 3, 18996, "mattextures", "sampwhite", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 4, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 15, 18996, "mattextures", "sampwhite", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1676,1942.096,-1775.377,14.052,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 2, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 3, 18996, "mattextures", "sampwhite", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 4, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 15, 18996, "mattextures", "sampwhite", 0x00000000);
tmpobjid = CreateDynamicObjectEx(1676,1942.096,-1778.517,14.052,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 1, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 2, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 3, 18996, "mattextures", "sampwhite", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 4, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 15, 18996, "mattextures", "sampwhite", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19357,1951.837,-1762.624,23.302,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampred", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19357,1951.377,-1762.624,23.302,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampred", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 3, 18996, "mattextures", "sampwhite", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19430,1951.349,-1762.204,22.602,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "P", 10, "Quartz MS", 20, 1, 0xFFFFFFFF, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19430,1951.356,-1763.262,22.642,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "O", 10, "Quartz MS", 20, 1, 0xFFFFFFFF, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19430,1951.899,-1762.984,22.602,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "P", 10, "Quartz MS", 20, 1, 0xFFFFFFFF, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19430,1951.866,-1762.002,22.642,0.000,0.000,180.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "O", 10, "Quartz MS", 20, 1, 0xFFFFFFFF, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19329,1936.895,-1764.055,18.032,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "PETROL", 20, "Quartz MS", 20, 1, 0xFFFFFFFF, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19329,1934.465,-1764.055,18.032,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "OFISI", 20, "Quartz MS", 20, 1, 0xFFFFFFFF, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19329,1951.783,-1761.732,21.002,0.000,0.000,-10.799,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "Kursunlu benzin", 40, "Calibri", 20, 1, 0xFF000000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19329,1951.626,-1761.590,20.202,0.000,0.000,-10.799,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "4,30", 20, "Engravers MT", 20, 1, 0xFFFFFFFF, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19329,1951.183,-1761.627,19.652,0.000,0.000,-10.799,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "Dizel", 40, "Calibri", 20, 1, 0xFF000000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19329,1951.603,-1761.709,19.102,0.000,0.000,-10.799,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "3,50", 20, "Engravers MT", 20, 1, 0xFFFFFFFF, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19329,1951.576,-1761.694,18.432,0.000,0.000,-10.799,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "Kursunsuz benzin", 40, "Calibri", 20, 1, 0xFF000000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19329,1951.603,-1761.709,17.772,0.000,0.000,-10.799,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "4,36", 20, "Engravers MT", 20, 1, 0xFFFFFFFF, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19329,1950.977,-1761.580,17.172,0.000,0.000,-10.799,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "LPG", 40, "Calibri", 20, 1, 0xFF000000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19329,1951.564,-1761.701,16.722,0.000,0.000,-10.799,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "1,74", 20, "Engravers MT", 20, 1, 0xFFFFFFFF, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19430,1940.604,-1780.639,16.655,89.500,270.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampwhite", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19329,1940.108,-1780.519,16.602,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "MILANGAZ", 40, "Engravers MT", 20, 1, 0xFF005E8A, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19329,1939.747,-1780.529,16.952,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, ".", 40, "Engravers MT", 20, 1, 0xFFFF0000, 0x00000000, 0);
tmpobjid = CreateDynamicObjectEx(19357,1928.510,-1785.652,14.096,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 10755, "airportrminl_sfse", "mirrwind4_LAn", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19357,1928.510,-1782.441,14.096,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 10755, "airportrminl_sfse", "mirrwind4_LAn", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19357,1928.480,-1780.490,14.096,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 10755, "airportrminl_sfse", "mirrwind4_LAn", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19357,1928.480,-1773.740,14.096,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 10755, "airportrminl_sfse", "mirrwind4_LAn", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19357,1928.480,-1770.529,14.096,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 10755, "airportrminl_sfse", "mirrwind4_LAn", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19357,1928.470,-1768.628,14.096,0.000,0.000,0.000,300.000,300.000);
SetDynamicObjectMaterial(tmpobjid, 0, 10755, "airportrminl_sfse", "mirrwind4_LAn", 0x00000000);
tmpobjid = CreateDynamicObjectEx(19329,1928.551,-1776.643,16.482,0.000,0.000,90.000,300.000,300.000);
SetDynamicObjectMaterialText(tmpobjid, 0, "MARKET", 40, "Quartz MS", 20, 1, 0xFFFFFFFF, 0x00000000, 0);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
tmpobjid = CreateDynamicObjectEx(983,1941.462,-1769.644,13.312,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(983,1941.462,-1776.105,13.312,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(983,1942.592,-1776.305,13.312,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(983,1942.592,-1769.855,13.312,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(628,1930.259,-1786.528,14.432,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(628,1930.382,-1766.751,14.452,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1343,1927.923,-1766.606,13.319,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(638,1951.676,-1776.366,12.846,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(638,1951.676,-1773.755,12.846,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(638,1951.676,-1771.125,12.846,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(638,1951.676,-1768.476,12.846,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(638,1951.676,-1765.855,12.846,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(638,1951.676,-1764.164,12.876,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18075,1946.518,-1771.890,17.746,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(18075,1938.108,-1771.890,17.746,0.000,0.000,0.000,300.000,300.000);
tmpobjid = CreateDynamicObjectEx(1616,1933.570,-1763.796,18.782,0.000,0.000,270.000,300.000,300.000);
	new caca1 = CreateObject(11359, -2043.89270, 329.62891, 44.94210,   0.00000, 0.00000, 180.00000);
	new caca2 = CreateObject(11359, -2050.50122, 329.86368, 37.45410,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(3851, -2068.04126, 330.30029, 41.71990,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, -2068.04126, 330.30029, 36.10390,   0.00000, 0.00000, 90.00000);
	new caca = CreateObject(11359, 709.63342, -1638.50000, 2.42490,   0.00000, 0.00000, 90.00000);
	new caca5 =CreateObject(11359, 709.63342, -1627.00000, 2.42490,   0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(caca, "{000000}[Z]ero Freeroam\n{00FF66}Build 1" , 0, 50, "Segoe UI Light", 16, 0, 0x00000000, 0xFFFFFFAA, 1);
	SetObjectMaterialText(caca5, "{f45865}Stunt{343434}/{5cd622}DM{343434}/{fecb24}MiniGames" , 0, 50, "Segoe UI Light", 16, 0, 0x00000000, 0xFFFFFFFF, 1);
	SetObjectMaterialText(caca1, "CaLderoN Bank" , 0, 50, "Segoe UI Light", 16, 0, 0x00000000, 0xFFFFFFFF, 1);
	SetObjectMaterialText(caca2, "The CaLderoN Bank", 0, 50, "Segoe UI Light", 16, 0, 0x00000000, 0xFFFFFFFF, 1);
	SetTimer("TextleriGuncelled", 1100, true);
	CreateDynamic3DTextLabel( "{FFFFFF}::[ {00a7c2}Spawn Bölgesi{FFFFFF} ]::\n{C0C0C0}Santa Maria Beach\n{FF8000}Zýrh-Can'ýnýzý /cz ile ücretsiz fulleyebilirsiniz. www.zerotr.com", 0x33CCFFFF, 437.8750,-1853.6279,3.4921, 80.0, 0xFFFF, 0xFFFF, 1 );
	CreateDynamic3DTextLabel( "{FFFFFF}::[ {00a7c2}Spawn Bölgesi{FFFFFF} ]::\n{C0C0C0}Disco Zone\n{FF8000}Zýrh-Can'ýnýzý /cz ile ücretsiz fulleyebilirsiniz. www.zerotr.com", 0x33CCFFFF, 1291.2681,-231.3453,12.3748, 80.0, 0xFFFF, 0xFFFF, 1 );
	CreateDynamic3DTextLabel( "{FFFFFF}::[ {00a7c2}Spawn Bölgesi{FFFFFF} ]::\n{C0C0C0}Drift Zone\n{FF8000}Zýrh-Can'ýnýzý /cz ile ücretsiz fulleyebilirsiniz. www.zerotr.com", 0x33CCFFFF, -299.3183,1506.0825,83.6708, 80.0, 0xFFFF, 0xFFFF, 1 );
	CreateDynamic3DTextLabel( "{FFFFFF}::[ {00a7c2}Spawn Bölgesi{FFFFFF} ]::\n{C0C0C0}Pimps\n{FF8000}Zýrh-Can'ýnýzý /cz ile ücretsiz fulleyebilirsiniz. www.zerotr.com", 0x33CCFFFF, -2676.4851,623.9783,14.4459, 80.0, 0xFFFF, 0xFFFF, 1 );
	CreateDynamic3DTextLabel( "{FFFFFF}::[ {00a7c2}Spawn Bölgesi{FFFFFF} ]::\n{C0C0C0}Big Hotel\n{FF8000}Zýrh-Can'ýnýzý /cz ile ücretsiz fulleyebilirsiniz. www.zerotr.com", 0x33CCFFFF, -1699.4066,1624.1786,2.2680, 80.0, 0xFFFF, 0xFFFF, 1 );
	CreateDynamic3DTextLabel( "{FFFFFF}::[ {00a7c2}Spawn Bölgesi{FFFFFF} ]::\n{C0C0C0}Restourant\n{FF8000}Zýrh-Can'ýnýzý /cz ile ücretsiz fulleyebilirsiniz. www.zerotr.com", 0x33CCFFFF, -2138.0576, -2373.5544, 32.0264, 80.0, 0xFFFF, 0xFFFF, 1 );

	#if defined RACEPASIF
	yaristimer = SetTimer("YarisBaslat", 150000, true);
	yariskalansure = GetTickCount()+150000;
	#endif
	UsePlayerPedAnims();
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	OnlineSayisi = 0;
	RekorSayisi = 0;
	format(RekorTarihi, sizeof(RekorTarihi), "-");
	djson_GameModeInit();

	if(fexist("rekor.json")) {
		RekorSayisi = djInt("rekor.json", "rekor");
	    format(RekorTarihi, sizeof(RekorTarihi), "%s", dj("rekor.json", "tarih"));

	    print("\n==========================================");
	    printf("    Sunucu Rekoru: %d Online.", RekorSayisi);
	    printf("    Rekor Tarihi: %s", RekorTarihi);
	    print("==========================================\n");

	    #if REKOR_TEXT == 1
	        new string[128];
	        format(string, sizeof(string), "~b~~h~~h~~h~Rekor: ~w~~h~~h~~h~%d Online~n~~b~~h~~h~~h~Rekor Tarihi: ~w~~h~~h~~h~%s", RekorSayisi, RekorTarihi);

			RekorTextDraw = TextDrawCreate(500.000000, 4.000000, string);
			TextDrawBackgroundColor(RekorTextDraw, 255);
			TextDrawFont(RekorTextDraw, 1);
			TextDrawLetterSize(RekorTextDraw, 0.200000, 1.000000);
			TextDrawColor(RekorTextDraw, -1);
			TextDrawSetOutline(RekorTextDraw, 1);
			TextDrawSetProportional(RekorTextDraw, 1);
			TextDrawSetSelectable(RekorTextDraw, 0);
		#endif
    }else{
        print("\n==========================================");
	    print("    Rekor Sistemi: scriptfiles/rekor.json bulunamadi!");
	    print("==========================================\n");
	    SendRconCommand("unloadfs rekor");
    }

	#if defined TDMPASIF
	SetTimer("TDMBASLAT", 500000, true);
	#endif

	BankTD0 = TextDrawCreate(646.250000, -10.000000, "_");
	TextDrawBackgroundColor(BankTD0, 255);
	TextDrawFont(BankTD0, 1);
	TextDrawLetterSize(BankTD0, 100.000000, 500.000000);
	TextDrawColor(BankTD0, -1);
	TextDrawSetOutline(BankTD0, 0);
	TextDrawSetProportional(BankTD0, 1);
	TextDrawSetShadow(BankTD0, 1);
	TextDrawUseBox(BankTD0, 1);
	TextDrawBoxColor(BankTD0, -918532353);
	TextDrawTextSize(BankTD0, -10.000000, 75.000000);
	TextDrawSetSelectable(BankTD0, 0);

	BankTD2 = TextDrawCreate(30.000000, 173.000000, "Hesap Hareketleri");
	TextDrawBackgroundColor(BankTD2, 255);
	TextDrawFont(BankTD2, 1);
	TextDrawLetterSize(BankTD2, 0.340000, 1.400000);
	TextDrawColor(BankTD2, -1);
	TextDrawSetOutline(BankTD2, 1);
	TextDrawSetProportional(BankTD2, 1);
	TextDrawSetSelectable(BankTD2, 1);

	BankTD3 = TextDrawCreate(30.000000, 197.000000, "Para Cek");
	TextDrawBackgroundColor(BankTD3, 255);
	TextDrawFont(BankTD3, 1);
	TextDrawLetterSize(BankTD3, 0.340000, 1.400000);
	TextDrawColor(BankTD3, -1);
	TextDrawSetOutline(BankTD3, 1);
	TextDrawSetProportional(BankTD3, 1);
	TextDrawSetSelectable(BankTD3, 1);

	BankTD4 = TextDrawCreate(30.000000, 225.000000, "Para Yatir");
	TextDrawBackgroundColor(BankTD4, 255);
	TextDrawFont(BankTD4, 1);
	TextDrawLetterSize(BankTD4, 0.340000, 1.400000);
	TextDrawColor(BankTD4, -1);
	TextDrawSetOutline(BankTD4, 1);
	TextDrawSetProportional(BankTD4, 1);
	TextDrawSetSelectable(BankTD4, 1);

	BankTD5 = TextDrawCreate(30.000000, 251.000000, "Havale/EFT");
	TextDrawBackgroundColor(BankTD5, 255);
	TextDrawFont(BankTD5, 1);
	TextDrawLetterSize(BankTD5, 0.340000, 1.400000);
	TextDrawColor(BankTD5, -1);
	TextDrawSetOutline(BankTD5, 1);
	TextDrawSetProportional(BankTD5, 1);
	TextDrawSetSelectable(BankTD5, 1);

	BankTD9 = TextDrawCreate(405.000000, 178.000000, "Primlerini Cek");
	TextDrawBackgroundColor(BankTD9, 255);
	TextDrawFont(BankTD9, 1);
	TextDrawLetterSize(BankTD9, 0.340000, 1.400000);
	TextDrawColor(BankTD9, -1);
	TextDrawSetOutline(BankTD9, 1);
	TextDrawSetProportional(BankTD9, 1);
	TextDrawSetSelectable(BankTD9, 1);

TDEditor_TD[0] = TextDrawCreate(200.000000, 90.000000, "box");
TextDrawLetterSize(TDEditor_TD[0], 0.000000, 28.500000);
TextDrawTextSize(TDEditor_TD[0], 450.000000, 0.000000);
TextDrawAlignment(TDEditor_TD[0], 1);
TextDrawColor(TDEditor_TD[0], -1);
TextDrawUseBox(TDEditor_TD[0], 1);
TextDrawBoxColor(TDEditor_TD[0], 150);
TextDrawSetShadow(TDEditor_TD[0], 0);
TextDrawSetOutline(TDEditor_TD[0], 0);
TextDrawBackgroundColor(TDEditor_TD[0], 255);
TextDrawFont(TDEditor_TD[0], 1);
TextDrawSetProportional(TDEditor_TD[0], 1);
TextDrawSetShadow(TDEditor_TD[0], 0);

TDEditor_TD[1] = TextDrawCreate(237.500000, 98.500000, "siralama");
TextDrawLetterSize(TDEditor_TD[1], 0.400332, 1.600000);
TextDrawAlignment(TDEditor_TD[1], 2);
TextDrawColor(TDEditor_TD[1], 263520180);
TextDrawSetShadow(TDEditor_TD[1], 0);
TextDrawSetOutline(TDEditor_TD[1], 0);
TextDrawBackgroundColor(TDEditor_TD[1], 0);
TextDrawFont(TDEditor_TD[1], 3);
TextDrawSetProportional(TDEditor_TD[1], 1);
TextDrawSetShadow(TDEditor_TD[1], 0);

TDEditor_TD[2] = TextDrawCreate(413.500000, 98.500000, "skor");
TextDrawLetterSize(TDEditor_TD[2], 0.400000, 1.600000);
TextDrawAlignment(TDEditor_TD[2], 2);
TextDrawColor(TDEditor_TD[2], 263520180);
TextDrawSetShadow(TDEditor_TD[2], 0);
TextDrawSetOutline(TDEditor_TD[2], 1);
TextDrawBackgroundColor(TDEditor_TD[2], 0);
TextDrawFont(TDEditor_TD[2], 3);
TextDrawSetProportional(TDEditor_TD[2], 1);
TextDrawSetShadow(TDEditor_TD[2], 0);

TDEditor_TD[3] = TextDrawCreate(325.500000, 98.500000, "isim");
TextDrawLetterSize(TDEditor_TD[3], 0.400000, 1.600000);
TextDrawAlignment(TDEditor_TD[3], 2);
TextDrawColor(TDEditor_TD[3], 263520180);
TextDrawSetShadow(TDEditor_TD[3], 0);
TextDrawSetOutline(TDEditor_TD[3], 1);
TextDrawBackgroundColor(TDEditor_TD[3], 0);
TextDrawFont(TDEditor_TD[3], 3);
TextDrawSetProportional(TDEditor_TD[3], 1);
TextDrawSetShadow(TDEditor_TD[3], 0);

TDEditor_TD[4] = TextDrawCreate(237.500000, 120.500000, "1~n~_~n~2~n~_~n~3~n~_~n~4~n~_~n~5~n~_~n~6~n~_~n~7~n~_~n~8");
TextDrawLetterSize(TDEditor_TD[4], 0.400000, 1.600000);
TextDrawAlignment(TDEditor_TD[4], 2);
TextDrawColor(TDEditor_TD[4], -76);
TextDrawSetShadow(TDEditor_TD[4], 0);
TextDrawSetOutline(TDEditor_TD[4], 1);
TextDrawBackgroundColor(TDEditor_TD[4], 0);
TextDrawFont(TDEditor_TD[4], 3);
TextDrawSetProportional(TDEditor_TD[4], 1);
TextDrawSetShadow(TDEditor_TD[4], 0);

TDEditor_TD[5] = TextDrawCreate(325.500000, 120.500000, "user1~n~_~n~user2~n~_~n~user3~n~_~n~user4~n~_~n~user5~n~__~n~user6~n~_~n~user7~n~_~n~user8");
TextDrawLetterSize(TDEditor_TD[5], 0.400000, 1.600000);
TextDrawAlignment(TDEditor_TD[5], 2);
TextDrawColor(TDEditor_TD[5], -76);
TextDrawSetShadow(TDEditor_TD[5], 0);
TextDrawSetOutline(TDEditor_TD[5], 1);
TextDrawBackgroundColor(TDEditor_TD[5], 0);
TextDrawFont(TDEditor_TD[5], 3);
TextDrawSetProportional(TDEditor_TD[5], 1);
TextDrawSetShadow(TDEditor_TD[5], 0);

TDEditor_TD[6] = TextDrawCreate(413.500000, 120.500000, "00:00~n~_~n~00:00~n~_~n~00:00~n~_~n~00:00~n~_~n~00:00~n~_~n~00:00~n~_~n~00:00~n~_~n~00:00");
TextDrawLetterSize(TDEditor_TD[6], 0.400000, 1.600000);
TextDrawAlignment(TDEditor_TD[6], 2);
TextDrawColor(TDEditor_TD[6], -76);
TextDrawSetShadow(TDEditor_TD[6], 0);
TextDrawSetOutline(TDEditor_TD[6], 1);
TextDrawBackgroundColor(TDEditor_TD[6], 0);
TextDrawFont(TDEditor_TD[6], 3);
TextDrawSetProportional(TDEditor_TD[6], 1);
TextDrawSetShadow(TDEditor_TD[6], 0);

TDEditor_TD[7] = TextDrawCreate(324.983306, 69.485153, "round_1:_round_name");
TextDrawLetterSize(TDEditor_TD[7], 0.400000, 1.600000);
TextDrawTextSize(TDEditor_TD[7], 0.000000, 249.999511);
TextDrawAlignment(TDEditor_TD[7], 2);
TextDrawColor(TDEditor_TD[7], 263520180);
TextDrawUseBox(TDEditor_TD[7], 1);
TextDrawBoxColor(TDEditor_TD[7], 150);
TextDrawSetShadow(TDEditor_TD[7], 0);
TextDrawSetOutline(TDEditor_TD[7], 1);
TextDrawBackgroundColor(TDEditor_TD[7], 0);
TextDrawFont(TDEditor_TD[7], 3);
TextDrawSetProportional(TDEditor_TD[7], 1);
TextDrawSetShadow(TDEditor_TD[7], 0);


//Player TextDraws:

	CreateDynamicObject(4867, -3141.94189, 2586.00195, 141.56400,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(4867, -3141.10889, 2402.89600, 141.57700,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8263, -3187.72900, 2311.91602, 144.62801,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8263, -3067.85889, 2311.90894, 144.62801,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8263, -3040.92212, 2371.52588, 144.62801,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(8263, -3040.90894, 2491.37695, 144.62801,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(8263, -3040.91211, 2611.19800, 144.56599,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(8263, -3245.36792, 2371.07202, 144.62801,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(8263, -3245.38208, 2490.91089, 144.66499,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(8263, -3245.37109, 2610.76904, 144.66499,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(8263, -3185.16504, 2670.87793, 144.66499,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8263, -3065.27197, 2670.88110, 144.66499,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8263, -3100.88599, 2494.64990, 144.65300,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8263, -3236.74805, 2494.76807, 144.66499,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(986, -3173.03198, 2494.58691, 143.28799,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(986, -3163.92896, 2497.03711, 143.27499,   0.00000, 0.00000, 139.60600);
	CreateDynamicObject(3279, -3199.49292, 2500.02710, 141.64000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3279, -3223.54102, 2499.90894, 141.64000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3279, -3130.19800, 2498.28198, 141.64000,   0.00000, 0.00000, -179.14101);
	CreateDynamicObject(3279, -3082.19604, 2497.76196, 141.64000,   0.00000, 0.00000, -179.14101);
	CreateDynamicObject(3279, -3145.01709, 2489.32007, 141.65300,   0.00000, 0.00000, -179.14101);
	CreateDynamicObject(3279, -3095.95190, 2489.14404, 141.65300,   0.00000, 0.00000, -179.14101);
	CreateDynamicObject(3279, -3206.49707, 2489.20605, 141.65300,   0.00000, 0.00000, -269.14099);
	CreateDynamicObject(3279, -3239.87793, 2596.34912, 141.64000,   0.00000, 0.00000, -269.14099);
	CreateDynamicObject(3279, -3239.52393, 2660.68311, 141.64000,   0.00000, 0.00000, -456.25699);
	CreateDynamicObject(3279, -3049.43091, 2664.64307, 141.64000,   0.00000, 0.00000, -539.14099);
	CreateDynamicObject(3279, -3045.35889, 2592.99194, 141.64000,   0.00000, 0.00000, -539.14099);
	CreateDynamicObject(3279, -3045.24902, 2439.52490, 141.65300,   0.00000, 0.00000, -539.14099);
	CreateDynamicObject(3279, -3045.72290, 2315.90308, 141.65300,   0.00000, 0.00000, -539.14099);
	CreateDynamicObject(3279, -3235.66602, 2316.57300, 141.65300,   0.00000, 0.00000, -629.14001);
	CreateDynamicObject(3279, -3240.81494, 2389.73193, 141.65300,   0.00000, 0.00000, -629.14001);
	CreateDynamicObject(16771, -3152.48901, 2648.05200, 148.13600,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(16771, -3142.85400, 2334.54102, 148.14799,   0.00000, 0.00000, -360.00000);
	CreateDynamicObject(16098, -3199.13599, 2321.99805, 146.56599,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(16098, -3083.23804, 2322.12402, 146.56599,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(16098, -3207.68896, 2659.89697, 146.55299,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(16098, -3089.80908, 2659.99194, 146.55299,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(16093, -3054.75708, 2540.31689, 145.59500,   0.00000, 0.00000, -91.71900);
	CreateDynamicObject(16093, -3054.18994, 2559.25195, 145.47000,   0.00000, 0.00000, -91.71900);
	CreateDynamicObject(16093, -3048.10107, 2628.67505, 145.84500,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(16093, -3233.03394, 2543.63403, 145.49500,   0.00000, 0.00000, -360.00000);
	CreateDynamicObject(16093, -3233.00806, 2563.16895, 145.62000,   0.00000, 0.00000, -360.00000);
	CreateDynamicObject(16638, -3233.00098, 2542.63110, 143.73000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16638, -3232.91602, 2562.20703, 143.87500,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16638, -3055.13794, 2559.24707, 143.73100,   0.00000, 0.00000, 267.90302);
	CreateDynamicObject(16638, -3055.71094, 2540.29810, 143.85600,   0.00000, 0.00000, 267.90302);
	CreateDynamicObject(12911, -3099.18701, 2412.07788, 141.57300,   0.00000, 0.00000, -78.75000);
	CreateDynamicObject(12911, -3099.00391, 2421.60400, 141.57300,   0.00000, 0.00000, -78.75000);
	CreateDynamicObject(12911, -3098.85205, 2431.61011, 141.57300,   0.00000, 0.00000, -78.75000);
	CreateDynamicObject(987, -3082.85010, 2439.49512, 141.57700,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(987, -3094.79810, 2439.52393, 141.57700,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(987, -3106.76904, 2439.54199, 141.57700,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(987, -3118.68604, 2439.66602, 141.57700,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, -3118.69800, 2427.69092, 141.57700,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, -3118.68091, 2415.69995, 141.57700,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, -3118.68701, 2403.88599, 141.57700,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(988, -3104.32495, 2404.67090, 142.64101,   0.00000, 0.00000, 22.50000);
	CreateDynamicObject(988, -3097.58496, 2403.50000, 142.61600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, -3094.85693, 2403.65601, 141.57700,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, -3082.95190, 2427.56006, 141.57700,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, -3082.95093, 2415.60010, 141.57700,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, -3082.94189, 2403.63306, 141.57700,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(7236, -3227.89502, 2435.58105, 167.14700,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(7238, -3099.28394, 2556.15210, 155.12399,   0.00000, 0.00000, 91.71900);
	CreateDynamicObject(3256, -3208.94312, 2432.06812, 141.49001,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3374, -3231.55908, 2610.46704, 143.05800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3374, -3231.70093, 2610.39990, 146.05800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3374, -3229.11499, 2614.49512, 143.05800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3374, -3227.34106, 2610.40088, 143.05800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3374, -3225.09302, 2614.43506, 143.05800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3374, -3227.33203, 2613.11890, 146.05800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3374, -3229.69702, 2611.89600, 149.01700,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3374, -3223.43311, 2610.30908, 143.05800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3374, -3230.16602, 2606.24805, 143.05800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3374, -3225.40698, 2606.21509, 143.05800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3374, -3225.69189, 2608.53809, 146.05800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16782, -3167.74390, 2668.89209, 144.14400,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1218, -3134.99609, 2644.11597, 142.07300,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1218, -3135.28711, 2639.68311, 142.07300,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1218, -3133.80396, 2642.23804, 142.07300,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1218, -3139.56494, 2642.14600, 142.07300,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1218, -3136.65991, 2640.92310, 142.07300,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1218, -3137.81104, 2643.03296, 142.07300,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1218, -3135.16699, 2642.90405, 142.07300,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(7102, -3192.02588, 2550.20898, 144.84200,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(7515, -3157.31689, 2426.77490, 147.56900,   0.00000, 0.00000, 0.00000);
	//();
	// ibo mekan
 	//
	new i = 0;
	new xx=0;
	DDObje[i] = CreateDynamicObject(3458, 783.25262, 3196.74585, 65.82210,   0.00000, 0.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 764.74194, 3196.86694, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(3458, 828.75262, 3196.74585, 65.82210,   0.00000, 0.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(3458, 805.98700, 3214.36182, 65.82210,   0.00000, 0.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(3458, 760.48700, 3214.36182, 65.82210,   0.00000, 0.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(3458, 851.48700, 3214.36182, 65.82210,   0.00000, 0.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(3458, 828.75262, 3231.74585, 65.82210,   0.00000, 0.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(3458, 783.25262, 3231.74585, 65.82210,   0.00000, 0.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 768.23138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 771.73138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 775.23138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 778.73138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 782.23138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 785.73138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 789.23138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 792.73138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 796.23138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 799.73138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 803.23138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.73138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 810.23138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 813.73138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 817.23138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 820.73138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 824.23138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 827.73138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 831.23138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 834.73138, 3196.84985, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 838.25641, 3196.86304, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 841.75641, 3196.86304, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 845.28137, 3196.87622, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 848.78137, 3196.87622, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 760.40253, 3197.07861, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 760.41119, 3199.33960, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 760.41119, 3202.83960, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 760.41119, 3206.33960, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 760.41119, 3209.83960, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 760.41119, 3212.83960, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 760.41119, 3216.33960, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 760.41119, 3219.33960, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 760.41119, 3222.83960, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 760.41119, 3226.33960, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 760.41119, 3229.83960, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 763.66589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 767.16589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 770.66589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 774.16589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 777.66589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 781.16589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 784.66589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 788.16589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 791.66589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 795.16589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 798.66589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 802.16589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 805.66589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 809.16589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 812.66589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 816.16589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 819.66589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 823.16589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 826.66589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 830.16589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 833.66589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 837.16589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 840.66589, 3231.75513, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 844.18060, 3231.74146, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 847.68060, 3231.74146, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 851.18060, 3231.74146, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 851.17786, 3228.40820, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 851.17792, 3224.90820, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 851.17792, 3221.40820, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 851.17792, 3217.90820, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 851.17792, 3214.40820, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 851.17792, 3210.90820, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 851.17792, 3207.40820, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 851.17792, 3203.90820, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 851.17792, 3200.40820, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 851.17767, 3196.88818, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 760.41119, 3231.83960, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 763.31512, 3196.87744, 67.34740,   0.00000, 90.00000, 0.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3228.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3224.95630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3221.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3217.95630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3214.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3210.95630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3207.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3203.95630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3200.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3197.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(3458, 805.98700, 3174.36182, 65.82210,   0.00000, 0.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3193.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3189.95630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3186.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3182.95630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3179.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3175.95630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3172.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3168.95630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3165.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3161.95630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3158.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.07855, 3155.94165, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(18779, 811.63782, 3167.59180, 87.43190,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(3458, 805.98700, 3253.86182, 65.82210,   0.00000, 0.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3234.95630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3238.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3241.95630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3245.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3248.95630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3252.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3255.95630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3259.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3262.95630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3266.45630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3269.95630, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(19366, 806.04559, 3272.31006, 67.34740,   0.00000, 90.00000, 90.00000);
	DDObje[i++] = CreateDynamicObject(18779, 799.54413, 3262.52637, 86.93190,   0.00000, 90.00000, -90.00000);

DDObje2[xx++] = CreateDynamicObject(3458, 3391.97168, -1980.93262, 0.00240,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3391.63086, -1988.51367, 0.00000,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3391.63086, -1973.53320, 0.00000,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3391.97168, -1955.88818, 0.00120,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3391.63086, -1938.25098, 0.00000,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3391.97168, -1930.72302, 0.00240,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3391.63086, -1923.30676, 0.00000,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3414.73047, -1963.29102, 0.00480,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3414.73047, -1948.35840, 0.00360,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3369.21582, -1963.29102, 0.00480,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3369.21582, -1948.35840, 0.00360,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3378, 3401.21777, -1956.36133, -1.39420,   8.99780, 0.00000, 270.00000);
DDObje2[xx++] = CreateDynamicObject(3378, 3382.73633, -1956.36133, -1.40140,   8.99780, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3354.33032, -1988.51367, 12.99031,   0.00000, 35.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(1634, 3408.88477, -1988.51270, 0.96149,   0.00000, 0.00000, 270.00000);
DDObje2[xx++] = CreateDynamicObject(1634, 3374.35645, -1988.51270, 0.96149,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3428.62207, -1988.51367, 12.99031,   0.00000, 325.00305, 0.00000);
DDObje2[xx++] = CreateDynamicObject(1634, 3374.35645, -1923.30652, 0.96149,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(1634, 3408.88477, -1923.42053, 0.96149,   0.00000, 0.00000, 269.99451);
DDObje2[xx++] = CreateDynamicObject(8838, 3354.33008, -1923.26086, 12.99031,   0.00000, 34.99695, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3428.62207, -1923.55078, 12.99031,   0.00000, 324.99756, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3432.33594, -1956.37598, 0.00426,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3351.57422, -1956.37598, 0.00426,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3455.10254, -1966.84570, 0.00054,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3455.10645, -1945.11816, -0.00186,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(2898, 3406.28589, -1918.04736, 1.50102,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3420.94458, -1912.77380, 0.00240,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3435.09521, -1935.52722, 0.00000,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(2898, 3406.28516, -1993.79370, 1.50102,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3420.94434, -1999.04724, 0.00240,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3435.08984, -1976.27795, 0.00000,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3434.89331, -1980.98621, 0.00000,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3434.89258, -1930.96753, 0.00000,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(2898, 3376.97119, -1918.04688, 1.50102,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(2898, 3376.97070, -1993.79126, 1.50102,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3362.30908, -1999.04688, 0.00240,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3362.31226, -1912.77344, 0.00240,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3328.82153, -1966.84570, 0.00054,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3328.81860, -1945.11816, -0.00186,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3348.17725, -1976.27734, 0.00000,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3348.18042, -1935.52637, 0.00000,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3348.99780, -1930.97412, 0.00000,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3349.07910, -1980.98535, 0.00000,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(1634, 3392.09302, -1955.95691, -1.92474,   334.50232, 0.00000, 270.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3338.97144, -1935.52637, 22.28794,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3338.97021, -1975.92407, 22.28618,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3443.99585, -1935.52637, 22.28794,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3443.99512, -1975.92383, 22.28618,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3378, 3430.48706, -1955.78979, 20.88428,   8.99780, 0.00000, 270.00000);
DDObje2[xx++] = CreateDynamicObject(3378, 3352.49023, -1956.01855, 20.88428,   8.99780, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3378, 3366.59668, -1941.87061, 19.10915,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3378, 3366.66992, -1970.09583, 19.10915,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3378, 3380.73779, -1955.93311, 19.10675,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3378, 3416.37793, -1969.95093, 19.10915,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3378, 3416.29858, -1941.72339, 19.10915,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3378, 3402.23389, -1955.87158, 19.10915,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3391.63086, -1975.43811, 18.75274,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3391.63086, -1936.35669, 18.75274,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3426.35547, -1998.68481, 22.28618,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3426.35547, -1912.77234, 22.28618,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3356.60718, -1912.77148, 22.28618,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3356.60645, -1998.68457, 22.28618,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3378, 3402.16870, -1933.33008, 19.09955,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3378, 3380.66235, -1933.39478, 19.09955,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3378, 3380.73730, -1978.48169, 19.09955,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3378, 3403.46387, -1978.41064, 19.09955,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3392.95264, -1912.77393, 22.28193,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3392.95215, -1998.68750, 22.28193,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(1660, 3391.78394, -1925.13000, 19.33339,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(1660, 3391.45459, -1986.19995, 19.33339,   0.00000, 0.00000, 180.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3432.89917, -1938.70764, 29.84682,   0.00000, 320.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3432.99316, -1972.98291, 29.84682,   0.00000, 319.99878, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3350.07129, -1973.11377, 29.84682,   0.00000, 40.00122, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3349.97705, -1938.83875, 29.84682,   0.00000, 39.99573, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3335.70874, -1975.92383, 40.22165,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3335.70947, -1935.52637, 40.22116,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3447.36743, -1975.92383, 40.22165,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3447.36743, -1935.52637, 40.22116,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3354.96167, -1922.72485, 40.21921,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3354.96094, -1989.08997, 40.21921,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3428.09839, -1922.72461, 40.21921,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3428.10083, -1989.08984, 40.21921,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3408.84937, -1975.92383, 40.22165,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3408.84814, -1935.52637, 40.22116,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3374.22559, -1975.92383, 40.22165,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3374.22339, -1935.52637, 40.22116,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3408.84863, -1975.92383, 40.21379,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3408.84766, -1935.52637, 40.20969,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3374.22266, -1935.52637, 40.21209,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(8838, 3374.22559, -1975.92383, 40.21139,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(3458, 3391.51880, -1955.67725, 40.20914,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(1634, 3381.71899, -1993.73816, 42.84204,   0.00000, 0.00000, 270.00000);
DDObje2[xx++] = CreateDynamicObject(1634, 3401.34473, -1917.79102, 42.84204,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(1634, 3381.73145, -1917.79102, 42.84204,   0.00000, 0.00000, 270.00000);
DDObje2[xx++] = CreateDynamicObject(1634, 3401.34473, -1993.73730, 42.84204,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(2898, 3368.96777, -1993.69678, 41.71773,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(2898, 3368.96655, -1918.12671, 41.71773,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(2898, 3414.13086, -1918.12231, 41.71773,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(2898, 3414.13086, -1993.69373, 41.71773,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(981, 3391.58398, -1906.04395, -3.83265,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(981, 3391.58398, -1959.15808, -3.83265,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(981, 3391.58398, -1953.46973, -3.83265,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(981, 3348.48779, -1944.35852, -3.83265,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(981, 3348.48730, -1969.50037, -3.83265,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(981, 3435.00806, -1969.50000, -3.83265,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(981, 3435.00781, -1944.11475, -3.83265,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(981, 3391.58398, -2006.35059, -3.83265,   0.00000, 0.00000, 0.00000);
DDObje2[xx++] = CreateDynamicObject(981, 3391.58398, -2006.35059, -3.83265,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(981, 3391.58398, -1906.04395, -3.83265,   0.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(9131, 3379.97314, -1997.26013, 1.66370,   65.00000, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(9131, 3379.97266, -1998.02051, 1.66370,   64.99512, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(9131, 3379.97266, -1998.78027, 1.66370,   64.99512, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(9131, 3379.97266, -1999.54199, 1.66370,   64.99512, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(9131, 3379.97266, -2000.30371, 1.66370,   64.99512, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(9131, 3403.29517, -1997.25977, 1.66370,   64.99512, 0.00000, 270.00000);
DDObje2[xx++] = CreateDynamicObject(9131, 3403.29492, -1998.02197, 1.66370,   64.99512, 0.00000, 269.99451);
DDObje2[xx++] = CreateDynamicObject(9131, 3403.29492, -1998.78247, 1.66370,   64.99512, 0.00000, 269.99451);
DDObje2[xx++] = CreateDynamicObject(9131, 3403.29492, -1999.54297, 1.66370,   64.99512, 0.00000, 269.99451);
DDObje2[xx++] = CreateDynamicObject(9131, 3403.29492, -2000.30493, 1.66370,   64.99512, 0.00000, 269.99451);
DDObje2[xx++] = CreateDynamicObject(9131, 3403.29492, -1914.40552, 1.66370,   64.99512, 0.00000, 269.99451);
DDObje2[xx++] = CreateDynamicObject(9131, 3403.29492, -1913.64453, 1.66370,   64.99512, 0.00000, 269.99451);
DDObje2[xx++] = CreateDynamicObject(9131, 3403.29492, -1912.88208, 1.66370,   64.99512, 0.00000, 269.99451);
DDObje2[xx++] = CreateDynamicObject(9131, 3403.29492, -1912.12085, 1.66370,   64.99512, 0.00000, 269.99451);
DDObje2[xx++] = CreateDynamicObject(9131, 3403.29492, -1911.35938, 1.66370,   64.99512, 0.00000, 269.99451);
DDObje2[xx++] = CreateDynamicObject(9131, 3379.97266, -1914.22339, 1.66370,   64.99512, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(9131, 3379.97266, -1913.46094, 1.66370,   64.99512, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(9131, 3379.97266, -1912.70020, 1.66370,   64.99512, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(9131, 3379.97266, -1911.93774, 1.66370,   64.99512, 0.00000, 90.00000);
DDObje2[xx++] = CreateDynamicObject(9131, 3379.97266, -1911.17798, 1.66370,   64.99512, 0.00000, 90.00000);

//	mysql_connect(SQL_HOST,SQL_USER,SQL_DB,SQL_PASS);
	mysql_connect("localhost","root","zero","");
//	mysql_connect("85.131.220.76", "ni407205_2_DB", "ni407205_2_DB", "Nsgw8ZZb");
	LoadPlaces();
	MekanlariYukle();
	//evleriYukle();
	if(mysql_ping() == 1)
	{
		mysql_debug(1);// SQL Log - 0: Off / 1: On
		printf("[MySQL]: `%s` Veritabanina baglanti kuruldu..", SQL_DB);
	}
	else
	{
		printf("[MySQL-ERROR]: `%s` Veritabanina baglanti kurulamadi.", SQL_DB);
	}
    SetWeather(1);
	xReactionTimer = SetTimer("xReactionTest", TIME+50000, 1);
	SetTimer("soruTest", TIME+100000, 1);
	SetTimer("chatText", 180000, 1);
	//DetectingHack", 1000, 1);
	lotoTimer = SetTimer("lottoBaslat", 700000, true);
	SetTimer("derbyUz", 250000, true);
	CreateDynamicObject(14639, 2003.1641, 1033.5078, 31.9531, 356.8584, 0.0, 3.1416);
    lift1 = CreateDynamicObject(974, 948.788574, 2439.683350, 9.874555, 90.2409, 0.0000, 0.0000);
    lift2 = CreateDynamicObject(974, 957.282593, 2432.806641, 42.432281, 90.2409, 0.0000, 0.0000);
    lift3 = CreateDynamicObject(974, 957.160950, 2442.099365, 81.161102, 90.2409, 0.0000, 0.0000);
	SendRconCommand("rcon_password aliomur1905");
	SendRconCommand("hostname •• [Z]ero™ [Elite] - Stunt/DM/Race [24/7] ••");
	SendRconCommand("mapname [TR/ENG/RUS]Turkiye «");
	SendRconCommand("gamemodetext [Z]Turkey Elite Turkiye");
	SendRconCommand("language Turkce/Turkish/English/Germany«");
	SendRconCommand("loadfs serverobjeler");
	AddPlayerClass(106,0.0000, 0.0000, 0.0000,0,0,0,0,0,0,-1); //
	AddPlayerClass(107,0.0000, 0.0000, 0.0000,0,0,0,0,0,0,-1); //
	AddPlayerClass(271,0.0000, 0.0000, 0.0000,0,0,0,0,0,0,-1); //
	AddPlayerClass(3,0.0000, 0.0000, 0.0000,0,0,0,0,0,0,-1); //
	AddPlayerClass(86,0.0000, 0.0000, 0.0000,0,0,0,0,0,0,-1); //
	AddPlayerClass(208,0.0000, 0.0000, 0.0000,0,0,0,0,0,0,-1); //
	AddPlayerClass(273,0.0000, 0.0000, 0.0000,0,0,0,0,0,0,-1); //
	AddPlayerClass(165,0.0000, 0.0000, 0.0000,0,0,0,0,0,0,-1); //
	AddPlayerClass(281,0.0000, 0.0000, 0.0000,0,0,0,0,0,0,-1); //
	AddPlayerClass(286,0.0000, 0.0000, 0.0000,0,0,0,0,0,0,-1); //
	AddPlayerClass(287,0.0000, 0.0000, 0.0000,0,0,0,0,0,0,-1); //
	AddPlayerClass(277,0.0000, 0.0000, 0.0000,0,0,0,0,0,0,-1); //
	AddPlayerClass(301, 0.0000, 0.0000, 0.0000, 0.0000, -1, -1, -1, -1, -1, -1);
	AddPlayerClass(302, 0.0000, 0.0000, 0.0000, 0.0000, -1, -1, -1, -1, -1, -1);
	AddPlayerClass(303, 0.0000, 0.0000, 0.0000, 0.0000, -1, -1, -1, -1, -1, -1);
	AddPlayerClass(304, 0.0000, 0.0000, 0.0000, 0.0000, -1, -1, -1, -1, -1, -1);
	AddPlayerClass(305, 0.0000, 0.0000, 0.0000, 0.0000, -1, -1, -1, -1, -1, -1);
	AddPlayerClass(306, 0.0000, 0.0000, 0.0000, 0.0000, -1, -1, -1, -1, -1, -1);
	AddPlayerClass(307, 0.0000, 0.0000, 0.0000, 0.0000, -1, -1, -1, -1, -1, -1);
	AddPlayerClass(308, 0.0000, 0.0000, 0.0000, 0.0000, -1, -1, -1, -1, -1, -1);
	AddPlayerClass(309, 0.0000, 0.0000, 0.0000, 0.0000, -1, -1, -1, -1, -1, -1);
	AddPlayerClass(300, 0.0000, 0.0000, 0.0000, 0.0000, -1, -1, -1, -1, -1, -1);
	AddPlayerClass(299, 0.0000, 0.0000, 0.0000, 0.0000, -1, -1, -1, -1, -1, -1);
	AddPlayerClass(287, 0.0000, 0.0000, 0.0000, 0.0000, -1, -1, -1, -1, -1, -1);
	AddPlayerClass(284, 0.0000, 0.0000, 0.0000, 0.0000, -1, -1, -1, -1, -1, -1);
	AddPlayerClass(210, 0.0000, 0.0000, 0.0000, 0.0000, -1, -1, -1, -1, -1, -1);

	CreateDynamicObject(8355, 227.07671, 63.36530, 1004.03522,   90.00000, 0.00000, -90.00000);
	CreateDynamicObject(8355, 233.88580, 64.13870, 1004.03522,   90.00000, 0.00000, 360.00000);
	CreateDynamicObject(8355, 237.18410, 50.61320, 1004.03369,   -90.00000, 0.00000, -90.00000);
	CreateDynamicObject(8355, 234.11510, 67.29350, 1004.05371,   180.00000, 0.00000, 0.00000);
	#if defined RACEPASIF
	new
	    rNameFile[64],
	    string[256],
	    count=0,
	    derbynameb[64]
	;
	racenames[0]=EOS;
	format(rNameFile, sizeof(rNameFile), "/RacesNew/RaceNames.txt");
	new File:mag = fopen(rNameFile, io_read);
    while(fread(mag, string)>0){
    sscanf(string,"s[128]",derbynameb);
    devrim[count] = derbynameb;
    strdelm(devrim[count], "\n");
    strdelm(devrim[count], "\r");
    printf("Yarýþ çekildi ' %s '", devrim[count]);
    count++;
    }
    fclose(mag);
	#endif
	#if !defined RACEPASIF
	new string[256];
	#endif
    return 1;
}

public OnGameModeExit()
{
	//evleriKaydet();
	OnlineSayisi = 0;
	RekorSayisi = 0;
 	format(RekorTarihi, sizeof(RekorTarihi), "-");
	djson_GameModeExit();

	#if REKOR_TEXT == 1
	    if(RekorTextDraw != Text: INVALID_TEXT_DRAW) TextDrawDestroy(RekorTextDraw);
	#endif

	print("\n==========================================");
 	print("    Rekor Sistemi: Sistem kapatildi.");
  	print("==========================================\n");

	for(new i; i < sizeof(DDObje); ++i)
	{
	    DestroyObject(DDObje[i]);
	    DDObje[i] = INVALID_OBJECT_ID;
	}

	for(new i; i < MAX_PLAYERS; ++i)
	{
	    if(!IsPlayerConnected(i)) continue;
	    DDCikar(i, 5);
	}
	KillTimer(xReactionTimer);
        new p = MAX_PLAYERS;
        for (new i=0; i < p; i++) {
                SetPVarInt(i, "Lazer", 0);
                RemovePlayerAttachedObject(i, 0);
        }
		SendRconCommand("exit");
        return 1;
 }
public OnIncomingConnection(playerid, ip_address[], port)
{
	return 1;
}
public OnQueryError( errorid, error[ ], resultid, extraid, callback[ ], query[ ], connectionHandle )
	return printf( "HATAid: %d | HATA: %s | resultid: %d | extraid: %d | callback: %s | query: %s", errorid, error, resultid, extraid, callback, query );

public OnPlayerRequestClass(playerid, classid)
{
    playerSpawned[playerid] = false;
	if(GetPVarInt(playerid,"asdfasdf") > GetTickCount())
	{
		if(GetPVarInt(playerid,"asdf") > 12)
		{
			Kickle(playerid,"Hack");
			return 1;
		}
		SetPVarInt(playerid,"asdf",GetPVarInt(playerid,"asdf")+1);
	}else
	{
		SetPVarInt(playerid,"asdf",0);
		SetPVarInt(playerid, "asdfasdf", GetTickCount()+300);
	}
    ApplyAnimation( playerid,"STRIP",Anims[random(sizeof(Anims))],4.1,1,1,1,1,1);
	CreatePlayerObject(playerid, 2763, 729.85114, -1477.39050, 13.22430,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 729.85107, -1477.39050, 12.19630,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 729.85107, -1477.39050, 11.11030,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 730.93707, -1477.39050, 13.22430,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 732.02307, -1477.39050, 13.22430,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 732.02307, -1477.39050, 12.13830,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 732.02307, -1477.39050, 11.05230,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 733.10907, -1477.39050, 13.22430,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 734.19513, -1477.39050, 13.22430,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 734.19513, -1477.39050, 12.13830,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 734.19513, -1477.39050, 11.05230,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 736.09442, -1477.12219, 9.78530,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 736.09442, -1477.12219, 10.87130,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 736.09479, -1477.20215, 11.95730,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 737.18079, -1477.20215, 11.95730,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 736.09479, -1477.20215, 13.04330,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 738.26678, -1477.20215, 11.95730,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 736.09479, -1477.20215, 14.12930,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 737.18079, -1477.20215, 14.12930,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 738.26678, -1477.20215, 14.12930,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 737.18042, -1477.12219, 9.78530,   90.00000, 0.00000, 0.00000);
	CreatePlayerObject(playerid, 2763, 738.26642, -1477.12219, 9.78530,   90.00000, 0.00000, 0.00000);

	PlayerPlaySound(playerid, 1183, 0,0,0);
	TogglePlayerControllable(playerid, 0);
	SetPVarString(playerid, "FreezedBy", "KarakterSecimi");
    SetPVarInt(playerid, "First", 1);
	SetPlayerPos(playerid, 712.6076,-1633.9952,3.4297);
	SetPlayerFacingAngle(playerid, -90);
	SetPlayerCameraPos(playerid, 721.7985, -1636.7983, 4.9672);
	SetPlayerCameraLookAt(playerid, 720.8567, -1636.4646, 4.8317);
	SetPlayerWeather(playerid, -61);
	SetPlayerTime(playerid, 12, 0);
    SetPlayerAttachedObject(playerid, 0, 18693, 5, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000);
	SetPlayerAttachedObject(playerid, 1, 18693, 6, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000);
    ApplyAnimation( playerid,"STRIP",Anims[random(sizeof(Anims))],4.1,1,1,1,1,1);
	SetPVarInt(playerid, "OnClass", 1);
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetTimerEx("TextleriGuncellee", 5000, true, "i", playerid);
	PlayAudioStreamForPlayer(playerid, "http://provisioning.streamtheworld.com/pls/METRO_FMAAC.pls");
        new stringf[25];
        format(stringf, sizeof(stringf), "%s", getName(playerid));
        duelinfo[playerid][playername] = stringf;

RemoveBuildingForPlayer(playerid, 3813, -2685.0469, 634.4922, 21.0703, 0.25);
RemoveBuildingForPlayer(playerid, 3813, -2694.2344, 634.4922, 21.0703, 0.25);
RemoveBuildingForPlayer(playerid, 3813, -2703.9141, 634.4922, 21.0703, 0.25);
RemoveBuildingForPlayer(playerid, 3813, -2657.4688, 634.4922, 21.0703, 0.25);
RemoveBuildingForPlayer(playerid, 3813, -2666.6641, 634.4922, 21.0703, 0.25);
RemoveBuildingForPlayer(playerid, 9593, -2673.7969, 639.9766, 39.6172, 0.25);
RemoveBuildingForPlayer(playerid, 9813, -2673.7969, 639.9766, 39.6172, 0.25);
RemoveBuildingForPlayer(playerid, 3813, -2675.8516, 634.4922, 21.0703, 0.25);
RemoveBuildingForPlayer(playerid, 3813, -2648.2813, 634.4922, 21.0703, 0.25);
RemoveBuildingForPlayer(playerid, 3813, -2639.0859, 634.4922, 21.0703, 0.25);
TDEditor_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 324.983306, 353.585601, "your_results:_pos_10_-_00:00");
PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][0], 0.400000, 1.600000);
PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][0], 0.000000, 249.999511);
PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][0], 2);
PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][0], 263520180);
PlayerTextDrawUseBox(playerid, TDEditor_PTD[playerid][0], 1);
PlayerTextDrawBoxColor(playerid, TDEditor_PTD[playerid][0], 150);
PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);
PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][0], 1);
PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][0], 0);
PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][0], 3);
PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][0], 1);
PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);
	SendClientMessage(playerid, -1, "{C3C3C3}» {E24234}[Z]ero Elite {FFFFFF}Official Turkish and International Server (2012 - 2015) - Website: {E24234}www.zerotr.com");
	DeleteObjects(playerid);
    shotTime[playerid] = 0;
	shot[playerid] = 0;
	SetPVarInt(playerid, "Spawned", 0);
    OnlineSayisi++;
    new string[128];

    if(OnlineSayisi > RekorSayisi)
    {
        RekorSayisi = OnlineSayisi;
        new gun, ay, yil, saat, dakika, saniye;
        getdate(yil, ay, gun);
        gettime(saat, dakika, saniye);
        format(RekorTarihi, sizeof(RekorTarihi), "%02d/%02d/%d %02d:%02d:%02d", gun, ay, yil, saat, dakika, saniye);
        format(string, sizeof(string), "Sunucumuz an itibariyle %d kiþilik rekorunu kýrdý. KAYITLARA GEÇÝLDÝ!", RekorSayisi);
        foreach(new i : Player) { Bilgimesaj(i, string, string); }

        #if REKOR_TEXT == 1
            if(RekorTextDraw != Text: INVALID_TEXT_DRAW)
            {
		        format(string, sizeof(string), "~b~~h~~h~~h~Rekor: ~w~~h~~h~~h~%d Online~n~~b~~h~~h~~h~Rekor Tarihi: ~w~~h~~h~~h~%s", RekorSayisi, RekorTarihi);
				TextDrawSetString(RekorTextDraw, string);
			}
        #endif

        #if REKOR_ODUL == 1
            new para = RekorSayisi*ODUL_MIKTAR;

			for(new i; i < MAX_PLAYERS; ++i)
			{
			    if(!IsPlayerConnected(i)) continue;
			    GivePlayerMoney(i, para);
			}

			format(string, sizeof(string), "## {FFFFFF}Sunucu rekoru kýrýldýðý için tüm oyunculara %d$ verildi.", para);
	    	SendClientMessageToAll(0x00C0C0FF, string);
		#endif

        djSetInt("rekor.json", "rekor", RekorSayisi);
        djSet("rekor.json", "tarih", RekorTarihi);
    }

    #if GIRIS_GOSTER == 1
	    format(string, sizeof(string), "Sunucumuz {E24234}' %s '{FFFFFF} tarihinde {E24234}' %d '{FFFFFF} kiþilik rekor kýrmýþtýr!", RekorTarihi, RekorSayisi);
		Bilgimesaj(playerid, string, string);
    #endif

    #if REKOR_TEXT == 1
		if(RekorTextDraw != Text: INVALID_TEXT_DRAW) TextDrawShowForPlayer(playerid, RekorTextDraw);
    #endif


	BankTD1 = CreatePlayerTextDraw(playerid,250.000000, 25.000000, "Calderon Bank");
	PlayerTextDrawBackgroundColor(playerid,BankTD1, 255);
	PlayerTextDrawFont(playerid,BankTD1, 1);
	PlayerTextDrawLetterSize(playerid,BankTD1, 0.450000, 1.800000);
	PlayerTextDrawColor(playerid,BankTD1, -1);
	PlayerTextDrawSetOutline(playerid,BankTD1, 0);
	PlayerTextDrawSetProportional(playerid,BankTD1, 1);
	PlayerTextDrawSetShadow(playerid,BankTD1, 1);
	PlayerTextDrawUseBox(playerid,BankTD1, 1);
	PlayerTextDrawBoxColor(playerid,BankTD1, 255);
	PlayerTextDrawTextSize(playerid,BankTD1, 370.750000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,BankTD1, 0);

	BankTD7 = CreatePlayerTextDraw(playerid,405.000000, 228.000000, "");
	PlayerTextDrawBackgroundColor(playerid,BankTD7, 255);
	PlayerTextDrawFont(playerid,BankTD7, 1);
	PlayerTextDrawLetterSize(playerid,BankTD7, 0.340000, 1.400000);
	PlayerTextDrawColor(playerid,BankTD7, -1);
	PlayerTextDrawSetOutline(playerid,BankTD7, 1);
	PlayerTextDrawSetProportional(playerid,BankTD7, 1);
	PlayerTextDrawSetSelectable(playerid,BankTD7, 1);

	BankTD8 = CreatePlayerTextDraw(playerid,405.000000, 202.250000, "");
	PlayerTextDrawBackgroundColor(playerid,BankTD8, 255);
	PlayerTextDrawFont(playerid,BankTD8, 1);
	PlayerTextDrawLetterSize(playerid,BankTD8, 0.340000, 1.400000);
	PlayerTextDrawColor(playerid,BankTD8, -1);
	PlayerTextDrawSetOutline(playerid,BankTD8, 1);
	PlayerTextDrawSetProportional(playerid,BankTD8, 1);
	PlayerTextDrawSetSelectable(playerid,BankTD8, 1);

	BankTD10 = CreatePlayerTextDraw(playerid,200.000000, 145.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,BankTD10, 255);
	PlayerTextDrawFont(playerid,BankTD10, 1);
	PlayerTextDrawLetterSize(playerid,BankTD10, 0.500000, 15.699999);
	PlayerTextDrawColor(playerid,BankTD10, -1);
	PlayerTextDrawSetOutline(playerid,BankTD10, 0);
	PlayerTextDrawSetProportional(playerid,BankTD10, 1);
	PlayerTextDrawSetShadow(playerid,BankTD10, 1);
	PlayerTextDrawUseBox(playerid,BankTD10, 1);
	PlayerTextDrawBoxColor(playerid,BankTD10, -1);
	PlayerTextDrawTextSize(playerid,BankTD10, 375.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,BankTD10, 0);

	BankTD11 = CreatePlayerTextDraw(playerid,200.000000, 175.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,BankTD11, 255);
	PlayerTextDrawFont(playerid,BankTD11, 1);
	PlayerTextDrawLetterSize(playerid,BankTD11, 100.000000, -1.150000);
	PlayerTextDrawColor(playerid,BankTD11, -1);
	PlayerTextDrawSetOutline(playerid,BankTD11, 0);
	PlayerTextDrawSetProportional(playerid,BankTD11, 1);
	PlayerTextDrawSetShadow(playerid,BankTD11, 1);
	PlayerTextDrawUseBox(playerid,BankTD11, 1);
	PlayerTextDrawBoxColor(playerid,BankTD11, -8388353);
	PlayerTextDrawTextSize(playerid,BankTD11, 375.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,BankTD11, 0);

	BankTD12 = CreatePlayerTextDraw(playerid,204.000000, 148.250000, "~l~Merhaba ~r~~h~[RC]LasVegas.Xd:Jr");
	PlayerTextDrawBackgroundColor(playerid,BankTD12, -1);
	PlayerTextDrawFont(playerid,BankTD12, 1);
	PlayerTextDrawLetterSize(playerid,BankTD12, 0.280000, 1.350000);
	PlayerTextDrawColor(playerid,BankTD12, -1);
	PlayerTextDrawSetOutline(playerid,BankTD12, 1);
	PlayerTextDrawSetProportional(playerid,BankTD12, 1);
	PlayerTextDrawSetSelectable(playerid,BankTD12, 0);

	BankTD13 = CreatePlayerTextDraw(playerid,204.000000, 178.250000, "~l~Kullanilabilir Bakiye: ~y~500,000$");
	PlayerTextDrawBackgroundColor(playerid,BankTD13, -1);
	PlayerTextDrawFont(playerid,BankTD13, 1);
	PlayerTextDrawLetterSize(playerid,BankTD13, 0.280000, 1.350000);
	PlayerTextDrawColor(playerid,BankTD13, -1);
	PlayerTextDrawSetOutline(playerid,BankTD13, 1);
	PlayerTextDrawSetProportional(playerid,BankTD13, 1);
	PlayerTextDrawSetSelectable(playerid,BankTD13, 0);

	BankTD14 = CreatePlayerTextDraw(playerid,204.000000, 198.250000, "~l~Prim (Ikramiye): ~y~0$");
	PlayerTextDrawBackgroundColor(playerid,BankTD14, -1);
	PlayerTextDrawFont(playerid,BankTD14, 1);
	PlayerTextDrawLetterSize(playerid,BankTD14, 0.280000, 1.350000);
	PlayerTextDrawColor(playerid,BankTD14, -1);
	PlayerTextDrawSetOutline(playerid,BankTD14, 1);
	PlayerTextDrawSetProportional(playerid,BankTD14, 1);
	PlayerTextDrawSetSelectable(playerid,BankTD14, 0);

	BankTD15 = CreatePlayerTextDraw(playerid,472.500000, 3.000000, "Butun musterilerimiz musteri memnuniyeti garantisi altindadir.");
	PlayerTextDrawBackgroundColor(playerid,BankTD15, 255);
	PlayerTextDrawFont(playerid,BankTD15, 1);
	PlayerTextDrawLetterSize(playerid,BankTD15, 0.160000, 1.250000);
	PlayerTextDrawColor(playerid,BankTD15, -1);
	PlayerTextDrawSetOutline(playerid,BankTD15, 0);
	PlayerTextDrawSetProportional(playerid,BankTD15, 1);
	PlayerTextDrawSetShadow(playerid,BankTD15, 0);
	PlayerTextDrawSetSelectable(playerid,BankTD15, 0);

	Textdraw[playerid][0] = CreatePlayerTextDraw(playerid, 1.000000, 430.000000, "_");
	PlayerTextDrawBackgroundColor(playerid, Textdraw[playerid][0], 255);
	PlayerTextDrawFont(playerid, Textdraw[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, Textdraw[playerid][0], 0.500000, 2.300000);
	PlayerTextDrawColor(playerid, Textdraw[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid, Textdraw[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, Textdraw[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, Textdraw[playerid][0], 1);
	PlayerTextDrawUseBox(playerid, Textdraw[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, Textdraw[playerid][0], 100);
	PlayerTextDrawTextSize(playerid, Textdraw[playerid][0], 650.000000, 0.000000);

	Textdraw[playerid][1] = CreatePlayerTextDraw(playerid, 1.000000, 430.000000, "_");
	PlayerTextDrawBackgroundColor(playerid, Textdraw[playerid][1], 255);
	PlayerTextDrawFont(playerid, Textdraw[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, Textdraw[playerid][1], 0.500000, -0.699999);
	PlayerTextDrawColor(playerid, Textdraw[playerid][1], -1);
	PlayerTextDrawSetOutline(playerid, Textdraw[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, Textdraw[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, Textdraw[playerid][1], 1);
	PlayerTextDrawUseBox(playerid, Textdraw[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, Textdraw[playerid][1], 13434879);
	PlayerTextDrawTextSize(playerid, Textdraw[playerid][1], 650.000000, 0.000000);

	Textdraw[playerid][2] = CreatePlayerTextDraw(playerid, 1.000000, 449.000000, "_");
	PlayerTextDrawBackgroundColor(playerid, Textdraw[playerid][2], 255);
	PlayerTextDrawFont(playerid, Textdraw[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, Textdraw[playerid][2], 0.500000, -0.300000);
	PlayerTextDrawColor(playerid, Textdraw[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid, Textdraw[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, Textdraw[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, Textdraw[playerid][2], 1);
	PlayerTextDrawUseBox(playerid, Textdraw[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, Textdraw[playerid][2], 13434879);
	PlayerTextDrawTextSize(playerid, Textdraw[playerid][2], 650.000000, 0.000000);

	Textdraw[playerid][3] = CreatePlayerTextDraw(playerid, 488.000000, 428.000000, "~w~~h~~h~~h~Kills:~b~~h~300~w~~h~~h~~h~ - Deaths:~b~~h~ 255~w~~h~~h~~h~ - Ratio: ~r~~h~5.4444");
	PlayerTextDrawBackgroundColor(playerid, Textdraw[playerid][3], 255);
	PlayerTextDrawFont(playerid, Textdraw[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, Textdraw[playerid][3], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, Textdraw[playerid][3], 512819199);
	PlayerTextDrawSetOutline(playerid, Textdraw[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, Textdraw[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, Textdraw[playerid][3], 0);

	Textdraw[playerid][4] = CreatePlayerTextDraw(playerid, 3.000000, 428.000000, "~w~~h~~h~~h~FPS: ~b~~h~39~w~~h~~h~~h~ - Can:~r~~h~ 100.0~w~~h~~h~~h~ - Zirh: ~b~~h~100.0");
	PlayerTextDrawBackgroundColor(playerid, Textdraw[playerid][4], 255);
	PlayerTextDrawFont(playerid, Textdraw[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, Textdraw[playerid][4], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, Textdraw[playerid][4], 512819199);
	PlayerTextDrawSetOutline(playerid, Textdraw[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, Textdraw[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, Textdraw[playerid][4], 0);

	Textdraw[playerid][5] = CreatePlayerTextDraw(playerid, 3.000000, 436.000000, "Tuyo 1#: ~g~~h~~h~Kendinize ~y~~h~/shop~g~~h~~h~ komutuyla bir urun alabilirsiniz.");
	PlayerTextDrawBackgroundColor(playerid, Textdraw[playerid][5], 255);
	PlayerTextDrawFont(playerid, Textdraw[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, Textdraw[playerid][5], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, Textdraw[playerid][5], 512819199);
	PlayerTextDrawSetOutline(playerid, Textdraw[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, Textdraw[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, Textdraw[playerid][5], 0);

	Textdraw[playerid][6] = CreatePlayerTextDraw(playerid, 283.000000, 426.000000, "ZeroTR");
	PlayerTextDrawBackgroundColor(playerid, Textdraw[playerid][6], 255);
	PlayerTextDrawFont(playerid, Textdraw[playerid][6], 3);
	PlayerTextDrawLetterSize(playerid, Textdraw[playerid][6], 0.440000, 2.099999);
	PlayerTextDrawColor(playerid, Textdraw[playerid][6], -498977537);
	PlayerTextDrawSetOutline(playerid, Textdraw[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, Textdraw[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, Textdraw[playerid][6], 0);

	Textdraw[playerid][7] = CreatePlayerTextDraw(playerid, 638.000000, 436.000000, "_");
	PlayerTextDrawAlignment(playerid, Textdraw[playerid][7], 3);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[playerid][7], 255);
	PlayerTextDrawFont(playerid, Textdraw[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, Textdraw[playerid][7], 0.230000, 1.000000);
	PlayerTextDrawColor(playerid, Textdraw[playerid][7], 512819199);
	PlayerTextDrawSetOutline(playerid, Textdraw[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, Textdraw[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, Textdraw[playerid][7], 0);
	
	SpecTD[0][playerid] = CreatePlayerTextDraw(playerid, 429.500000, 359.277893, "usebox");
	PlayerTextDrawLetterSize(playerid, SpecTD[0][playerid], 0.000000, 5.585186);
	PlayerTextDrawTextSize(playerid, SpecTD[0][playerid], 212.500000, 0.000000);
	PlayerTextDrawAlignment(playerid, SpecTD[0][playerid], 1);
	PlayerTextDrawColor(playerid, SpecTD[0][playerid], 0);
	PlayerTextDrawUseBox(playerid, SpecTD[0][playerid], true);
	PlayerTextDrawBoxColor(playerid, SpecTD[0][playerid], 1819967538);
	PlayerTextDrawSetShadow(playerid, SpecTD[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpecTD[0][playerid], 0);
	PlayerTextDrawFont(playerid, SpecTD[0][playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, SpecTD[0][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid, SpecTD[0][playerid], 0.000000, 0.000000, 0.000000, 0.000000);

	SpecTD[1][playerid] = CreatePlayerTextDraw(playerid, 219.899993, 359.084503, "~y~~h~Player1~r~~h~(~w~~h~~h~~h~0~r~~h~)~n~Money:~r~~h~5~n~Score:~r~~h~15");
	PlayerTextDrawLetterSize(playerid, SpecTD[1][playerid], 0.286500, 1.307555);
	PlayerTextDrawAlignment(playerid, SpecTD[1][playerid], 1);
	PlayerTextDrawColor(playerid, SpecTD[1][playerid], -1);
	PlayerTextDrawSetShadow(playerid, SpecTD[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpecTD[1][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SpecTD[1][playerid], 51);
	PlayerTextDrawFont(playerid, SpecTD[1][playerid], 1);
	PlayerTextDrawSetProportional(playerid, SpecTD[1][playerid], 1);
	PlayerTextDrawSetPreviewModel(playerid, SpecTD[1][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid, SpecTD[1][playerid], 0.000000, 0.000000, 0.000000, 0.000000);

	SpecTD[2][playerid] = CreatePlayerTextDraw(playerid, 331.500000, 359.644439, "~y~~h~Mycar~n~~g~~h~~h~Y:~w~~h~~h~~h~Hiz_~g~~h~N:~w~~h~~h~~h~Zipla");
	PlayerTextDrawLetterSize(playerid, SpecTD[2][playerid], 0.275000, 1.550222);
	PlayerTextDrawAlignment(playerid, SpecTD[2][playerid], 1);
	PlayerTextDrawColor(playerid, SpecTD[2][playerid], -1);
	PlayerTextDrawSetShadow(playerid, SpecTD[2][playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpecTD[2][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SpecTD[2][playerid], 51);
	PlayerTextDrawFont(playerid, SpecTD[2][playerid], 1);
	PlayerTextDrawSetProportional(playerid, SpecTD[2][playerid], 1);

	SpecTD[3][playerid] = CreatePlayerTextDraw(playerid, 216.000000, 395.733337, "~<~_________________________~>~");
	PlayerTextDrawLetterSize(playerid, SpecTD[3][playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, SpecTD[3][playerid], 1);
	PlayerTextDrawColor(playerid, SpecTD[3][playerid], -1);
	PlayerTextDrawSetShadow(playerid, SpecTD[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpecTD[3][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SpecTD[3][playerid], 51);
	PlayerTextDrawFont(playerid, SpecTD[3][playerid], 1);
	PlayerTextDrawSetProportional(playerid, SpecTD[3][playerid], 1);
	PlayerTextDrawSetPreviewModel(playerid, SpecTD[3][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid, SpecTD[3][playerid], 0.000000, 0.000000, 0.000000, 0.000000);

	SpecTD[4][playerid] = CreatePlayerTextDraw(playerid, 320.000000, 396.977752, "~p~~h~Suphe: ~w~~h~~h~~h~Airbreak_FlyHack");
	PlayerTextDrawLetterSize(playerid, SpecTD[4][playerid], 0.221000, 1.270220);
	PlayerTextDrawAlignment(playerid, SpecTD[4][playerid], 2);
	PlayerTextDrawColor(playerid, SpecTD[4][playerid], -1);
	PlayerTextDrawSetShadow(playerid, SpecTD[4][playerid], 0);
	PlayerTextDrawSetOutline(playerid, SpecTD[4][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, SpecTD[4][playerid], 51);
	PlayerTextDrawFont(playerid, SpecTD[4][playerid], 1);
	PlayerTextDrawSetProportional(playerid, SpecTD[4][playerid], 1);
	PlayerTextDrawSetPreviewModel(playerid, SpecTD[4][playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid, SpecTD[4][playerid], 0.000000, 0.000000, 0.000000, 0.000000);


	TarihTD = TextDrawCreate(544.000000, 26.000000, "22 Mayis 2016");
	TextDrawBackgroundColor(TarihTD, 255);
	TextDrawFont(TarihTD, 3);
	TextDrawLetterSize(TarihTD, 0.329999, 1.699999);
	TextDrawColor(TarihTD, 1718145279);
	TextDrawSetOutline(TarihTD, 1);
	TextDrawSetProportional(TarihTD, 1);

	SaatTD = TextDrawCreate(623.000000, 40.000000, "12:00");
	TextDrawAlignment(SaatTD, 3);
	TextDrawBackgroundColor(SaatTD, 255);
	TextDrawFont(SaatTD, 3);
	TextDrawLetterSize(SaatTD, 0.329999, 1.699999);
	TextDrawColor(SaatTD, -1);
	TextDrawSetOutline(SaatTD, 1);
	TextDrawSetProportional(SaatTD, 1);


	new strs[ 100 ];
	gpci( playerid , strs , sizeof( strs ) );
	printf("Player %s Connected. Serial: %s", oIsim(playerid), strs);

	new Text:fdfd;
    fdfd = TextDrawCreate(3011.000000, 3818.000000, "_");
	for(new x; x < 612; x++)
	{
    	TextDrawSetPreviewModel(fdfd, x);
    	TextDrawHideForPlayer(playerid, fdfd);
    	TextDrawShowForPlayer(playerid, fdfd);
	}
	if(!strcmp(oIsim(playerid),"con",true) || strfind(oIsim(playerid),"_con",true) != -1 || strfind(oIsim(playerid),"con_",true) != -1)
	{
		Kick(playerid);
	}
    SetPVarInt(playerid, "T_STATE", 1);
   	SendDeathMessage(INVALID_PLAYER_ID,playerid,200);

	if(strfind(oIsim(playerid), "con", true)!= -1) return Ban(playerid);
	if(strfind(oIsim(playerid), "cOn", true)!= -1) return Ban(playerid);
	if(strfind(oIsim(playerid), "CoN", true)!= -1) return Ban(playerid);
	if(strfind(oIsim(playerid), "CON", true)!= -1) return Ban(playerid);
	if(strfind(oIsim(playerid), "COn", true)!= -1) return Ban(playerid);
	if(strfind(oIsim(playerid), "coN", true)!= -1) return Ban(playerid);
	if(strfind(oIsim(playerid), "Con", true)!= -1) return Ban(playerid);
	if(strfind(oIsim(playerid), "cON", true)!= -1) return Ban(playerid);
	if(strfind(oIsim(playerid),"s0nicTz",true)!=-1 || strfind(oIsim(playerid),"[BoT]",true)!=-1) Kickle(playerid, "Bot Hack");
	if(GetPVarInt(playerid, "Language__") == 0) SetPVarInt(playerid, "Language__", TURKISH);
	for(new i = 0; i < 12; i++)
	{
	    OyuncununSilahlari[playerid][i] = 0;
	}

	Badana6[playerid] = TextDrawCreate(497.000000, 100.000000, "_");
	TextDrawBackgroundColor(Badana6[playerid], 255);
	TextDrawFont(Badana6[playerid], 1);
	TextDrawLetterSize(Badana6[playerid], 0.200000, 1.000000);
	TextDrawColor(Badana6[playerid], -1);
	TextDrawSetOutline(Badana6[playerid], 1);
	TextDrawSetProportional(Badana6[playerid], 1);
	TextDrawSetShadow(Badana6[playerid], 1);
	TextDrawSetSelectable(Badana6[playerid], 0);

	SetSpawnInfo(playerid, 0, 0, 0, 0, 0,0, 0,0,0,0,0,0);
	SetPVarInt(playerid, "Language", TURKISH);
	if(MySQLHesapKontrol(playerid) != 0) PlayerInfo[playerid][Registered] = 1;

	PlayerUserBox[playerid][0] = CreatePlayerTextDraw(playerid, 142.666778, 132.408950, "_");
	PlayerTextDrawLetterSize(playerid, PlayerUserBox[playerid][0], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, PlayerUserBox[playerid][0], 1);
	PlayerTextDrawColor(playerid, PlayerUserBox[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, PlayerUserBox[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, PlayerUserBox[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerUserBox[playerid][0], 51);
	PlayerTextDrawFont(playerid, PlayerUserBox[playerid][0], 3);
	PlayerTextDrawSetProportional(playerid, PlayerUserBox[playerid][0], 1);

	PlayerUserBox[playerid][1] = CreatePlayerTextDraw(playerid, 144.888931, 177.208816, "asfd");
	PlayerTextDrawLetterSize(playerid, PlayerUserBox[playerid][1], 0.2900, 1.1000);
	PlayerTextDrawAlignment(playerid, PlayerUserBox[playerid][1], 1);
	PlayerTextDrawColor(playerid, PlayerUserBox[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, PlayerUserBox[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, PlayerUserBox[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerUserBox[playerid][1], 51);
	PlayerTextDrawFont(playerid, PlayerUserBox[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, PlayerUserBox[playerid][1], 1);

	SetPVarInt(playerid, "Spawned", 0);

	    if(GetPVarInt(playerid, "Language__") == ENGLISH){
		for(new i=0;i<5;i++)TextDrawShowForPlayer(playerid,eMessage[0][i]);
		for(new s=0;s<3;s++)TextDrawShowForPlayer(playerid,deMessage[0][s]);
		}else{
		for(new i=0;i<5;i++)TextDrawShowForPlayer(playerid,eMessage[1][i]);
		for(new s=0;s<3;s++)TextDrawShowForPlayer(playerid,deMessage[1][s]);
		}

	SetTimerEx("ivirzivirGuncelle", 1000, true, "i", playerid);
	dgi[playerid]=-1;
	dgi2[playerid]=-1;

    SetPlayerTime(playerid, 7, 0);
	if(MySQLHesapKontrol(playerid) == 0) ShowPlayerDialog(playerid, Language, DIALOG_STYLE_MSGBOX, ""DIALOG_BASLIK" - Dil Seçimi/Language Selection", "{C0C0C0}» {E24234}Türkçe -{FFFFFF} Devam etmek icin tercih ettiginiz dili secmeniz gerekiyor.\n{C0C0C0}» {E24234}English -{FFFFFF} You have to select your prefered language to continue.", "Turkish", "English");
	ivirzivirGuncelle(playerid);
	if(PlayerInfo[playerid][LoggedIn] == 1)
	{
	    RegServ(playerid, "Servere otomatik olarak giris yaptiniz, bilgileriniz yuklendi.", "You auto logged in, accounts data's loaded.");
	}

	switch(random(10))
	{
	    case 0: SetPlayerColor(playerid, 0x33EECCAA);
	    case 1: SetPlayerColor(playerid, 0xBCFF33AA);
	    case 2: SetPlayerColor(playerid, 0xFF5000AA);
	    case 3: SetPlayerColor(playerid, 0xC887FFAA);
	    case 4: SetPlayerColor(playerid, 0x00FFAAAA);
	    case 5: SetPlayerColor(playerid, 0xFAFAFAAA);
	    case 6: SetPlayerColor(playerid, 0xECCCDFAA);
	    case 7: SetPlayerColor(playerid, 0xFDFDFDAA);
	    case 8: SetPlayerColor(playerid, 0xFFBAD2AA);
	    case 9: SetPlayerColor(playerid, 0xEBFF00FF);
	}
    ApplyAnimation( playerid,"STRIP",Anims[random(sizeof(Anims))],4.1,1,1,1,1,1);
	return 1;
}
public OnPlayerRequestSpawn(playerid)
{
	if(GetPVarInt(playerid,"AntiFloodSspsawnMagNeteC") > GetTickCount())
	{
		if(GetPVarInt(playerid,"flood_ssspawn") > 5)
		{
			new
			    string[256],
			    cekenIsim[24],
				yil,
				ay,
				gun
			;
			GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));
			getdate(yil, ay, gun);
			format(string, sizeof(string), "{FFFFFF}Sunucudan name banlandiniz ! Detaylar:\n{FFFFFF}Banlayan:{E24234} Console\n{FFFFFF}Sebep:{E24234} SpamAttack\n{FFFFFF}Tarih:{E24234}%d.%d.%d\n\n{FFFFFF}Gereksiz yere n-banlandiginiz dusunuyorsaniz zerotr.com/forum adresimizden sikayet olusturun.", yil, ay, gun);
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK"{FFFFFF} - N-Banlandiniz!", string, "Tamam", "");
			TogglePlayerControllable(playerid, 0);
			PlayerInfo[playerid][banned] = 1;
			SetPVarInt(playerid, "NameBan", 1);
			SetTimerEx("banPlayer", 500, false, "i", playerid);
			format(string, sizeof(string), "~r~[~w~~h~~h~~h~N-BAN~r~]~p~ Console~w~~h~~h~~h~ >>>~p~~h~%s~w~~h~~h~~h~ [Gerekce: ~r~SpamAttack~w~~h~~h~~h~]", oIsim(playerid));
			TextMesaj(string, string);
			NBanSave(playerid, playerid, "SPAMATTAK");
			return 1;
		}
		SetPVarInt(playerid,"flood_ssspawn",GetPVarInt(playerid,"flood_ssspawn")+1);
	}else
	{
		SetPVarInt(playerid,"flood_ssspawn",0);
		SetPVarInt(playerid, "AntiFloodSspsawnMagNeteC", GetTickCount()+300);
	}
	if(MySQLHesapKontrol(playerid) != 0)
	{
		new str[256];
		format(str, sizeof(str), "SELECT * FROM oyuncular WHERE kullaniciadi = '%s'", oIsim(playerid));
		mysql_query(str);
		while(mysql_retrieve_row())
		{
		    new savingstring[256];
			mysql_fetch_field_row(savingstring, "otogiris");PlayerInfo[playerid][otogiris] = strval(savingstring);
			if(PlayerInfo[playerid][otogiris] == 1)
			{
				mysql_fetch_field_row(savingstring, "IP");
				mysql_free_result();
				new pip[30];
				GetPlayerIp(playerid,pip,30);
				if(!strcmp(savingstring,pip,true))
				{
					LoginPlayer(playerid);
					Bilgimesaj(playerid,"{C3C3C3}» {C3C3C3} Hesabýnýza otomatik olarak giriþ yapýldý, otomatik giriþi kapatmak için /omenu kullanýn.","{C3C3C3}» {FFFFFF}You auto logged-in the account.");
				}
			}
	 	}
	}
	if(PlayerInfo[playerid][LoggedIn] == 0 && MySQLHesapKontrol(playerid) != 0)
	{
		new
		    sus_Seyi[512]
		;
		format(sus_Seyi, sizeof(sus_Seyi), "{FFFFFF}Sunucuya hos geldiniz sayin {E24234}%s{FFFFFF},\nAsagidaki kutucuga sifrenizi girerek oyuna devam edebilirsiniz.", oIsim(playerid));
		ShowPlayerDialog(playerid, 1111, DIALOG_STYLE_PASSWORD, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Giris Yap", sus_Seyi, "Giriþ", "");
		return 0;
	}
	if(MySQLHesapKontrol(playerid) == 0)
	{
	    RegServ(playerid, "Sunucumuya kaydolmak icin {E24234}' /kayit '{FFFFFF} yazin.", "You are not registered, use /register command.");
	    
 }
	mapiconYukle(playerid);
	SendClientMessage(playerid,-1, "{C3C3C3}» {FFFFFF}Yetkili fiyat listemize bakmak için /fiyatlar yazýn.");
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(GetPVarInt(playerid,"AntiFloodSspawnMagNeteC") > GetTickCount())
	{
		if(GetPVarInt(playerid,"flood_sspawn") > 5)
		{
			Kickle(playerid,"State Hack");
			return 1;
		}
		SetPVarInt(playerid,"flood_sspawn",GetPVarInt(playerid,"flood_sspawn")+1);
	}else
	{
		SetPVarInt(playerid,"flood_sspawn",0);
		SetPVarInt(playerid, "AntiFloodSspawnMagNeteC", GetTickCount()+300);
	}
    return 1;
}
public OnPlayerSpawn(playerid)
{
    playerSpawned[playerid] = true;

	SetPVarInt(playerid, "OnClass", 0);
	/*TextDrawShowForPlayer(playerid, Badana0);
	TextDrawShowForPlayer(playerid, Badana1);
	TextDrawShowForPlayer(playerid, Badana2);
	TextDrawShowForPlayer(playerid, Badana3);
	TextDrawShowForPlayer(playerid, Badana4);
	TextDrawShowForPlayer(playerid, Badana5);
	TextDrawShowForPlayer(playerid, Badana6[playerid]);
	TextDrawShowForPlayer(playerid, Badana7);
	TextDrawShowForPlayer(playerid, Badana8);
	TextDrawShowForPlayer(playerid, Badana9);
	TextDrawShowForPlayer(playerid, Badana10);*/
	new geo_IPx[30];
	GetPlayerIp(playerid,geo_IPx, sizeof(geo_IPx));
    new strt[256];
    format(strt, sizeof(strt), "UPDATE oyuncular SET IP = '%s' WHERE kullaniciadi = '%s'", geo_IPx, oIsim(playerid));
    mysql_query(strt);
    format(strt, sizeof(strt), "UPDATE oyuncular SET LoggedIn = '1' WHERE kullaniciadi = '%s'", oIsim(playerid));
    mysql_query(strt);
	RemoveBuildingForPlayer(playerid, 10946, -2076.6563, 354.3672, 35.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 11024, -2076.2734, 359.3203, 44.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 11403, -2076.6563, 354.3672, 35.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 3868, -2120.7656, 336.8672, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3868, -2103.3281, 336.8672, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3868, -2032.2891, 336.8672, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3868, -2022.0859, 347.1328, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3868, -2022.0859, 364.5781, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3868, -2032.2969, 380.7422, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3868, -2131.1797, 347.2813, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3868, -2131.1797, 364.7266, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3868, -2049.7344, 336.8672, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3867, -2131.1797, 347.2813, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3867, -2120.7656, 336.8672, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3867, -2103.3281, 336.8672, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 792, -2056.6094, 326.6094, 34.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 3867, -2049.7344, 336.8672, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3867, -2032.2891, 336.8672, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3867, -2022.0859, 347.1328, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3867, -2131.1797, 364.7266, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 10949, -2076.2734, 359.3203, 44.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 3867, -2032.2969, 380.7422, 49.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3867, -2022.0859, 364.5781, 49.1563, 0.25);

//izle(playerid);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerTime(playerid,12,0);
	SetPlayerWeather(playerid,1);
	SetPlayerInterior(playerid,0);
	
		new
	    str[4];
	format(str, 4, "%d", PlayerInfo[playerid][skinplayer]);
	komut_myskin(playerid, str);
	
	if(PlayerInfo[playerid][rengim] != 0){
	SetPlayerColor(playerid, PlayerInfo[playerid][rengim]);
	}

	if(GetPlayerScore(playerid) >= 2500 && GetPlayerScore(playerid) <= 4999)
	{
 		PlayerInfo[playerid][SemiPro] = 1;
		SendClientMessage(playerid, -1, "{0A7E8C}<(SemiPro)>:{FFFFFF} Skorunuz 2.500 üzerinde oldugu icin artik ozel uyemissiniz !");
		SendClientMessage(playerid, -1, "{0A7E8C}<(SemiPro)>:{FFFFFF} Bazi durumlarda ayricaliklisiniz - MyCar,Her Spawnda Yarim Zirh,Giriþ Baþina 500$ !");
	}
    IsPlayerSpawned[playerid] = 1;
	//ShowDigitalClock(playerid);
	if(PlayerInfo[playerid][SemiPro] == 1) SetPlayerArmour(playerid, 50.0);
	PlayerPlaySound(playerid, 1184, 0,0,0);
	SetPlayerWeather(playerid, 0);
	SetPlayerTime(playerid, 10, 0);
    SetPVarInt(playerid, "First", 0);
	if(PlayerInfo[playerid][LoggedIn] == 0 && PlayerInfo[playerid][Registered] == 1) return ForceClassSelection(playerid), Hatamesaj(playerid, "Giris yapmadan spawn olamassiniz!", "You spawn is blocked. Reason: Not Logged-In");
 	SetTimerEx("TextleriGuncelle", 100, true, "i", playerid);
	PlayerTextDrawShow(playerid, Textdraw[playerid][0]);
	PlayerTextDrawShow(playerid, Textdraw[playerid][1]);
	PlayerTextDrawShow(playerid, Textdraw[playerid][2]);
	PlayerTextDrawShow(playerid, Textdraw[playerid][3]);
	PlayerTextDrawShow(playerid, Textdraw[playerid][4]);
	PlayerTextDrawShow(playerid, Textdraw[playerid][5]);
	PlayerTextDrawShow(playerid, Textdraw[playerid][6]);
	PlayerTextDrawShow(playerid, Textdraw[playerid][7]);
	if(GetPVarInt(playerid,"AntiFloodSpawnMagNeteC") > GetTickCount())
	{
		if(GetPVarInt(playerid,"flood_spawn") > 2)
		{
			Kickle(playerid,"Spawn Flood");
			return 1;
		}
		SetPVarInt(playerid,"flood_spawn",GetPVarInt(playerid,"flood_spawn")+1);
	}else
	{
		SetPVarInt(playerid,"flood_spawn",0);
		SetPVarInt(playerid, "AntiFloodSpawnMagNeteC", GetTickCount()+300);
	}
    Spectekiler[playerid] = -1;
	TextDrawSetString(Death2, "NaN");
	TextDrawSetString(Death3, "NaN");
	TextDrawHideForPlayer(playerid, Death0);
	TextDrawHideForPlayer(playerid, Death1);
	TextDrawHideForPlayer(playerid, Death2);
	TextDrawHideForPlayer(playerid, Death3);
	TextDrawHideForPlayer(playerid, Death4);

	if(GetPlayerScore(playerid) < 5000) PlayerInfo[playerid][Veteran] = 0;
	if(GetPlayerScore(playerid) > 5000 && PlayerInfo[playerid][Veteran] == 0)
	{
	    PlayerInfo[playerid][Veteran] = 1;
		SendClientMessage(playerid, -1, "{ffa500}<(Veteran)>:{FFFFFF} Skorunuz 5.000 üzerinde oldugu icin artik ozel uyemissiniz !");
		SendClientMessage(playerid, -1, "{ffa500}<(Veteran)>:{FFFFFF} Bazi durumlarda ayricaliklisiniz - MyCar,Her Spawnda Zirh,Giriþ Baþina Skor !");
	}
	if(PlayerInfo[playerid][Veteran] == 1) SetPlayerArmour(playerid, 99.0);
    RecentlyShot[playerid] = 0;
	ivirzivirGuncelle(playerid);
    if(MySQLHesapKontrol(playerid) == 1){
    new	Query[512],savingstring[16];
	format(Query, sizeof(Query), "SELECT `language`, `IP`, `banned`, `otogiris` FROM `oyuncular` WHERE `kullaniciadi` = '%s'", oIsim(playerid));
	mysql_query(Query);
	mysql_store_result();
	while(mysql_retrieve_row())
	{
	mysql_fetch_field_row(savingstring, "banned");
	if(strval(savingstring) != 0){
		Kickle(playerid, "Name-Ban Yemis.");
	return 1;
	}
	}}
	GivePlayerWeapon(playerid, WEAPON_KATANA, 1);
	GivePlayerWeapon(playerid, WEAPON_TEC9, 15000);
	GivePlayerWeapon(playerid, WEAPON_COLT45, 15000);
	GivePlayerWeapon(playerid, WEAPON_M4, 15000);
	GivePlayerWeapon(playerid, WEAPON_DEAGLE, 15000);
	GivePlayerWeapon(playerid, WEAPON_SHOTGUN, 15000);
	SetPVarInt(playerid, "Spawned", 1);
	PlayerPlaySound(playerid, 1186, 0,0,0);
	PlayerPlaySound(playerid, 1150, 0,0,0);
    SetPlayerTime(playerid, 7, 0);
    TogglePlayerControllable(playerid, 0);
	SetPVarString(playerid, "FreezedBy", "ObjelerYukleniyor");
	SetTimerEx("objelerYukleniyor", 1600, false, "i", playerid);
	SetPVarInt(playerid, "Coz__", 1);
	SetCameraBehindPlayer(playerid);
	SetPlayerWeather(playerid, 1);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	if(PlayerInfo[playerid][Jailed] == 1) return 1;
	if (GetPVarInt(playerid, "PlayerInDM") == 0)
	{
		if (PlayerInfo[playerid][SpawnAlani] != 0)
		{
			switch(PlayerInfo[playerid][SpawnAlani]-1)
			{
				case 0: SetPlayerPos(playerid, 437.8750,-1853.6279,3.4921+0.4), SetPlayerFacingAngle(playerid, 186.7484);
				case 1: SetPlayerPos(playerid, 1291.2681,-231.3453,12.3748+0.4), SetPlayerFacingAngle(playerid, 18.8235);
				case 2: SetPlayerPos(playerid, -299.3183,1506.0825,83.6708+0.4),SetPlayerFacingAngle(playerid, 357.6948);
				case 3: SetPlayerPos(playerid, -2676.4851,623.9783,14.4459+0.4);
				case 4: SetPlayerPos(playerid, -1699.4066,1624.1786,2.2680+0.4),SetPlayerFacingAngle(playerid, 178.0495);
				case 5: SetPlayerPos(playerid, -2138.0576, -2373.5544, 32.0264+0.1),SetPlayerFacingAngle(playerid, 178.0495);
			}
			}else
			{
				switch(random(6))
				{
					case 0: SetPlayerPos(playerid, 437.8750,-1853.6279,3.4921+0.4), SetPlayerFacingAngle(playerid, 186.7484);
					case 1: SetPlayerPos(playerid, 1291.2681,-231.3453,12.3748+0.4), SetPlayerFacingAngle(playerid, 18.8235);
					case 2: SetPlayerPos(playerid, -299.3183,1506.0825,83.6708+0.4),SetPlayerFacingAngle(playerid, 357.6948);
					case 3: SetPlayerPos(playerid, -2676.4851,623.9783,14.4459+0.4);
					case 4: SetPlayerPos(playerid, -1699.4066,1624.1786,2.2680+0.4),SetPlayerFacingAngle(playerid, 178.0495);
					case 5: SetPlayerPos(playerid, -2138.0576, -2373.5544, 32.0264+0.1),SetPlayerFacingAngle(playerid, 178.0495);
			}
		}
	if (GetPVarInt(playerid, "Zirh__") != 0)
	{
	    SetPlayerArmour(playerid, 100.0);
	}
	}
	else
	{
	    if (GetPVarInt(playerid, "PlayerInDM") == 1) SetPVarInt(playerid, "PlayerInDM", 0), komut_mg1(playerid, " ");
	    if (GetPVarInt(playerid, "PlayerInDM") == 2) SetPVarInt(playerid, "PlayerInDM", 0), komut_mg2(playerid, " ");
	    if (GetPVarInt(playerid, "PlayerInDM") == 3) SetPVarInt(playerid, "PlayerInDM", 0), komut_rocket(playerid, " ");
	}
	if(PlayerInfo[playerid][Jailed] != 0)
	{
	    Bilgimesaj(playerid, "Oyundan ciktiginizda hapisteydiniz, tekrar hapse gonderildiniz.", "You jailed!");
		new iTargetID = playerid;
		if(PlayerInfo[iTargetID][Jailed] != 0)
		{
				SetPlayerVirtualWorld(iTargetID, 696969);
				new rand = random(sizeof(AdminPrisonFloat));
				SetPlayerPos(iTargetID, AdminPrisonFloat[rand][0], AdminPrisonFloat[rand][1], AdminPrisonFloat[rand][2]);
		}
	}
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == BankTD2)
	{
		if(!spamProtect(playerid, "apampawetnpo", 1)) return INmessage(playerid, "Bu komutu kullanabilmeniz icin {E24234}' 1 '{FFFFFF} saniye beklemeniz lazim!");
	    new string[2001];
	    new	Query[512],islem[16], tarih[34], miktar[24], kime[24];
		format(Query, sizeof(Query), "SELECT * FROM dokumanlar WHERE sahip = '%s' ORDER BY `id` DESC LIMIT 10", oIsim(playerid));
		mysql_query(Query);
		mysql_store_result();
		while(mysql_retrieve_row())
		{
			mysql_fetch_field_row(islem, "islem");
			mysql_fetch_field_row(tarih, "tarih");
			mysql_fetch_field_row(miktar, "mevla");
			mysql_fetch_field_row(kime, "kime");
			format(string, sizeof(string), "%s{FFFFFF}Tarih: {E24234}%s{FFFFFF} - Ýþlem: {E24234}%s{FFFFFF} - Miktar:{E24234} %i{FFFFFF} Kime: {E24234}%s\n", string, tarih, islem, strval(miktar), kime);
		}
		strcat(string, "\n{FFFFFF}Sadece son 10 iþlemin dökümanýný görebilirsiniz. Devamýný forum üzerinden isteyebilirsiniz.");
		ShowPlayerDialog(playerid, 3434, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK" - Banka - Dökümanlar", string, "Tamam", "");
		bankaKayit(playerid, "Banka", "Bilgi Teyidi", -1);
	}
	else if(clickedid == BankTD3)
	{
		new string[512];
		format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{ffffff}Çekeceginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Deposit]);
		ShowPlayerDialog(playerid, 1240, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka - Para Çek", string, "Geri", "");
	}
	else if(clickedid == BankTD4)
	{
		new string[512];
		format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{8CE02C}» {FFFFFF}Mevcud oyun bakiyeniz: {8CE02C}%d\n{ffffff}Yatiracaginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Deposit], GetPlayerMoney(playerid));
		ShowPlayerDialog(playerid, 1241, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka - Para Yatir", string, "Geri", "");
	}
	else if(clickedid == BankTD5)
	{
		new string[512];
		format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{ffffff}Hesabina para transfer edeceginiz kisinin rumuzunu girin; (Orn: [AoA]CaLderoN)", PlayerInfo[playerid][Deposit]);
		ShowPlayerDialog(playerid, 1299, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Transfer", string, "Geri", "");
	}
	else if(clickedid == BankTD9)
	{
		new string[512];
		format(string, sizeof(string), "{8CE02C}» {FFFFFF}Prim Miktarý; {8CE02C}%d\n{ffffff}Prim (Ýkramiye) bakiyenizden ne kadar çekeceksiniz?;", PlayerInfo[playerid][Ikramiye]);
		ShowPlayerDialog(playerid, 1290, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka - Ýkramiye", string, "Geri", "");
	}
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	#if defined TDMPASIF
	    new musade;
		foreach(new i : zombieGamer)
		{
		    if(i == playerid)
		    {
		        musade = 1;
		    }
		}
		if(musade == 1) return Hatamesaj(playerid,"Bu komutu kullanabilmeniz icin TDM'de olmamaniz lazim","Please exit tdm.."), 0;
	#endif
	#if defined RACEPASIF
	if(Joined[playerid] == true) return Hatamesaj(playerid,"Bu komutu kullanabilmeniz icin RACE'de olmamaniz lazim","Please exit race.."), 0;
    #endif
	if(balance[playerid] == true) return PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0),CloseselectioanMenu(playerid),CancelSelectTextDraw(playerid),SetPVarInt(playerid, "vspawner_active", 0);
    if(ETK[playerid] == 1) return PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0),CloseselectioanMenu(playerid),CancelSelectTextDraw(playerid),SetPVarInt(playerid, "vspawner_active", 0);
    if(DDArac[playerid] != INVALID_VEHICLE_ID) return PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0),CloseselectioanMenu(playerid),CancelSelectTextDraw(playerid),SetPVarInt(playerid, "vspawner_active", 0);
    if(GetPVarInt(playerid, "PlayerInDM")) return PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0),CloseselectioanMenu(playerid),CancelSelectTextDraw(playerid),SetPVarInt(playerid, "vspawner_active", 0);
	new x=0;
	while(x != selectioaN_itemaS)
	{
	    if(playertextid == gselectioanitemas[playerid][x])
		{
			if(IsPlayerInAnyVehicle(playerid)) return Hatamesaj(playerid, "Sorun olusmamasi adina aractan inin.", "Sorun olusmamasi adina aractan inin.");// if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
			if(Araba[playerid] == 1) DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
		    new str[4];
		    format(str, sizeof(str), "%d", x);
		    SendClientMessage(playerid, -1, str);
	        HandlePlayeritemaselectioan(playerid, x);
	        PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
         	CloseselectioanMenu(playerid);
	        CancelSelectTextDraw(playerid);
        	SetPVarInt(playerid, "vspawner_active", 0);
        	return 1;
		}
		x++;
	}
	return 1;
}
function objelerYukleniyor(playerid)
{
	SetPVarInt(playerid, "Coz__", 0);
    TogglePlayerControllable(playerid, 1);
	return 1;
}
public OnPlayerCleoDetected(playerid, cleoid )
{
	if(cleoid == 1)
	{
	    Kickle(playerid, "Fake Kill");
	}
	else if(cleoid == 2)
	{
	    Kickle(playerid, "Car Warper");
	}
	else if(cleoid == 3)
	{
		Kickle(playerid, "Player Bugger");
	}
	else if(cleoid == 5)
	{
	    Kickle(playerid, "Car Spammer");
	}
	return 1;
}
public OnPlayerCommandReceived(playerid, cmdtext[])
{
	if(!strcmp(cmdtext,"/races",true))
	{
		if(PlayerInfo[playerid][Level] < 9)return YETERSIZSEVIYE2(playerid,9);
		#if defined RACEPASIF
	    if(RaceBusy == 0x00) {
	    ShowPlayerDialog(playerid, 4790, DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Yarýþlar",racenames,"Baþlat","Ýptal");
		return 1;
		}else return Hatamesaj(playerid, "Lütfen yarýþýn bitmesini bekleyin.", "Lütfen yarýþýn bitmesini bekle.");
		#endif
	}

	if(!strcmp(cmdtext, "/bcik"))
	{
	    if(balance[playerid] == false) return Hatamesaj(playerid, "Su an balancede deðilsiniz.", "You are'nt entered balance."), 0;
        SetPlayerHealth(playerid, -1);
	    return 0;
	}
 	if(balance[playerid] == true) return Hatamesaj(playerid, "Önce Balance'den cikmalisiniz - Cikmak icin {E24234}/bcik{FFFFFF} yazin.", "Balance exit command is /bcik."), 0;

	#if defined TDMPASIF
	if(!strcmp(cmdtext, "/tdmasfasf", true))
	{
		if(PlayerInfo[playerid][Level] == 0) return 1;
		zombieKills ++;
		return 1;
	}
	if(!strcmp(cmdtext, "/tdmcik", true))
	{
	    new musade;
		foreach(new i : zombieGamer)
		{
		    if(i == playerid)
		    {
		        musade = 1;
		    }
		}
		if(musade == 0) return Hatamesaj(playerid,"Bu komutu kullanabilmeniz icin TDM'de olmaniz lazim","You are not in a TDM."), 0;
		SpawnPlayer(playerid);
		Iter_Remove(zombieGamer, playerid);
		SetPVarInt(playerid, "Thakim", 0);
		TextDrawHideForPlayer(playerid, Sayac3);
		TextDrawHideForPlayer(playerid, Sayac2);
		TextDrawHideForPlayer(playerid, Sayac1);
		TextDrawHideForPlayer(playerid, Sayac0);
 		GameTextForPlayer(playerid, "_", 1, 3);
		return 0;
	}
	foreach(new i : zombieGamer)
	{
	    if(i == playerid)
	    {
	        return INmessage(playerid, "Önce TDM'den cikmalisiniz - TDM'den cikmak icin {E24234}' /tdmcik '{FFFFFF} yazin."), 0;
	    }
	}
	#endif
	if(!strcmp(cmdtext, "/sos", true))
	{
	    #if defined RACEPASIF
		if(Joined[playerid] != true) return Hatamesaj(playerid,"Bu komutu kullanabilmeniz icin yarisda olmaniz lazim!","You are not in a race."), 0;
		if(RaceStarted == 0) return Hatamesaj(playerid, "Yarisin baslamasini bekleyin.", "Please wait race start."), 0;
		SetPlayerPos(playerid, vPos[playerid][0],vPos[playerid][1],vPos[playerid][2]);
		SetTimerEx("gulsun", 150, false, "i", playerid);
		#endif
		return 0;
	}
	if(!strcmp(cmdtext, "/yariscik", true))
	{
	    #if defined RACEPASIF
	    if(Joined[playerid] == true)
	    {
	        for ( new i = 0; i < 11; i++ )
	   		PlayerTextDrawHide( playerid, Race_InfoTD[ i ] );

			JoinCount--;
			Joined[playerid] = false;
			DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
		    DisablePlayerRaceCheckpoint(playerid);
			TextDrawHideForPlayer(playerid, RaceInfo[playerid]);
			CPProgess[playerid] = 0;
			KillTimer(InfoTimer[playerid]);
			TogglePlayerControllable(playerid, true);
			SetCameraBehindPlayer(playerid);
			TextDrawHideForPlayer(playerid, RaceSayac0);
			SpawnPlayer(playerid);
			TextDrawHideForPlayer(playerid, RaceSayac1);
			TextDrawHideForPlayer(playerid, RaceSayac2);
			TextDrawHideForPlayer(playerid, RaceSayac3);
			TextDrawHideForPlayer(playerid, RaceSayac4);
			TextDrawHideForPlayer(playerid, RaceSayac5);
			#if defined RACE_IN_OTHER_WORLD
			SetPlayerVirtualWorld(playerid, 0);
			#endif
		} else return Hatamesaj(playerid, "Bir yarisda degilsiniz.", "You are not in a race!"),0;
		#endif
		return 0;
	}
	#if defined RACEPASIF
    if(Joined[playerid] == true) return INmessage(playerid, "Önce yarisdan cikmalisiniz - Yarisdan cikmak icin {E24234}/yariscik{FFFFFF} yazin."), 0;
	#endif
	if(!strcmp(cmdtext, "/ddcik", true))
	{
	    if(DDArac[playerid] == INVALID_VEHICLE_ID) return INmessage(playerid, "Bir DD'de degilsiniz."), 0;
	    DDCikar(playerid, 3);
	    SetCameraBehindPlayer(playerid);
		return 0;
	}
    if(DDArac[playerid] != INVALID_VEHICLE_ID) return INmessage(playerid, "Önce DD'den cikmalisiniz - DD'den cikmak icin {E24234}/ddcik{FFFFFF} yazin."), 0;
	if(PlayerInfo[playerid][Jailed] == 1 && PlayerInfo[playerid][JailTime] > 0)
	{
	    new
			string[256];
		format(string, sizeof(string), "Hapisdeyken komut kullanamassiniz. Kalan sure {E24234}' %s '", TimeConvert(PlayerInfo[playerid][JailTime]));
		Hatamesaj(playerid, string, string);
		return 0;
	}
	if(!strcmp(cmdtext, "/etkcik", true))
	{
	    ETK[playerid] = 0;
		OnPlayerSpawn(playerid);
		return 0;
	}
	if(ETK[playerid] == 1) return INmessage(playerid,"Önce etkinlikten cikmalisiniz - Etkinlikten cikmak icin {E24234}/etkcik{FFFFFF} yazin."), 0;
	if(GetPVarInt(playerid, "Coz__") == 1)
	{
	    Hatamesaj(playerid, "Etrafinizda ki objelerin yuklenmesini bekleyin.", "Please wait for the loading of objects around.");
		return 0;
	}
	if(playerSpawned[playerid] == false) {
	    Hatamesaj(playerid, "Spawn olmadan komut kullanamassiniz.", "Please wait for the spawning.");
		return 0;
	}
	if(!strcmp(cmdtext, "/dmcik", true))
	{
		if (GetPVarInt(playerid, "PlayerInDM") != 0)
		{
			SetPVarInt(playerid, "PlayerInDM", 0);
			ResetPlayerWeapons(playerid);
			OnPlayerSpawn(playerid);
		} else return Hatamesaj(playerid, "Su an bir DM'de degilsiniz!", "You are not entered dm."), 0;
		return 0;
	}
	if(GetPVarInt(playerid, "PlayerInDM") != 0)
	{
		return Hatamesaj(playerid, "Önce DM'den cikmalisiniz - DM'den cikmak icin {E24234}' /dmcik '{FFFFFF} yazin.", "You need to leave DeathMatch!"), 0;
	}
	return 1;
}
public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success)
	{
		Hatamesaj(playerid, "Boyle bir komut bulunmamaktadir, yardim almak icin {E24234}/yardim{FFFFFF} yazin.", "This command is unknown! To see the rest of the commands consider using {E24234}/help{FFFFFF}.");
	}
	return 1;
}
public OnVehicleMod(playerid, vehicleid, componentid) {

	return 1;
}
public OnVehicleDeath(vehicleid, killerid)
{
	if(GetVehicleModel(vehicleid) == DD_MODEL)
	{
	    for(new i; i < MAX_PLAYERS; ++i)
	    {
	        if(!IsPlayerConnected(i)) continue;
	        if(vehicleid == DDArac[i]) DDCikar(i, 6);
	    }
	}

	return 1;
}
//
//}
public OnPlayerDeath(playerid, killerid, reason)
{
    playerSpawned[playerid] = false;
    if(duelinfo[killerid][induel] == 1)
    {
        duelinfo[killerid][induel] = 0;
        new string[128];
            format(string, sizeof(string), "{C3C3C3}« Duel »{E24234} %s{FFFFFF},{E24234}%s{FFFFFF}'i öldürerek düelloyu kazandý - Ödül: {E24234}%d score", duelinfo[killerid][playername], duelinfo[playerid][playername], duelinfo[playerid][reward]);
            SendClientMessageToAll(-1, string);
            SetPlayerScore(killerid, GetPlayerScore(killerid) + duelinfo[killerid][reward]);
    }

	if (GetPVarInt(playerid, "OnClass") == 1)
	{
	    Kickle(playerid, "Hack");
	}
	#if defined TDMPASIF
	if(GetPVarInt(killerid, "Thakim") == ZOMBI_) zombieKills++, insanSpawn(playerid);
	if(GetPVarInt(killerid, "Thakim") == INSAN_) insanKills++, zombiSpawn(playerid);
	#endif
	if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
	ShowPlayerDialog(playerid, 500000, 3, "_","_","_","_");
	if(killerid != INVALID_PLAYER_ID && playerid == killerid) Kickle(playerid,"Death Hack");

	if(playerid >= 0)
	{
	    if(!spamProtect(playerid, "spamCeath", 1)) {} else SendDeathMessage(killerid, playerid, reason);

		SetPVarInt(playerid, "Spawned", 0);
		PlayerInfo[playerid][Deaths] += 1;
		DDCikar(playerid, 1);
		ETK[playerid] = 0;
	 	//kombo sistemi
	    kombo[playerid] = 0;
	    if(kombo[killerid]< 15)kombo[killerid]++;
		new cal_str[256];
		format(cal_str,256,"~y~Combooo!~n~~y~-~w~~h~~h~~h~ %d ~y~-~n~~y~+%d score",kombo[killerid],kombo[killerid]);
		GameTextForPlayer(killerid, cal_str, 3000, 3);
		SetPlayerScore(killerid,GetPlayerScore(killerid)+kombo[killerid]);
		format(cal_str,256,"Kombo {FF0015}%d",kombo[killerid]);
		SetPlayerChatBubble(killerid, cal_str, -1, 100.0, 60000);

	   if(killerid != INVALID_PLAYER_ID)
	    {
			new string[60], silahname[36];
			SetPVarInt(playerid, "Spawned", 0);
			new playersWeapon = GetPlayerWeapon(killerid);
			GetWeaponName(playersWeapon, silahname, sizeof(silahname));
			format(string, sizeof(string), "Olduren: ~r~%s", oIsim(killerid));
			TextDrawSetString(Death2, string);
			format(string, sizeof(string), "Silah: ~r~%s", silahname);
			TextDrawSetString(Death3, string);
			TextDrawShowForPlayer(playerid, Death0);
			TextDrawShowForPlayer(playerid, Death1);
			TextDrawShowForPlayer(playerid, Death2);
			TextDrawShowForPlayer(playerid, Death3);
			TextDrawShowForPlayer(playerid, Death4);
			if(GetPlayerMoney(playerid) > 1000 && GetPlayerScore(playerid) > 0) GivePlayerMoney(playerid, -1000), SetPlayerScore(playerid, GetPlayerScore(playerid)-1);
		}
		ivirzivirGuncelle(playerid);
		PlayerInfo[killerid][Kills] += 1;
		SetPVarInt(playerid, "Spawned", 0);
		if(dgi2[playerid] == killerid ||dgi2[killerid] == playerid){
			SetPlayerScore(killerid, GetPlayerScore(killerid)+SKOR_KAZANMA);
			GivePlayerMoney(killerid, 2000);
			SendClientMessage(playerid, -1, "{E24234}<(Bilgi)>{FFFFFF} Düelloyu kaybettiniz.");
			SendClientMessage(killerid, -1, "{E24234}<(Bilgi)>{FFFFFF} Düelloyu kazandiniz. +2 skor ve $2000+ para!");
			SendDeathMessage(killerid, playerid, reason);
			ResetPlayerWeapons(playerid);
			ResetPlayerWeapons(killerid);
			SpawnPlayer(killerid);
			duelinfo[playerid][induel] = 0;
			duelinfo[killerid][induel] = 0;
		}
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
    if(!success) //If the password was incorrect
    {
        new pip[16];
        for(new playerid=0; playerid<MAX_PLAYERS; playerid++) //Loop through all players
        {
            GetPlayerIp(playerid, pip, sizeof(pip));
            if(!strcmp(ip, pip, true)) //If a player's IP is the IP that failed the login
            {
				new string[256];
				if(GetPVarInt(playerid, "Uyari") == 3) return Kickle(playerid, "Rcon Uyari");
				SetPVarInt(playerid, "Uyari", GetPVarInt(playerid, "Uyari")+1);
				format(string, sizeof(string), "Girmis oldugunuz {E24234}' %s '{FFFFFF} sifresi rcon sifremizle ayni degil! [%d/3]", password, GetPVarInt(playerid, "Uyari"));
				Bilgimesaj(playerid, string, string);
			}
		}
    }
    return 1;
}

public OnPlayerDisconnect(playerid)
{
    Speedlimit[playerid] = 0;
	OnlineSayisi--;

	if(GetPVarInt(playerid,"reconnecting") == 1)
	{
	    new fad[34], ipd[24];
	    GetPlayerIp(playerid, ipd, sizeof(ipd));
	    format(fad, sizeof(fad), "unbanip %s", ipd);
		SendRconCommand(fad);
		DeletePVar(playerid,"reconnecting");
	}
	#if defined TDMPASIF
	Iter_Remove(zombieGamer, playerid);
	#endif
	SendDeathMessage(INVALID_PLAYER_ID, playerid, 201);

    DDCikar(playerid, 0);
    SavePlayer(playerid);
	PlayerInfo[playerid][Jailed]=0;
    PlayerInfo[playerid][sqlid]=0;PlayerInfo[playerid][money]=0;PlayerInfo[playerid][Deaths]=0;PlayerInfo[playerid][Kills]=0;PlayerInfo[playerid][Level]=0;PlayerInfo[playerid][Animator]=0;
	PlayerInfo[playerid][score]=0;PlayerInfo[playerid][LoggedIn]=0;
	PlayerInfo[playerid][banned]=0;PlayerInfo[playerid][Registered]=0;
	PlayerInfo[playerid][JailTime]=0;PlayerInfo[playerid][language]=0;PlayerInfo[playerid][oyundami]=0;PlayerInfo[playerid][Muted]=0;PlayerInfo[playerid][Frozen]=0;PlayerInfo[playerid][FreezeTime]=0;
	PlayerInfo[playerid][Warnings]=0;PlayerInfo[playerid][SpecID]=0;
	PlayerInfo[playerid][SpecType]=0;PlayerInfo[playerid][FailLogin]=0;PlayerInfo[playerid][DialogGiris]=0;PlayerInfo[playerid][God] = 1;
	PlayerInfo[playerid][DisablePM]=0;PlayerInfo[playerid][ceteid] = -1;PlayerInfo[playerid][ceterutbeid] = -1;PlayerInfo[playerid][onlinet] =0;
	PlayerInfo[playerid][pmspec] = 0;PlayerInfo[playerid][skinplayer] = -1;PlayerInfo[playerid][yetkiname] = EOS;PlayerInfo[playerid][rengim] = 0;
	PlayerInfo[playerid][vayar] = 0;PlayerInfo[playerid][mayar] = 0;PlayerInfo[playerid][shootskil] = 0;PlayerInfo[playerid][spectime]=0;PlayerInfo[playerid][spec]=0;

	SetPVarInt(playerid, "Spawned", 0);
	SetPVarInt(playerid, "Lazer", 0);
    RemovePlayerAttachedObject(playerid, 0);
	dgi[playerid]=-1;
	dgi2[playerid]=-1;
	return 1;
}
public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
 	for(new x; x < 15; x++)
	{
		if (checkpointid == InfoPlace[x])
		{
		    if (TypePalace[x] == 0) komut_teles(playerid, " ");
		    else komut_v1(playerid, " "), INmessage(playerid, "Daha cok arac listesi gormek istiyorsaniz {E24234}' /v1-17 '{FFFFFF} deneyin.");
		}
	}
	return 1;
}
public OnPlayerText(playerid, text[])
{
 	if(noChat == 1 && PlayerInfo[playerid][Level] < 5)
	{
	    SendClientMessage(playerid, -1, "{C3C3C3}« zr-Admin «{FFFFFF} Chat ekrani bir yönetici tarafindan kapatildi!");
	    PlayerPlaySound(playerid, 1085, 0.0,0.0,0.0);
	    return 0;
	}
	new texta[500];
	format(texta, sizeof(texta),"%s",text);
	new s;
    while(texta[s] != EOS){
   	if((texta[s] == texta[s+1]) && (texta[s+1] == texta[s+2]) && (texta[s+2] == texta[s+3]))return Hatamesaj(playerid, "Lütfen harf uzatmasi yapmayin.", "Please don't flood."), 0;
   	else
   	s++;
   	}
    if(strfind(text," ",true)!=-1 || strfind(text,"ô",true)!=-1
	|| strfind(text,"¦",true)!=-1
	|| strfind(text,"¢",true)!=-1
	|| strfind(text,"£",true)!=-1
	|| strfind(text,"•",true)!=-1
	|| strfind(text,"Ô",true)!=-1
	|| strfind(text,"Ã",true)!=-1
	|| strfind(text,"û",true)!=-1
	|| strfind(text,"Û",true)!=-1
	|| strfind(text,"î",true)!=-1
	|| strfind(text,"Î",true)!=-1
	)
	{
	    return 0;
	}else{
	if(PlayerInfo[playerid][muted] == 1 && PlayerInfo[playerid][mutedtime] > 0)
	{
	    new
			string[256];
		format(string, sizeof(string), "Mute cezaniz oldugundan konusamassiniz. Kalan sure {E24234}' %s '", TimeConvert(PlayerInfo[playerid][mutedtime]));
		Hatamesaj(playerid, string, string);
		return 0;
	}
	if(PlayerInfo[playerid][Jailed] == 1 && PlayerInfo[playerid][JailTime] > 0)
	{
	    new
			string[256];
		format(string, sizeof(string), "Hapisdeyken konusamassiniz. Kalan sure {E24234}' %s '", TimeConvert(PlayerInfo[playerid][JailTime]));
		Hatamesaj(playerid, string, string);
		return 0;
	}
	if(!spamProtect(playerid, "vekong", 2) && PlayerInfo[playerid][Level] < 8)
	{
	    Hatamesaj(playerid, "Tekrar chate yazabilmeniz icin {E24234}' 2 '{FFFFFF} saniye beklemeniz lazim!", "Please wait 2 second before use chat.");
		return 0;
	}
	if(playerSpawned[playerid] == false) {
	    Hatamesaj(playerid, "Spawn olmadan chati kullanamassiniz.", "Please wait for the spawning.");
		return 0;
	}

    if(soruBasladi == 1)
    {
        if(!strcmp(sorular[aktifSoruID][Soru_Cevap], text))
        {
			new
				string[138],
				pName[MAX_PLAYER_NAME]
			;
			GetPlayerName(playerid, pName, sizeof(pName));
			for(new x; x < MAX_PLAYERS; x++)
			{
			    if(GetPVarInt(x, "Language__") == ENGLISH) format(string, sizeof(string), "{C3C3C3}« Quiz » {E24234}%s{FFFFFF} player has won! Prize: {E24234}10000$ {FFFFFF}- {E24234}5 score{FFFFFF}.", pName);
			    else format(string, sizeof(string), "{C3C3C3}« Quiz » {E24234}%s{FFFFFF} adli oyuncu kazandi! Odül: {E24234}10000$ {FFFFFF}- {E24234}5 score{FFFFFF}.", pName);
				SendClientMessage(x, -1, string);
			}
			GivePlayerMoney(playerid, 10000);
			SetPlayerScore(playerid, GetPlayerScore(playerid) + 5);
			soruBasladi = 0;
			return 0;
        }
    }
	switch(xTestBusy)
	{
		case true:
		{
			if(!strcmp(xChars, text, false))
			{
				new
					string[137],
					pName[MAX_PLAYER_NAME]
				;
				GetPlayerName(playerid, pName, sizeof(pName));
				for(new x; x < MAX_PLAYERS; x++)
				{
				    if(GetPVarInt(x, "Language__") == ENGLISH) format(string, sizeof(string), "{C3C3C3}« Test » {E24234}%s{FFFFFF} player has won! Prize: {E24234}15000$ {FFFFFF}- {E24234}5 score{FFFFFF}.", pName);
				    else format(string, sizeof(string), "{C3C3C3}« Test » {E24234}%s{FFFFFF} adli oyuncu kazandi! Odül: {E24234}15000$ {FFFFFF}- {E24234}5 score{FFFFFF}.", pName);
					SendClientMessage(x, -1, string);
				}
				GivePlayerMoney(playerid, 15000);
				SetPlayerScore(playerid, GetPlayerScore(playerid) + 5);
				xReactionTimer = SetTimer("xReactionTest", TIME, 1);
				xTestBusy = false;
				return 0;
			}
		}
	}
    if(text[0] == '#' && (PlayerInfo[playerid][Level] >= 1)) {
	    new string[256]; GetPlayerName(playerid,string,sizeof(string));
		format(string,sizeof(string),"{5f5f5f}» Admin Chat «{C3C3C3} %s[%d]{5f5f5f}; %s",string,playerid,text[1]); MessageToAdmins(-1,string);
	    return 0;
	}
	if(text[0] == '$' && (PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) {
	    new string[256]; GetPlayerName(playerid,string,sizeof(string));
		format(string,sizeof(string),"{dcdcdc}» Anim Chat « {C3C3C3}%s[%d]{dcdcdc}; %s",string,playerid,text[1]); MessageToAnims(-1,string);
	    return 0;
	}
	if(IsPlayerConnected(playerid))
	{
	    if(strfind(text,"{",true)!=-1 || strfind(text,"}",true)!=-1)
		{
			Hatamesaj(playerid, "Mesajinizda ozel karakter bulunduramassiniz.", "You cannot use special characters.");
			return 0;
		}
		if(unIP(text))
		{
			Hatamesaj(playerid, "Lütfen reklam yapmayin!", "Please don't advertise.");
			return 0;
		}
		if(PlayerInfo[playerid][Veteran] == 1 && PlayerInfo[playerid][Level] == 0 && PlayerInfo[playerid][Animator] == 0)
		{
			new
				szMessage[256],
				oyuncuad[24]
			;
			GetPlayerName(playerid, oyuncuad, sizeof(oyuncuad));
			if(PlayerInfo[playerid][veterantercih] == 2) format(szMessage, sizeof(szMessage),"{%06x}[{ffa500}Veteran{%06x}] %s™ ({ffa500}%d{%06x}) : {FFFFFF}%s", GetPlayerColor(playerid) >>> 8 , GetPlayerColor(playerid) >>> 8, getName(playerid), playerid ,GetPlayerColor(playerid) >>> 8 , text);
			if(PlayerInfo[playerid][veterantercih] == 1 || PlayerInfo[playerid][veterantercih] == 0) format(szMessage, sizeof(szMessage), "{%06x}%s™{ffa500}({FFFFFF}%d{ffa500}){FFFFFF}: %s", GetPlayerColor(playerid) >>> 8,oyuncuad, playerid, text);
			SendClientMessageToAll(-1, szMessage);
			printf("%s (%d): %s", oyuncuad,playerid,text);
			format(lastmessage[playerid], 144, "%s", text);
			return 0;
		}
		if(PlayerInfo[playerid][SemiPro] == 1 && PlayerInfo[playerid][Level] == 0 && PlayerInfo[playerid][Animator] == 0)
		{
			new
				szMessage[256],
				oyuncuad[24]
			;
			GetPlayerName(playerid, oyuncuad, sizeof(oyuncuad));
			if(PlayerInfo[playerid][semiprotercih] == 2) format(szMessage, sizeof(szMessage), "{%06x}[{0A7E8C}SemiPro{%06x}] %s™ ({0A7E8C}%d{%06x}) : {FFFFFF}%s", GetPlayerColor(playerid) >>> 8 , GetPlayerColor(playerid) >>> 8, getName(playerid), playerid ,GetPlayerColor(playerid) >>> 8 , text);
			if(PlayerInfo[playerid][semiprotercih] == 1 || PlayerInfo[playerid][semiprotercih] == 0) format(szMessage, sizeof(szMessage), "{%06x}%s™{0A7E8C}({FFFFFF}%d{0A7E8C}){FFFFFF}: %s", GetPlayerColor(playerid) >>> 8,oyuncuad, playerid, text);
			SendClientMessageToAll(-1, szMessage);
			printf("%s (%d): %s", oyuncuad,playerid,text);
			format(lastmessage[playerid], 144, "%s", text);
			return 0;
		}
		if(PlayerInfo[playerid][Level] == 0 && PlayerInfo[playerid][Animator] == 0)
		{
		if(PlayerInfo[playerid][Registered] == 0)return HataMesaji(playerid, "/kayit olmadan konuþamazsýnýz");
			new
				szMessage[256],
				oyuncuad[24]
			;
			GetPlayerName(playerid, oyuncuad, sizeof(oyuncuad));
			format(szMessage, sizeof(szMessage), "{%06x}%s({FFFFFF}%d{%06x}): {FFFFFF}%s", GetPlayerColor(playerid) >>> 8, oyuncuad, playerid, GetPlayerColor(playerid) >>> 8, text);
			SendClientMessageToAll(-1, szMessage);
			printf("%s (%d): %s", oyuncuad,playerid,text);
			format(lastmessage[playerid], 144, "%s", text);
			return 0;
		}
  if(PlayerInfo[playerid][DJ] > 0 && PlayerInfo[playerid][Level] == 0 && PlayerInfo[playerid][Animator] == 0)
		{
			new
				szMessage[256],
				oyuncuad[25]
			;
			GetPlayerName(playerid, oyuncuad, sizeof(oyuncuad));
			format(szMessage, sizeof(szMessage), "{%06x}>{FFFFFF}DJ{%06x}< %s ({FFFFFF}%d{%06x}) : {FFFFFF}%s", GetPlayerColor(playerid) >>> 8 , GetPlayerColor(playerid) >>> 8, getName(playerid), playerid ,GetPlayerColor(playerid) >>> 8 , text);
			SendClientMessageToAll(-1, szMessage);
			printf("%s (%d): %s", oyuncuad,playerid,text);
			format(lastmessage[playerid], 144, "%s", text);
			return 0;
		}
		if(PlayerInfo[playerid][Level] > 0)
		{
   new
				szMessage[256],
				oyuncuad[24]
			;
			GetPlayerName(playerid, oyuncuad, sizeof(oyuncuad));
			format(szMessage, sizeof(szMessage), "{%06x}>{FFFFFF}GM{%06x}< %s ({FFFFFF}%d{%06x}) : {FFFFFF}%s", GetPlayerColor(playerid) >>> 8 , GetPlayerColor(playerid) >>> 8, getName(playerid), playerid ,GetPlayerColor(playerid) >>> 8 , text);
			SendClientMessageToAll(-1, szMessage);
			printf("%s (%d): %s", oyuncuad,playerid,text);
			format(lastmessage[playerid], 144, "%s", text);
			return 0;
		}
		if(PlayerInfo[playerid][Animator] > 0)
		{
			new
				szMessage[256],
				oyuncuad[24]
			;
			GetPlayerName(playerid, oyuncuad, sizeof(oyuncuad));
			format(szMessage, sizeof(szMessage), "{%06x}>{FFFFFF}ANM{%06x}< %s ({FFFFFF}%d{%06x}) : {FFFFFF}%s", GetPlayerColor(playerid) >>> 8 , GetPlayerColor(playerid) >>> 8, getName(playerid), playerid ,GetPlayerColor(playerid) >>> 8 , text);
			SendClientMessageToAll(-1, szMessage);
			printf("%s (%d): %s", oyuncuad,playerid,text);
			format(lastmessage[playerid], 144, "%s", text);
			return 0;
		}
	}
	}
	return 1;
}

new yalanci;
forward public TextleriGuncelled();
public TextleriGuncelled() {
	new str[65];
	if(yalanci == 0){ format(str, sizeof(str), "~y~Z~y~~h~erot~w~~h~~h~~h~urkiye"), yalanci = 1;}
	else if(yalanci == 1){ format(str, sizeof(str), "~y~Zerot~y~~h~urk~w~~h~~h~~h~iye"), yalanci = 2;}
	else if(yalanci == 2){ format(str, sizeof(str), "~y~Zeroturk~y~~h~iye"), yalanci = 3;}

	else if(yalanci == 3){ format(str, sizeof(str), "~y~Zeroturkiye"), yalanci = 4;}

	else if(yalanci == 4){ format(str, sizeof(str), "~r~Z~r~~h~erot~y~urkiye"), yalanci = 5;}
	else if(yalanci == 5){ format(str, sizeof(str), "~r~Zerot~r~~h~urk~y~iye"), yalanci = 6;}
	else if(yalanci == 6){ format(str, sizeof(str), "~r~Zeroturk~y~iye"), yalanci = 7;}

	else if(yalanci == 7){ format(str, sizeof(str), "~r~Zeroturkiye"), yalanci = 8;}

	else if(yalanci == 8){ format(str, sizeof(str), "~p~Z~p~~h~erot~r~urkiye"), yalanci = 9;}
	else if(yalanci == 9){ format(str, sizeof(str), "~p~Zerot~p~~h~urk~r~iye"), yalanci = 10;}
	else if(yalanci == 10){ format(str, sizeof(str), "~p~Zeroturk~p~~h~iye"), yalanci = 11;}
	
	else if(yalanci == 11){ format(str, sizeof(str), "~p~Zeroturkiye"), yalanci = 0;}
	for(new x; x < GetMaxPlayers(); x++)
	{
		PlayerTextDrawSetString(x, Textdraw[x][6], str);
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	new str[4];
	format(str, sizeof(str), "%d", clickedplayerid);
	return komut_stats(playerid, str);
}
public OnPlayerPickUpPickup(playerid, pickupid)
{
   	for(new p; p <= BOOST_AMOUNT; p ++)
	{
	    if(pickupid == Boost[p])
	    {
			if(IsPlayerInAnyVehicle(playerid))
			{
				new Float:T[4];
				GetVehicleZAngle(GetPlayerVehicleID(playerid), T[3]);
				GetVehicleVelocity(GetPlayerVehicleID(playerid), T[0], T[1], T[2]);
				SetVehicleVelocity(GetPlayerVehicleID(playerid),floatadd(T[0],floatmul(1.5,floatsin(-T[3],degrees))), floatadd(T[1],floatmul(1.5,floatcos(-T[3],degrees))), T[2]);
			}
		}
	}
    return 1;
}

new tuyosira;
forward public TextleriGuncellee(playerid);
public TextleriGuncellee(playerid)
{
	if(tuyosira == 0)
		PlayerTextDrawSetString(playerid, Textdraw[playerid][5], "Tuyo 1#: ~g~~h~~h~Kendine ~y~~h~/shop~g~~h~~h~ komutuyla bir urun alabilirsin."), tuyosira = 1;
	else if(tuyosira == 1)
		PlayerTextDrawSetString(playerid, Textdraw[playerid][5], "Tuyo 2#: ~g~~h~~h~Adam oldurerek para ve skor kazanabilirsin."), tuyosira = 2;
	else if(tuyosira == 2)
		PlayerTextDrawSetString(playerid, Textdraw[playerid][5], "Tuyo 3#: ~g~~h~~h~Quiz, Test, Lotto ile cok para kazanabilirsin."), tuyosira = 3;
	else if(tuyosira == 3)
		PlayerTextDrawSetString(playerid, Textdraw[playerid][5], "Tuyo 4#: ~g~~h~~h~Hileli varsa onun cevresinde oynama, rapor et."), tuyosira = 4;
	else if(tuyosira == 4)
		PlayerTextDrawSetString(playerid, Textdraw[playerid][5], "Tuyo 5#: ~g~~h~~h~Kendine ~y~~h~/mystyle~g~~h~~h~ komutuyla aksesuar alabilirsin."), tuyosira = 5;
	else if(tuyosira == 5)
		PlayerTextDrawSetString(playerid, Textdraw[playerid][5], "Tuyo 6#: ~g~~h~~h~DD'de kacarak belesci olma, carpis hakkini ver."), tuyosira = 6;
	else if(tuyosira == 6)
		PlayerTextDrawSetString(playerid, Textdraw[playerid][5], "Tuyo 7#: ~g~~h~~h~/cz ile spawn bolgelerinde bedava can-zirh alabilirsin."), tuyosira = 0;
	return 1;
}
/*
	if(yalanci == 0) format(str, sizeof(str), "~y~M~y~~h~aest~w~~h~~h~~h~ronline"), yalanci = 1;
	else if(yalanci == 1) format(str, sizeof(str), "~y~Maest~y~~h~ronl~w~~h~~h~~h~ine"), yalanci = 2;
	else if(yalanci == 2) format(str, sizeof(str), "~y~zeronl~y~~h~ine"), yalanci = 3;

	else if(yalanci == 3) format(str, sizeof(str), "~r~M~r~~h~aest~w~~h~~h~~h~ronline"), yalanci = 4;
	else if(yalanci == 4) format(str, sizeof(str), "~r~Maest~r~~h~ronl~w~~h~~h~~h~ine"), yalanci = 5;
	else if(yalanci == 5) format(str, sizeof(str), "~r~zeronl~r~~h~ine"), yalanci = 6;

	else if(yalanci == 6) format(str, sizeof(str), "~p~M~p~~h~aest~w~~h~~h~~h~ronline"), yalanci = 7;
	else if(yalanci == 7) format(str, sizeof(str), "~p~Maest~p~~h~ronl~w~~h~~h~~h~ine"), yalanci = 8;
	else if(yalanci == 8) format(str, sizeof(str), "~p~zeronl~p~~h~ine"), yalanci = 0;
*/
stock ModifyVehicleSpeed(vehicleid,mph) //Miles Per Hour
{
	new Float:Vx,Float:Vy,Float:Vz,Float:DV,Float:multiple;
	GetVehicleVelocity(vehicleid,Vx,Vy,Vz);
	DV = floatsqroot(Vx*Vx + Vy*Vy + Vz*Vz);
	if(DV > 0) //Directional velocity must be greater than 0 (display strobes if 0)
	{
		multiple = ((mph + DV * 100) / (DV * 100)); //Multiplying DV by 100 calculates speed in MPH
		return SetVehicleVelocity(vehicleid,Vx*multiple,Vy*multiple,Vz*multiple);
	}
	return 0;
}

forward public TextleriGuncelle(playerid);
public TextleriGuncelle(playerid) {

	TextDrawShowForPlayer(playerid, SaatTD);
	TextDrawShowForPlayer(playerid, TarihTD);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && Speedlimit[playerid] && Joined[playerid] == false)
	{
	    new a, b, c;
		GetPlayerKeys(playerid, a, b ,c);
	    if(a == 8 && GetVehicleSpeed(GetPlayerVehicleID(playerid)) > Speedlimit[playerid])
	    {
	        new newspeed = GetVehicleSpeed(GetPlayerVehicleID(playerid)) - Speedlimit[playerid];
	    	ModifyVehicleSpeed(GetPlayerVehicleID(playerid), -newspeed);
	    }
	}

	if(!IsPlayerInAnyVehicle(playerid)) return PlayerTextDrawSetString(playerid, Textdraw[playerid][7], "_");
	if (GetPVarInt(playerid, "IsFrozen") == 1) TogglePlayerControllablex(playerid, 0);
	if (GetPVarInt(playerid, "IsFrozen") == 0) TogglePlayerControllablex(playerid, 1);
	new id = GetPlayerVehicleID(playerid), string[64];
	format(string, sizeof(string), "~r~~h~%d KM/H ~w~~h~~h~~h~(~r~~h~%s~w~~h~~h~~h~)", GetVehicleSpeed(id), VehicleFriendlyNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
	PlayerTextDrawSetString(playerid, Textdraw[playerid][7], string);
	return 1;
}
public OnPlayerModelSelection(playerid, response, listid, modelid)
{
    if(listid == v1 || v2 || v3 || v4 || v5 || v6 || v7  || v8 || v9 || v10 || v11 || v12 || v13 || v14 || v15 || v16 || v17)
    {
        if(response)
        {
            new Float:Xp, Float:Yp, Float:Zp, Float:Angle;
            if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, "Önce bulundugunuz aractan inin!");
			if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
	       	GetPlayerPos(playerid, Xp, Yp, Zp), GetPlayerFacingAngle(playerid, Angle), Araba[playerid] = 1;
        	DestroyVehObject(playerid);
			ivehicle[playerid] = CreateVehicle(modelid, Xp, Yp, (Zp+1), Angle, -1, -1, 90);
        	LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
        	SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid));
        	PutPlayerInVehicle(playerid, ivehicle[playerid], 0);
		}
	}
   	return 1;
}
forward InHouse(playerid);
public InHouse(playerid)
{
	for(new x; x < 200; x++)
	{
	    if (IsPlayerInRangeOfPoint(playerid, 4.0, House[x][h_x], House[x][h_y], House[x][h_z]))
	    	return x;
	}
	return -1;
}

#emit LOAD.S.pri ShowPlayerModelasdasds
#emit LOAD.S.pri TotalGameTime
#emit LOAD.S.pri gMessage
#emit LOAD.S.pri ob
#emit LOAD.S.pri selectioanMenu
