 #include <YSI\y_hooks>

enum PlayerInfok
{
	CurrentHID
};
new pInfo[MAX_PLAYERS][PlayerInfok];

#define HMenu                                                           7654
#define CInt                                                            8765
#define Houses_Table                                                    "evler"
#define MAX_HOUSES 500 
enum HInfo
{
	ID,
	Owner[25],
	Owned,
	Locked,
	InteriorID,
	World,
	Price,
	Float:OX,
	Float:OY,
	Float:OZ,
	Float:IX,
	Float:IY,
	Float:IZ,
	H_Cash,
	H_Weapon1,
	H_Weapon2,
	H_Weapon3,
	H_Ammo1,
	H_Ammo2,
	H_Ammo3,
	Text3D:Label,
	Icon,
	EnterPickup,
	ExitPickup
};
new HouseInfo[MAX_HOUSES][HInfo];
new CreatedHouses = 0;
new gQuery[256];
hook OnGameModeInit()
{
	CreateDynamicObject(987, 1531.67834, -14.33049, 1000.07239,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(987, 1532.63135, -4.60217, 1000.07239,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, 1521.29578, -6.17688, 1000.07239,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 1523.51086, -15.28000, 1000.07239,   0.00000, 0.00000, 90.00000);
	LoadHouses();
	return 1;
}

hook OnFilterScriptExit()
{
	return 1;
}

hook OnPlayerConnect(playerid)
{
	pInfo[playerid][CurrentHID] = -1;
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	pInfo[playerid][CurrentHID] = -1;
	return 1;
}

hook OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	for(new i=1; i<=CreatedHouses; i++)
	{
	    if(pickupid == HouseInfo[i][ExitPickup])
	    {
	        KickFromHouse(playerid, i);
	    }
	    else if(pickupid == HouseInfo[i][EnterPickup])
	    {
	        if(HouseInfo[i][Owned] == 0)
			{
				new string[256],lockstr[24];
				if (HouseInfo[i][Locked] == 1) {format(lockstr, sizeof(lockstr), "Kilitli");}
				else {format(lockstr, sizeof(lockstr), "Açýk");}
				format(string, sizeof(string), "{E24234}»{FFFFFF}  Kapý Numarasý: \t\t{E24234}[%d]\n{E24234}»{FFFFFF} Kilit Durumu: \t\t{E24234}[Kilitli]\n{E24234}»{FFFFFF} Interior: \t\t\t{E24234}%d\n{E24234}»{FFFFFF} Ev Sahibi: \t\t\t{E24234}[N/A]", i, lockstr, HouseInfo[i][InteriorID], HouseInfo[i][Owner]);
				ShowPlayerDialog(playerid, 7413, DIALOG_STYLE_MSGBOX, "{FFFFFF}[Z]eroTR {E24234}-{FFFFFF} Ev Bilgileri", string, "Satýn Al", "Tamam");
				return 1;
			}
	        else if(HouseInfo[i][Owned] == 1)
	        {
				new string[256],lockstr[24];
				if (HouseInfo[i][Locked] == 1) {format(lockstr, sizeof(lockstr), "Kilitli");}
				else {format(lockstr, sizeof(lockstr), "Açýk");}
				format(string, sizeof(string), "{E24234}»{FFFFFF}  Kapý Numarasý: \t\t{E24234}[%d]\n{E24234}»{FFFFFF} Kilit Durumu: \t\t{E24234}[%s]\n{E24234}»{FFFFFF} Interior: \t\t\t{E24234}%d\n{E24234}»{FFFFFF} Ev Sahibi: \t\t\t{E24234}[%s]", i, lockstr, HouseInfo[i][InteriorID], HouseInfo[i][Owner]);
				ShowPlayerDialog(playerid, 7412, DIALOG_STYLE_MSGBOX, "{FFFFFF}[Z]eroTR {E24234}-{FFFFFF} Ev Bilgileri", string, "Eve Gir", "Tamam");
				break;
			}
			else continue;
		}
	}
	return 1;
}
CMD:evcik(playerid, params[])
{
	KickFromHouse(playerid, pInfo[playerid][CurrentHID]);
	return 1;
}
CMD:evdencik(playerid, params[]) return komut_evcik(playerid, params);
CMD:cik(playerid, params[]) return komut_evcik(playerid, params);
CMD:gir(playerid, params[])
{
	new i;
	for(new xi=1; xi<=CreatedHouses; xi++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 4.0, HouseInfo[xi][OX], HouseInfo[xi][OY], HouseInfo[xi][OZ]))
	    {
	        i = xi;
	        break;
	    }
	}
	if (i > 0)
	{
    if(HouseInfo[i][Owned] == 0)
	{
        Bilgimesaj(playerid, "Bu evi satýn almak için ikonda /satinal yazýn.", "Buy house command: /satinal");
		PutPlayerInHouse(playerid, i);
		return 1;
	}
    else if(HouseInfo[i][Owned] == 1)
    {
        if(HouseInfo[i][Locked] == 1)
        {
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, sizeof(name));
			if(strcmp(name, HouseInfo[i][Owner]) != 0)
			{
				HataMesaji(playerid, "Bu ev kilitli olduðu için girilemez.");
				return 1;
			}
		}
		PutPlayerInHouse(playerid, i);
	}
	}
	return 1;
}
CMD:evegir(playerid, params[]) return komut_gir(playerid, " ");
CMD:evgir(playerid, params[]) return komut_gir(playerid, " ");
CMD:createhouse(playerid,params[])
{
	new HID = CreatedHouses+1, price, interior, Float:x, Float:y, Float:z;
	if(!IsPlayerAdmin(playerid)) return 0;
	if(sscanf(params, "ii", price, interior)) return Kullanimmesaj(playerid, "createhouse [fiyat] [interior(1-2-3)]", "createhouse [fiyat] [interior(1-2-3)]");
	if(interior >= 4 || interior <= 0) return HataMesaji(playerid, "Ýnterior numarasý yalnýzca 1-2-3 olabilir.");
	if(CreatedHouses == MAX_HOUSES-1) return HataMesaji(playerid, "Sunucuda ki toplam ev sayýsý limiti aþtý! Lütfen CaLderoN ile iletiþime geçin.");
	GetPlayerPos(playerid, x, y, z);
	HouseInfo[HID][ID] = HID;
	new name[25];
	format(name,25,"None");
	HouseInfo[HID][Owner] = name;
	HouseInfo[HID][Locked] = 0;
	HouseInfo[HID][World] = HID;
	HouseInfo[HID][InteriorID] = interior;
	HouseInfo[HID][Price] = price;
	HouseInfo[HID][OX] = x;
	HouseInfo[HID][OY] = y;
	HouseInfo[HID][OZ] = z;
	new lString[256];
//	new string[256];
    format(lString, sizeof(lString), "{C3C3C3}Kapý No: {ffffa5}%i\n{C3C3C3}Ev Fiyatý: {ffffa5}%i$\n{C3C3C3}Satýn almak için {ffffa5}/satinal{C3C3C3} yazýn.",HID, HouseInfo[HID][Price]);
	HouseInfo[HID][Label] = CreateDynamic3DTextLabel(lString, -1, HouseInfo[HID][OX], HouseInfo[HID][OY], HouseInfo[HID][OZ]+0.5, 20.0);
	HouseInfo[HID][Icon] = CreateDynamicMapIcon(HouseInfo[HID][OX], HouseInfo[HID][OY], HouseInfo[HID][OZ], 31, -1);
	HouseInfo[HID][EnterPickup] = CreateDynamicPickup(19524, 23, HouseInfo[HID][OX], HouseInfo[HID][OY], HouseInfo[HID][OZ], -1, -1, -1, 20.0);
	format(gQuery,256,"INSERT INTO `"Houses_Table"` (ID, Owner, Owned, Locked, InteriorID, World, Price, OX, OY, OZ) VALUES ('%i', '%s', '%i', '%i', '%i', '%i', '%i', '%f', '%f', '%f')",
	HouseInfo[HID][ID], HouseInfo[HID][Owner], HouseInfo[HID][Owned], HouseInfo[HID][Locked], HouseInfo[HID][InteriorID], HouseInfo[HID][World], HouseInfo[HID][Price], HouseInfo[HID][OX], HouseInfo[HID][OY], HouseInfo[HID][OZ]);
	if(mysql_query(gQuery))
	    Bilgimesaj(playerid, "Ev baþarýyla yaratýldý.", "Ev baþarýyla yaratýldý!");
	else
	    Bilgimesaj(playerid, "Ev yaratýlamadý. Hata kodu: mysql_query", "Ev yaratýlamadý. Hata kodu: mysql_query");
	SetHouseExit(playerid, HID);
	CreatedHouses++;
	return 1;
}
CMD:evimisat(playerid,params[])
{
	new hID = PlayerInfo[playerid][evsayisi];
	if (hID != 0)
	{
	new name[MAX_PLAYER_NAME], lString[389];
	GetPlayerName(playerid,name,sizeof(name));
    format(name,25,"None");
    HouseInfo[hID][Owner] = EOS;
    HouseInfo[hID][Locked] = 0;
    HouseInfo[hID][Owned] = 0;
    format(lString, sizeof(lString), "{C3C3C3}Kapý No: {ffffa5}%i\n{C3C3C3}Ev Fiyatý: {ffffa5}%i$\n{C3C3C3}Satýn almak için {ffffa5}/satinal{C3C3C3} yazýn.", hID, HouseInfo[hID][Price]);
    UpdateDynamic3DTextLabelText(Text3D:HouseInfo[hID][Label], -1, lString);
    format(gQuery, sizeof(gQuery),"UPDATE `"Houses_Table"` SET `Owner` = '%s', `Owned` = '%i', `Locked` = '%i'", HouseInfo[hID][Owner], HouseInfo[hID][Owned], HouseInfo[hID][Locked]);
    mysql_query(gQuery);
    DestroyDynamicMapIcon(HouseInfo[hID][Icon]);
    HouseInfo[hID][Icon] = CreateDynamicMapIcon(HouseInfo[hID][OX], HouseInfo[hID][OY], HouseInfo[hID][OZ], 31, -1);
	GivePlayerMoney(playerid, HouseInfo[hID][Price]/2);
	new string[128];
	format(string, sizeof(string),"Evi {E24234}' $%i '{FFFFFF} karþýlýðýnda sattýnýz!", HouseInfo[hID][Price]/2);
    SendClientMessage(playerid, -1, string);
    KickFromHouse(playerid, hID);
	}
	else
	{
	    Bilgimesaj(playerid, "Bir evin yok.", "Bir evin yok.");
	}
    return 1;
}

