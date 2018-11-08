new hoo;
#if defined RACEPASIF
//[200][124];
native XML:xml_open(const filename[]);
new checkpoint[][]=
{
    "posX",
	"posY",
	"posZ"
};
new spawnpoint[][]=
{
	"posX",
	"posY",
	"posZ",
	"rotation",
 	"vehicle"
};
new spawnpointa[][]=
{
	"posX",
	"posY",
	"posZ",
	"rotZ",
 	"vehicle"
};

native xml_close(XML:handle);
native bool:xml_get_bool(XML:handle, const xpath[]);
native xml_get_int(XML:handle, const xpath[]);
native Float:xml_get_float(XML:handle, const xpath[]);
native xml_get_string(XML:handle, const xpath[], result[], size = sizeof result);
new Float:SpawnPointX[MAX_PLAYERS],Float:SpawnPointY[MAX_PLAYERS],Float:SpawnPointZ[MAX_PLAYERS],Float:SpawnPointA[MAX_PLAYERS],SpawnPointVeh[MAX_PLAYERS],SpawnPointUsed[MAX_PLAYERS];
static ObjectCount, VehicleCount;
new MapName[64];
new pveh[MAX_PLAYERS];
new ObjAttr[][] =
{
		"model",
		"posX",
		"posY",
		"posZ",
		"rotX",
		"rotY",
		"rotZ",
		"dimension",
		"interior"
};
new PckAttr[][] =
{
		"type",
		"vehicle",
		"posX",
		"posY",
		"posZ"
},
	RaceWeather,
	RaceHour,
	rObje[5000],
	BuildRaceType;
new SpawnAttr[][] = {
		"vehicle",
		"posX",
		"posY",
		"posZ",
		"rotZ"
};


stock CreateVehicleEx(model, Float:pox, Float:poy, Float:poz, Float:poa, dimension, interior, c1, c2, spawn_d) {
	new vehid = CreateVehicle(model, pox, poy, poz, poa, c1, c2, spawn_d);
	LinkVehicleToInterior(vehid, interior);
	SetVehicleVirtualWorld(vehid, dimension);
}
stock SpawnInVehicle(playerid, model, Float:pox, Float:poy, Float:poz, Float:poa, dimension, interior, c1, c2, spawn_d) {
	if(pveh[playerid]>0) DestroyVehicle(pveh[playerid]);
	pveh[playerid] = CreateVehicle(model, pox, poy, poz, poa, c1, c2, spawn_d);
	PutPlayerInVehicle(playerid, pveh[playerid], 0);
	LinkVehicleToInterior(pveh[playerid], interior);
	SetVehicleVirtualWorld(pveh[playerid], dimension);
}
stock VehicleChanger(Float:X, Float:Y, Float:Z, MID) {
		new id;
		for(new i=0; i<sizeof(Repair); i++)
		{
			if(VChange[i]>0) continue;
			VChange[i] = CreatePickup(1239,14,X,Y,Z,0);
			id=i;
			break;
		}
		ChangeID[id]=MID;
		return 1;
}
new yariskalansure;
/*
	Release:
	    	» Race System Filterscript

	Author:
	        » » RyDeR «

	Last Update:
	        » 26/04/2010

	ChangeLog:
	        » v0.1a:
				- Initial release

			» v0.2a:
			    - Major Bugs fixed!
			    - Racing in other worlds added (enable/disbable with uncomment/comment-ing the define)
			    - New Commands added:
			                        - /startautorace: You can enable that the script starts automaticly a race after the previous one is done.
			                        - /stopautorace: You can disable the command above.
			                        - /exitrace: To exit the race safely
       			- Best Race Times added (Top 5 best time laps; You will see a message when the record is broken).
       			- Crash while creating a race is fixed.
       			- Etc..

	Bugs:
	        » No bugs

	Version:
			» v0.2a

	Functions:
			» IsPlayerInRace(playerid);    >> UseFull in stunt servers to disable speedhack, nitro etc. while racing.

	Credits:
			» Joker: He knows why ;)
			» Joe Torran C, ModrLicC: For testing.
			» DracoBlue: 'Dini' include.
	        » Y_Less: 'IsOdd' function.
	        » Seif_: 'function' function.
	        » ZeeX: 'zcmd' include.
			» Switch: InRace Position function.
*/

#include <a_samp>
#include <dini>
#include <zcmd>
#include <YSI\y_hooks>
new yaristimer=-1;
#pragma unused \
	ret_memcpy

#define ForEach(%0,%1) \
	for(new %0 = 0; %0 != %1; %0++) if(IsPlayerConnected(%0) && !IsPlayerNPC(%0))

#define Loop(%0,%1) \
	for(new %0 = 0; %0 != %1; %0++)

#define IsOdd(%1) \
	((%1) & 1)

#define ConvertTime(%0,%1,%2,%3,%4) \
	new \
	    Float: %0 = floatdiv(%1, 60000) \
	;\
	%2 = floatround(%0, floatround_tozero); \
	%3 = floatround(floatmul(%0 - %2, 60), floatround_tozero); \
	%4 = floatround(floatmul(floatmul(%0 - %2, 60) - %3, 1000), floatround_tozero)

#define function%0(%1) \
	forward%0(%1); public%0(%1)

#define MAX_RACE_CHECKPOINTS_EACH_RACE \
 	120

#define MAX_RACES \
 	100

#define COUNT_DOWN_TILL_RACE_START \
	31 // seconds

#define MAX_RACE_TIME \
	300 // seconds

#define RACE_CHECKPOINT_SIZE \
	12.0

#define DEBUG_RACE \
	1

#define RACE_IN_OTHER_WORLD // Uncomment to enable

#define GREY \
	0xAFAFAFAA

#define RED \
	0xE60000FF

#define YELLOW \
	0xFFFF00AA

#define WHITE \
	0xFFFFFFAA

new
	BuildRace,
	BuildVehicle,
	BuildCreatedVehicle,
	BuildModeVID,
	BuildName[30],
	bool: BuildTakeVehPos,
	BuildVehPosCount,
	bool: BuildTakeCheckpoints,
	BuildCheckPointCount,
