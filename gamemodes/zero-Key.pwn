#include <a_samp>
#include <YSI\y_hooks>
new
	bool: balanceBasladi,
	bool: balance[MAX_PLAYERS],
	bool: balanceKatilim,
	balanceSayi,
	balanceSira,
	isvec,
 	balanceDurum,
	balanceKutu,
	balanceCar[4],
	efstring[256]
;

hook OnFilterScriptInit()
{
	balanceKutu = CreateObject(18843, -3527.87695, 1741.45020, 37.45420,   90.00000, 0.00000, 0.00000);
	balanceCar[0] = CreateVehicle(468, -3525.0649, 1734.1338, 88.0649, 0.0000, -1, -1, 100);
	balanceCar[1] = CreateVehicle(468, -3522.9695, 1735.0181, 88.0649, 0.0000, -1, -1, 100);
	balanceCar[2] = CreateVehicle(468, -3527.9534, 1735.7932, 88.0649, 0.0000, -1, -1, 100);
	balanceCar[3] = CreateVehicle(468, -3526.0571, 1738.9833, 88.0649, 0.0000, -1, -1, 100);
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(balance[playerid] == true)
	{
	    new oyuncuad[24], string[256];
	    GetPlayerName(playerid, oyuncuad, sizeof(oyuncuad));
	    format(string, sizeof(string), "{C0C0C0}» Oyuncu {FFFFFF}%s{C0C0C0} balance'den elendi. Sebep: {FFFFFF}Oyundan Çikti{C0C0C0}(0xFFFF)", oyuncuad);
	}
	new balancePlayer;
	for(new x; x < MAX_PLAYERS; x++)
	{
	    if(IsPlayerConnected(x))
	    {
			if(balance[x] == true)
			{
				balancePlayer ++;
			}
		}
	}
	if(balancePlayer == 1 && balanceKatilim == false && balanceBasladi == true)
	{
		for(new x; x < MAX_PLAYERS; x++)
		{
		    if(IsPlayerConnected(x))
		    {
			    new string[256], oyuncuad[24];
				if(balance[x] == true)
				{
					balanceKatilim = false;
					balanceBasladi = false;
					balance[x] = false;
				    GetPlayerName(x, oyuncuad, sizeof(oyuncuad));
				    format(string, sizeof(string), "~g~~h~[Balance]~w~~h~~h~~h~ Oyuncu ~r~~h~%s~w~~h~~h~~h~ balanceyi kazandi. Odul: ~r~10~w~~h~~h~~h~ Skor ~r~15.000$~w~~h~~h~~h~", oyuncuad);
					GivePlayerMoney(x, 15000);
					SetPlayerScore(x, GetPlayerScore(x)+10);
					balanceSira = 0;
					SpawnPlayer(playerid);
					TextMesaj(string, string);
				}
//				SendClientMessage(x, -1, string);
			}
		}
	}
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	if(balance[playerid] == true)
	{
	    new oyuncuad[24], string[256];
	    GetPlayerName(playerid, oyuncuad, sizeof(oyuncuad));
	    format(string, sizeof(string), "{C0C0C0}» Oyuncu {FFFFFF}%s{C0C0C0} balance'den elendi. Sebep: {FFFFFF}Düþtü{C0C0C0}(0xFFFF)", oyuncuad);
		foreach(new i : Player)
		{
		    if(balance[i] == true)
		    {
		        SendClientMessage(i, -1, string);
		    }
		}
		balance[playerid] = false;
	}
	new balancePlayer;
	for(new x; x < MAX_PLAYERS; x++)
	{
	    if(IsPlayerConnected(x))
	    {
			if(balance[x] == true)
			{
				balancePlayer ++;
			}
		}
	}
	if(balancePlayer == 1 && balanceKatilim == false && balanceBasladi == true)
	{
		for(new x; x < MAX_PLAYERS; x++)
		{
		    if(IsPlayerConnected(x))
		    {
			    new string[256], oyuncuad[24];
				if(balance[x] == true)
				{
					balanceKatilim = false;
					balanceBasladi = false;
					balance[x] = false;
				    GetPlayerName(x, oyuncuad, sizeof(oyuncuad));
				    format(string, sizeof(string), "~g~~h~[Balance]~w~~h~~h~~h~ Oyuncu ~r~~h~%s~w~~h~~h~~h~ balanceyi kazandi. Odul: ~r~10~w~~h~~h~~h~ Skor ~r~15.000$~w~~h~~h~~h~", oyuncuad);
					TextMesaj(string, string);
					GivePlayerMoney(x, 15000);
					SetPlayerScore(x, GetPlayerScore(x)+10);
					balanceSira = 0;
				}
//				SendClientMessage(x, -1, string);
			}
		}
	}
	return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    balance[playerid] = false;
	if(balance[playerid] == true)
	{
	    new oyuncuad[24], string[256];
	    GetPlayerName(playerid, oyuncuad, sizeof(oyuncuad));
	    format(string, sizeof(string), "{C0C0C0}» Oyuncu {FFFFFF}%s{C0C0C0} balance'den elendi. Sebep: {FFFFFF}Öldü{C0C0C0}(0xFFFF)", oyuncuad);
	}
	new balancePlayer;
	for(new x; x < MAX_PLAYERS; x++)
	{
	    if(IsPlayerConnected(x))
	    {
			if(balance[x] == true)
			{
				balancePlayer ++;
			}
		}
	}
	if(balancePlayer == 1 && balanceKatilim == false && balanceBasladi == true)
	{
		for(new x; x < MAX_PLAYERS; x++)
		{
		    if(IsPlayerConnected(x))
		    {
			    new string[256], oyuncuad[24];
				if(balance[x] == true)
				{
					balanceKatilim = false;
					balanceBasladi = false;
					balance[x] = false;
				    GetPlayerName(x, oyuncuad, sizeof(oyuncuad));
				    format(string, sizeof(string), "~g~~h~[Balance]~w~~h~~h~~h~ Oyuncu ~r~~h~%s~w~~h~~h~~h~ balanceyi kazandi. Odul: ~r~10~w~~h~~h~~h~ Skor ~r~15.000$~w~~h~~h~~h~", oyuncuad);
					TextMesaj(string, string);
					GivePlayerMoney(x, 15000);
					SetPlayerScore(x, GetPlayerScore(x)+10);
					balanceSira = 0;
				}
//				SendClientMessage(x, -1, string);
			}
		}
	}
	return 1;
}