CMD:evmenu(playerid,params[])
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	if(pInfo[playerid][CurrentHID] == -1) return HataMesaji(playerid, "Bir evin içinde deðilsin!");
	if(strcmp(name, HouseInfo[pInfo[playerid][CurrentHID]][Owner]) != 0) return HataMesaji(playerid, "Bu evin sahibi deðilsin!");
	new string[256],lockstr[24];
	if (HouseInfo[pInfo[playerid][CurrentHID]][Locked] == 1) {format(lockstr, sizeof(lockstr), "Kilidi Aç");}
	else {format(lockstr, sizeof(lockstr), "Kilitle");}
	format(string, sizeof(string), "{E24234}»{FFFFFF} %s\n{E24234}»{FFFFFF} Ýnterior Seçimi\n{E24234}»{FFFFFF} Para Kasasý\t\t\t%d$\n{E24234}»{FFFFFF} Evimi Sat", lockstr, HouseInfo[pInfo[playerid][CurrentHID]][H_Cash]);
	ShowPlayerDialog(playerid, HMenu, DIALOG_STYLE_LIST, "{FFFFFF}[Z]eroTR {E24234}-{FFFFFF} Ev Menü", string, "Seç", "Iptal");
	return 1;
}
CMD:gohouse(playerid,params[]) return komut_evimegit(playerid, params);
CMD:evimegit(playerid,params[])
{
 	if(PlayerInfo[playerid][evsayisi] != 0)
 	{
	SetPlayerPos(playerid, HouseInfo[PlayerInfo[playerid][evsayisi]][OX], HouseInfo[PlayerInfo[playerid][evsayisi]][OY], HouseInfo[PlayerInfo[playerid][evsayisi]][OZ]);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	}
	else
	{
	    HataMesaji(playerid, "Bir eviniz yok.");
	}
	return 1;
}