#emit LOAD.S.pri BuildRace
#emit LOAD.S.pri BuildRaceType
#emit LOAD.S.pri BuildVehicle
#emit LOAD.S.pri BuildCreatedVehicle
#emit LOAD.S.pri BuildModeVID
#emit LOAD.S.pri BuildName
#emit LOAD.S.pri BuildTakeVehPos
#emit LOAD.S.pri BuildVehPosCount
#emit LOAD.S.pri BuildTakeCheckpoints
#emit LOAD.S.pri BuildCheckPointCount
	RaceBusy = 0x00,
	RaceName[30],
	RaceVehicle,
	RaceType,
	TotalCP,
	Float: RaceVehCoords[555][4],
	Float: CPCoords[MAX_RACE_CHECKPOINTS_EACH_RACE][4],
	//[MAX_PLAYERS],
	Index,
	PlayersCount[2],
	CountTimer,
	CountAmount,
	RaceTick,
	RaceStarted,
	CPProgess[MAX_PLAYERS],
	Position,
	FinishCount,
	JoinCount,
	rCounter,
	PlayerText:Race_InfoTD[ 11 ],
	RaceTime,
	Text: RaceInfo[MAX_PLAYERS],
	InfoTimer[MAX_PLAYERS],
	RacePosition[MAX_PLAYERS] = 1,
	RaceNames[MAX_RACES][128],
	devrim[MAX_RACES][128],
	nospid[500],
	repid[500],
	vehch[500],
	vehchcar[500],
	Text3D:vehchlabel[500],
	Iterator:nosp<500>,
	Iterator:vehp<500>,
	Iterator:rep<500>,
 	TimeProgress

;
stock CreateRacePickup(picount,modelid,tiip,Float:x,Float:y,Float:z){
    new pickup = CreateDynamicPickup(modelid,tiip,x,y,z,10,-1,-1,300);
    mPickInfo[picount][sX] = x;
    mPickInfo[picount][sY] = y;
    mPickInfo[picount][sZz] = z;
    return pickup;
}

hook OnFilterScriptExit()
{
	BuildCreatedVehicle = (BuildCreatedVehicle == 0x01) ? (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00) : (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00);
	KillTimer(rCounter);
	KillTimer(CountTimer);
	Loop(i, MAX_PLAYERS)
	{
		DisablePlayerRaceCheckpoint(i);
		TextDrawDestroy(RaceInfo[i]);
		DestroyVehicle(ivehicle[i]);
		Joined[i] = false;
		KillTimer(InfoTimer[i]);
	}
	JoinCount = 0;
	FinishCount = 0;
	TimeProgress = 0;
	return 1;
}
CMD:yarisbaslat(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 10)) return YETERSIZSEVIYE2(playerid, 10);
	YarisBaslat();
	return 1;
}
CMD:yarisgit(playerid, params[])
{
	if(RaceStarted == 1) return Hatamesaj(playerid, "Yarisa katilimlar durdu, bir sonra ki oyunu bekleyin.", "Race joins is off. Please wait new race.");
	if(RaceBusy == 0x00)
	{
		new str[256];
		format(str,256,"Henüz bir yaris baslamis degil.",TimeConverter(yariskalansure - GetTickCount()));
		return Bilgimesaj(playerid, str, str);
	}
	if(Joined[playerid] == true) return SendClientMessage(playerid, RED, "<(Bilgi)> You already joined a race!");
	if(IsPlayerInAnyVehicle(playerid)) return SetTimerEx("SetupRaceForPlayer", 2500, 0, "e", playerid), RemovePlayerFromVehicle(playerid), Joined[playerid] = true;
	ShowPlayerDialog(playerid, 500000, 3, "_","_","_","_");
// 	CloseselectioanMenu(playerid);
//	CancelSelectTextDraw(playerid);
//	SetPVarInt(playerid, "vspawner_active", 0);
//	OnPlayerClickTextDraw(playerid, Text:INVALID_TEXT_DRAW);
	SetPlayerVirtualWorld(playerid, 10);
	SetPlayerTime(playerid,RaceHour,0);
	SetPlayerWeather(playerid,RaceWeather);
	SetupRaceForPlayer(playerid);
	Joined[playerid] = true;
	Bilgimesaj(playerid, "Yarisda hata olmasi durumunda {E24234}' /sos '{FFFFFF} kullanin.", "In race error (Car Burning, Car Delete) to use {E24234}' /sos '{FFFFFF} command.");
	Bilgimesaj(playerid, "Buglu haritalarý /ticket ile bildirin. (Ismini unutmayin.)", "Map is bug? Please /ticket to say admins.");
	return 1;
}

hook OnPlayerEnterRaceCheckpoint(playerid)
{
	if(CPProgess[playerid] == TotalCP -1)
	{
		new
		    TimeStamp,
		    TotalRaceTime,
		    string[256],
		    rFile[256],
		    pName[MAX_PLAYER_NAME],
			rTime[3],
			Prize[2],
			TempTotalTime,
			TempTime[3],
			pstr[5]
		;
		Position++;
		GetPlayerName(playerid, pName, sizeof(pName));
		TimeStamp = GetTickCount();
		TotalRaceTime = TimeStamp - RaceTick;
		ConvertTime(varr, TotalRaceTime, rTime[0], rTime[1], rTime[2]);
		switch(Position)
		{
		    case 1: Prize[0] = (random(random(5000)) + 10000), Prize[1] = 10, format(pstr, sizeof(pstr),"1 st");
		    case 2: Prize[0] = (random(random(4500)) + 9000), Prize[1] = 9, format(pstr, sizeof(pstr),"2 nd");
		    case 3: Prize[0] = (random(random(4000)) + 8000), Prize[1] = 8, format(pstr, sizeof(pstr),"3 rd");
		    case 4: Prize[0] = (random(random(3500)) + 7000), Prize[1] = 7, format(pstr, sizeof(pstr),"4 th");
		    case 5: Prize[0] = (random(random(3000)) + 6000), Prize[1] = 6, format(pstr, sizeof(pstr),"5 th");
		    case 6: Prize[0] = (random(random(2500)) + 5000), Prize[1] = 5, format(pstr, sizeof(pstr),"6 th");
		    case 7: Prize[0] = (random(random(2000)) + 4000), Prize[1] = 4, format(pstr, sizeof(pstr),"7 th");
		    case 8: Prize[0] = (random(random(1500)) + 3000), Prize[1] = 3, format(pstr, sizeof(pstr),"8 th");
		    case 9: Prize[0] = (random(random(1000)) + 2000), Prize[1] = 2, format(pstr, sizeof(pstr),"9 th");
		    default: Prize[0] = random(random(1000)), Prize[1] = 1;
		}
		format(string, sizeof(string), "Oyuncu ~r~~h~%s~w~~h~~h~~h~ yarisi ~p~~h~%s~w~~h~~h~~h~ bitirdi. Odul: ~y~~h~%d$~w~~h~~h~~h~ - ~y~~h~%d~y~~h~ score", pName, pstr, Prize[0], Prize[1]);
		TextMesaj(string, string);
		OnPlayerCommandReceived(playerid, "/yariscik");
		if(FinishCount <= 5)
		{
			format(rFile, sizeof(rFile), "/rRaceSystem/%s.RRACE", RaceName);
		    format(string, sizeof(string), "BestRacerTime_%d", TimeProgress);
		    TempTotalTime = dini_Int(rFile, string);
		    ConvertTime(varr1, TempTotalTime, TempTime[0], TempTime[1], TempTime[2]);
		    if(TotalRaceTime <= dini_Int(rFile, string) || TempTotalTime == 0)
		    {
		        dini_IntSet(rFile, string, TotalRaceTime);
				format(string, sizeof(string), "BestRacer_%d", TimeProgress);
				dini_Set(rFile, string, pName);
				TimeProgress++;
		    }
		}
		FinishCount++;
		GivePlayerMoney(playerid, Prize[0]);
		SetPlayerScore(playerid, GetPlayerScore(playerid) + Prize[1]);
		DisablePlayerRaceCheckpoint(playerid);
		CPProgess[playerid]++;
		if(FinishCount >= JoinCount) return StopRace();
    }
	else
	{
		CPProgess[playerid]++;
		CPCoords[CPProgess[playerid]][3]++;
		RacePosition[playerid] = floatround(CPCoords[CPProgess[playerid]][3], floatround_floor);
	    SetCP(playerid, CPProgess[playerid], CPProgess[playerid]+1, TotalCP, RaceType);
	    PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
		GetVehiclePos(GetPlayerVehicleID(playerid),vPos[playerid][0],vPos[playerid][1],vPos[playerid][2]);
		GetVehicleZAngle(GetPlayerVehicleID(playerid),vPos[playerid][3]);
		GetVehicleVelocity(GetPlayerVehicleID(playerid),vHiz[playerid][0],vHiz[playerid][1],vHiz[playerid][2]);
	    SetCP(playerid, CPProgess[playerid], CPProgess[playerid]+1, TotalCP, RaceType);
	}
    return 1;
}