CMD:balance(playerid, params[])
{
	    if(!spamProtect(playerid, "balanceSpammer", 10)) return Hatamesaj(playerid, "Balanceye limitinden fazla baglanti istegi gonderemessiniz. Lutfen gondermeden biraz bekleyin.", "Please wait.");
		if(balanceBasladi == true && balanceKatilim == false) return SendClientMessage(playerid, -1, "{E24234}<(Bilgi)>{FFFFFF} Balance baslamis ve katilimlar sona ermis.");
		if(balanceBasladi == true)
		{
			new balancePlayer;
			for(new x; x < MAX_PLAYERS; x++)
			{
			    if(IsPlayerConnected(x))
			    {
					if(balance[x] == true)
					{
					    balancePlayer ++;
					}
			    }
			}
			// hesap
			if(balanceSira > 4) return Hatamesaj(playerid, "Balance maksimum oyuncuya ulasti!","Balance is full."), 1;
		 	CloseselectioanMenu(playerid);
			CancelSelectTextDraw(playerid);
			SetPVarInt(playerid, "vspawner_active", 0);
		    SetPlayerInterior(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 0);
		    balanceKatil(playerid);
		    SetPlayerInterior(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 0);
		    balance[playerid] = true;
		}
		else
		{
		    ShowPlayerDialog(playerid, 4451, DIALOG_STYLE_LIST, "{C04044}[Z]ero{FFFFFF} - Balance", "{FFFFFF}Cam Festivali\n{FFFFFF}Su Akýntýsý", "Tamam", "Ýptal");
		}
	    return 1;
	}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
 	CloseselectioanMenu(playerid);
	CancelSelectTextDraw(playerid);
	SetPVarInt(playerid, "vspawner_active", 0);
	if(dialogid == 4451)
	{
	    if(response)
	    {
	        if(balanceBasladi == true) return HataMesaji(playerid, "Balance baþlamýþ! Geciktiniz");
	        if(balanceKatilim == true) return HataMesaji(playerid, "Balance katýlýmlarý baþlamýþ bile! Geciktiniz");
	        if(balance[playerid] == true) return HataMesaji(playerid, "Zaten balancedesiniz!");
	        if(listitem == 0)
	        {
				DestroyVehicle(balanceCar[0]);
				DestroyVehicle(balanceCar[1]);
				DestroyVehicle(balanceCar[2]);
				DestroyVehicle(balanceCar[3]);
				balanceCar[0] = CreateVehicle(468, -3525.0649, 1734.1338, 88.0649, 0.0000, -1, -1, 100);
				balanceCar[1] = CreateVehicle(468, -3522.9695, 1735.0181, 88.0649, 0.0000, -1, -1, 100);
				balanceCar[2] = CreateVehicle(468, -3527.9534, 1735.7932, 88.0649, 0.0000, -1, -1, 100);
				balanceCar[3] = CreateVehicle(468, -3526.0571, 1738.9833, 88.0649, 0.0000, -1, -1, 100);
				DestroyObject(balanceKutu);
				balanceKutu = CreateObject(18843, -3527.87695, 1741.45020, 37.45420,   90.00000, 0.00000, 0.00000);

			    SetPlayerInterior(playerid, 0);
			    SetPlayerVirtualWorld(playerid, 0);
			    balanceSira = 0;
				format(efstring, sizeof(efstring), "~g~~h~[Balance]~w~~h~~h~~h~ Oyuncu ~r~%s~w~~h~~h~~h~,~b~~h~ Cam Festivali,~w~~h~~h~~h~ isimli balanceyi baslatti. Katilmak icin ~y~/balance~w~~h~~h~~h~ kullanin.", getName(playerid));
				TextMesaj(efstring, efstring);
				balanceBasladi = true;
			    balanceKatilim = true;
			    balanceKatil(playerid);
			    isvec = SetTimer("balanceSay", 1000, true);
			    SetTimer("balanceKontrol", 200, true);
			    balanceSayi = 30;
			}
			else
			{
				DestroyVehicle(balanceCar[0]);
				DestroyVehicle(balanceCar[1]);
				DestroyVehicle(balanceCar[2]);
				DestroyVehicle(balanceCar[3]);
				balanceCar[0] = CreateVehicle(468, -3525.0649, 1734.1338, 88.0649, 0.0000, -1, -1, 100);
				balanceCar[1] = CreateVehicle(468, -3522.9695, 1735.0181, 88.0649, 0.0000, -1, -1, 100);
				balanceCar[2] = CreateVehicle(468, -3527.9534, 1735.7932, 88.0649, 0.0000, -1, -1, 100);
				balanceCar[3] = CreateVehicle(468, -3526.0571, 1738.9833, 88.0649, 0.0000, -1, -1, 100);
				DestroyObject(balanceKutu);
				balanceKutu = CreateObject(18844, -3527.87695, 1741.45020, 37.45420,   90.00000, 0.00000, 0.00000);

			    SetPlayerInterior(playerid, 0);
			    SetPlayerVirtualWorld(playerid, 0);
			    balanceSira = 0;
				format(efstring, sizeof(efstring), "~g~~h~[Balance]~w~~h~~h~~h~ Oyuncu ~r~%s~w~~h~~h~~h~,~b~~h~ Su Akintisi,~w~~h~~h~~h~ isimli balanceyi baslatti. Katilmak icin ~y~/balance~w~~h~~h~~h~ kullanin.", getName(playerid));
				TextMesaj(efstring, efstring);
				balanceBasladi = true;
			    balanceKatilim = true;
			    balanceKatil(playerid);
			    isvec = SetTimer("balanceSay", 1000, true);
			    SetTimer("balanceKontrol", 200, true);
			    balanceSayi = 30;
			}
	    }
	}
	return 1;
}