CMD:gotohouse(playerid,params[])
{
	if (PlayerInfo[playerid][Level] > 7)
	{
	new hID;
	if(sscanf(params, "i", hID)) return Kullanimmesaj(playerid, "gotohouse [id]", "gotohouse [id]");
	SetPlayerPos(playerid, HouseInfo[hID][OX], HouseInfo[hID][OY], HouseInfo[hID][OZ]);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	}else{YETERSIZSEVIYE2(playerid, 7);}
	return 1;
}

CMD:satinal(playerid,params[])
{
	new id = 0, name[25], count = 0;
	for(new i=1; i<=CreatedHouses; i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 4.0, HouseInfo[i][OX], HouseInfo[i][OY], HouseInfo[i][OZ]))
	    {
	        id = i;
	        break;
	    }
	}
	for(new i=1; i<=CreatedHouses; i++)
	{
	    GetPlayerName(playerid, name, sizeof(name));
	    if(strcmp(name, HouseInfo[i][Owner]) == 0)
	    {
	        count++;
	    }
	}
	if(id == 0) return HataMesaji(playerid, "Bir evin yakýnýnda deðilsiniz!");
	if(count >= 2) return HataMesaji(playerid, "En fazla 2 ev satýn alabilirsiniz!");
	if(HouseInfo[id][Owned] == 1) return HataMesaji(playerid, "Bu evin zaten bir sahibi var.");
	if(GetPlayerMoney(playerid) < HouseInfo[id][Price]) return HataMesaji(playerid, "Bu evi alabilmeniz için yeterli paranýz yok.");
	GetPlayerName(playerid, name, 25);
	HouseInfo[id][Owned] = 1;
	HouseInfo[id][Owner] = name;
	GivePlayerMoney(playerid,-HouseInfo[id][Price]);
	PlayerInfo[playerid][evsayisi] = id;
	new lString[256];
	DestroyDynamicMapIcon(HouseInfo[id][Icon]);
	HouseInfo[id][Icon] = CreateDynamicMapIcon(HouseInfo[id][OX], HouseInfo[id][OY], HouseInfo[id][OZ], 32, -1);
    format(lString, sizeof(lString),"{C3C3C3}Kapý No: {ffffa5}%i\n{C3C3C3}Ev Sahibi: {ffffa5}%s\n{C3C3C3}Ev Durumu: {ffffa5}%s", id, HouseInfo[id][Owner], (HouseInfo[id][Locked] == 1) ? ("Kilitli") : ("Açýk"));
   	UpdateDynamic3DTextLabelText(Text3D:HouseInfo[id][Label], -1, lString);
	format(gQuery, 256, "UPDATE `"Houses_Table"` SET `Owned` = '%i', `Owner` = '%s' WHERE `ID` = '%i'",HouseInfo[id][Owned], HouseInfo[id][Owner], id);
	if(mysql_query(gQuery))
	    Bilgimesaj(playerid, "Evi baþarýyla satýn aldýnýz!", "You bought a new house!");
	else
	    Bilgimesaj(playerid, "Bir hata oluþtu, lütfen 8+ admine danýþýnýz.", "Unknown error! Please contact level8+ admin.");
	PutPlayerInHouse(playerid, id);
	return 1;
}
forward LoadHouses();
public LoadHouses()
{
	for(new i=1; i<=MAX_HOUSES; i++)
	{
	    format(gQuery,256, "SELECT * FROM `"Houses_Table"` WHERE `ID` = '%i'", i);
	    mysql_query(gQuery);
	    mysql_store_result();
	    if(mysql_num_rows() == 0) break;
	    else if(mysql_num_rows() != 0)
	    {
	        mysql_fetch_row_format(gQuery);
	        sscanf(gQuery, "e<p<|>is[25]iiiiiffffffiiiiiii>", HouseInfo[i]);
	        new lString[256];
			switch(HouseInfo[i][Owned])
			{
			    case 0:
			    {
			        format(lString, sizeof(lString), "{C3C3C3}Kapý No: {ffffa5}%i\n{ffffa5}Ev Fiyatý: {ffffa5}%i$\n{C3C3C3}Satýn almak için {ffffa5}/satinal{C3C3C3} yazýn.",i, HouseInfo[i][Price]);
	            	HouseInfo[i][Label] = CreateDynamic3DTextLabel(lString, -1, HouseInfo[i][OX], HouseInfo[i][OY], HouseInfo[i][OZ]+0.5, 20.0);
					HouseInfo[i][Icon] = CreateDynamicMapIcon(HouseInfo[i][OX], HouseInfo[i][OY], HouseInfo[i][OZ], 31, -1);
					HouseInfo[i][EnterPickup] = CreateDynamicPickup(19524, 23, HouseInfo[i][OX], HouseInfo[i][OY], HouseInfo[i][OZ], -1, -1, -1, 20.0);
					HouseInfo[i][ExitPickup] = CreateDynamicPickup(19524, 23, HouseInfo[i][IX], HouseInfo[i][IY], HouseInfo[i][IZ], -1, -1, -1, 20.0);
				}
				case 1:
				{
				    format(lString, sizeof(lString),"{C3C3C3}Kapý No: {C3C3C3}%i\n{C3C3C3}Ev Sahibi: {ffffa5}%s\n{C3C3C3}Ev Durumu: {ffffa5}%s", i, HouseInfo[i][Owner], (HouseInfo[i][Locked] == 1) ? ("Kilitli") : ("Açýk"));
	            	HouseInfo[i][Label] = CreateDynamic3DTextLabel(lString, -1, HouseInfo[i][OX], HouseInfo[i][OY], HouseInfo[i][OZ]+0.5, 20.0);
		 			HouseInfo[i][Icon] = CreateDynamicMapIcon(HouseInfo[i][OX], HouseInfo[i][OY], HouseInfo[i][OZ], 32, -1);
					HouseInfo[i][EnterPickup] = CreateDynamicPickup(19522, 23, HouseInfo[i][OX],HouseInfo[i][OY], HouseInfo[i][OZ], -1, -1, -1, 20.0);
					HouseInfo[i][ExitPickup] = CreateDynamicPickup(19522, 23, HouseInfo[i][IX], HouseInfo[i][IY], HouseInfo[i][IZ], -1, -1, -1, 20.0);
				}
			}
			CreatedHouses++;
		}
	}
	mysql_free_result();
	printf("Number of house: %d", CreatedHouses);
	return 1;
}
 forward SetHouseExit(playerid, houseid);