hook OnPlayerDisconnect(playerid)
{
	if(Joined[playerid] == true)
    {
    for ( new i = 0; i < 11; i++ )
   		PlayerTextDrawHide( playerid, Race_InfoTD[ i ] );
		JoinCount--;
		Joined[playerid] = false;
		DestroyVehicle(ivehicle[playerid]);
		DisablePlayerRaceCheckpoint(playerid);
		TextDrawHideForPlayer(playerid, RaceInfo[playerid]);
		CPProgess[playerid] = 0;
		KillTimer(InfoTimer[playerid]);
		#if defined RACE_IN_OTHER_WORLD
		SetPlayerVirtualWorld(playerid, 0);
		#endif
	}
	TextDrawDestroy(RaceInfo[playerid]);
	if(BuildRace == playerid+1) BuildRace = 0;
	return 1;
}

hook OnPlayerConnect(playerid)
{

	RaceRez1[playerid] = TextDrawCreate(611.000000, 364.000000, "_");
	TextDrawBackgroundColor(RaceRez1[playerid], 255);
	TextDrawFont(RaceRez1[playerid], 1);
	TextDrawLetterSize(RaceRez1[playerid], 0.500000, -0.199999);
	TextDrawColor(RaceRez1[playerid], -1);
	TextDrawSetOutline(RaceRez1[playerid], 0);
	TextDrawSetProportional(RaceRez1[playerid], 1);
	TextDrawSetShadow(RaceRez1[playerid], 1);
	TextDrawUseBox(RaceRez1[playerid], 1);
	TextDrawBoxColor(RaceRez1[playerid], -206);
	TextDrawTextSize(RaceRez1[playerid], 560.000000, 55.000000);
	TextDrawSetSelectable(RaceRez1[playerid], 0);

	RaceRez2[playerid] = TextDrawCreate(611.000000, 405.000000, "_");
	TextDrawBackgroundColor(RaceRez2[playerid], 255);
	TextDrawFont(RaceRez2[playerid], 1);
	TextDrawLetterSize(RaceRez2[playerid], 0.500000, -0.199999);
	TextDrawColor(RaceRez2[playerid], -1);
	TextDrawSetOutline(RaceRez2[playerid], 0);
	TextDrawSetProportional(RaceRez2[playerid], 1);
	TextDrawSetShadow(RaceRez2[playerid], 1);
	TextDrawUseBox(RaceRez2[playerid], 1);
	TextDrawBoxColor(RaceRez2[playerid], -206);
	TextDrawTextSize(RaceRez2[playerid], 560.000000, 55.000000);
	TextDrawSetSelectable(RaceRez2[playerid], 0);

	RaceRez3[playerid] = TextDrawCreate(611.000000, 367.000000, "_");
	TextDrawBackgroundColor(RaceRez3[playerid], 255);
	TextDrawFont(RaceRez3[playerid], 1);
	TextDrawLetterSize(RaceRez3[playerid], -1.120000, 4.099999);
	TextDrawColor(RaceRez3[playerid], -1);
	TextDrawSetOutline(RaceRez3[playerid], 0);
	TextDrawSetProportional(RaceRez3[playerid], 1);
	TextDrawSetShadow(RaceRez3[playerid], 1);
	TextDrawUseBox(RaceRez3[playerid], 1);
	TextDrawBoxColor(RaceRez3[playerid], -206);
	TextDrawTextSize(RaceRez3[playerid], 607.000000, 65.000000);
	TextDrawSetSelectable(RaceRez3[playerid], 0);

	RaceRez4[playerid] = TextDrawCreate(587.000000, 367.000000, "st");
	TextDrawBackgroundColor(RaceRez4[playerid], 255);
	TextDrawFont(RaceRez4[playerid], 2);
	TextDrawLetterSize(RaceRez4[playerid], 0.150000, 0.800000);
	TextDrawColor(RaceRez4[playerid], -106);
	TextDrawSetOutline(RaceRez4[playerid], 0);
	TextDrawSetProportional(RaceRez4[playerid], 1);
	TextDrawSetShadow(RaceRez4[playerid], 1);
	TextDrawSetSelectable(RaceRez4[playerid], 0);

	RaceRez5[playerid] = TextDrawCreate(578.000000, 371.000000, "1");
	TextDrawBackgroundColor(RaceRez5[playerid], 255);
	TextDrawFont(RaceRez5[playerid], 2);
	TextDrawLetterSize(RaceRez5[playerid], 0.320000, 1.800000);
	TextDrawColor(RaceRez5[playerid], -106);
	TextDrawSetOutline(RaceRez5[playerid], 0);
	TextDrawSetProportional(RaceRez5[playerid], 1);
	TextDrawSetShadow(RaceRez5[playerid], 1);
	TextDrawSetSelectable(RaceRez5[playerid], 0);

	RaceRez6[playerid] = TextDrawCreate(592.000000, 381.000000, "/ 5");
	TextDrawBackgroundColor(RaceRez6[playerid], 255);
	TextDrawFont(RaceRez6[playerid], 2);
	TextDrawLetterSize(RaceRez6[playerid], 0.180000, 1.200000);
	TextDrawColor(RaceRez6[playerid], -106);
	TextDrawSetOutline(RaceRez6[playerid], 0);
	TextDrawSetProportional(RaceRez6[playerid], 1);
	TextDrawSetShadow(RaceRez6[playerid], 1);
	TextDrawSetSelectable(RaceRez6[playerid], 0);

	RaceRez7[playerid] = TextDrawCreate(574.000000, 393.000000, "10 / 26");
	TextDrawBackgroundColor(RaceRez7[playerid], 255);
	TextDrawFont(RaceRez7[playerid], 1);
	TextDrawLetterSize(RaceRez7[playerid], 0.160000, 0.900000);
	TextDrawColor(RaceRez7[playerid], -106);
	TextDrawSetOutline(RaceRez7[playerid], 0);
	TextDrawSetProportional(RaceRez7[playerid], 1);
	TextDrawSetShadow(RaceRez7[playerid], 1);
	TextDrawSetSelectable(RaceRez7[playerid], 0);
	return 1;
}

