new Text:TarihTD;
new Text:SaatTD;
new bool: playerSpawned[MAX_PLAYERS];

forward settimed(playerid);
public settimed(playerid)
{
        new string[256],year,month,day,hours,minutes,seconds, ay[24];
        getdate(year, month, day), gettime(hours, minutes, seconds);
        if (month == 1) format(ay, 24, "Ocak");
        if (month == 2) format(ay, 24, "Subat");
        if (month == 3) format(ay, 24, "Mart");
        if (month == 4) format(ay, 24, "Nisan");
        if (month == 5) format(ay, 24, "Mayis");
        if (month == 6) format(ay, 24, "Haziran");
        if (month == 7) format(ay, 24, "Temmuz");
        if (month == 8) format(ay, 24, "Agustos");
        if (month == 9) format(ay, 24, "Eylul");
        if (month == 10) format(ay, 24, "Ekim");
        if (month == 11) format(ay, 24, "Kasim");
        if (month == 12) format(ay, 24, "Aralik");
        format(string, sizeof string, "%02d %s %02d", day, ay, year);
        TextDrawSetString(TarihTD, string);
        format(string, sizeof string, "%02d:%02d", hours, minutes);
        TextDrawSetString(SaatTD, string);
}
#define BOOST_AMOUNT            	38
new Boost[BOOST_AMOUNT];
// Enum
enum DuelSystem
{
        playername[25],
        induel,
        weapname[45],
        weapid,
        reward
}
new duelinfo[MAX_PLAYERS][DuelSystem];

enum sWeaponInfo
{
    Name[60],
        Valid,
        Slot
}

new WeaponInfo[][sWeaponInfo] =
{
    {"Fist",1,0},
    {"Brass Knuckles",1,0},
    {"Golf Club",1,1},
    {"Nightstick",1,1},
    {"Knife",1,1},
    {"Baseball Bat",1,1},
    {"Shovel",1,1},
    {"Pool cue",1,1},
    {"Katana",1,1},
    {"Chainsaw",1,1},
    {"Double-ended Dildo",1,10},
    {"Dildo",1,10},
    {"Vibrator",1,10},
    {"Silver Vibrator",1,10},
    {"Flowers",1,10},
    {"Cane",1,10},
    {"Grenade",1,8},
    {"Tear Gas",1,8},
    {"Molotov Cocktail",1,8},
    {"",0},
    {"",0},
    {"",0},
    {"9mm Pistol",1,2},
    {"Silenced 9mm",1,2},
    {"Deagle",1,2},
    {"Shotgun",1,3},
    {"Sawnoff Shotgun",1,3},
    {"Combat Shotgun",1,3},
    {"Micro SMG",1,4},
    {"MP5",1,4},
    {"AK-47",1,5},
    {"M4",1,5},
    {"Tec-9",1,4},
    {"Country Rifle",1,6},
    {"Sniper Rifle",1,6},
    {"RPG",1,7},
    {"HS Rocket",1,7},
    {"Flamethrower",1,7},
    {"Minigun",1,7},
    {"Sachel Charge",1,8},
    {"Detonator",1,12},
    {"Spray Can",1,9},
    {"Fire Extinguisher",1,9},
    {"Camera",1,9},
    {"Night Vision Goggles",0,11},
    {"Thermal Goggles",0,11},
    {"Parachute",1,11}
};

new invite[MAX_PLAYERS],
    inviter[MAX_PLAYERS],
    DuelSender[MAX_PLAYERS],
    DuelReciever[MAX_PLAYERS];

new v1 = mS_INVALID_LISTID;
new v2 = mS_INVALID_LISTID;
new v3 = mS_INVALID_LISTID;
new v4 = mS_INVALID_LISTID;
new v5 = mS_INVALID_LISTID;
new v6 = mS_INVALID_LISTID;
new v7 = mS_INVALID_LISTID;
new v8 = mS_INVALID_LISTID;
new v9 = mS_INVALID_LISTID;
new v10 = mS_INVALID_LISTID;
new v11 = mS_INVALID_LISTID;
new v12 = mS_INVALID_LISTID;
new v13 = mS_INVALID_LISTID;
new v14 = mS_INVALID_LISTID;
new v15 = mS_INVALID_LISTID;
new v16 = mS_INVALID_LISTID;
new v17 = mS_INVALID_LISTID;

enum HouseInfox
{
	h_id,
	h_name[24],
	Float: h_x, Float: h_y, Float: h_z,
	h_weapon1, h_ammo1,
	h_weapon2, h_ammo2,
	h_weapon3, h_ammo3,
	h_cash,
	h_price,
	h_lock,
	h_type,
	Text3D:h_label,
	h_pickup,
	h_owned,
	h_owner[24]
}
new House[200][HouseInfox];
new
	bool: Joined[MAX_PLAYERS];
new Speedlimit[MAX_PLAYERS];
new PlayerText:TDEditor_PTD[MAX_PLAYERS][1];
new Text:TDEditor_TD[8];

new ob[MAX_VEHICLES][10];
new lastmessage[MAX_PLAYERS][144];
new ddtype;
#define calderon 1290
#define tercihlerim 1291
#define level1 1292
#define level2 1293
#define level3 1294
#define level4 1295
#define level5 1296
#define level6 1297
#define level7 1298
#define level8 1299
#define level9 1300
#define level10 1301
#define Mycar 1302
#define Language 1303
#define Animsd 1304

new noChat;
new TypePalace[15];
new InfoPlace[15];
new ddStarted;
new shotTime[MAX_PLAYERS];
new shot[MAX_PLAYERS];
#define TogglePlayerControllablex TogglePlayerControllable

stock _TogglePlayerControllable(playerid, stat)
{
	if (stat == 0) SetPVarInt(playerid, "IsFrozen", 1);
	if (stat == 1) SetPVarInt(playerid, "IsFrozen", 0);
	TogglePlayerControllable(playerid, stat);
	return 1;
}
#define TogglePlayerControllable _TogglePlayerControllable
#define RACEPASIF // baþýna // koyarsan minigame deaktif olur
//#define TDMPASIF
#if defined TDMPASIF
new Text:Sayac0;
new Text:Sayac1;
new Text:Sayac2;
new Text:Sayac3;
#endif
#if defined RACEPASIF
enum spInfo
{
	sType,
	sCreated,
    Float:sX,
    Float:sY,
    Float:sZz,
    sPickup,
    Text3D:sText
};

new mPickInfo[100][spInfo],
 	dmPickInfo[100][spInfo],
 	smPickInfo[100][spInfo],
	tNitro[MAX_PLAYERS],
	tRepair[MAX_PLAYERS];
new PickAttr[][] =
{
	"posX",
	"posY",
	"posZ",
	"type",
	"vehicle"
};
new
	nospidd[500],
	Text3D:labeld[500],
	repidd[500],
	dObje[2000],
	Iterator:nospd<500>,
	Iterator:repd<500>;
new
	nospids[500],
	Text3D:labels[500],
	repids[500],
	sObje[2000],
	Iterator:nosps<500>,
	Iterator:reps<500>;
#endif
new
	Float:AdminPrisonFloat[18][3] = {
		{215.664749, 1806.403198, 1618.534423},
		{211.635513, 1806.531005, 1618.534423},
		{207.159301, 1806.923339, 1618.535888},
		{201.544662, 1806.452758, 1618.535888},
		{197.230133, 1806.381225, 1618.535888},
		{193.142883, 1806.796752, 1618.535888},
		{215.664749, 1806.403198, 1614.260375},
		{211.635513, 1806.531005, 1614.260375},
		{207.159301, 1806.923339, 1614.260375},
		{201.544662, 1806.452758, 1614.260375},
		{197.230133, 1806.381225, 1614.260375},
		{193.142883, 1806.796752, 1614.260375},
		{215.664749, 1806.403198, 1609.985473},
		{211.635513, 1806.531005, 1609.985473},
		{207.159301, 1806.923339, 1609.985473},
		{201.544662, 1806.452758, 1609.985473},
		{197.230133, 1806.381225, 1609.985473},
		{193.142883, 1806.796752, 1609.985473}
};