public SetHouseExit(playerid, houseid)
{
	switch(HouseInfo[houseid][InteriorID])
	{
	    case 1:
	    {
	        HouseInfo[houseid][IX] = 2466.5610;
	        HouseInfo[houseid][IY] = -1698.3323;
	        HouseInfo[houseid][IZ] = 1013.5078;
	        new pickupidd = 0;
	        if (HouseInfo[houseid][Owned] != 1) { pickupidd = 19524;}
	        if (HouseInfo[houseid][Owned] == 1) { pickupidd = 19522;}
	        HouseInfo[houseid][ExitPickup] = CreateDynamicPickup(pickupidd, 23, HouseInfo[houseid][IX], HouseInfo[houseid][IY], HouseInfo[houseid][IZ], -1, -1, -1, 20.0);
	        format(gQuery,sizeof gQuery,"UPDATE `"Houses_Table"` SET `IX` = '%f', `IY` = '%f', `IZ` = '%f' WHERE `ID` = '%i'", HouseInfo[houseid][IX], HouseInfo[houseid][IY], HouseInfo[houseid][IZ], houseid);
	        mysql_query(gQuery);
		}
		case 2:
		{
            HouseInfo[houseid][IX] = 327.9615;
	        HouseInfo[houseid][IY] = 1478.2103;
	        HouseInfo[houseid][IZ] = 1084.4375;
	        new pickupidd = 0;
	        if (HouseInfo[houseid][Owned] != 1) { pickupidd = 19524;}
	        if (HouseInfo[houseid][Owned] == 1) { pickupidd = 19522;}
	        HouseInfo[houseid][ExitPickup] = CreateDynamicPickup(pickupidd, 23, HouseInfo[houseid][IX], HouseInfo[houseid][IY], HouseInfo[houseid][IZ], -1, -1, -1, 20.0);
			format(gQuery, sizeof gQuery,"UPDATE `"Houses_Table"` SET `IX` = '%f', `IY` = '%f', `IZ` = '%f' WHERE `ID` = '%i'", HouseInfo[houseid][IX], HouseInfo[houseid][IY], HouseInfo[houseid][IZ], houseid);
	        mysql_query(gQuery);
		}
		case 3:
		{
            HouseInfo[houseid][IX] = 327.9615;
	        HouseInfo[houseid][IY] = 1478.2103;
	        HouseInfo[houseid][IZ] = 1084.4375;
	        new pickupidd = 0;
	        if (HouseInfo[houseid][Owned] != 1) { pickupidd = 19524;}
	        if (HouseInfo[houseid][Owned] == 1) { pickupidd = 19522;}
	        HouseInfo[houseid][ExitPickup] = CreateDynamicPickup(pickupidd, 23, HouseInfo[houseid][IX], HouseInfo[houseid][IY], HouseInfo[houseid][IZ], -1, -1, -1, 20.0);
			format(gQuery, sizeof gQuery,"UPDATE `"Houses_Table"` SET `IX` = '%f', `IY` = '%f', `IZ` = '%f' WHERE `ID` = '%i'", HouseInfo[houseid][IX], HouseInfo[houseid][IY], HouseInfo[houseid][IZ], houseid);
	        mysql_query(gQuery);
		}
	}
	return 1;
}