hook OnPlayerDeath(playerid)
{
    if(Joined[playerid] == true)
    {
    for ( new i = 0; i < 11; i++ )
   		PlayerTextDrawHide( playerid, Race_InfoTD[ i ] );
		JoinCount--;
		Joined[playerid] = false;
		DestroyVehicle(ivehicle[playerid]);
		DisablePlayerRaceCheckpoint(playerid);
		TextDrawHideForPlayer(playerid, RaceInfo[playerid]);
		CPProgess[playerid] = 0;
		KillTimer(InfoTimer[playerid]);
		#if defined RACE_IN_OTHER_WORLD
		SetPlayerVirtualWorld(playerid, 0);
		#endif
	}
	if(BuildRace == playerid+1) BuildRace = 0;
	return 1;
}
function LoadRaceNames()
{
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
    sscanf(string,"s[128] ",RaceNames[count]);
    format(derbynameb,64,"%s",RaceNames[count]);
    derbynameb[0] = toupper(derbynameb[0]);
    derbynameb[5] = toupper(derbynameb[5]);
    format(racenames,sizeof(racenames),"%s\n{00eeff}%03d-) {D6A374}%s",racenames,count+1,derbynameb);
    count++;
    }
    fclose(mag);
	return 1;
}
function LoadRace(playerid, rName[])
{
	LoadAutoRace(rName);
	return 1;
}
function LoadAutoRace(rName[])
{
	if(!spamProtects("raceStart", 10)) return 1;
	RaceTime = 300;
	new File[128],
	    Str[9][40],
	    buf[50],
	    count,
	    obcount,
	    picount,
	    spawnco,
	    mapname[64],
	    time[12]
		;
	format(File,128,"/RacesNew/%s/meta.xml",rName);
	if(!fexist(File))return printf("%s eksik!",File);
	new XML:Map = xml_open(File);
	xml_get_string(Map,"meta/info/@name",RaceName);
	xml_get_string(Map,"meta/map/@src",mapname);
	xml_get_string(Map,"meta/settings/setting[1]/@value",time);
	RaceWeather = xml_get_int(Map,"meta/settings/setting[2]/@value");
	xml_close(Map);
	sscanf(time,"p<:>d",RaceHour);
	format(File,128,"/RacesNew/%s/%s",rName,mapname);
	if(!fexist(File))return printf("%s eksik!",File);
	Map = xml_open(File);
   new spawnp = xml_get_int(Map,"count(map/spawnpoint)");
    new Objectp = xml_get_int(Map,"count(map/object)");
	new Racepick = xml_get_int(Map, "count(map/racepickup)");
    new Checkpo = xml_get_int(Map,"count(map/checkpoint)");
    new Max1 = max(spawnp,Objectp);
    new Max2 = max(Checkpo,Racepick);
    new Max = max(Max1,Max2);
    for(new a=1,b=Max+1; a<b; a++)
	{
		if(Objectp != 0 && Objectp >= a)
 		{
			for(new c=0; c<sizeof(ObjAttr); c++)
			{
            	format(Str[c], sizeof(Str[]), "map/object[%d]/@%s",a,ObjAttr[c]);
            }
            rObje[obcount] = CreateDynamicObject(xml_get_int(Map,Str[0]),xml_get_float(Map,Str[1]),xml_get_float(Map,Str[2]),xml_get_float(Map,Str[3]),xml_get_float(Map,Str[4]),xml_get_float(Map,Str[5]),xml_get_float(Map,Str[6]));
            obcount++;
            if(obcount>=2000){
			printf("%s/%s isimli mapte obje sayisi cok fazla",rName,mapname);
			return 0;
			}
		}
        if(spawnp != 0 && spawnp >=a)
        {
            for(new c=0; c<sizeof(spawnpoint); c++)
            {
                format(Str[c], sizeof(Str[]), "map/spawnpoint[%d]/@%s",a,spawnpoint[c]);
			}
			RaceVehCoords[spawnco][0] = xml_get_float(Map,Str[0]);
			RaceVehCoords[spawnco][1] = xml_get_float(Map,Str[1]);
			RaceVehCoords[spawnco][2] = xml_get_float(Map,Str[2]);
			RaceVehCoords[spawnco][3] = xml_get_float(Map,Str[3]);
			if(RaceVehCoords[spawnco][3] != RaceVehCoords[spawnco][3]){
			format(Str[3], sizeof(Str[]), "map/spawnpoint[%d]/@rotZ",a);
			RaceVehCoords[spawnco][3] = xml_get_float(Map,Str[3]);
			}
			RaceVehicle = xml_get_int(Map,Str[4]);
			spawnco++;
		}
		if(Checkpo != 0 && Checkpo >=a)
		{
		    for(new c=0; c<sizeof(checkpoint); c++)
            {
                format(Str[c], sizeof(Str[]), "map/checkpoint[%d]/@%s",a,checkpoint[c]);
			}
			CPCoords[count][0] = xml_get_float(Map,Str[0]);
			CPCoords[count][1] = xml_get_float(Map,Str[1]);
			CPCoords[count][2] = xml_get_float(Map,Str[2]);
			count++;
		}
	}
	xml_close(Map);
	TotalCP = count;
	// = spawnco;
	Position = 0;
	FinishCount = 0;
	JoinCount = 0;
	Loop(x, 2) PlayersCount[x] = 0;
	CountAmount = COUNT_DOWN_TILL_RACE_START;
	RaceBusy = 0x01;
	KillTimer(hoo);
	hoo=SetTimer("CountTillRace", 999, 1);
	#pragma unused picount
	#pragma unused buf
	#pragma unused MapName
	#pragma unused ObjectCount
	#pragma unused PckAttr
	#pragma unused RaceWeather
	#pragma unused SpawnAttr
	#pragma unused SpawnPointA
	#pragma unused SpawnPointUsed
	#pragma unused SpawnPointVeh
	#pragma unused SpawnPointX
	#pragma unused SpawnPointY
	#pragma unused SpawnPointZ
	#pragma unused VehicleCount
	#pragma unused spawnpointa
	return printf("%s isimli yaris basariyla baslatildi",RaceName),1;//mapworld
}
hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hitid == 3851 || hitid == 1649 && IsPlayerInRangeOfPoint(playerid, 300, -2051.9277, 313.3314, 35.0954))
	{
	    SetPVarInt(playerid, "Warnn", GetPVarInt(playerid, "Warnn")+1);
	    if(GetPVarInt(playerid, "Warnn") != 3)
	    {
			new string[256];
			format(string, sizeof(string), "Camlarý kýrmak yasaktýr. Uyarýnýz dolunca 10 dakika hapis! {E24234}[%d/3]", GetPVarInt(playerid, "Warnn"));
			Bilgimesaj(playerid, string, string);
	    }
		else
		{
		    new oyuncu_id = playerid, string[256];
			PlayerInfo[oyuncu_id][Jailed] = 1;
			PlayerInfo[oyuncu_id][JailTime] = 600;

			format(string, sizeof(string), "~r~[~w~~h~~h~~h~JAIL~r~]~p~ Konsol~w~~h~~h~~h~, oyuncu ~p~~h~%s~w~~h~~h~~h~'i ~r~600~w~~h~~h~~h~ saniye hapse gonderdi. [Sebep: ~r~Banka Camlarini Kirmak~w~~h~~h~~h~]", oIsim(playerid));
			TextMesaj(string, string);
			if(PlayerInfo[oyuncu_id][Jailed] != 0)
			{
		   	    SetPlayerPos(oyuncu_id, 231.7616,66.8649,1005.0391);
				SetPlayerInterior(oyuncu_id, 6);
				SetPlayerVirtualWorld(oyuncu_id, 30);
			}
		}
	}
	return 1;
}