forward balanceKontrol();
public balanceKontrol()
{
	new balancePlayer;
	for(new x; x < MAX_PLAYERS; x++)
	{
	    if(IsPlayerConnected(x))
	    {
			if(balance[x] == true)
			{
			    balancePlayer ++;
				new Float:X, Float:Y, Float:Z, string[256], oyuncuad[24];
				GetPlayerPos(x, X, Y, Z);
				if(Z < 33)
				{
				    GetPlayerName(x, oyuncuad, sizeof(oyuncuad));
				    format(string, sizeof(string), "{C0C0C0}» Oyuncu {FFFFFF}%s{C0C0C0} balance'den elendi. Sebep: {FFFFFF}Düstü{C0C0C0}(0xFFFF)", oyuncuad);
				    SpawnPlayer(x);
				    balance[x] = false;
				}
				if(strlen(string)) SendClientMessage(x, -1, string);
			}
		}
	}
	if(balancePlayer == 1 && balanceKatilim == false && balanceBasladi == true)
	{
		for(new ax; ax < MAX_PLAYERS; ax++)
		{
		    if(IsPlayerConnected(ax))
		    {
			    new stringg[256], oyuncuadd[24];
				if(balance[ax] == true)
				{
					balanceKatilim = false;
					balanceBasladi = false;
					balance[ax] = false;
				    GetPlayerName(ax, oyuncuadd, sizeof(oyuncuadd));
				    format(stringg, sizeof(stringg), "~g~~h~[Balance]~w~~h~~h~~h~ Oyuncu ~r~~h~%s~w~~h~~h~~h~ balanceyi kazandi. Odul: ~r~10~w~~h~~h~~h~ Skor ~r~15.000$~w~~h~~h~~h~", oyuncuadd);
					TextMesaj(stringg, stringg);
					GivePlayerMoney(ax, 15000);
					SetPlayerScore(ax, GetPlayerScore(ax)+10);
					balanceSira = 0;
				}
			}
		}
	}
	return 1;
}hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if(balance[playerid] == true)
	{
	    new oyuncuad[24], string[256];
	    GetPlayerName(playerid, oyuncuad, sizeof(oyuncuad));
	    format(string, sizeof(string), "{C0C0C0}» Oyuncu {FFFFFF}%s{C0C0C0} balance'den elendi. Sebep: {FFFFFF}Araçtan Indi{C0C0C0}(0xFFFF)", oyuncuad);
	}
	new balancePlayer;
	for(new x; x < MAX_PLAYERS; x++)
	{
	    if(IsPlayerConnected(x))
	    {
			if(balance[x] == true)
			{
				balancePlayer ++;
			}
		}
	}
	if(balancePlayer == 1 && balanceKatilim == false && balanceBasladi == true)
	{
		for(new x; x < MAX_PLAYERS; x++)
		{
		    if(IsPlayerConnected(x))
		    {
			    new string[256], oyuncuad[24];
				if(balance[x] == true)
				{
					balanceKatilim = false;
					balanceBasladi = false;
					balance[x] = false;
				    GetPlayerName(x, oyuncuad, sizeof(oyuncuad));
				    format(string, sizeof(string), "~g~~h~[Balance]~w~~h~~h~~h~ Oyuncu ~r~~h~%s~w~~h~~h~~h~ balanceyi kazandi. Odul: ~r~10~w~~h~~h~~h~ Skor ~r~15.000$", oyuncuad);
					TextMesaj(string, string);
					GivePlayerMoney(x, 15000);
					SetPlayerScore(x, GetPlayerScore(x)+10);
					balanceSira = 0;
				}
//				SendClientMessage(x, -1, string);
			}
		}
	}

	return 1;
}
forward balanceSay();
public balanceSay()
{
	if(balanceSayi > 0)
	{
	    balanceSayi --;
		for(new x; x < MAX_PLAYERS; x++)
		{
		    if(IsPlayerConnected(x))
		    {
				if(balance[x] == true)
				{
					new string[60];
					format(string, sizeof(string), "~y~Balance started in~n~~y~-~w~~h~~h~~h~ %i ~y~-~n~seconds", balanceSayi);
					GameTextForPlayer(x, string, 2700, 3);
				}
		    }
		}
	}
	else
	{
		new
			oyuncuSayisi;
		for(new x; x < MAX_PLAYERS; x++)
		{
		    if(IsPlayerConnected(x))
		    {
				if(balance[x] == true)
				{
				    TogglePlayerControllable(x, 1);
				    oyuncuSayisi++;
				}
		    }
		}
		if(oyuncuSayisi == 0 || oyuncuSayisi == 1)
		{
			DestroyVehicle(balanceCar[0]);
			DestroyVehicle(balanceCar[1]);
			DestroyVehicle(balanceCar[2]);
			DestroyVehicle(balanceCar[3]);
			balanceCar[0] = CreateVehicle(468, -3525.0649, 1734.1338, 88.0649, 0.0000, -1, -1, 100);
			balanceCar[1] = CreateVehicle(468, -3522.9695, 1735.0181, 88.0649, 0.0000, -1, -1, 100);
			balanceCar[2] = CreateVehicle(468, -3527.9534, 1735.7932, 88.0649, 0.0000, -1, -1, 100);
			balanceCar[3] = CreateVehicle(468, -3526.0571, 1738.9833, 88.0649, 0.0000, -1, -1, 100);
			foreach(new i : Player)
			{
			    if(balance[i] == true)
			    {
			        SetPlayerHealth(i, -1);
			    }
			}
			KillTimer(isvec), balanceSira = 0, balanceBasladi = false, balanceKatilim = false, StopObject(balanceKutu), TextMesaj("~g~~h~[Balance]~w~~h~~h~~h~ Sistem tarafindan durduruldu.", "~g~~h~[Balance]~w~~h~~h~~h~ Sistem tarafindan durduruldu.");
		}
		else
		{
		balanceBaslat();
		balanceBasladi = true;
		balanceKatilim = false;
		TextMesaj("~g~~h~[Balance]~w~~h~~h~~h~ Balance'ye katilimlar durdu", "~g~~h~[Balance]~w~~h~~h~~h~ Balance'ye katilimlar durdu.");
	    KillTimer(isvec);
        balanceSira = 0;
		}
	}
	return 1;
}
stock balanceKatil(playerid)
{
	PutPlayerInVehicle(playerid, balanceCar[balanceSira], 0);
	balanceSira ++;
	balance[playerid] = true;
	TogglePlayerControllable(playerid, 0);
	return 1;
}
stock balanceBaslat()
{
 	MoveObject(balanceKutu, -3527.87695, 1741.45020, 38.45420, 0.5, 57.4974, 30.750000, 1.00000);
 	balanceDurum = 1;
 	return 1;
}