new Text:BankTD0;
new PlayerText:BankTD1;
new Text:BankTD2;
new Text:BankTD3;
new Text:BankTD4;
new Text:BankTD5;
new PlayerText:BankTD6;
new PlayerText:BankTD7;
new PlayerText:BankTD8;
new Text:BankTD9;
new PlayerText:BankTD10;
new PlayerText:BankTD11;
new PlayerText:BankTD12;
new PlayerText:BankTD13;
new PlayerText:BankTD14;
new PlayerText:BankTD15;
#if defined RACEPASIF
new racenames[4096];
new Text:RaceRez0[MAX_PLAYERS];
new Text:RaceRez1[MAX_PLAYERS];
new Text:RaceRez2[MAX_PLAYERS];
new Text:RaceRez3[MAX_PLAYERS];
new Text:RaceRez4[MAX_PLAYERS];
new Text:RaceRez5[MAX_PLAYERS];
new Text:RaceRez6[MAX_PLAYERS];
new Text:RaceRez7[MAX_PLAYERS];
new Text:RaceRez8[MAX_PLAYERS];
#endif
#define     GIRIS_GOSTER        (1) 	// birisi servera giriþ yaptýðýnda rekoru gösterir (kapatmak için 0 yapabilirsiniz)
#define     REKOR_TEXT          (0)     // sunucu rekorunu textdraw olarak göster (kapatmak için 0 yapabilirsiniz)
#define     REKOR_ODUL          (0) 	// sunucu rekoru kýrýldýðýnda oyundaki kiþilere otomatik olarak para verme (kapatmak için 0 yapabilirsiniz)
#define     ODUL_MIKTAR         (0) 	// rekor kýrýldýðýnda verilen paranýn ana miktarý (örn. server 10 kiþilik rekor kýrarsa herkese 10x500 = 5000$ verilir)


new
	OnlineSayisi = 0,
	RekorSayisi = 0,
	RekorTarihi[20],
	Text: RekorTextDraw;
#emit LOAD.S.alt RekorTextDraw
GetVehicleSpeed(vehicleID)
{
	new Float: vehiclesVelocity[3];
	GetVehicleVelocity(vehicleID, vehiclesVelocity[0], vehiclesVelocity[1], vehiclesVelocity[2]);
	return floatround(floatsqroot((vehiclesVelocity[0] * vehiclesVelocity[0] + vehiclesVelocity[1] * vehiclesVelocity[1] + vehiclesVelocity[2] * vehiclesVelocity[2])) * 200.2);
}
new Text:DigitalTd[35];
new IsPlayerSpawned[MAX_PLAYERS];
forward Timer();
#if defined RACEPASIF
new Text:TopRace0;
new Text:TopRace1;
new Text:TopRace2;
new Text:TopRace3;
new Text:TopRace4;
new Text:TopRace5;
new Text:TopRace6;
new Text:TopRace7;
new Float:vPos[MAX_PLAYERS][4];
new Float:vHiz[MAX_PLAYERS][3];
new Text:RaceSayac0;
new Text:RaceSayac1;
new Text:RaceSayac2;
new Text:RaceSayac3;
new Text:RaceSayac4;
new Text:RaceSayac5;
#endif
	#if defined TDMPASIF
new
	bool: zombieBasladi,
	bool: zombieKatilim,
	zombieTimer,
	zombieSayac,
	zombieKills,
	insanKills,
	dadada = 0,
	zombieMap,
	kalanSure = 300,
	zombieKalanSure = -1
;

new Iterator: zombieGamer<MAX_PLAYERS>;

new Float:insanlarSpawn1[][] =
{
	{-3215.8301, 2329.5713, 142.9093},
	{-3215.9521, 2322.8137, 142.9093},
	{-3235.6958, 2316.3235, 158.8950},
	{-3141.2798, 2359.6255, 142.8373}
};

new Float:zombilerSpawn1[][] =
{
	{-3229.3088, 2611.3813, 151.7075},
	{-3182.6079, 2532.7849, 146.5942},
	{-3239.2610, 2596.5491, 158.9944},
	{-3233.0764, 2565.1406, 146.8118}
};

new Float:insanlarSpawn2[][] =
{
	{1285.94, -783.23, 1089.92},
	{1274.65, -790.08, 1089.93},
	{1289.13, -795.92, 1089.93},
	{1274.64, -803.39, 1089.93},
	{1288.02, -807.90, 1089.93}
};

new Float:zombilerSpawn2[][] =
{
	{1275.08, -815.38, 1089.93},
	{1289.56, -819.26, 1089.93},
	{1282.83, -826.37, 1089.93},
	{1283.59, -838.78, 1089.93},
	{1276.83, -824.84, 1089.93}
};

#define ZOMBI_ 50
#define INSAN_ 49
stock zombiSpawn(playerid)
{
	if(zombieMap == 0)
	{
	SetPlayerSkin(playerid, 78);
	new Randdom = random(sizeof(zombilerSpawn1));
	SetPlayerPos(playerid, zombilerSpawn1[Randdom][0], zombilerSpawn1[Randdom][1], zombilerSpawn1[Randdom][2]);
 	}
	if(zombieMap == 1)
	{
	SetPlayerSkin(playerid, 286);
	SetPlayerInterior(playerid, 5);
	new Randdom = random(sizeof(zombilerSpawn2));
	SetPlayerPos(playerid, zombilerSpawn2[Randdom][0], zombilerSpawn2[Randdom][1], zombilerSpawn2[Randdom][2]);
 	}
 	SetPlayerTeam(playerid, ZOMBI_);
 	SetPVarInt(playerid, "Thakim", ZOMBI_);
	Iter_Add(zombieGamer, playerid);
	TextDrawShowForPlayer(playerid, Sayac0);
	TextDrawShowForPlayer(playerid, Sayac1);
	TextDrawShowForPlayer(playerid, Sayac2);
	TextDrawShowForPlayer(playerid, Sayac3);
	if(zombieMap == 0) Silahver(playerid, 9, 5);
	if(zombieMap == 1) Silahver(playerid, WEAPON_TEC9, 75), Silahver(playerid, WEAPON_AK47, 450);
	return 1;
}
forward zombieSayacc();
public zombieSayacc()
{
	switch(kalanSure)
	{
	    case 0:
	    {
		    foreach(new i : zombieGamer)
		    {
		        if(zombieKills > insanKills && zombieMap == 0)
				{
					if(GetPVarInt(i, "Thakim") == ZOMBI_)
					{
					    SetPlayerScore(i, GetPlayerScore(i)+5);
						GivePlayerMoney(i, 15000);
					}
					TextMesaj("~g~~h~[TDM]~w~~h~~h~~h~ Savasi ~r~~h~ Zombie~w~~h~~h~~h~ takimi kazandi. Odul: ~r~~h~15.000$~w~~h~~h~~h~ - ~r~~h~5 score", "~g~~h~[TDM]~w~~h~~h~~h~ Savasi ~r~~h~ Zombie~w~~h~~h~~h~ takimi kazandi. Odul: ~r~~h~15.000$~w~~h~~h~~h~ - ~r~~h~5 score");
				}
		        else if(insanKills > zombieKills && zombieMap == 0)
				{
					if(GetPVarInt(i, "Thakim") == INSAN_)
					{
					    SetPlayerScore(i, GetPlayerScore(i)+5);
						GivePlayerMoney(i, 15000);
					}
					TextMesaj("~g~~h~[TDM]~w~~h~~h~~h~ Savasi ~r~~h~ Insan~w~~h~~h~~h~ takimi kazandi. Odul: ~r~~h~15.000$~w~~h~~h~~h~ - ~r~~h~5 score", "~g~~h~[TDM]~w~~h~~h~~h~ Savasi ~r~~h~ Insan~w~~h~~h~~h~ takimi kazandi. Odul: ~r~~h~15.000$~w~~h~~h~~h~ - ~r~~h~5 score");
				}
		        else if(zombieKills > insanKills && zombieMap == 1)
				{
					if(GetPVarInt(i, "Thakim") == ZOMBI_)
					{
					    SetPlayerScore(i, GetPlayerScore(i)+5);
						GivePlayerMoney(i, 15000);
					}
					TextMesaj("~g~~h~[TDM]~w~~h~~h~~h~ Savasi ~r~~h~ FBI~w~~h~~h~~h~ takimi kazandi. Odul: ~r~~h~15.000$~w~~h~~h~~h~ - ~r~~h~5 score", "~g~~h~[TDM]~w~~h~~h~~h~ Savasi ~r~~h~ FBI~w~~h~~h~~h~ takimi kazandi. Odul: ~r~~h~15.000$~w~~h~~h~~h~ - ~r~~h~5 score");
				}
		        else if(insanKills > zombieKills && zombieMap == 1)
				{
					if(GetPVarInt(i, "Thakim") == INSAN_)
					{
					    SetPlayerScore(i, GetPlayerScore(i)+5);
						GivePlayerMoney(i, 15000);
					}
					TextMesaj("~g~~h~[TDM]~w~~h~~h~~h~ Savasi ~r~~h~ Mafya~w~~h~~h~~h~ takimi kazandi. Odul: ~r~~h~15.000$~w~~h~~h~~h~ - ~r~~h~5 score", "~g~~h~[TDM]~w~~h~~h~~h~ Savasi ~r~~h~ Insan~w~~h~~h~~h~ takimi kazandi. Odul: ~r~~h~15.000$~w~~h~~h~~h~ - ~r~~h~5 score");
				}
		        else if(insanKills == zombieKills)
				{
					if(GetPVarInt(i, "Thakim") == INSAN_)
					{
					    SetPlayerScore(i, GetPlayerScore(i)+5);
						GivePlayerMoney(i, 15000);
					}
					TextMesaj("~g~~h~[TDM]~w~~h~~h~~h~ Savasin kazanani yok, durum berabere.", "~g~~h~[TDM]~w~~h~~h~~h~ Savasin kazanani yok, durum berabere.");
				}
				TextDrawSetString(Sayac0, "~r~~h~05:00 ~b~~h~- ~g~~h~~h~00:00");
		        SpawnPlayer(i);
				zombieBasladi = false;
				zombieKatilim = false;
				KillTimer(zombieKalanSure);
				KillTimer(zombieTimer);
				TextDrawHideForAll(Sayac0);
				TextDrawHideForAll(Sayac2);
				TextDrawHideForAll(Sayac3);
				TextDrawHideForAll(Sayac1);
				Iter_Remove(zombieGamer, i);
				zombieTimer=0;
				zombieSayac=0;
				zombieKills=0;
				insanKills=0;
				dadada = 0,
				kalanSure = 300,
				zombieKalanSure = -1;
			    TextDrawSetString(Sayac3, "NaN~n~NaN");
		    }
	    }
		default:
		{
			if(!(Iter_Count(zombieGamer) >= 2))
			{
			    KillTimer(zombieKalanSure);
			    TextMesaj("~g~~h~[TDM]~w~~h~~h~~h~ Yeterli kisi katilmadigindan dolayi iptal edildi.", "~g~~h~[TDM]~w~~h~~h~~h~ Yeterli kisi katilmadigindan dolayi iptal edildi.");
	    foreach(new i : zombieGamer)
	    {
				TextDrawSetString(Sayac0, "~r~~h~05:00 ~b~~h~- ~g~~h~~h~00:00");
		        SpawnPlayer(i);
				zombieBasladi = false;
				zombieKatilim = false;
				KillTimer(zombieKalanSure);
				KillTimer(zombieTimer);
				TextDrawHideForAll(Sayac0);
				TextDrawHideForAll(Sayac2);
				TextDrawHideForAll(Sayac3);
				TextDrawHideForAll(Sayac1);
				Iter_Remove(zombieGamer, i);
				zombieTimer=0;
				zombieSayac=0;
				zombieKills=0;
				insanKills=0;
				dadada = 0,
				kalanSure = 300,
				zombieKalanSure = -1;
			    TextDrawSetString(Sayac3, "NaN~n~NaN");
}			}
		    new string[56];
		    format(string, sizeof(string), "~r~~h~%02d:%02d~b~~h~ - ~g~~h~~h~%02d:%02d", floatround(floatdiv(kalanSure,60),floatround_floor), kalanSure%60, floatround(floatdiv(dadada,60),floatround_floor), dadada%60);
			TextDrawSetString(Sayac0, string);
		    if(zombieMap == 0) format(string, sizeof(string), "zombi:~r~~h~ %02d Puan~n~~w~~h~~h~~h~insan:~b~~h~ %02d puan", zombieKills, insanKills);
		    if(zombieMap == 1) format(string, sizeof(string), "fbi:~r~~h~ %02d Puan~n~~w~~h~~h~~h~mafya:~b~~h~ %02d puan", zombieKills, insanKills);
		    TextDrawSetString(Sayac3, string);
		}
	}
	return kalanSure--, dadada++;
}