function SetCP(playerid, PrevCP, NextCP, MaxCP, Type)
{
	if(Type == 0)
	{
		if(NextCP == MaxCP) SetPlayerRaceCheckpoint(playerid, 1, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
			else SetPlayerRaceCheckpoint(playerid, 0, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
	}
	else if(Type == 3)
	{
		if(NextCP == MaxCP) SetPlayerRaceCheckpoint(playerid, 4, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
			else SetPlayerRaceCheckpoint(playerid, 3, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
	}
	return 1;
}
function SetupRaceForPlayer(playerid)
{
	TextDrawDestroy(RaceRez0[playerid]);
	RaceRez0[playerid] = TextDrawCreate(612.000000, 362.000000, "_");
	TextDrawBackgroundColor(RaceRez0[playerid], 255);
	TextDrawFont(RaceRez0[playerid], 1);
	TextDrawLetterSize(RaceRez0[playerid], 0.500000, 4.800000);
	TextDrawColor(RaceRez0[playerid], -1);
	TextDrawSetOutline(RaceRez0[playerid], 0);
	TextDrawSetProportional(RaceRez0[playerid], 1);
	TextDrawSetShadow(RaceRez0[playerid], 1);
	TextDrawUseBox(RaceRez0[playerid], 1);
	TextDrawBoxColor(RaceRez0[playerid], 150);
	TextDrawTextSize(RaceRez0[playerid], 559.000000, 55.000000);
	TextDrawSetSelectable(RaceRez0[playerid], 0);

		TextDrawShowForPlayer(playerid, RaceRez0[playerid]);
		TextDrawShowForPlayer(playerid, RaceRez1[playerid]);
		TextDrawShowForPlayer(playerid, RaceRez2[playerid]);
		TextDrawShowForPlayer(playerid, RaceRez3[playerid]);
		TextDrawShowForPlayer(playerid, RaceRez4[playerid]);
		TextDrawShowForPlayer(playerid, RaceRez5[playerid]);
		TextDrawShowForPlayer(playerid, RaceRez6[playerid]);
		TextDrawShowForPlayer(playerid, RaceRez7[playerid]);
		TextDrawShowForPlayer(playerid, RaceRez8[playerid]);
    for ( new i = 0; i < 11; i++ )
   		PlayerTextDrawShow( playerid, Race_InfoTD[ i ] );
	CPProgess[playerid] = 0;
	TogglePlayerControllable(playerid, false);
	SetPVarString(playerid, "FreezedBy", "race");
	CPCoords[playerid][3] = 0;
	SetCP(playerid, CPProgess[playerid], CPProgess[playerid]+1, TotalCP, RaceType);
	if(IsOdd(playerid)) Index = 1;
	    else Index = 0;
	TextDrawShowForPlayer(playerid, TopRace0);
	TextDrawShowForPlayer(playerid, TopRace1);
	TextDrawShowForPlayer(playerid, TopRace2);
	TextDrawShowForPlayer(playerid, TopRace3);
	TextDrawShowForPlayer(playerid, TopRace4);
	TextDrawShowForPlayer(playerid, TopRace5);
	TextDrawShowForPlayer(playerid, TopRace6);
	TextDrawShowForPlayer(playerid, TopRace7);
	new string[256], racername[24], dosyayolu[256], TempTotalTime, strt[256], TotalRaceTime, TimeStamp, rTime[6];
	format(dosyayolu, sizeof(dosyayolu), "/rRaceSystem/%s.RRACE", RaceName);
		TimeStamp = GetTickCount();
		TotalRaceTime = TimeStamp - RaceTick;
		ConvertTime(varr, TotalRaceTime, rTime[0], rTime[1], rTime[2]);
	for(new x; x < 5; x++)
	{
	    format(string, sizeof(string), "BestRacerTime_%d", x);
	    TempTotalTime = dini_Int(dosyayolu, string);
	    if (TempTotalTime == 0){}
	    format(string, sizeof(string), "BestRacer_%d", x);
		format(racername, sizeof(racername), "%s", dini_Get(dosyayolu, string));
	    //format(strt, sizeof(strt), "%d-) ~w~~h~~h~~h~%s - %s", x+1, racername, TimeConverterz(TempTotalTime));
		if(x+1 == 1) TextDrawSetString(TopRace2, strt);
		if(x+1 == 2) TextDrawSetString(TopRace3, strt);
		if(x+1 == 3) TextDrawSetString(TopRace4, strt);
		if(x+1 == 4) TextDrawSetString(TopRace5, strt);
		if(x+1 == 5) TextDrawSetString(TopRace6, strt);
	}
	#if defined RACE_IN_OTHER_WORLD
	SetPlayerVirtualWorld(playerid, 10);
	#endif
	switch(Index)
	{
	    case 0:
		{
			RaceVehCoords[0][0] -= (6 * floatsin(-RaceVehCoords[0][3], degrees));
	 		RaceVehCoords[0][1] -= (6 * floatcos(-RaceVehCoords[0][3], degrees));
			SetPlayerPos(playerid, RaceVehCoords[0][0], RaceVehCoords[0][1], RaceVehCoords[0][2]+3);
 	        SetPlayerFacingAngle(playerid, RaceVehCoords[0][3]);
			vPos[playerid][0] = RaceVehCoords[0][0];
			vPos[playerid][1] = RaceVehCoords[0][1];
			vPos[playerid][2] = RaceVehCoords[0][2];
			vPos[playerid][3] = RaceVehCoords[0][3];
			SetTimerEx("amojin1", 2000, false, "i", playerid);
	    }
	    case 1:
	    {
			RaceVehCoords[1][0] -= (6 * floatsin(-RaceVehCoords[1][3], degrees));
	 		RaceVehCoords[1][1] -= (6 * floatcos(-RaceVehCoords[1][3], degrees));
			SetPlayerPos(playerid, RaceVehCoords[1][0], RaceVehCoords[1][1], RaceVehCoords[1][2]+3);
 	        SetPlayerFacingAngle(playerid, RaceVehCoords[0][3]);
			vPos[playerid][0] = RaceVehCoords[0][0];
			vPos[playerid][1] = RaceVehCoords[0][1];
			vPos[playerid][2] = RaceVehCoords[0][2];
			vPos[playerid][3] = RaceVehCoords[0][3];
			SetTimerEx("amojin2", 2000, false, "i", playerid);
   		}
	}
	InfoTimer[playerid] = SetTimerEx("TextInfo", 500, 1, "e", playerid);
	JoinCount++;
	return 1;
}

function amojin1(playerid)
{
	if(Joined[playerid] != true) return 1;
	if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
	CreatePlayerVehicleRace(playerid, RaceVehicle);
	Camera(playerid, RaceVehCoords[0][0], RaceVehCoords[0][1], RaceVehCoords[0][2], RaceVehCoords[0][3], 20);
	return 1;
}

function amojin2(playerid)
{
	if(Joined[playerid] != true) return 1;
	if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
	CreatePlayerVehicleRace(playerid, RaceVehicle);
	Camera(playerid, RaceVehCoords[0][0], RaceVehCoords[0][1], RaceVehCoords[0][2], RaceVehCoords[0][3], 20);
	return 1;
}

function CountTillRace()
{
	switch(CountAmount)
	{
 		case 0:
	    {
			StartRace();
	    }
	    case 4:
	    {
			TextDrawSetString(RaceSayac2, "_");
			TextDrawSetString(RaceSayac3, "_");
			TextDrawSetString(RaceSayac4, "_");
		    SetTimer("Renkler", 1000, false);
		    SetTimer("Renkler2", 2000, false);
		    SetTimer("Renkler3", 3000, false);
		    SetTimer("Renkler4", 3700, false);
			ForEach(playerid, MAX_PLAYERS)
			{
			    if(Joined[playerid] == true)
			    {
					TextDrawShowForPlayer(playerid, RaceSayac0);
					TextDrawShowForPlayer(playerid, RaceSayac1);
					TextDrawShowForPlayer(playerid, RaceSayac2);
					TextDrawShowForPlayer(playerid, RaceSayac3);
					TextDrawShowForPlayer(playerid, RaceSayac4);
					TextDrawShowForPlayer(playerid, RaceSayac5);
			    }
			}
	    }
	    case 30, 20:
	    {
	        new
	            string[224],
	            RaceNamex[256]
			;
			format(RaceNamex, sizeof(RaceName), "%s", RaceName);
			format(string, sizeof(string), "~w~~h~~h~~h~Birazdan ~r~~h~%s~w~~h~~h~~h~ adli yaris baslayacak (Max~r~~h~ 24~w~~h~~h~~h~ Oyuncu). Gitmek icin ~y~~h~/yarisgit~w~~h~~h~~h~ yazin.", RaceNamex);
			TextMesaj(string, string);
	    }
	}
	return CountAmount--;
}

function StartRace()
{
	ForEach(i, MAX_PLAYERS)
	{
	    if(Joined[i] == true)
	    {
	        TogglePlayerControllable(i, true);
			SetPVarString(i, "FreezedBy", "race");
			SetCameraBehindPlayer(i);
	    }
	}
	rCounter = SetTimer("RaceCounter", 900, 1);
	RaceTick = GetTickCount();
	RaceStarted = 1;
	KillTimer(CountTimer);
	return 1;
}

function StopRace()
{
	for(new x; x < 2000; x++){
	DestroyDynamicObject(rObje[x]);}

	KillTimer(rCounter);
	RaceStarted = 0;
	RaceTick = 0;
	RaceBusy = 0x00;
	JoinCount = 0;
	FinishCount = 0;
    TimeProgress = 0;

	ForEach(i, MAX_PLAYERS)
	{
	    if(Joined[i] == true)
	    {
	    	DisablePlayerRaceCheckpoint(i);
	    	DestroyVehicle(ivehicle[i]);
	    	Joined[i] = false;
			TextDrawHideForPlayer(i, RaceInfo[i]);
			CPProgess[i] = 0;
			KillTimer(InfoTimer[i]);
			SpawnPlayer(i);
		}
	}
	for(new a;a<500;a++)DestroyDynamic3DTextLabel(vehchlabel[a]),vehchlabel[a]=Text3D:0;
	for(new a;a<500;a++)DestroyDynamicPickup(nospid[a]),DestroyDynamicPickup(repid[a]),repid[a]=0;
 	Iter_Clear(nosp);
 	Iter_Clear(rep);
 	Iter_Clear(vehp);
	KillTimer(hoo);
	return 1;
}

function RaceCounter()
{
	if(RaceStarted == 1)
	{
		RaceTime--;
		if(JoinCount <= 0)
		{
			StopRace();
			KillTimer(hoo);
			TextMesaj("Yaris durduruldu.", "Yaris durduruldu.");
		}
	}
	if(RaceTime <= 0)
	{
	    StopRace();
	}
	return 1;
}

function TextInfo(i)
{
PlayerTextDrawHide(i, gselectioanitemas[i][0]);
PlayerTextDrawHide(i, gselectioanitemas[i][1]);
new str[25],txt[24];
if (RacePosition[i] == 1) format(txt, 24, "st");
else if (RacePosition[i] == 2) format(txt, 24, "nd");
else if (RacePosition[i] == 3) format(txt, 24, "rd");
else format(txt, 24, "th");
TextDrawSetString(RaceRez4[i], txt);
format(str, sizeof(str), "%i", RacePosition[i]);
TextDrawSetString(RaceRez5[i], str);
format(str, sizeof(str), "/ %i", JoinCount);
TextDrawSetString(RaceRez6[i], str);
format(str, sizeof(str), "%i  /  %i", CPProgess[i], TotalCP);
TextDrawSetString(RaceRez7[i], str);}

function Camera(playerid, Float:X, Float:Y, Float:Z, Float:A, Mul)
{
	SetPlayerCameraLookAt(playerid, X, Y, Z);
	SetPlayerCameraPos(playerid, X + (Mul * floatsin(-A, degrees)), Y + (Mul * floatcos(-A, degrees)), Z+6);
}

function IsPlayerInRace(playerid)
{
	if(Joined[playerid] == true) return true;
	    else return false;
}
stock IsValidVehicle(vehicleid)
{
	if(vehicleid < 400 || vehicleid > 611) return false;
	    else return true;
}

function YarisBaslat()
{
	if(yaristimer!=-1)KillTimer(yaristimer);
 	yaristimer = SetTimer("YarisBaslat",300000,false);
 	yariskalansure = GetTickCount()+300000;
	LoadAutoRace(devrim[random(100)]);
	return 1;
}
forward Renkler();
public Renkler()
{
	TextDrawSetString(RaceSayac2, ".");
	foreach(new i : Player)
	{
	    if(Joined[i] != true) return 1;
	    TogglePlayerControllable(i, 0);
	    PlayerPlaySound(i, 1056,0,0,0);
	}
	return 1;
}

forward Renkler2();
public Renkler2()
{
	TextDrawSetString(RaceSayac3, ".");
	TextDrawSetString(RaceSayac5, "Hazir!!!");
	foreach(new i : Player)
	{
	    if(Joined[i] != true) return 1;
	    TogglePlayerControllable(i, 0);
	    PlayerPlaySound(i, 1056,0,0,0);
	}
	return 1;
}

forward Renkler3();
public Renkler3()
{
	TextDrawSetString(RaceSayac4, ".");
	foreach(new i : Player)
	{
	    if(Joined[i] != true) return 1;
	    TogglePlayerControllable(i, 0);
	    PlayerPlaySound(i, 1056,0,0,0);
	}
/*	TextDrawHideForPlayer(playerid, RaceSayac0);
	TextDrawHideForPlayer(playerid, RaceSayac1);
	TextDrawHideForPlayer(playerid, RaceSayac2);
	TextDrawHideForPlayer(playerid, RaceSayac3);
	TextDrawHideForPlayer(playerid, RaceSayac4);
	TextDrawHideForPlayer(playerid, RaceSayac5);
    PlayerPlaySound(playerid, 1056, 0, 0, 0);
*/
	return 1;
}

forward Renkler4();
public Renkler4()
{
	foreach(new i : Player)
	{
	    if(Joined[i] != true) return 1;
		TextDrawHideForPlayer(i, RaceSayac0);
		TextDrawHideForPlayer(i, RaceSayac1);
		TextDrawHideForPlayer(i, RaceSayac2);
		TextDrawHideForPlayer(i, RaceSayac3);
		TextDrawHideForPlayer(i, RaceSayac4);
		TextDrawHideForPlayer(i, RaceSayac5);
    	PlayerPlaySound(i, 1057, 0, 0, 0);
	    TogglePlayerControllable(i, 1);
		Camera(i, RaceVehCoords[1][0], RaceVehCoords[1][1], RaceVehCoords[1][2], RaceVehCoords[1][3], 20);
	}
	return 1;
}
hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_ONFOOT && (Joined[playerid] == true))
	{
   		PutPlayerInVehicle(playerid, ivehicle[playerid], 0);
   	}
	return 1;
}
stock CreatePlayerVehicleRace( playerid, modelid )
{
 	if(GetPVarInt(playerid, "Spawned") == 0)
	{
		return Hatamesaj(playerid, "Spawn olmadan bu islemi yapamassiniz!", "Please wait spawn!");
	}
if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
       new Float:x, Float:y, Float:z, Float:angle;
            if(IsPlayerInAnyVehicle(playerid)){
          GetVehiclePos(GetPlayerVehicleID(playerid),x,y,z);
          GetVehicleZAngle(GetPlayerVehicleID(playerid),angle);
            }else{
            GetPlayerPos(playerid, x,y,z);
            GetPlayerFacingAngle(playerid, angle);
            }
            if(IsPlayerInAnyVehicle(playerid))RemovePlayerFromVehicle(playerid);
            if(Araba[playerid] == 1) RemovePlayerFromVehicle(playerid), DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
	        DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle( modelid, x, y, ( z + 1 ), angle, -1, -1, -1);Araba[playerid] = 1;

        SetVehicleNumberPlate(ivehicle[playerid], "{FF0015}[Z]ero");//{3333FF}mavi{E24234}yesil{0040FF}mavi{E24234}sari{FF0015}kirmizi{FFFFFF}beyaz{F7F09D}<(Bilgi>:{FFFFFF}{FFFFFF}
        LinkVehicleToInterior( ivehicle[playerid], GetPlayerInterior( playerid ) );
        SetVehicleVirtualWorld( ivehicle[playerid], GetPlayerVirtualWorld( playerid ) );
        PutPlayerInVehicle( playerid, ivehicle[playerid], 0 );
        SetPlayerArmedWeapon(playerid,0);
        SetPVarInt(playerid,"ModifiyeCar",0);

          return 1;
}
function gulsun(playerid)
{
	if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
    DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle( RaceVehicle, vPos[playerid][0],vPos[playerid][1],vPos[playerid][2], vPos[playerid][3], -1, -1, -1);Araba[playerid] = 1;
    SetVehicleVirtualWorld( ivehicle[playerid], GetPlayerVirtualWorld( playerid ) );
    PutPlayerInVehicle(playerid, ivehicle[playerid], 0);
    PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	SetVehiclePos(ivehicle[playerid],vPos[playerid][0],vPos[playerid][1],vPos[playerid][2]);
	SetVehicleZAngle(ivehicle[playerid],vPos[playerid][3]);
	SetVehicleVelocity(ivehicle[playerid],vHiz[playerid][0],vHiz[playerid][1],vHiz[playerid][2]);
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(Joined[playerid] == true) return 1;
	if ( newkeys & KEY_YES )
	{
		if( GetPlayerVehicleSeat( playerid ) == 0 ) return 	komut_flip( playerid, "lol" );
	}

    if (HOLDING(KEY_LEFT))
	{
	    if(PlayerInfo[playerid][spec] == 1)
	    {
	        if(!IsPlayerConnected(Spectekiler[playerid]-1) && IsPlayerConnected(Spectekiler[playerid]-2)) return StopSpectate(playerid), StartSpectate(playerid, Spectekiler[playerid]-2);
	        if(IsPlayerConnected(Spectekiler[playerid]-1) && !IsPlayerConnected(Spectekiler[playerid]-2)) return StopSpectate(playerid), StartSpectate(playerid, Spectekiler[playerid]-1);
	    }
	}
    if (HOLDING(KEY_RIGHT))
	{
	    if(PlayerInfo[playerid][spec] == 1)
	    {
	        if(!IsPlayerConnected(Spectekiler[playerid]+1) && IsPlayerConnected(Spectekiler[playerid]+2)) return StopSpectate(playerid), StartSpectate(playerid, Spectekiler[playerid]+2);
	    }
	}
	if(newkeys & KEY_YES) {
		komut_hpbmn(playerid," ");
        CloseselectioanMenu(playerid);
        SetPVarInt(playerid, "vspawner_active", 0);
	}
	if(newkeys & KEY_NO) {
		if(GetPVarInt(playerid, "vspawner_active") == 1) {
			CloseselectioanMenu(playerid);
		    CancelSelectTextDraw(playerid);
			PVS->Int->vspawner_active[playerid]->0;
		}
		if(GetPVarInt(playerid, "Opened") == 1)
			TextDrawHideForPlayer(playerid, UserBox[0]),
			TextDrawHideForPlayer(playerid, UserBox[1]),
			TextDrawHideForPlayer(playerid, UserBox[2]),
			TextDrawHideForPlayer(playerid, UserBox[3]),
			PlayerTextDrawHide(playerid, PlayerUserBox[playerid][0]),
			PlayerTextDrawHide(playerid, PlayerUserBox[playerid][1]),
			PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][1], "_"),
			SetPVarInt(playerid, "Opened", 0);
	}
    if(newkeys & KEY_RIGHT)
    {
        SetPVarInt(playerid, "CMDPAGE", 2);
        new formul[1024];
        strcat(formul, "/rules - Sunucu kurallarini gorebilirsiniz.~n~/mystyle - Giysi, sapka gibi seyler alabilirsiniz.~n~/dovusstil - Dovus stilinizi degistirebilirsiniz.~n~/duello - Bir oyuncuyla skor karsiligi duello yapabilirsiniz.~n~/dm - Deathmatch oyunlarimiza katilabilirsiniz. ~n~/eiffel - Eyfel kulesine gidebilirsiniz.~n~");
		strcat(formul, "/maze - Labirenti tamamlayabilecekmisin ? Hic sanmiyorum.~n~/dil - Gelecek mesajlarin dilini secebilirsiniz.~n~/stunts - Birbirinden guzel stuntlara gidebilirisinz.");
		PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][1], formul);
	}
    if(newkeys & KEY_LEFT)
    {
        SetPVarInt(playerid, "CMDPAGE", 1);
        new formul[1024];
        strcat(formul, "/shop - Alisveris yapabilirsiniz.~n~/teles - Genis teleport menumuzu gorebilirsiniz.~n~/neon - Aracina neon takabilirsiniz.~n~/animasyonlar - Karakterinize animasyon yaptirabilirsiniz.~n~/report - Yoneticilere bir oyuncuyu rapor edebilirsiniz. ~n~/can - Caninizi 10.000$ karsiligi doldurabilirsiniz.~n~");
		strcat(formul, "/zirh - Zirhinizi 12.500$ karsiligi doldurabilirsiniz.~n~/about - Sunucu modu hakkinda detayli bilgi alabilirsiniz.~n~/credits - Sunucu yapiminda emegi gecenleri goreiblirsiniz.~n~/yetenekler - Kendinize mutant ozellikler (yetenekler) satin alabilirsiniz.~n~/m1...18 - Kendinize hazir modifiyeli araclar indirebilirsiniz.~n~/v1...17 - Kendinize bir arac indirebilirsiniz.~n~");
		PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][1], formul);
	}
    if(newkeys & KEY_LOOK_BEHIND && IsPlayerInAnyVehicle(playerid))
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    {
	        return HataMesaji(playerid, "Bir aracin söforu olmaniz lazim!");
	    }
		RepairVehicle(GetPlayerVehicleID(playerid));
		SetVehicleHealth(GetPlayerVehicleID(playerid), 1100);
        PlayerPlaySound(playerid, 1133 ,0, 0, 0);