hook OnObjectMoved(objectid)
{
	if(objectid == balanceKutu && balanceDurum == 1)
	{
	    balanceDurum = 2;
 		MoveObject(balanceKutu, -3527.87695, 1741.45020, 36.45420, 0.5, -57.4974, -30.750000, 2.00000);
	}
	else if(objectid == balanceKutu && balanceDurum == 2)
	{
	    balanceDurum = 1;
 		MoveObject(balanceKutu, -3527.87695, 1741.45020, 39.45420, 0.5, 57.4974, 35.750000, 3.00000);
	}
	return 1;
}

function ivirzivirGuncelle(i)
{
	SetPVarInt(i, "ALT_TABBED", 0);
	if (Radar_GetVehicleSpeed(GetPlayerVehicleID(i)) >= 1000)
	{
	    Kickle(i, "Hiz Hilesi");
	}
	#if defined RACEPASIF
	if(Joined[i] == false)
	{
	    TextDrawHideForPlayer(i, TopRace0);
	    TextDrawHideForPlayer(i, TopRace1);
	    TextDrawHideForPlayer(i, TopRace2);
	    TextDrawHideForPlayer(i, TopRace3);
	    TextDrawHideForPlayer(i, TopRace4);
	    TextDrawHideForPlayer(i, TopRace5);
	    TextDrawHideForPlayer(i, TopRace6);
	    TextDrawHideForPlayer(i, TopRace7);
		TextDrawDestroy(RaceRez0[i]);
		TextDrawHideForPlayer(i, RaceRez0[i]);
		TextDrawHideForPlayer(i, RaceRez1[i]);
		TextDrawHideForPlayer(i, RaceRez2[i]);
		TextDrawHideForPlayer(i, RaceRez3[i]);
		TextDrawHideForPlayer(i, RaceRez4[i]);
		TextDrawHideForPlayer(i, RaceRez5[i]);
		TextDrawHideForPlayer(i, RaceRez6[i]);
		TextDrawHideForPlayer(i, RaceRez7[i]);
		TextDrawHideForPlayer(i, RaceRez8[i]);
	}
	#endif
	if(GetPlayerVehicleSeat(i) >= 5 && GetVehicleModel(GetPlayerVehicleID(i)) != 431  && GetVehicleModel(GetPlayerVehicleID(i)) != 437) return Kickle(i, "Koltuk Hilesi");
	if(PlayerInfo[i][money] != GetPlayerMoney_C(i)) ResetPlayerMoney_C(i), GivePlayerMoney_C(i, PlayerInfo[i][money]);
	    //TextDrawSetPreviewModel(modelTD[i], GetVehicleModel(GetPlayerVehicleID(i)));
	AFK[i] = 0;
    CheckAFK();
	new gecerlisilah = GetPlayerWeapon(i);
	if(gecerlisilah != GetPVarInt(i, "OyuncuGecerliSilah"))
	{
		OyuncuSilahDegistirdi(i, GetPVarInt(i, "OyuncuGecerliSilah"), gecerlisilah);
 		SetPVarInt(i, "OyuncuGecerliSilah", gecerlisilah);
	}

	new Float:x, Float:y, Float:z;
	#if defined RACEPASIF
	GetPlayerPos(i, x, y, z);
	if(y > 7000.0 || x > 7000.0 && Joined[i] == false) return Kickle(i, "On Foot Crasher");
	#endif
	if(!IsPlayerInAnyVehicle(i))
	{
	    if(FP_GetPlsayerSpeed(i) >= 500) return Kickle(i, "Surfing Hack");
	}
	GetPlayerPos(i, x, y, z);
	new vara = GetPlayerAnimationIndex (i);
	if (z > 12.0 && (vara == 1543 || vara == 1538 || vara == 1539))
	{
        if(GetPVarInt(i, "Uyasri") == 0 || GetPVarInt(i, "Uyasri") == 1 || GetPVarInt(i, "Uyasri") == 2)
		{
			SetPVarInt(i, "Uyasri", GetPVarInt(i, "Uyasri")+1);
			if(GetPVarInt(i, "suphe") == 5) SetPVarInt(i, "suphe", 6);
			else SetPVarInt(i, "suphe", 4);
		}
		else if(GetPVarInt(i, "Uyasri") == 3 && PlayerInfo[i][Level]==0) Kickle(i, "FLY Hack");
	}
	//new Float:x, Float:y, Float:z;

	if(PlayerInfo[i][muted] == 1 && PlayerInfo[i][mutedtime] == 0)
	{
		PlayerInfo[i][muted] = 0;
		Bilgimesaj(i, "Mute cezanizin suresi doldu, iyi oyunlar!", "You unmuted by server, good games!");
	}
	if(PlayerInfo[i][mutedtime] == 0) PlayerInfo[i][muted] = 0;
	if(PlayerInfo[i][Jailed] == 1 && PlayerInfo[i][JailTime] == 0)
	{
	    SpawnPlayer(i);
		PlayerInfo[i][Jailed] = 0;
		Bilgimesaj(i, "Hapisden sureniz doldugu icin cikarildiniz.", "You released, good games!");
	}
	if(PlayerInfo[i][JailTime] == 0) PlayerInfo[i][Jailed] = 0;
	new Float:Pos[3];
	GetPlayerPos(i, Pos[0], Pos[1], Pos[2]);
	if(Pos[2] < 0.08)
	{
	    SetPVarInt(i, "DenizSeviyesinde", 1);
	}
	else
	{
	    SetPVarInt(i, "DenizSeviyesinde", 0);
	}
	new string[256];
	format(string, sizeof(string), "_", PlayerInfo[i][Deaths], PlayerInfo[i][Kills], GetPlayerScore(i), Float:PlayerInfo[i][Kills]/Float:PlayerInfo[i][Deaths]);
	TextDrawSetString(Badana6[i], string);
	if(PlayerInfo[i][Jailed] == 1 && PlayerInfo[i][JailTime] > 0)
	{
	    PlayerInfo[i][JailTime] --;
	}
	if(PlayerInfo[i][muted] == 1 && PlayerInfo[i][mutedtime] > 0)
	{
	    PlayerInfo[i][mutedtime] --;
	}
	new playerid = i, Float:can, Float:zirh,rutbe[24];
	GetPlayerHealth(playerid, can);
	GetPlayerArmour(playerid, zirh);
	if (GetPlayerScore(playerid) < 500)
	{
		format(rutbe, 24, "Newbie");
	}
	if (GetPlayerScore(playerid) > 500)
	{
		format(rutbe, 24, "J.Newbie");
	}
	if (GetPlayerScore(playerid) > 1500)
	{
		format(rutbe, 24, "SemiPro");
	}
	if (GetPlayerScore(playerid) > 2500)
	{
		format(rutbe, 24, "Pro");
	}
	if (GetPlayerScore(playerid) > 5000)
	{
		format(rutbe, 24, "Veteran");
	}
	if (GetPlayerScore(playerid) > 5000)
	{
		format(rutbe, 24, "Prestige");
	}
	format(string, sizeof(string), "~w~~h~~h~~h~Kills:~b~~h~ %d~w~~h~~h~~h~ - Deaths:~b~~h~ %d~w~~h~~h~~h~ - Rutbe: ~r~~h~%s", PlayerInfo[playerid][Kills], PlayerInfo[playerid][Deaths], rutbe);
	PlayerTextDrawSetString(playerid, Textdraw[playerid][3], string);
	new getfps = GetPlayerFPS(playerid);
	if (GetPlayerFPS(playerid) == 0)
	{
	    getfps = GetPVarInt(playerid, "oldFPS");
	}
	else
	{
	    SetPVarInt(playerid, "oldFPS", GetPlayerFPS(playerid));
	    getfps = GetPlayerFPS(playerid);
	}
	format(string, sizeof(string), "~w~~h~~h~~h~FPS: ~b~~h~%d~w~~h~~h~~h~ - Can:~r~~h~ %0.1f~w~~h~~h~~h~ - Zirh: ~b~~h~%0.1f", getfps, can, zirh);
	PlayerTextDrawSetString(playerid, Textdraw[playerid][4], string);
	PlayerInfo[playerid][onlinet] ++;
	return 1;
}