forward zombieSay();
public zombieSay()
{
	if(zombieSayac > 1)
	{
	    zombieSayac --;
	    foreach(new i : zombieGamer)
	    {
			new string[56];
			format(string, sizeof(string), "~y~TDM STARTED IN~n~~y~-~w~~h~~h~~h~ %i ~y~-~n~seconds", zombieSayac);
	    	GameTextForPlayer(i, string, 1555, 3);
	    	TogglePlayerControllable(i, 0);
			SetPVarString(i, "FreezedBy", "tdm");
		}
	}
	else
	{
	    if(zombieKalanSure != -1) return 0;
        zombieKalanSure = SetTimer("zombieSayacc", 999, true);
        kalanSure = 300;
	    foreach(new i : zombieGamer)
	    {
			new string[26];
			format(string, sizeof(string), "~p~~h~BASLA", zombieSayac);
	    	TogglePlayerControllable(i, 1);
	    	GameTextForPlayer(i, string, 555, 3);
			TextMesaj("~g~~h~[TDM]~w~~h~~h~~h~ Katilimlar durdu.","~g~~h~[TDM]~w~~h~~h~~h~ Katilimlar durdu.");
		}
	}
	return 1;
}stock insanSpawn(playerid)
{
	if(zombieMap == 0)
	{
	SetPlayerSkin(playerid, 296);
	new Randdom = random(sizeof(insanlarSpawn1));
	SetPlayerPos(playerid, insanlarSpawn1[Randdom][0], insanlarSpawn1[Randdom][1], insanlarSpawn1[Randdom][2]);
 	}
	if(zombieMap == 1)
	{
	SetPlayerSkin(playerid, 124);
	SetPlayerInterior(playerid, 5);
	new Randdom = random(sizeof(insanlarSpawn2));
	SetPlayerPos(playerid, insanlarSpawn2[Randdom][0], insanlarSpawn2[Randdom][1], insanlarSpawn2[Randdom][2]);
 	}
 	SetPlayerTeam(playerid, INSAN_);
	SetPVarInt(playerid, "Thakim", INSAN_);
	Iter_Add(zombieGamer, playerid);
	TextDrawShowForPlayer(playerid, Sayac0);
	TextDrawShowForPlayer(playerid, Sayac1);
	TextDrawShowForPlayer(playerid, Sayac2);
	TextDrawShowForPlayer(playerid, Sayac3);
	if(zombieMap == 0) Silahver(playerid, WEAPON_DEAGLE, 5), Silahver(playerid, WEAPON_M4, 350);
	if(zombieMap == 1) Silahver(playerid, WEAPON_DEAGLE, 75), Silahver(playerid, WEAPON_M4, 450);
	return 1;
}
stock eliteSpawn(playerid)
{
	if(zombieMap == 0)
	{
	new Randdom = random(sizeof(insanlarSpawn1));
	SetPlayerPos(playerid, insanlarSpawn1[Randdom][0], insanlarSpawn1[Randdom][1], insanlarSpawn1[Randdom][2]);
 	}
	if(zombieMap == 1)
	{
	SetPlayerInterior(playerid, 5);
	new Randdom = random(sizeof(insanlarSpawn2));
	SetPlayerPos(playerid, insanlarSpawn2[Randdom][0], insanlarSpawn2[Randdom][1], insanlarSpawn2[Randdom][2]);
 	}
	SetPVarInt(playerid, "Thakim", INSAN_);
 	SetPlayerTeam(playerid, INSAN_);
	Iter_Add(zombieGamer, playerid);
	TextDrawShowForPlayer(playerid, Sayac0);
	TextDrawShowForPlayer(playerid, Sayac1);
	TextDrawShowForPlayer(playerid, Sayac2);
	TextDrawShowForPlayer(playerid, Sayac3);
	SetPlayerArmour(playerid, 100);
	if(zombieMap == 0) Silahver(playerid, WEAPON_DEAGLE, 5), Silahver(playerid, WEAPON_M4, 350);
	if(zombieMap == 1) Silahver(playerid, WEAPON_DEAGLE, 75), Silahver(playerid, WEAPON_M4, 450);
	return 1;
}
forward TDMBASLAT();
public TDMBASLAT()
{
    zombieSayac = 50;
    zombieTimer = SetTimer("zombieSay", 1000, true);
	zombieBasladi = true;
	zombieKatilim = true;
	zombieMap = random(2);
	if(zombieMap == 1) TextMesaj("~g~~h~[TDM]~w~~h~~h~~h~ Birazdan ~b~~h~FBI~w~~h~~h~~h~ - ~b~~h~Mafya~w~~h~~h~~h~ savasi baslayacak. Gitmek icin ~y~~h~/tdmgit~w~~h~~h~~h~ yazin.", "~g~~h~[TDM]~w~~h~~h~~h~ Birazdan ~b~~h~Isciler~w~~h~~h~~h~ - ~b~~h~Tinerciler~w~~h~~h~~h~ savasi baslayacak. Gitmek icin ~y~~h~/tdmgit~w~~h~~h~~h~ yazin.");
	else TextMesaj("~g~~h~[TDM]~w~~h~~h~~h~ Birazdan ~b~~h~Zombie~w~~h~~h~~h~ - ~b~~h~Insan~w~~h~~h~~h~ savasi baslayacak. Gitmek icin ~y~~h~/tdmgit~w~~h~~h~~h~ yazin.", "~g~~h~[TDM]~w~~h~~h~~h~ Birazdan ~b~~h~Isciler~w~~h~~h~~h~ - ~b~~h~Tinerciler~w~~h~~h~~h~ savasi baslayacak. Gitmek icin ~y~~h~/tdmgit~w~~h~~h~~h~ yazin.");
	return 1;
}
#endif
new PlayerText:SpecTD[6][MAX_PLAYERS];