//		SetVehicleHealth(GetPlayerVehicleID(playerid), 800);
		GameTextForPlayer(playerid, "~w~~h~~h~~h~10X ~r~~h~~h~NITRO~n~~b~~h~FULL TAMIR", 1600, 3);
		UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), 0,0, 0, 0);
	    AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
	}
	if(newkeys & KEY_YES && IsPlayerInAnyVehicle(playerid) && DDArac[playerid] == INVALID_VEHICLE_ID)
	{
	    komut_hpbmn(playerid, " ");
	    CloseselectioanMenu(playerid),CancelSelectTextDraw(playerid),SetPVarInt(playerid, "vspawner_active", 0);
	    return 1;
	}
    if(newkeys & KEY_FIRE && IsPlayerInAnyVehicle(playerid) && DDArac[playerid] == INVALID_VEHICLE_ID)
    {
        MyCarPress(playerid, PVG->Int->firekey[playerid]);
        return 1;
    }
    if(newkeys & KEY_CROUCH && IsPlayerInAnyVehicle(playerid))
    {
        MyCarPress(playerid, PVG->Int->hkey[playerid]);
        return 1;
    }
	return 1;
}
#emit LOAD.S.alt dObje
#emit LOAD.S.alt dmPickInfo
#emit LOAD.S.alt labeld
#emit LOAD.S.alt labels
#emit LOAD.S.alt nospd@YSII_Ag
#emit LOAD.S.alt nospd@YSII_Cg
#emit LOAD.S.alt nospidd
#emit LOAD.S.alt nospids
#emit LOAD.S.alt nosps@YSII_Ag
#emit LOAD.S.alt nosps@YSII_Cg
#emit LOAD.S.alt repd@YSII_Ag
#emit LOAD.S.alt repd@YSII_Cg
#emit LOAD.S.alt repidd
#emit LOAD.S.alt repids
#emit LOAD.S.alt reps@YSII_Ag
#emit LOAD.S.alt reps@YSII_Cg
#emit LOAD.S.alt sObje
#emit LOAD.S.alt smPickInfo
#emit LOAD.S.alt tNitro
#emit LOAD.S.alt tRepair
#emit LOAD.S.alt PickAttr
#emit LOAD.S.alt vehch
#emit LOAD.S.alt vehchcar
#endif