forward PutPlayerInHouse(playerid, houseid);
public PutPlayerInHouse(playerid, houseid)
{
	Bilgimesaj(playerid, "Evden çýkmak için /evcik yazýn.", "Evden çýkmak için /evcik yazýn.");
	switch(HouseInfo[houseid][InteriorID])
	{
	    case 1:
	    {
	        SetPlayerInterior(playerid, 5);
	        SetPlayerPos(playerid, 226.7545, 1114.4180, 1080.9952);
	        SetPlayerVirtualWorld(playerid, HouseInfo[houseid][World]);
	        pInfo[playerid][CurrentHID] = houseid;
	    }
	    case 2:
	    {
	        SetPlayerInterior(playerid, 10);
	        SetPlayerPos(playerid, 2269.9636, -1210.3275, 1047.5625);
	        SetPlayerVirtualWorld(playerid, HouseInfo[houseid][World]);
	        pInfo[playerid][CurrentHID] = houseid;
	    }
	    case 3:
	    {
	        SetPlayerInterior(playerid, 10);
	        SetPlayerPos(playerid, 2259.8435, -1136.2699, 1050.6328);
	        SetPlayerVirtualWorld(playerid, HouseInfo[houseid][World]);
	        pInfo[playerid][CurrentHID] = houseid;
	    }
	}
	return 1;
}

forward KickFromHouse(playerid, houseid);
public KickFromHouse(playerid, houseid)
{
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid, HouseInfo[houseid][OX]+1.5, HouseInfo[houseid][OY]+1.5, HouseInfo[houseid][OZ]);
	SetPlayerVirtualWorld(playerid, 0);
	pInfo[playerid][CurrentHID] = -1;
	return 1;
}