new AracIsimler[212][] = {
{"Landstalker"},{"Bravura"},{"Buffalo"},{"Linerunner"},{"Perrenial"},{"Sentinel"},{"Dumper"},{"Firetruck"},{"Trashmaster"},{"Stretch"},{"Manana"},{"Infernus"},{"Voodoo"},{"Pony"},{"Mule"},{"Cheetah"},{"Ambulance"},{"Leviathan"},{"Moonbeam"},{"Esperanto"},{"Taxi"},{"Washington"},
{"Bobcat"},{"Mr Whoopee"},{"BF Injection"},{"Hunter"},{"Premier"},{"Enforcer"},{"Securicar"},{"Banshee"},{"Predator"},{"Bus"},{"Rhino"},{"Barracks"},{"Hotknife"},{"Trailer 1"},{"Previon"},{"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},{"Romero"},{"Packer"},{"Monster"},
{"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},{"Trailer 2"},{"Turismo"},{"Speeder"},{"Reefer"},{"Tropic"},{"Flatbed"},{"Yankee"},{"Caddy"},{"Solair"},{"Berkley's RC Van"},{"Skimmer"},{"PCJ-600"},{"Faggio"},{"Freeway"},{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},
{"Sanchez"},{"Sparrow"},{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},{"Hermes"},{"Sabre"},{"Rustler"},{"ZR-350"},{"Walton"},{"Regina"},{"Comet"},{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},{"Baggage"},{"Dozer"},{"Maverick"},{"News Chopper"},{"Rancher"},{"FBI Rancher"},{"Virgo"},{"Greenwood"},
{"Jetmax"},{"Hotring"},{"Sandking"},{"Blista Compact"},{"Police Maverick"},{"Boxville"},{"Benson"},{"Mesa"},{"RC Goblin"},{"Hotring Racer A"},{"Hotring Racer B"},{"Bloodring Banger"},{"Rancher"},{"Super GT"},{"Elegant"},{"Journey"},{"Bike"},{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt"},
{"Tanker"}, {"Roadtrain"},{"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Hydra"},{"FCR-900"},{"NRG-500"},{"HPV1000"},{"Cement Truck"},{"Tow Truck"},{"Fortune"},{"Cadrona"},{"FBI Truck"},{"Willard"},{"Forklift"},{"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},
{"Blade"},{"Freight"},{"Streak"},{"Vortex"},{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},{"Firetruck LA"},{"Hustler"},{"Intruder"},{"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},{"Utility"},{"Nevada"},{"Yosemite"},{"Windsor"},{"Monster A"},{"Monster B"},{"Uranus"},{"Jester"},
{"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},{"RC Tiger"},{"Flash"},{"Tahoma"},{"Savanna"},{"Bandito"},{"Freight Flat"},{"Streak Carriage"},{"Kart"},{"Mower"},{"Duneride"},{"Sweeper"},{"Broadway"},{"Tornado"},{"AT-400"},{"DFT-30"},{"Huntley"},{"Stafford"},{"BF-400"},{"Newsvan"},
{"Tug"},{"Trailer 3"},{"Emperor"},{"Wayfarer"},{"Euros"},{"Hotdog"},{"Club"},{"Freight Carriage"},{"Trailer 3"},{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},{"Police Car (SFPD)"},{"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"S.W.A.T. Van"},{"Alpha"},{"Phoenix"},{"Glendale"},
{"Sadler"},{"Luggage Trailer A"},{"Luggage Trailer B"},{"Stair Trailer"},{"Boxville"},{"Farm Plow"},{"Utility Trailer"}
};SpawnVehicle_InfrontOfPlayer(playerid, vehiclemodel)
{
	return CreatePlayerVehicle(playerid, vehiclemodel);
}
native gpci( playerid , const serial[] , maxlen );

#define ARALIK 250 // 250 ms - saniyede 4 kere günceller


new VehicleFriendlyNames[212][] = {
	{"Landstalker"},{"Bravura"},{"Buffalo"},{"Linerunner"},{"Perrenial"},{"Sentinel"},
 	{"Dumper"},{"Firetruck"},{"Trashmaster"},{"Stretch"},{"Manana"},{"Infernus"},{"Voodoo"},
  	{"Pony"},{"Mule"},{"Cheetah"},{"Ambulance"},{"Leviathan"},{"Moonbeam"},{"Esperanto"},{"Taxi"},
   	{"Washington"},{"Bobcat"},{"Mr. Whoopee"},{"BF. Injection"},{"Hunter"},{"Premier"},{"Enforcer"},
   	{"Securicar"},{"Banshee"},{"Predator"},{"Bus"},{"Rhino"},{"Barracks"},{"Hotknife"},{"Article Trailer"},
    {"Previon"},{"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},{"Romero"},{"Packer"},{"Monster"},
    {"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},{"Article Trailer 2"},{"Turismo"},{"Speeder"},
    {"Reefer"},{"Tropic"},{"Flatbed"},{"Yankee"},{"Caddy"},{"Solair"},{"Berkley's RC Van"},{"Skimmer"},
    {"PCJ-600"},{"Faggio"},{"Freeway"},{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},{"Sanchez"},
    {"Sparrow"},{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},{"Hermes"},{"Sabre"},{"Rustler"},{"ZR-350"},
    {"Walton"},{"Regina"},{"Comet"},{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},{"Baggage"},{"Dozer"},
    {"Maverick"},{"News Chopper"},{"Rancher"},{"FBI Rancher"},{"Virgo"},{"Greenwood"},{"Jetmax"},{"Hotring"},
    {"Sandking"},{"Blista Compact"},{"Police Maverick"},{"Boxville"},{"Benson"},{"Mesa"},{"RC Goblin"},
    {"Hotring Racer A"},{"Hotring Racer B"},{"Bloodring Banger"},{"Rancher"},{"Super GT"},{"Elegant"},
    {"Journey"},{"Bike"},{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt"},{"Tanker"},{"Roadtrain"},
    {"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Hydra"},{"FCR-900"},{"NRG-500"},{"HPV1000"},
    {"Cement Truck"},{"Tow Truck"},{"Fortune"},{"Cadrona"},{"FBI Truck"},{"Willard"},{"Forklift"},
    {"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},{"Blade"},{"Freight"},{"Streak"},
    {"Vortex"},{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},{"Firetruck LA"},{"Hustler"},{"Intruder"},
    {"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},{"Utility"},{"Nevada"},{"Yosemite"},{"Windsor"},
    {"Monster A"},{"Monster B"},{"Uranus"},{"Jester"},{"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},
    {"RC Tiger"},{"Flash"},{"Tahoma"},{"Savanna"},{"Bandito"},{"Freight Flat"},{"Streak Carriage"},
    {"Kart"},{"Mower"},{"Dunerider"},{"Sweeper"},{"Broadway"},{"Tornado"},{"AT-400"},{"DFT-30"},{"Huntley"},
    {"Stafford"},{"BF-400"},{"Newsvan"},{"Tug"},{"Article Trailer 3"},{"Emperor"},{"Wayfarer"},{"Euros"},{"Mobile Hotdog"},
    {"Club"},{"Freight Carriage"},{"Trailer 3"},{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},
    {"Police Car (SFPD)"},{"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"S.W.A.T Van"},{"Alpha"},
    {"Phoenix"},{"Glendale"},{"Sadler"},{"Luggage Trailer A"},{"Luggage Trailer B"},{"Stair Trailer"},
    {"Boxville"},{"Farm Plow"},{"Utility Trailer"}
};

stock GetVehiclesSpeed(vehicleid)
{
	new Float:Pos[3],Float:ARRAY ;
	GetVehicleVelocity(vehicleid, Pos[0], Pos[1], Pos[2]);
	ARRAY = floatsqroot(Pos[0]*Pos[0] + Pos[1]*Pos[1] + Pos[2]*Pos[2])*200;
	return floatround(ARRAY,floatround_round);
}

new AFK[MAX_PLAYERS];
new OyuncununSilahlari[MAX_PLAYERS][12];
stock HileciyiYasakla(playerid, aldigisilah)
{
	#emit LOAD.S.alt aldigisilah
	Kickle(playerid, "Silah Hilesi");
	return 1;
}

stock OyuncuSilahDegistirdi(playerid, eskisilah, yenisilah)
{
    #pragma unused eskisilah
	if(OyuncununSilahlari[playerid][0] != 1 && GetPlayerWeapon(playerid) == 1)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][1] != 2 && GetPlayerWeapon(playerid) == 2)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][1] != 3 && GetPlayerWeapon(playerid) == 3)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][1] != 4 && GetPlayerWeapon(playerid) == 4)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][1] != 5 && GetPlayerWeapon(playerid) == 5)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][1] != 6 && GetPlayerWeapon(playerid) == 6)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][1] != 7 && GetPlayerWeapon(playerid) == 7)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][1] != 8 && GetPlayerWeapon(playerid) == 8)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][1] != 9 && GetPlayerWeapon(playerid) == 9)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][10] != 10 && GetPlayerWeapon(playerid) == 10)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][10] != 11 && GetPlayerWeapon(playerid) == 11)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][10] != 12 && GetPlayerWeapon(playerid) == 12)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][10] != 13 && GetPlayerWeapon(playerid) == 13)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][10] != 14 && GetPlayerWeapon(playerid) == 14)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][10] != 15 && GetPlayerWeapon(playerid) == 15)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][8] != 16 && GetPlayerWeapon(playerid) == 16)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][8] != 17 && GetPlayerWeapon(playerid) == 17)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][8] != 18 && GetPlayerWeapon(playerid) == 18)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][2] != 22 && GetPlayerWeapon(playerid) == 22)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][2] != 23 && GetPlayerWeapon(playerid) == 23)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][2] != 24 && GetPlayerWeapon(playerid) == 24)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][3] != 25 && GetPlayerWeapon(playerid) == 25)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][3] != 26 && GetPlayerWeapon(playerid) == 26)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][3] != 27 && GetPlayerWeapon(playerid) == 27)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][4] != 28 && GetPlayerWeapon(playerid) == 28)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][4] != 29 && GetPlayerWeapon(playerid) == 29)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][5] != 30 && GetPlayerWeapon(playerid) == 30)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][5] != 31 && GetPlayerWeapon(playerid) == 31)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][4] != 32 && GetPlayerWeapon(playerid) == 32)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][6] != 33 && GetPlayerWeapon(playerid) == 33)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][6] != 34 && GetPlayerWeapon(playerid) == 34)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][7] != 35 && GetPlayerWeapon(playerid) == 35)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][7] != 36 && GetPlayerWeapon(playerid) == 36)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][7] != 37 && GetPlayerWeapon(playerid) == 37)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][7] != 38 && GetPlayerWeapon(playerid) == 38)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][8] != 39 && GetPlayerWeapon(playerid) == 39)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][9] != 41 && GetPlayerWeapon(playerid) == 41)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][9] != 42 && GetPlayerWeapon(playerid) == 42)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][9] != 43 && GetPlayerWeapon(playerid) == 43)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][11] != 44 && GetPlayerWeapon(playerid) == 44)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	if(OyuncununSilahlari[playerid][11] != 45 && GetPlayerWeapon(playerid) == 45)
	{
	    HileciyiYasakla(playerid,yenisilah);
	}
	return 1;
}

stock Silahver(playerid, Silah, Mermi)
{
	switch(Silah)
	{
	    case 0, 1:
	    {
     		OyuncununSilahlari[playerid][0] = Silah;
      		GivePlayerWeapon(playerid, Silah, Mermi);
	    }
	    case 2, 3, 4, 5, 6, 7, 8, 9:
	    {
		    OyuncununSilahlari[playerid][1] = Silah;
		    GivePlayerWeapon(playerid, Silah, Mermi);
	    }
	    case 22, 23, 24:
	    {
		    OyuncununSilahlari[playerid][2] = Silah;
		    GivePlayerWeapon(playerid, Silah, Mermi);
	    }
	    case 25, 26, 27:
	    {
		    OyuncununSilahlari[playerid][3] = Silah;
		    GivePlayerWeapon(playerid, Silah, Mermi);
	    }
	    case 28, 29, 32:
	    {
		    OyuncununSilahlari[playerid][4] = Silah;
		    GivePlayerWeapon(playerid, Silah, Mermi);
	    }
	    case 30, 31:
	    {
		    OyuncununSilahlari[playerid][5] = Silah;
		    GivePlayerWeapon(playerid, Silah, Mermi);
	    }
	    case 33, 34:
	    {
		    OyuncununSilahlari[playerid][6] = Silah;
		    GivePlayerWeapon(playerid, Silah, Mermi);
	    }
	    case 35, 36, 37, 38:
	    {
		    OyuncununSilahlari[playerid][7] = Silah;
		    GivePlayerWeapon(playerid, Silah, Mermi);
	    }
	    case 39, 16, 17, 18, 40:
	    {
		    OyuncununSilahlari[playerid][8] = Silah;
		    GivePlayerWeapon(playerid, Silah, Mermi);
	    }
	    case 41, 42, 43:
	    {
		    OyuncununSilahlari[playerid][9] = Silah;
		    GivePlayerWeapon(playerid, Silah, Mermi);
	    }
	    case 10, 11, 12, 13, 14, 15:
	    {
		    OyuncununSilahlari[playerid][10] = Silah;
		    GivePlayerWeapon(playerid, Silah, Mermi);
            }
	    case 44, 45, 46:
	    {
		    OyuncununSilahlari[playerid][11] = Silah;
		    GivePlayerWeapon(playerid, Silah, Mermi);
	    }
       }
    return 1;
}

#define GivePlayerWeapon Silahver
stock SendClientMessagex_(playerid, renk, const string[])
{
	if(strlen(string) < 2) return 1;
	else SendClientMessage(playerid, renk, string);
	return 1;
}
#define SendClientMessage SendClientMessagex_
//==========================//
#define HOLDING(%0) ((newkeys & (%0)) == (%0)) //You can use anything here (PRESSED or RELEASED)
//==========================//
//==========================//
new legalmods[48][22] = {
        {400, 1024,1021,1020,1019,1018,1013,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {401, 1145,1144,1143,1142,1020,1019,1017,1013,1007,1006,1005,1004,1003,1001,0000,0000,0000,0000},
        {404, 1021,1020,1019,1017,1016,1013,1007,1002,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {405, 1023,1021,1020,1019,1018,1014,1001,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {410, 1024,1023,1021,1020,1019,1017,1013,1007,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000},
        {415, 1023,1019,1018,1017,1007,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {418, 1021,1020,1016,1006,1002,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {420, 1021,1019,1005,1004,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {421, 1023,1021,1020,1019,1018,1016,1014,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {422, 1021,1020,1019,1017,1013,1007,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {426, 1021,1019,1006,1005,1004,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {436, 1022,1021,1020,1019,1017,1013,1007,1006,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000},
        {439, 1145,1144,1143,1142,1023,1017,1013,1007,1003,1001,0000,0000,0000,0000,0000,0000,0000,0000},
        {477, 1021,1020,1019,1018,1017,1007,1006,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {478, 1024,1022,1021,1020,1013,1012,1005,1004,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {489, 1024,1020,1019,1018,1016,1013,1006,1005,1004,1002,1000,0000,0000,0000,0000,0000,0000,0000},
        {491, 1145,1144,1143,1142,1023,1021,1020,1019,1018,1017,1014,1007,1003,0000,0000,0000,0000,0000},
        {492, 1016,1006,1005,1004,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {496, 1143,1142,1023,1020,1019,1017,1011,1007,1006,1003,1002,1001,0000,0000,0000,0000,0000,0000},
        {500, 1024,1021,1020,1019,1013,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {516, 1021,1020,1019,1018,1017,1016,1015,1007,1004,1002,1000,0000,0000,0000,0000,0000,0000,0000},
        {517, 1145,1144,1143,1142,1023,1020,1019,1018,1017,1016,1007,1003,1002,0000,0000,0000,0000,0000},
        {518, 1145,1144,1143,1142,1023,1020,1018,1017,1013,1007,1006,1005,1003,1001,0000,0000,0000,0000},
        {527, 1021,1020,1018,1017,1015,1014,1007,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {529, 1023,1020,1019,1018,1017,1012,1011,1007,1006,1003,1001,0000,0000,0000,0000,0000,0000,0000},
        {534, 1185,1180,1179,1178,1127,1126,1125,1124,1123,1122,1106,1101,1100,0000,0000,0000,0000,0000},
        {535, 1121,1120,1119,1118,1117,1116,1115,1114,1113,1110,1109,0000,0000,0000,0000,0000,0000,0000},
        {536, 1184,1183,1182,1181,1128,1108,1107,1105,1104,1103,0000,0000,0000,0000,0000,0000,0000,0000},
        {540, 1145,1144,1143,1142,1024,1023,1020,1019,1018,1017,1007,1006,1004,1001,0000,0000,0000,0000},
        {542, 1145,1144,1021,1020,1019,1018,1015,1014,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {546, 1145,1144,1143,1142,1024,1023,1019,1018,1017,1007,1006,1004,1002,1001,0000,0000,0000,0000},
        {547, 1143,1142,1021,1020,1019,1018,1016,1003,1000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {549, 1145,1144,1143,1142,1023,1020,1019,1018,1017,1012,1011,1007,1003,1001,0000,0000,0000,0000},
        {550, 1145,1144,1143,1142,1023,1020,1019,1018,1006,1005,1004,1003,1001,0000,0000,0000,0000,0000},
        {551, 1023,1021,1020,1019,1018,1016,1006,1005,1003,1002,0000,0000,0000,0000,0000,0000,0000,0000},
        {558, 1168,1167,1166,1165,1164,1163,1095,1094,1093,1092,1091,1090,1089,1088,0000,0000,0000,0000},
        {559, 1173,1162,1161,1160,1159,1158,1072,1071,1070,1069,1068,1067,1066,1065,0000,0000,0000,0000},
        {560, 1170,1169,1141,1140,1139,1138,1033,1032,1031,1030,1029,1028,1027,1026,0000,0000,0000,0000},
        {561, 1157,1156,1155,1154,1064,1063,1062,1061,1060,1059,1058,1057,1056,1055,1031,1030,1027,1026},
        {562, 1172,1171,1149,1148,1147,1146,1041,1040,1039,1038,1037,1036,1035,1034,0000,0000,0000,0000},
        {565, 1153,1152,1151,1150,1054,1053,1052,1051,1050,1049,1048,1047,1046,1045,0000,0000,0000,0000},
        {567, 1189,1188,1187,1186,1133,1132,1131,1130,1129,1102,0000,0000,0000,0000,0000,0000,0000,0000},
        {575, 1177,1176,1175,1174,1099,1044,1043,1042,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {576, 1193,1192,1191,1190,1137,1136,1135,1134,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {580, 1023,1020,1018,1017,1007,1006,1001,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {589, 1145,1144,1024,1020,1018,1017,1016,1013,1007,1006,1005,1004,1000,0000,0000,0000,0000,0000},
        {600, 1022,1020,1018,1017,1013,1007,1006,1005,1004,0000,0000,0000,0000,0000,0000,0000,0000,0000},
        {603, 1145,1144,1143,1142,1024,1023,1020,1019,1018,1017,1007,1006,1001,0000,0000,0000,0000,0000}
};
stock iswheelmodel(modelid) {

    new wheelmodels[17] = {1025,1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1096,1097,1098};

    for(new I = 0, b = sizeof(wheelmodels); I != b; ++I) {
        if (modelid == wheelmodels[I])
            return true;

    }

    return false;
}

stock IllegalCarNitroIde(carmodel) {

    new illegalvehs[29] = { 581, 523, 462, 521, 463, 522, 461, 448, 468, 586, 509, 481, 510, 472, 473, 493, 595, 484, 430, 453, 452, 446, 454, 590, 569, 537, 538, 570, 449 };

    for(new I = 0, b = sizeof(illegalvehs); I != b; ++I) {

        if (carmodel == illegalvehs[I])
            return true;

    }

    return false;
}

// assumes player is in a car - make sure it is.
stock illegal_nos_vehicle(PlayerID) {

    new carid = GetPlayerVehicleID(PlayerID);
    new playercarmodel = GetVehicleModel(carid);

    return IllegalCarNitroIde(playercarmodel);

}

stock islegalcarmod(vehicleide, componentid) {

    new modok = false;

    // stereo, hydraulics & nos (1x 2x 3x) are special.
    if ( (iswheelmodel(componentid)) || (componentid == 1086) || (componentid == 1087) || ((componentid >= 1008) && (componentid <= 1010))) {

        new nosblocker = IllegalCarNitroIde(vehicleide);

        if (!nosblocker)
            modok = true;

    } else {

        // check if the specified model CAN use this particular mod.
        for(new I = 0, b = sizeof(legalmods); I != b; ++I) {

            if (legalmods[I][0] == vehicleide) { // first is car IDE

                for(new J = 1; J < 22; J++) { // start with 1
                    if (legalmods[I][J] == componentid)
                        modok = true;
                }

            }

        }

    }

    return modok;
}
new ddBasladid;

#define     DD_MODEL        (411)       // http://wiki.sa-mp.com/wiki/Vehicles:All
#define     BEKLEME_SURESI  (30)        // dd baþlatildiginda oyuncularin katilmasina verilen zaman (saniye olarak)
#define     DD_PARA         (15000)     // dd kazanan oyuncunun alacagi para
#define     DD_SKOR         (15)         // dd kazanan oyuncunun alacagi skor

new
	DDObje[193] = {INVALID_OBJECT_ID, ...},
	DDObje2[250] = {INVALID_OBJECT_ID, ...},
	DDArac[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...},
	DDOyuncu = 0,
	DDTimer = -1,
	bool: DDBasladi = false;

new
	Float: DDSpawnPos[][4] = {
	    {851.2864, 3225.3269, 68.666, 0.0},
		{851.2864, 3217.8269, 68.666, 0.0},
		{851.2864, 3210.3269, 68.666, 0.0},
		{805.9697, 3204.3481, 68.666, 0.0},
		{805.9697, 3211.3481, 68.666, 0.0},
		{805.9697, 3237.8481, 68.666, 0.0},
		{760.3018, 3210.7000, 68.666, 0.0}
	};
new
	Float: DDSpawnPos2[][4] = {
		{3366.9910, -1948.9835, 21.2653,0.0},
		{3367.6194, -1962.1653, 21.2653,0.0},
		{3369.0771, -1960.9635, 2.5693,0.0},
		{3369.6335, -1949.5284, 2.5693,0.0},
		{3348.9495, -1946.0474, 2.5693,0.0},
		{3348.5164, -1924.2799, 2.5693,0.0}
	};



new RecentlyShot[MAX_PLAYERS];
#define COLOR_RED    0xFC3535FF
#define SERVER_MAX_PLAYERS 500

new kombo[MAX_PLAYERS];
new Text:Death0;
new Text:Death1;
new Text:Death2;
new Text:Death3;
new Text:Death4;
new Anims[7][8] = {
"strip_A",
"strip_B",
"strip_C",
"strip_D",
"strip_E",
"strip_F",
"strip_G"
};

new
   ETK[MAX_PLAYERS],
   EtkBaslat[MAX_PLAYERS],
   Etkinlik,
   etkismi[128],
   Float:ePos[4],
   EtkName[128]
;
#define DIALOGID0 15
new
	lotoBasladi,
	lotoSayi,
	lotoPara,
	lotoTimer
;
/*stockShowPlayerDialogM(playerid,dialogid,dialogstil,baslik[],icerik[],buton1[],buton2[])
{
	if(GetPVarInt(playerid, "Opened") == 1)
	{
	    Hatamesaj(playerid, "Lütfen acik olan yardim veya komutlar penceresini kapatin. [ESC]", "Please hide on active help,commands menu. [ESC Key]");
		return 1;
	}
	codexx(baslik);
 	SetPVarInt(playerid,"DialogAcik",1);
 	SetPVarInt(playerid,"Dialogid",dialogid);
	return ShowPlayerDialog(playerid,dialogid,dialogstil,baslik,icerik,buton1,buton2);
}
*/
//#define ShowPlayerDialog ShowPlayerDialogM
enum s_Functions
{
	Soru_Cevap[ 129 ],
	Soru[ 129 ]
}
new

	InfernusTuning[ MAX_PLAYERS ][ 8 ],
	Elegy[ MAX_PLAYERS ][ 3 ],
	SunrisePol[ MAX_PLAYERS ][ 4 ],
	Saddler[ MAX_PLAYERS ][ 8 ],
	BurritoTuning[ MAX_PLAYERS ][ 6 ],
	SultanTaxi[ MAX_PLAYERS ][ 4 ],
	StrutamTuning[ MAX_PLAYERS ][ 7 ];
stock DestroyVehObject( playerid )
{
SetVehicleNumberPlate(GetPlayerVehicleID(playerid), "ZeroTR");

		for ( new i = 0; i < 8; i++ )
		    DestroyObject( InfernusTuning[ playerid ][ i ] );
		for ( new i = 0; i < 3; i++ )
		    DestroyObject( Elegy[ playerid ][ i ] );
		for ( new i = 0; i < 4; i++ )
		    DestroyObject( SunrisePol[ playerid ][ i ] );
		for ( new i = 0; i < 8; i++ )
		    DestroyObject( Saddler[ playerid ][ i ] );
		for ( new i = 0; i < 6; i++ )
		    DestroyObject( BurritoTuning[ playerid ][ i ] );
		for ( new i = 0; i < 4; i++ )
		    DestroyObject( SultanTaxi[ playerid ][ i ] );
	 	for ( new i = 0; i < 7; i++ )
		    DestroyObject( StrutamTuning[ playerid ][ i ] );
}
new sorular[ 5 ][ s_Functions ] =
{
	{ "Limon", "Sarýdýr rengim|Dalda yetiþirim|Bilin bakalým|Ben hangi meyveyim?" },
	{ "Havlu", "Kurulandýkça ýslanan þey?" },
	{ "Çöp Kamyonu", "4 Ayaklý Sinekli Þey" },
	{ "Ayý", "Ormanda Gezer,Balý Çok Sever" },
	{ "Gamze", "Gülünce görünür, Ýnci gibi dizilir." }
};
new aktifSoruID, soruBasladi;
#emit LOAD.S.pri sorular
#define Lazer1 122
#define Lazer2 233
enum PlayerData
{
	sqlid,
	kullaniciadi[24],
	sifre[35],
	money,
	Deaths,
	Kills,
	Level,
	Animator,
	score,
	LoggedIn,
	LastOn[30],
	RegisteredDate[30],
	TimesOnServer,
	banned,
	Registered,
	Jailed,
	JailTime,
	language,
	oyundami,
    savaskazandi,
    yariskazandi,
    etkkazandi,
    evsayisi,
	ceteid,
	ceterutbe[20],
	ceterutbeid,
	IP[30],
	Float:pinfox,
	Float:pinfoy,
	Float:pinfoz,
	pinfointerior,
	pinfoworld,
	onlinet,
	vayar,
	mayar,
	fallkazandi,
	derbykazandi,
	otogiris,
	yetkiname[25],
	skinplayer,
	rengim,
	shootskil,
	Deposit,
	muted,
	mutedtime,
 	// Burdan sonrasi SQLde olmadigi için SQL'e birþey ekledigimizde Alltakiler yokmuþ gibi buraya ekliyoruz
	Muted,
	Float:faiz,
	sTotalTime,
	sConnectTime,
	God,
	GodCar,
	shours,
	smins,
	ssecs,
	Frozen,
	FreezeTime,
	Warnings,
	SpecID,
	SpecType,
	FailLogin,
	DialogGiris,
	DisablePM,
	PingCount,
	PingTime,
	pmspec,
	spec,
	spectime,
	Veteran,
	SemiPro,
	ticket1,
	ticket2,
	ticket3,
	ticket4,
	ticket5,
	ticket6,
	ticket7,
	ticket8,
	ticket9,
	ticket10,
	semiprotercih,
	veterantercih,
	odultercih,
	Ikramiye,
	CeteRutbe,
	Cete,
	DJ,
	SpawnAlani,
	viplevel
};
new PlayerInfo[MAX_PLAYERS][PlayerData];
stock GetPlayerMoney_C(playerid)
{
	return GetPlayerMoney(playerid);
}
stock GivePlayerMoney_C(playerid,para)
{
	GivePlayerMoney(playerid,para);
	return 1;
}
stock ResetPlayerMoney_C(playerid)
{
	ResetPlayerMoney(playerid);
	return 1;
}
stock GivePlayerMoney_M(playerid,para)
{
	PlayerInfo[playerid][money] += para;
	GivePlayerMoney(playerid,para);
	return 1;
}
#define GivePlayerMoney GivePlayerMoney_M
stock ResetPlayerMoney_M(playerid)
{
	PlayerInfo[playerid][money] = 0;
	return ResetPlayerMoney(playerid);
}
#define ResetPlayerMoney ResetPlayerMoney_M
stock SetPlayerMoney(playerid,para)
{
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid,para);
}
stock GetPlayerMoney_M(playerid)
{
	return PlayerInfo[playerid][money];
}
#define GetPlayerMoney GetPlayerMoney_M

#define SKOR_KAZANMA 1
new xdmesajpm[1024],kacpm;
new EVTPM=-1;
new gMessage[256];/*
new iName[MAX_PLAYER_NAME+1];
new pName1[MAX_PLAYER_NAME+1];
new Message[256];
new sendername[MAX_PLAYER_NAME];*/
new Text:eMessagepm[4][10];
new MessageStrpm[4][10][1024];
stock PmMesaji(playerid, text1[])
{
    if(strcmp(xdmesajpm,text1,true)){kacpm = 0; xdmesajpm = "";}
	if(kacpm >= 1){
		if(!strcmp(xdmesajpm,text1,true)){
		    return 1;
		}
	}
	strmid(xdmesajpm,text1, 0, strlen(text1), 1024);
	kacpm += 1;
	for(new i;i<4;i++)
	{
	for(new line; line < 9; line++)
    {
    	MessageStrpm[i][line] = MessageStrpm[i][line+1];
     	TextDrawSetString(eMessagepm[i][line], MessageStrpm[i][line]);
    }
    }
    if(PlayerInfo[playerid][Level] < 7){
	format(MessageStrpm[0][9],256,"%s",text1);
	TextDrawSetString(eMessagepm[0][9], MessageStrpm[0][9]);
	format(MessageStrpm[1][9],256,"%s",text1);
	TextDrawSetString(eMessagepm[1][9], MessageStrpm[1][9]);
	format(MessageStrpm[2][9],256,"%s",text1);
	TextDrawSetString(eMessagepm[2][9], MessageStrpm[2][9]);
	format(MessageStrpm[3][9],256,"%s",text1);
	TextDrawSetString(eMessagepm[3][9], MessageStrpm[3][9]);
	}else if(PlayerInfo[playerid][Level] == 8){
	format(MessageStrpm[1][9],256,"%s",text1);
	TextDrawSetString(eMessagepm[1][9], MessageStrpm[1][9]);
	format(MessageStrpm[2][9],256,"%s",text1);
	TextDrawSetString(eMessagepm[2][9], MessageStrpm[2][9]);
	format(MessageStrpm[3][9],256,"%s",text1);
	TextDrawSetString(eMessagepm[3][9], MessageStrpm[3][9]);
	}else if(PlayerInfo[playerid][Level] == 9){
	format(MessageStrpm[2][9],256,"%s",text1);
	TextDrawSetString(eMessagepm[2][9], MessageStrpm[2][9]);
	format(MessageStrpm[3][9],256,"%s",text1);
	TextDrawSetString(eMessagepm[3][9], MessageStrpm[3][9]);
	}else if(PlayerInfo[playerid][Level] == 10){
	format(MessageStrpm[3][9],256,"%s",text1);
	TextDrawSetString(eMessagepm[3][9], MessageStrpm[3][9]);
	}
    if(EVTPM!=-1)KillTimer(EVTPM);
    EVTPM = -1;
    EVTPM = SetTimerEx("emessagepmdele",3500,false,"d",0);
    return 1;
}
forward emessagepmdele(id);
public emessagepmdele(id)
{
for(new i=0;i<4;i++){
MessageStrpm[i][id][0] = EOS;
TextDrawSetString(eMessagepm[i][id],"");
}
if(id >=9)return 1;
EVTPM = SetTimerEx("emessagepmdele",3500,false,"d",id+1);
return 1;
}

new Spectekiler[MAX_PLAYERS];

new dgi[MAX_PLAYERS];
new dgi2[MAX_PLAYERS];

#define NEON 1337 // dialog 1337
#define COLOR_WHITE 0xFFFFFFAA
new  Text:UserBox[4], PlayerText: PlayerUserBox[MAX_PLAYERS][2];
new Text:eMessage[2][5];
new MessageStr[2][5][1024];
new Text:deMessage[2][3];
///[2][3][1024];
new EVT[5]=-1;

new lift1, lift2, lift3;
new PlayerText:Textdraw[MAX_PLAYERS][8];
#define Shop 50
#define S           "{ffa64c}"
#pragma dynamic 1055840
#define DIALOG_BASLIK "[Z]ero Türkiye"
#define ENGLISH     (2)
#define TURKISH     (1)
new ivehicle[MAX_PLAYERS];
new Araba[MAX_PLAYERS];
#pragma tabsize 0

#if !defined Loop
#define Loop(%0,%1) \
        for(new %0 = 0; %0 != %1; %0++)
#endif

#if !defined function
#define function%0(%1) \
        forward%0(%1); public%0(%1)
#endif

#if !defined PURPLE
#define PURPLE \
    0xBF60FFFF
#endif

#if !defined GREEN
#define GREEN \
    0x94D317FF
#endif

#if !defined TIME
#define TIME \
    220000
#endif
new
        xCharacters[][] =
        {
            "A", "R", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
                "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
            "a", "r", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
                "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
            "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
        },
        xChars[16] = "",
        xReactionTimer,
        bool: xTestBusy
;
#define mysql_fetch_row(%1) 													mysql_fetch_row_format(%1,"|")
#define SQL_HOST 																"127.0.0.1"//            |
#define SQL_USER 																"root"//                 |  Mysql Giriþ Bilgileri
#define SQL_PASS 																""//                     |
#define SQL_DB 																	"zero"//
new onlines[MAX_PLAYERS];
stock SavePlayer(playerid)
{
		if(PlayerInfo[playerid][LoggedIn] == 1){

        if(MySQLHesapKontrol(playerid) != 0){

    new strt[256];
    format(strt, sizeof(strt), "UPDATE oyuncular SET LoggedIn = 0, DJ = %d, spawnsecim = %d WHERE kullaniciadi = '%s'",PlayerInfo[playerid][DJ], PlayerInfo[playerid][SpawnAlani], oIsim(playerid));
    mysql_query(strt);
        new Query[800],toplam[5000],geo_IPx[30];
        GetPlayerIp(playerid,geo_IPx, sizeof(geo_IPx));
		// max_slot 200 slot ken nie okunuyor 60 dan sonr aha dur ona bakiyim
		format(Query, sizeof(Query), "UPDATE `oyuncular` SET `money` = '%d',`Deaths` = '%d',`Kills` = '%d', `fallkazandi` = '%d', `derbykazandi` = '%d', `yariskazandi` = '%d', `savaskazandi` = '%d', `etkkazandi` = '%d'",
		GetPlayerMoney(playerid),PlayerInfo[playerid][Deaths],PlayerInfo[playerid][Kills],PlayerInfo[playerid][fallkazandi],PlayerInfo[playerid][derbykazandi],PlayerInfo[playerid][yariskazandi],PlayerInfo[playerid][savaskazandi]
		,PlayerInfo[playerid][etkkazandi]);
		strcat(toplam,Query,5000);
		format(Query, sizeof(Query), ",`Level` = '%d',`Animator` = '%d',`score` = '%d',`Jailed` = '%d', `vayar` = '%d', `mayar` = '%d', `otogiris` = '%d'",
		PlayerInfo[playerid][Level],PlayerInfo[playerid][Animator],GetPlayerScore(playerid),PlayerInfo[playerid][Jailed]
		,PlayerInfo[playerid][vayar],PlayerInfo[playerid][mayar],PlayerInfo[playerid][otogiris]);
		strcat(toplam,Query,5000);
		format(Query, sizeof(Query), ",`JailTime` = '%d',`language` = '%d', `evsayisi` = %d, `pinfox` = '%.02f',`pinfoy` = '%.02f',`pinfoz` = '%.02f', `onlinet` = '%d', `deposit` = %d, `spectime` = %d, `veterantercih` = %d, `semiprotercih` = %d, Ikramiye = %d, skinplayer = %d WHERE `kullaniciadi` = '%s'",
		PlayerInfo[playerid][JailTime],PlayerInfo[playerid][language],PlayerInfo[playerid][evsayisi],PlayerInfo[playerid][pinfox],PlayerInfo[playerid][pinfoy],PlayerInfo[playerid][pinfoz],PlayerInfo[playerid][onlinet],PlayerInfo[playerid][Deposit],PlayerInfo[playerid][spectime],PlayerInfo[playerid][veterantercih],PlayerInfo[playerid][semiprotercih],PlayerInfo[playerid][Ikramiye],PlayerInfo[playerid][skinplayer],oIsim(playerid));
		strcat(toplam,Query,5000);
		mysql_query(toplam);
		mysql_free_result();
    	}
		}
		return 1;
}
stock MySQLHesapKontrol(playerid)
{
	#emit LOAD.S.pri playerid
	new query[128];
	new escstr[MAX_PLAYER_NAME];
	mysql_real_escape_string(oIsim(playerid), escstr);
	format(query, sizeof(query), "SELECT sqlid FROM oyuncular WHERE LOWER(kullaniciadi) = LOWER('%s') LIMIT 1", escstr);
	mysql_query(query);
	mysql_store_result(); // valla buldum
	if (mysql_num_rows()==0)
	{
	    mysql_free_result();
		return 0;
	}
	else
	{
		mysql_free_result();
		return 1;
	}
}
stock DDCikar(playerid, sebep)
{
	if(DDArac[playerid] == INVALID_VEHICLE_ID) return 1;
	SetCameraBehindPlayer(playerid);
	new sebepler[][32] = {"Oyundan Cikti", "Araci Patladi", "Denize Dustu", "Kendi Istegiyle", "Aractan Indi", "Diger", "Araci Yok Oldu", "FPS Dusuk"};
	if(sebep != 0 && sebep != 1)
	{
		SetPlayerInterior(playerid, GetPVarInt(playerid, "DDInterior"));
		SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "DDVirtual"));
		SetPlayerPos(playerid, GetPVarFloat(playerid, "DDPosX"), GetPVarFloat(playerid, "DDPosY"), GetPVarFloat(playerid, "DDPosZ"));
	}

	if(sebep != 3 && sebep != 5 && DDBasladi)
	{
	}

	TogglePlayerControllable(playerid, 1);
	SetPlayerVirtualWorld(playerid, 0);
	DestroyVehicle(DDArac[playerid]);
	DDArac[playerid] = INVALID_VEHICLE_ID;
	DDOyuncu--;
	if(DDBasladi)
	{
	    new string[159];
	    if(sebep != 3 && sebep != 5)
	    {
		    GetPlayerName(playerid, string, MAX_PLAYER_NAME);
		    for(new x; x < MAX_PLAYERS; x++)
		    {
          		if(DDArac[x] != INVALID_VEHICLE_ID)
          		{
          		    new calderond[256];
          		    format(calderond, sizeof(calderond), "{C3C3C3}« DD »{C3C3C3} Oyuncu {FFFFFF}%s{C3C3C3} DD'den elendi. Sebep: [{FFFFFF}%s{C3C3C3}]", string, sebepler[sebep]);
					SendClientMessage(x, -1, calderond);
			  	}
		    }
	    }

		if(DDOyuncu < 2)
		{
		    new kazanan = INVALID_PLAYER_ID;
		    for(new i; i < MAX_PLAYERS; ++i)
		    {
		        if(DDArac[i] == INVALID_VEHICLE_ID) continue;
		        kazanan = i;
		        break;
		    }

		    if(IsPlayerConnected(kazanan))
		    {
		        ddStarted = 0;
				GameTextForPlayer(kazanan, "~n~~n~~n~~g~~h~~h~Kazandin!", 5000, 4);
		        GetPlayerName(kazanan, string, MAX_PLAYER_NAME);
				format(string, sizeof(string), "~w~~h~~h~~h~Oyuncu ~r~%s~w~~h~~h~~h~ derby'i kazandi. Odul: ~y~~h~15 score~w~~h~~h~~h~ - ~y~~h~$15000.~w~~h~~h~~h~", oIsim(kazanan));
				TextMesaj(string, string);

          		GivePlayerMoney(kazanan, DD_PARA);
				SetPlayerScore(kazanan, GetPlayerScore(kazanan)+DD_SKOR);
          		DDCikar(kazanan, 5);
		    }

		    DDOyuncu = 0;
		    DDBasladi = false;
		    KillTimer(DDTimer);
		    DDTimer = -1;
		}
	}

	return 1;
}

