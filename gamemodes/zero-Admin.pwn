stock GetWeaponIDFromName( WeaponName[ ] )
{
	if ( strfind( "molotov", WeaponName, true ) != -1 ) return 18;
	for ( new i = 0; i <= 46; i++ )
	{
		switch( i )
		{
			case 0,19,20,21,44,45: continue;
			default:
			{
				new name[ 32 ];
				GetWeaponName( i, name, 32 );
				if ( strfind( name, WeaponName, true ) != -1 ) return i;
			}
		}
	}
	return -1;
}stock IsValidWeapon( weaponid )
{
    if ( weaponid > 0 && weaponid < 19 || weaponid > 21 && weaponid < 47 )
		return ( 1 );

	return ( 0 );
}new vNames[ 212 ][ ] =
{
	{"Landstalker"},
	{"Bravura"},
	{"Buffalo"},
	{"Linerunner"},
	{"Perrenial"},
	{"Sentinel"},
	{"Dumper"},
	{"Firetruck"},
	{"Trashmaster"},
	{"Stretch"},
	{"Manana"},
	{"Infernus"},
	{"Voodoo"},
	{"Pony"},
	{"Mule"},
	{"Cheetah"},
	{"Ambulance"},
	{"Leviathan"},
	{"Moonbeam"},
	{"Esperanto"},
	{"Taxi"},
	{"Washington"},
	{"Bobcat"},
	{"Mr Whoopee"},
	{"BF Injection"},
	{"Hunter"},
	{"Premier"},
	{"Enforcer"},
	{"Securicar"},
	{"Banshee"},
	{"Predator"},
	{"Bus"},
	{"Rhino"},
	{"Barracks"},
	{"Hotknife"},
	{"Trailer 1"},
	{"Previon"},
	{"Coach"},
	{"Cabbie"},
	{"Stallion"},
	{"Rumpo"},
	{"RC Bandit"},
	{"Romero"},
	{"Packer"},
	{"Monster"},
	{"Admiral"},
	{"Squalo"},
	{"Seasparrow"},
	{"Pizzaboy"},
	{"Tram"},
	{"Trailer 2"},
	{"Turismo"},
	{"Speeder"},
	{"Reefer"},
	{"Tropic"},
	{"Flatbed"},
	{"Yankee"},
	{"Caddy"},
	{"Solair"},
	{"Berkley's RC Van"},
	{"Skimmer"},
	{"PCJ-600"},
	{"Faggio"},
	{"Freeway"},
	{"RC Baron"},
	{"RC Raider"},
	{"Glendale"},
	{"Oceanic"},
	{"Sanchez"},
	{"Sparrow"},
	{"Patriot"},
	{"Quad"},
	{"Coastguard"},
	{"Dinghy"},
	{"Hermes"},
	{"Sabre"},
	{"Rustler"},
	{"ZR-350"},
	{"Walton"},
	{"Regina"},
	{"Comet"},
	{"BMX"},
	{"Burrito"},
	{"Camper"},
	{"Marquis"},
	{"Baggage"},
	{"Dozer"},
	{"Maverick"},
	{"News Chopper"},
	{"Rancher"},
	{"FBI Rancher"},
	{"Virgo"},
	{"Greenwood"},
	{"Jetmax"},
	{"Hotring"},
	{"Sandking"},
	{"Blista Compact"},
	{"Police Maverick"},
	{"Boxville"},
	{"Benson"},
	{"Mesa"},
	{"RC Goblin"},
	{"Hotring Racer A"},
	{"Hotring Racer B"},
	{"Bloodring Banger"},
	{"Rancher"},
	{"Super GT"},
	{"Elegant"},
	{"Journey"},
	{"Bike"},
	{"Mountain Bike"},
	{"Beagle"},
	{"Cropdust"},
	{"Stunt"},
	{"Tanker"},
	{"Roadtrain"},
	{"Nebula"},
	{"Majestic"},
	{"Buccaneer"},
	{"Shamal"},
	{"Hydra"},
	{"FCR-900"},
	{"NRG-500"},
	{"HPV1000"},
	{"Cement Truck"},
	{"Tow Truck"},
	{"Fortune"},
	{"Cadrona"},
	{"FBI Truck"},
	{"Willard"},
	{"Forklift"},
	{"Tractor"},
	{"Combine"},
	{"Feltzer"},
	{"Remington"},
	{"Slamvan"},
	{"Blade"},
	{"Freight"},
	{"Streak"},
	{"Vortex"},
	{"Vincent"},
	{"Bullet"},
	{"Clover"},
	{"Sadler"},
	{"Firetruck LA"},
	{"Hustler"},
	{"Intruder"},
	{"Primo"},
	{"Cargobob"},
	{"Tampa"},
	{"Sunrise"},
	{"Merit"},
	{"Utility"},
	{"Nevada"},
	{"Yosemite"},
	{"Windsor"},
	{"Monster A"},
	{"Monster B"},
	{"Uranus"},
	{"Jester"},
	{"Sultan"},
	{"Stratum"},
	{"Elegy"},
	{"Raindance"},
	{"RC Tiger"},
	{"Flash"},
	{"Tahoma"},
	{"Savanna"},
	{"Bandito"},
	{"Freight Flat"},
	{"Streak Carriage"},
	{"Kart"},
	{"Mower"},
	{"Duneride"},
	{"Sweeper"},
	{"Broadway"},
	{"Tornado"},
	{"AT-400"},
	{"DFT-30"},
	{"Huntley"},
	{"Stafford"},
	{"BF-400"},
	{"Newsvan"},
	{"Tug"},
	{"Trailer 3"},
	{"Emperor"},
	{"Wayfarer"},
	{"Euros"},
	{"Hotdog"},
	{"Club"},
	{"Freight Carriage"},
	{"Trailer 3"},
	{"Andromada"},
	{"Dodo"},
	{"RC Cam"},
	{"Launch"},
	{"Police Car (LSPD)"},
	{"Police Car (SFPD)"},
	{"Police Car (LVPD)"},
	{"Police Ranger"},
	{"Picador"},
	{"S.W.A.T. Van"},
	{"Alpha"},
	{"Phoenix"},
	{"Glendale"},
	{"Sadler"},
	{"Luggage Trailer A"},
	{"Luggage Trailer B"},
	{"Stair Trailer"},
	{"Boxville"},
	{"Farm Plow"},
	{"Utility Trailer"}
};
stock GetVehicleModelIDFromName( vname[ ] )
{
	for ( new i = 0; i < 211; i++ )
		if ( strfind( vNames[ i ], vname, true ) != -1 )
			return i + 400;

	return -1;
}
new CarName[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
	"Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
	"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BFInjection",
	"Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
	"Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
	"Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
	"Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
	"Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "BerkleysRCVan",
	"Skimmer", "PCJ-600", "Faggio", "Freeway", "RCBaron", "RCRaider", "Glendale",
	"Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
	"Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
	"Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "NewsChopper",
	"Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
	"BlistaCompact", "PoliceMaverick", "Boxvillde", "Benson", "Mesa", "RCGoblin",
	"HotringRacerA", "HotringRacerB", "BloodringBanger", "Rancher", "SuperGT",
	"Elegant", "Journey", "Bike", "MountainBike", "Beagle", "Cropduster", "Stunt",
 	"Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
 	"FCR-900", "NRG-500", "HPV1000", "CementTruck", "TowTruck", "Fortune",
 	"Cadrona", "FBITruck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
 	"Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
    "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
	"Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
	"Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
	"Elegy", "Raindance", "RCTiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "FreightFlat", "StreakCarriage", "Kart", "Mower", "Dune", "Sweeper",
	"Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
	"News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
	"FreightBox", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD",
 	"SFPD", "LVPD", "PoliceRanger", "Picador", "S.W.A.T", "Alpha",
 	"Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
 	"Tiller", "UtilityTrailer"
};
stock weaponNames( weaponid )
{
	new
		str[ 25 ]
	;
	switch( weaponid )
	{
     	case 0: str = "Fist";
		case 1:	str = "Brass Knuckles";
		case 2: str = "Golf Club";
		case 3: str = "Night Stick";
		case 4: str = "Knife";
		case 5: str = "Baseball Bat";
		case 6: str = "Shovel";
		case 7: str = "Pool Cue";
		case 8: str = "Katana";
		case 9: str = "Chainsaw";
		case 10: str = "Purple Dildo";
		case 11: str = "Vibrator";
		case 12: str = "Vibrator";
		case 13: str = "Vibrator";
		case 14: str = "Flowers";
		case 15: str = "Cane";
		case 16: str = "Grenade";
		case 17: str = "Teargas";
		case 18: str = "Molotov";
		case 19: str = " ";
		case 20: str = " ";
		case 21: str = " ";
		case 22: str = "Colt 45";
		case 23: str = "Silenced Pistol";
		case 24: str = "Deagle";
		case 25: str = "Shotgun";
		case 26: str = "Sawns";
		case 27: str = "Spas";
		case 28: str = "Uzi";
		case 29: str = "MP5";
		case 30: str = "AK47";
		case 31: str = "M4";
		case 32: str = "Tec9";
		case 33: str = "County Rifle";
		case 34: str = "Sniper Rifle";
		case 35: str = "Rocket Launcher";
		case 36: str = "Heat-Seeker";
		case 37: str = "Flamethrower";
		case 38: str = "Minigun";
		case 39: str = "Satchel Charge";
		case 40: str = "Detonator";
		case 41: str = "Spray Can";
		case 42: str = "Fire Extinguisher";
		case 43: str = "Camera";
		case 44: str = "Night Vision Goggles";
		case 45: str = "Infrared Goggles";
		case 46: str = "Parachute";
		case 47: str = "Fake Pistol";
		case 48: str = "None"; //For duel msgs
	}
	return str;
}
CMD:adminlistesi(playerid, params[])
{
    new clanname[MAX_PLAYER_NAME], string[256],stringe[98192], clankills,savingstring[256],stringea[128],stringet[98192],laston[1024];
    mysql_query("SELECT `kullaniciadi`, `Level`,`LastOn` FROM `oyuncular` ORDER BY `Level` DESC LIMIT 50");
    mysql_store_result();
    while(mysql_retrieve_row())
    {
        mysql_fetch_field_row(savingstring, "LastOn"); format(laston,30,"%s",savingstring);
        mysql_fetch_field_row(savingstring, "kullaniciadi"); format(clanname,24,"%s",savingstring);
        mysql_fetch_field_row(savingstring, "Level"); clankills = strval(savingstring);
        format(string, sizeof(string), "{FFFFFF}%d\t\t\t{00FF00}%s\t\t{FFFFFF}%s\n",clankills,laston, clanname);
        if(clankills > 0){
        strcat(stringe,string,10000);
        }
    }
    mysql_free_result();
    format(stringea, sizeof(stringea),"{FFFF00}Level\t\t\t{FFFF00}{FFFF00}Oyuna Son Giriþ Tarihi\tNick\n");
    format(stringet, sizeof(stringet),"%s%s",stringea,stringe);
    ShowPlayerDialog( playerid, 1, DIALOG_STYLE_MSGBOX,"{FFFF00}Admin Listesi", stringet, "Kapat", "");
	return 1;
}
CMD:animlistesi(playerid, params[])
{
    if(PlayerInfo[playerid][Level] < 9 && !IsPlayerAdmin(playerid)) return YETERSIZSEVIYE2(playerid,9);
    new clanname[MAX_PLAYER_NAME], string[256],stringe[18192], clankills,savingstring[256],stringea[128],stringet[18192],laston[1024];
    mysql_query("SELECT `kullaniciadi`, `Animator`,`LastOn` FROM `oyuncular` ORDER BY `Animator` DESC LIMIT 50");
    mysql_store_result();
    while(mysql_retrieve_row())
    {
        mysql_fetch_field_row(savingstring, "LastOn"); format(laston,30,"%s",savingstring);
        mysql_fetch_field_row(savingstring, "kullaniciadi"); format(clanname,24,"%s",savingstring);
        mysql_fetch_field_row(savingstring, "Animator"); clankills = strval(savingstring);
        format(string, sizeof(string), "{FFFFFF}%d\t\t\t{00FF00}%s\t\t{FFFFFF}%s\n",clankills,laston, clanname);
        if(clankills > 0){
        strcat(stringe,string,10000);
        }
    }
    format(stringea, sizeof(stringea),"{FFFF00}Level\t\t\t{FFFF00}{FFFF00}Oyuna Son Giriþ Tarihi\tNick\n");
    format(stringet, sizeof(stringet),"%s%s",stringea,stringe);
    ShowPlayerDialog( playerid, 1, DIALOG_STYLE_MSGBOX,"{FFFF00}Anim Listesi", stringet, "Kapat", "");
    mysql_free_result();
	return 1;
}
CMD:evsistemi(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 9)) return YETERSIZSEVIYE2(playerid, 9), 1;
	if (InHouse(playerid) != -1)
	{
	    new
	        string[256],
			evtipi[9];
		if (House[InHouse(playerid)][h_type] == 0)
		format(evtipi, 9, "Apartman");
		if (House[InHouse(playerid)][h_type] == 1)
		format(evtipi, 9, "Bahçeli Ev");
		if (House[InHouse(playerid)][h_type] == 2)
		format(evtipi, 9, "Villa");
		format (string, sizeof(string), "{C3C3C3}» {FFFFFF}Ev Sahibi: {E24234}%s\n");
		format (string, sizeof(string), "%s{C3C3C3}» {FFFFFF}Ev Fiyatý: {E24234}%s\n", string, House[InHouse(playerid)][h_price]);
		format (string, sizeof(string), "%s{C3C3C3}» {FFFFFF}Ev Tipi: {E24234}%s", string, evtipi);
		ShowPlayerDialog(playerid, 3888, DIALOG_STYLE_LIST, "[Z]eroTR - Ev Düzenle", string, "Devam", "Iptal");
	}
	return 1;
}
CMD:frozen(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 3 || PlayerInfo[playerid][Animator] >= 3)) return YETERSIZSEVIYE2(playerid, 3), 1;
	new
	    weap[244],
	    donduran[24]
	;
	format(weap, sizeof(weap), "Oyuncu Ýsmi\tDonduran\n");
	foreach(new a : Player)
	{
	    if (GetPVarInt(a, "IsFrozen") == 1)
	    {
	        GetPVarString(a, "FreezedBy", donduran, sizeof(donduran));
	        if (strlen(donduran) < 1) format(donduran, sizeof(donduran), "N/A");
	        format(weap, sizeof(weap), "%s%s\t%s\n", weap,getName(a), donduran);
	    }
	}
	ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"{E24234}"DIALOG_BASLIK" {FFFFFF}- Frozen",weap,"Tamam","");
	return 1;
}
CMD:jailed(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 3 || PlayerInfo[playerid][Animator] >= 3)) return YETERSIZSEVIYE2(playerid, 3), 1;
	new
	    weap[244],
	    donduran[24]
	;
	format(weap, sizeof(weap), "Oyuncu Ýsmi");
	foreach(new a : Player)
	{
	    if (PlayerInfo[a][Jailed] == 1)
	    {
	        if (strlen(donduran) < 1) format(donduran, sizeof(donduran), "N/A");
	        format(weap, sizeof(weap), "%s%s\t%d saniye\n", weap,getName(a), PlayerInfo[a][JailTime]);
	    }
	}
	ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"{E24234}"DIALOG_BASLIK" {FFFFFF}- Jailed",weap,"Tamam","");
	return 1;
}
CMD:pmspec(playerid, params[])
{
	#pragma unused params
	if((PlayerInfo[playerid][Level] < 1 && PlayerInfo[playerid][Animator] < 1) && !IsPlayerAdmin(playerid)) return YETERSIZSEVIYE2(playerid,1);
	new noas;
	switch(PlayerInfo[playerid][Level])
	{
	case 1..7:noas = 0;
	case 8:noas= 1;
	case 9:noas=2;
	case 10:noas=3;
	}
 	for(new line=0;line<10;line++){
	TextDrawShowForPlayer(playerid,eMessagepm[noas][line]);}
	ADmessage(playerid, "PM Spec ekranini actiniz! Artik bütün oyuncularin gonderdigi pmleri goreceksiniz.");

	return 1;
}
CMD:pmspecoff(playerid,params[]) {
	#pragma unused params
	if((PlayerInfo[playerid][Level] < 1 && PlayerInfo[playerid][Animator] < 1) && !IsPlayerAdmin(playerid)) return YETERSIZSEVIYE2(playerid,1);
	new noas;
	switch(PlayerInfo[playerid][Level])
	{
	case 1..7:noas = 0;
	case 8:noas= 1;
	case 9:noas=2;
	case 10:noas=3;
	}
	for(new line=0;line<10;line++){
	TextDrawHideForPlayer(playerid,eMessagepm[noas][line]);}
	ADmessage(playerid, "PM Spec ekranini kapattiniz.");
	return 1;
}
CMD:admins(playerid, params[])
{
    #pragma unused params
    new string[1024];
    new stringe[128];
    new stringz[128];
    new stringt[1024];
    new count = 0;
    if(IsPlayerConnected(playerid)){
    for (new i = 0; i < MAX_PLAYERS; i++){
    if(IsPlayerConnected(i)){
    if(PlayerInfo[i][Level] >= 1 && PlayerInfo[i][Level] <= 11){
        count++;
        new serve[30];
		if(Spectekiler[i] != -1){format(serve, sizeof(serve),"{E24234}Görevde");}//•••
		else{format(serve, sizeof(serve),"{E24234}Müsait\t");}//{8A0886}morr
		format(stringe, sizeof(stringe),"{FFFFFF}ID\t\t{FFFFFF}Level\t\t{FFFFFF}Durum\t\t{FFFFFF}Nick\n");
		format(stringz, sizeof(stringz),"{999999}>{FFFFFF}Toplam {E24234}'%d' {FFFFFF}admin aktif!", count);
        format(string, sizeof(string),"%s{E24234}%i\t\t{FFFFFF}{E24234}%d\t\t{E24234}%s\t{E24234}%s\n", string, i, PlayerInfo[i][Level],  serve, oIsim(i));
        format(stringt, sizeof(stringt),"%s%s\n%s",stringe, string, stringz);}
		}
    }
    ShowPlayerDialog(playerid,5,DIALOG_STYLE_MSGBOX,"{E24234}[Z]ero {FFFFFF}- Adminler",stringt,"Tamam","");
    }
    if (count == 0) ShowPlayerDialog(playerid,5,DIALOG_STYLE_MSGBOX,"{E24234}[Z]ero {FFFFFF}- Adminler","{FFFFFF}» Serverde online administrator yok!","Tamam","Iptal");
    return 1;
}
CMD:djler(playerid, params[])
{
    #pragma unused params
    new string[1024];
    new stringe[128];
    new stringz[128];
    new stringt[1024],kidem[24];
    new count = 0;
    if(IsPlayerConnected(playerid)){
    for (new i = 0; i < MAX_PLAYERS; i++){
    if(IsPlayerConnected(i)){
    if(PlayerInfo[i][DJ] >= 1 && PlayerInfo[i][DJ] <= 3){
		if (PlayerInfo[playerid][DJ] == 1) format(kidem, 24, "Yeni DJ");
		if (PlayerInfo[playerid][DJ] == 2) format(kidem, 24, "Kýdemli DJ");
		if (PlayerInfo[playerid][DJ] == 3) format(kidem, 24, "DJ Sorumlusu");
		count++;
        new serve[20];
		if(Spectekiler[i] == 1 && AFK[i] < 3){format(serve, sizeof(serve),"{E24234}Meþgul");}//•••
		else{format(serve, sizeof(serve),"{E24234}AFK\t");}//{8A0886}morr
		format(serve, sizeof(serve),"{E24234}Müsait\t");
		format(stringe, sizeof(stringe),"{FFFFFF}ID\t\t{FFFFFF}Kýdem\t\t{FFFFFF}Durum\t\t{FFFFFF}Nick\n");
		format(stringz, sizeof(stringz),"{999999}>{FFFFFF}Toplam {E24234}'%d' {FFFFFF}dj aktif!", count);
        format(string, sizeof(string),"%s{E24234}%i\t\t{FFFFFF}{E24234}%s\t\t{E24234}%s\t{E24234}%s\n", string, i, kidem,  serve, oIsim(i));
        format(stringt, sizeof(stringt),"%s%s\n%s",stringe, string, stringz);}
		}
    }
    ShowPlayerDialog(playerid,5,DIALOG_STYLE_MSGBOX,"{E24234}[Z]ero {FFFFFF}- DJLer",stringt,"Tamam","");
    }
    if (count == 0) ShowPlayerDialog(playerid,5,DIALOG_STYLE_MSGBOX,"{E24234}[Z]ero {FFFFFF}- DJLer","{FFFFFF}» Serverde online dj yok!","Tamam","Iptal");
    return 1;
}
CMD:anims(playerid, params[])
{
    #pragma unused params
    new string[1024];
    new stringe[128];
    new stringz[128];
    new stringt[1024];
    new count = 0;
    if(IsPlayerConnected(playerid)){
    for (new i = 0; i < MAX_PLAYERS; i++){
    if(IsPlayerConnected(i)){
    if(PlayerInfo[i][Animator] >= 1 && PlayerInfo[i][Animator] <= 11){
        count++;
        new serve[20];
		if(Spectekiler[i] != -1){format(serve, sizeof(serve),"{E24234}Görevde");}//•••
		else if(GetPVarInt(playerid, "ALT_TABBED") == 1){format(serve, sizeof(serve),"{E24234}Alt-Tabbed");}//•••
		else{format(serve, sizeof(serve),"{E24234}Müsait\t");}//{8A0886}morr

		format(stringe, sizeof(stringe),"{FFFFFF}ID\t\t{FFFFFF}Level\t\t{FFFFFF}Durum\t\t{FFFFFF}Nick\n");
		format(stringz, sizeof(stringz),"{999999}>{FFFFFF}Toplam {8C7A99}'%d' {FFFFFF}animator aktif!", count);
        format(string, sizeof(string),"%s{FFFFFF}%i\t\t{FFFFFF}%d\t\t%s\t{E24234}%s\n", string, i, PlayerInfo[i][Animator],  serve, oIsim(i));
        format(stringt, sizeof(stringt),"%s%s\n%s",stringe, string, stringz);}
		}
    }
    ShowPlayerDialog(playerid,5,DIALOG_STYLE_MSGBOX,"{E24234}[Z]ero - Animatorler{E24234}",stringt,"Tamam","");
    }
    if (count == 0) ShowPlayerDialog(playerid,5,DIALOG_STYLE_MSGBOX,"{E24234}[Z]ero - Animatorler","{FFFFFF}» Serverda online animator yok!","Tamam","Iptal");
    return 1;
}

CMD:makeadmin(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return YETERSIZSEVIYE2(playerid, 10), 1;
	new
	    oyuncu_id,
	    seviye
	;
	if (sscanf(params, "dd", oyuncu_id, seviye)) return USmessage(playerid, "makeadmin [oyuncuid] [seviye]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (seviye >= 11 || seviye <= -1) return INmessage(playerid, "Girmis oldugunuz seviye gecersiz !");
	if (seviye == PlayerInfo[oyuncu_id][Level]) return INmessage(playerid, "Oyuncu zaten girdiginiz seviyede yonetici!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizi {E24234}' %d '{FFFFFF} level yonetici yapti!", verenIsim, seviye);
	ADmessage(oyuncu_id, string);

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'i {E24234}' %d '{FFFFFF} level yonetici yaptin!", oyuncuIsim, seviye);
	ADmessage(playerid, string);
	PlayerInfo[oyuncu_id][Level] = seviye;
	PlayerInfo[oyuncu_id][Animator] = 0;
	logadmin(playerid,"AdminYapmak", oyuncu_id, "-");
	return 1;
}

CMD:setvip(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return YETERSIZSEVIYE2(playerid, 10), 1;
	new
	    oyuncu_id,
	    seviye,
	    gun
	;
	if (sscanf(params, "ddd", oyuncu_id, seviye, gun)) return USmessage(playerid, "setvip [oyuncuid] [seviye] [gün]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (seviye >= 3 || seviye <= -1) return INmessage(playerid, "Girmis oldugunuz seviye gecersiz !");
	if (seviye == PlayerInfo[oyuncu_id][Level]) return INmessage(playerid, "Oyuncu zaten girdiginiz seviyede vip!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizi {E24234}' %d günlük %d '{FFFFFF} level vip yapti!", verenIsim, gun, seviye);
	ADmessage(oyuncu_id, string);

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'i {E24234}' %d '{FFFFFF} level vip yaptin!", oyuncuIsim, seviye);
	ADmessage(playerid, string);
	PlayerInfo[oyuncu_id][viplevel] = seviye;
	format(string, 256, "%s - %d gün - %d", oyuncuIsim, gun, seviye);
	logadmin(playerid,"VIP", oyuncu_id, string);
	return 1;
}

CMD:makedj(playerid, params[])
{
	if(PlayerInfo[playerid][DJ] != 3 || !IsPlayerAdmin(playerid)) return YETERSIZSEVIYE2(playerid, 10), 1;

	new
	    oyuncu_id,
	    seviye
	;
	if (sscanf(params, "dd", oyuncu_id, seviye)) return USmessage(playerid, "makeadmin [oyuncuid] [seviye]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (seviye >= 4 || seviye <= -1) return INmessage(playerid, "Girmis oldugunuz seviye gecersiz !");
	if (seviye == PlayerInfo[oyuncu_id][DJ]) return INmessage(playerid, "Oyuncu zaten girdiginiz seviyede dj!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));
	new kidem[24];
	if (PlayerInfo[playerid][DJ] == 1) format(kidem, 24, "Yeni DJ");
	if (PlayerInfo[playerid][DJ] == 2) format(kidem, 24, "Kýdemli DJ");
	if (PlayerInfo[playerid][DJ] == 3) format(kidem, 24, "DJ Sorumlusu");
	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizi {E24234}' %s '{FFFFFF} yapti!", verenIsim, kidem);
	ADmessage(oyuncu_id, string);

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'i {E24234}' %s '{FFFFFF} yaptin!", oyuncuIsim, kidem);
	ADmessage(playerid, string);
	PlayerInfo[oyuncu_id][DJ] = seviye;
	logadmin(playerid,"DJ", oyuncu_id, "-");

	return 1;
}
CMD:fullkick(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return YETERSIZSEVIYE2(playerid, 10), 1;
	new string[256];
	format(string, sizeof(string), "Yonetici ~r~~h~%s~w~~h~~h~~h~ herkesi kickledi.", oIsim(playerid));
	TextMesaj(string, string);
	foreach(new i : Player) Kick(i);
	logadmin(playerid,"Fullkick", 65535, "RCON");
	return 1;
}

CMD:testc(playerid, params[])
{
	new
		text[24]
	;
	if (sscanf(params, "s[24]", text)) return USmessage(playerid, "testc [text]");
    onlyLetterNumbers(playerid, text);
	return 1;
}
CMD:sound(playerid, params[])
{
	new
	    soundid
	;
	if (sscanf(params, "i", soundid)) return USmessage(playerid, "sound [ses id]");
	PlayerPlaySound(playerid, soundid, 0,0,0);
	return 1;
}
CMD:lays(playerid, params[])
{
	new
	    soundid
	;
	if (sscanf(params, "i", soundid)) return USmessage(playerid, "lays [nu]");
	ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);
	GivePlayerMoney(playerid, -10000);
	return 1;
}
CMD:spectime(playerid, params[])
{
	new
	    saniye
	;
	if (sscanf(params, "i", saniye)) return USmessage(playerid, "spectime [playerid]");
	if (!IsPlayerConnected(saniye)) return Hatamesaj(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!", "Player not connected.");
	if (PlayerInfo[saniye][Level] == 0 && PlayerInfo[saniye][Animator] == 0) return Hatamesaj(playerid, "Oyuncu yönetici degil!", "Player is not admin.");
	new string[256];
	format(string, sizeof(string), "Yetkili {E24234}%s{FFFFFF}'in spec süresi {E24234}' %s '{FFFFFF} saniyedir.", oIsim(playerid), CT(PlayerInfo[saniye][spectime]));
	ADmessage(playerid, string);
	return 1;
}
stock CT(saniye)
{
	new b[32];
	format(b,32,"%02d:%02d.%02d",floatround(floatdiv(saniye,3600),floatround_floor),floatround(floatdiv((saniye%3600),60),floatround_floor),(saniye%60));
	return b;
}

CMD:report(playerid, params[])
{
/*	new
	    server
	;
	foreach (new a : Player)
	{
	    if(PlayerInfo[a][Level] > 0) return server++;
	}
	if(server == 0) return INmessage(playerid, "Hic cevrimici yetkili kisi yok!");
*/	new
	    text[124]
	;
	if (sscanf(params, "s[124]", text)) return USmessage(playerid, "report [text(maks 124)]");
	else
	{
		new
		    gidecekYazi[280]
		;
		format(gidecekYazi, sizeof(gidecekYazi), "{C3C3C3}« Report » {E24234}%s{FFFFFF} >>>{E24234} %s", oIsim(playerid), text);
		foreach (new a : Player)
		{
		    if(PlayerInfo[a][Level] > 0)
		    {
		        SendClientMessage(a, -1, gidecekYazi);
		    }
		}
		SendClientMessage(playerid, -1, "{C3C3C3}» {FFFFFF}Raporunuz acik olan yetkili kisilere basariyla ulasmistir!");
		PlayerPlaySound(playerid, 1150, 0,0,0);
	}
	return 1;
}

CMD:reports(playerid, params[]) return SendClientMessage(playerid, 0xC3C3C3FF, "« mo-Admin »{FFFFFF} Bu komut kaldirilmis yada gecici olarak aktif degil.");
CMD:fakedeath(playerid, params[]) return SendClientMessage(playerid, 0xC3C3C3FF, "« mo-Admin »{FFFFFF} Bu komut kaldirilmis yada gecici olarak aktif degil.");
CMD:fakekill(playerid, params[]) return SendClientMessage(playerid, 0xC3C3C3FF, "« mo-Admin »{FFFFFF} Bu komut kaldirilmis yada gecici olarak aktif degil.");
CMD:fakecmd(playerid, params[]) return SendClientMessage(playerid, 0xC3C3C3FF, "« mo-Admin »{FFFFFF} Bu komut kaldirilmis yada gecici olarak aktif degil.");

CMD:makeanim(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return YETERSIZSEVIYE2(playerid, 10), 1;
	new
	    oyuncu_id,
	    seviye
	;
	if (sscanf(params, "dd", oyuncu_id, seviye)) return USmessage(playerid, "makeanim [oyuncuid] [seviye]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (seviye >= 6 || seviye <= -1) return INmessage(playerid, "Girmis oldugunuz seviye gecersiz !");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizi {E24234}' %d '{FFFFFF} level animator yapti!", verenIsim, seviye);
	ADmessage(oyuncu_id, string);

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'i {E24234}' %d '{FFFFFF} level animator yaptin!", oyuncuIsim, seviye);
	ADmessage(playerid, string);
	PlayerInfo[oyuncu_id][Animator] = seviye;
	PlayerInfo[oyuncu_id][Level] = 0;
	logadmin(playerid,"AnimYapmak", oyuncu_id, "-");
	return 1;
}


CMD:mute(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 2 || PlayerInfo[playerid][Animator] >= 2)) return YETERSIZSEVIYE2(playerid, 2), 1;
	new
	    oyuncu_id,
	    saniye,
	    sebeb[25]
	;
	if (sscanf(params, "ids[25]", oyuncu_id, saniye, sebeb)) return USmessage(playerid, "mute [oyuncuid] [saniye] [sebeb]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (saniye > 500) return INmessage(playerid, "10 Dakika(500 Saniye)'dan fazla mute veremessiniz!");
	if (saniye < 0) return INmessage(playerid, "0 Saniyeden kisa surede muteyi nasil amacliyorsun tassaksiz.");
	if (PlayerInfo[oyuncu_id][muted] == 1) return INmessage(playerid, "Oyuncu zaten susturulmus.");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} tarafindan {E24234}' %d '{FFFFFF} saniye susturuldunuz!", verenIsim, saniye);
	ADmessage(oyuncu_id, string);

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'i {E24234}' %d '{FFFFFF} saniye susturdunuz!", oyuncuIsim, saniye);
	ADmessage(playerid, string);

	PlayerInfo[oyuncu_id][muted] = 1;
	PlayerInfo[oyuncu_id][mutedtime] = saniye;

	format(string, sizeof(string), "~w~~h~~h~~h~[Susturuldu] ~r~~h~%s ~w~~h~~h~~h~>>> ~r~~h~%s~w~~h~~h~~h~ Sebep: ~r~~h~%s", verenIsim, oyuncuIsim, sebeb);
	TextMesaj(string, string);
	logadmin(playerid,"Mute", oyuncu_id, sebeb);
	return 1;
}

CMD:unmute(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 2 || PlayerInfo[playerid][Animator] >= 2)) return YETERSIZSEVIYE2(playerid, 2), 1;
	new
	    oyuncu_id
	;
	if (sscanf(params, "d", oyuncu_id)) return USmessage(playerid, "unmute [oyuncuid]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (PlayerInfo[oyuncu_id][muted] == 0) return INmessage(playerid, "Oyuncu susturulmus degil!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in mute cezasini kaldirdiniz.", oyuncuIsim);
	ADmessage(playerid, string);

	PlayerInfo[oyuncu_id][muted] = 0;
	PlayerInfo[oyuncu_id][mutedtime] = 0;

	format(string, sizeof(string), "~w~~h~~h~~h~Yonetici~r~~h~ %s ~w~~h~~h~~h~tarafindan~r~~h~ %s~w~~h~~h~~h~ adli oyuncunun susturulma cezasi kaldirildi. ", verenIsim, oyuncuIsim);
	TextMesaj(string, string);
	if(PlayerInfo[oyuncu_id][muted] != 0)
	{
	    format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin mute cezanizi sildi.", verenIsim);
	    ADmessage(oyuncu_id, string);
	}
	logadmin(playerid,"UnMute", oyuncu_id, "-");
	return 1;
}

CMD:freeze(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
	new
	    oyuncu_id,
	    sebep[24]
	;
	if (sscanf(params, "d", oyuncu_id)) return USmessage(playerid, "freeze [oyuncuid] [sebep]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'i dondurdunuz. Sebep: {E24234}%s", oyuncuIsim, sebep);
	ADmessage(playerid, string);

	TogglePlayerControllable(oyuncu_id, 0);
	SetPVarString(oyuncu_id, "FreezedBy", verenIsim);

	format(string, sizeof(string), "~w~~h~~h~~h~[Freeze] ~r~~h~%s ~w~~h~~h~~h~>>> ~r~~h~%s~w~~h~~h~~h~ Sebep: ~r~~h~%s", verenIsim, oyuncuIsim, sebep);
	TextMesaj(string, string);
	if(PlayerInfo[oyuncu_id][muted] != 0)
	{
	    format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizi dondurdu!", verenIsim);
	    ADmessage(oyuncu_id, string);
	}
	logadmin(playerid,"Freeze", oyuncu_id, sebep);
	return 1;
}

CMD:lotoogren(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 10 || PlayerInfo[playerid][Animator] >= 10)) return YETERSIZSEVIYE2(playerid, 10), 1;
	new str[66];
	format(str, sizeof(str), "Loto sayisi {E24234}' %d '{FFFFFF}dir.", lotoSayi);
	Bilgimesaj(playerid, str, str);
	logadmin(playerid,"LotoOgren", 65535, "Öðrendi");
	return 1;
}

CMD:unfreeze(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
	new
	    oyuncu_id
	;
	if (sscanf(params, "d", oyuncu_id)) return USmessage(playerid, "unfreeze [oyuncuid]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in dondurma cezasini kaldirdiniz.", oyuncuIsim);
	ADmessage(playerid, string);

	TogglePlayerControllable(oyuncu_id, 1);

	format(string, sizeof(string), "~w~~h~~h~~h~Yonetici~r~~h~ %s ~w~~h~~h~~h~tarafindan~r~~h~ %s~w~~h~~h~~h~ adli oyuncunun donma cezasi kaldirildi. ", verenIsim, oyuncuIsim);
	TextMesaj(string, string);
    format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin kipirdayamama cezanizi sildi!", verenIsim);
    ADmessage(oyuncu_id, string);
	logadmin(playerid,"Unfreeze", oyuncu_id, "-");
	return 1;
}

CMD:asay(playerid, params[])
{
	if (PlayerInfo[playerid][Animator] >= 1)
	{
	    Bilgimesaj(playerid, "Animatörler /ansay kullanacak.", "");
	    return 1;
	}
  	 if(!(PlayerInfo[playerid][Level] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
     new plaka[124];
     if (sscanf(params, "s[124]", plaka)) return USmessage(playerid, "asay [yazi]");
     new string[240];
     format(string, sizeof(string), "{802C26}**{ffec8b} Admin Say{FFFFFF} %s{ffec8b}({FFFFFF}%d{ffec8b}){FFFFFF}: {ffa07a}%s", oIsim(playerid), playerid, plaka);
	 SendClientMessageToAll(-1, string);
 	 logadmin(playerid,"ANsay", 65535, plaka);
     return 1;
}

CMD:altsay(playerid, params[])
{
  	 if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
     new plaka[124];
     if (sscanf(params, "s[124]", plaka)) return USmessage(playerid, "altsay [yazi]");
	 TextMesaj(plaka, plaka);
 	 logadmin(playerid,"ANsay", 65535, plaka);
     return 1;
}

CMD:ansay(playerid, params[])
{
	 if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
     new plaka[124];
     if (sscanf(params, "s[124]", plaka)) return USmessage(playerid, "ansay [yazi]");
     new string[240];
     format(string, sizeof(string), "{d9daf2}**{adaec1} Anim Say{FFFFFF} %s{ffaaa9}({FFFFFF}%d{ffaaa9}){FFFFFF}: {ffaaa9}%s", oIsim(playerid), playerid, plaka);
	 SendClientMessageToAll(-1, string);
	logadmin(playerid,"ANsay", 65535, string);
     return 1;
}

CMD:setskin(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 3 || PlayerInfo[playerid][Animator] >= 3)) return YETERSIZSEVIYE2(playerid, 3), 1;
	new
	    oyuncu_id,
	    skinid
	;
	if (sscanf(params, "dd", oyuncu_id, skinid)) return USmessage(playerid, "setskin [oyuncuid] [skinid]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in skinini {E24234}' %d '{FFFFFF} olarak ayarladiniz.", oyuncuIsim, skinid);
	ADmessage(playerid, string);

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin skininizi {E24234}' %d '{FFFFFF} olarak ayarladi.", verenIsim, skinid);
	ADmessage(oyuncu_id, string);

	SetPlayerSkin(oyuncu_id, skinid);
	logadmin(playerid,"Skin", oyuncu_id, "-");
	return 1;
}

CMD:setworld(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 4 || PlayerInfo[playerid][Animator] >= 4)) return YETERSIZSEVIYE2(playerid, 4), 1;
	new
	    oyuncu_id,
	    skinid
	;
	if (sscanf(params, "dd", oyuncu_id, skinid)) return USmessage(playerid, "setworld [oyuncuid] [worldid]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in world'ünü {E24234}' %d '{FFFFFF} olarak ayarladiniz.", oyuncuIsim, skinid);
	ADmessage(playerid, string);

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin virtual world'ünüzü {E24234}' %d '{FFFFFF} olarak ayarladi.", verenIsim, skinid);
	ADmessage(oyuncu_id, string);

	SetPlayerVirtualWorld(oyuncu_id, skinid);
	logadmin(playerid,"SetWorld", oyuncu_id, "-");
	return 1;
}

CMD:setinterior(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 4 || PlayerInfo[playerid][Animator] >= 4)) return YETERSIZSEVIYE2(playerid, 4), 1;
	new
	    oyuncu_id,
	    skinid
	;
	if (sscanf(params, "dd", oyuncu_id, skinid)) return USmessage(playerid, "setinterior [oyuncuid] [int id]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in interior'unu {E24234}' %d '{FFFFFF} olarak ayarladiniz.", oyuncuIsim, skinid);
	ADmessage(playerid, string);

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin interior'unuzu {E24234}' %d '{FFFFFF} olarak ayarladi.", verenIsim, skinid);
	ADmessage(oyuncu_id, string);

	SetPlayerInterior(oyuncu_id, skinid);
	logadmin(playerid,"Interior", oyuncu_id, "-");
	return 1;
}

CMD:unban(playerid,params[])
{
	if(!(PlayerInfo[playerid][Level] >= 6 || PlayerInfo[playerid][Animator] >= 6)) return YETERSIZSEVIYE2(playerid, 6), 1;
	new cevapp[150],string[144];
	if(sscanf(params, "s[150]", cevapp)) return Kullanimmesaj(playerid, "unban [isim]", "unban [isim]");
	format(string, sizeof(string), "UPDATE oyuncular SET banned = 0 WHERE kullaniciadi = '%s'", cevapp);mysql_free_result();
	mysql_query(string);mysql_free_result();
	Bilgimesaj(playerid, "Kisinin ban cezasi basariyla kaldirilmistir.", "The account ban is removed!");
	logadmin(playerid,"UnBan", INVALID_PLAYER_ID, cevapp);
	return true;
}

CMD:setarmour(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 7 || PlayerInfo[playerid][Animator] >= 7)) return YETERSIZSEVIYE2(playerid, 7), 1;
	new
	    oyuncu_id,
	    skinid
	;
	if (sscanf(params, "dd", oyuncu_id, skinid)) return USmessage(playerid, "setarmour [oyuncuid] [zirh]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in zirhini {E24234}' %d '{FFFFFF} olarak ayarladiniz.", oyuncuIsim, skinid);
	ADmessage(playerid, string);

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin zirhini {E24234}' %d.0 '{FFFFFF} olarak ayarladi.", verenIsim, skinid);
	ADmessage(oyuncu_id, string);

	SetPlayerArmour(oyuncu_id, skinid+0.1);
	logadmin(playerid,"Armour", oyuncu_id, "-");
	return 1;
}

CMD:setcash(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 10 || PlayerInfo[playerid][Animator] >= 10)) return YETERSIZSEVIYE2(playerid, 10), 1;
	new
	    oyuncu_id,
	    skinid
	;
	if (sscanf(params, "dd", oyuncu_id, skinid)) return USmessage(playerid, "setcash [oyuncuid] [para]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in parasini {E24234}' %d '{FFFFFF} olarak ayarladiniz.", oyuncuIsim, skinid);
	ADmessage(playerid, string);

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin paranizi {E24234}' %d '{FFFFFF} olarak ayarladi.", verenIsim, skinid);
	ADmessage(oyuncu_id, string);

	ResetPlayerMoney(oyuncu_id);
	GivePlayerMoney(oyuncu_id, skinid);
	logadmin(playerid,"SetCash", oyuncu_id, "-");
	return 1;
}

CMD:setscore(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 10 || PlayerInfo[playerid][Animator] >= 10)) return YETERSIZSEVIYE2(playerid, 10), 1;
	new
	    oyuncu_id,
	    skinid
	;
	if (sscanf(params, "dd", oyuncu_id, skinid)) return USmessage(playerid, "setscore [oyuncuid] [para]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in skorunu {E24234}' %d '{FFFFFF} olarak ayarladiniz.", oyuncuIsim, skinid);
	ADmessage(playerid, string);

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin skorunuzu {E24234}' %d '{FFFFFF} olarak ayarladi.", verenIsim, skinid);
	ADmessage(oyuncu_id, string);

	SetPlayerScore(oyuncu_id, skinid);
	logadmin(playerid,"SetScore", oyuncu_id, "-");
	return 1;
}

CMD:givescore(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 10 || PlayerInfo[playerid][Animator] >= 10)) return YETERSIZSEVIYE2(playerid, 10), 1;
	new
	    oyuncu_id,
	    skinid
	;
	if (sscanf(params, "dd", oyuncu_id, skinid)) return USmessage(playerid, "givescore [oyuncuid] [para]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'e {E24234}' %d '{FFFFFF} kadar skor verdiniz.", oyuncuIsim, skinid);
	ADmessage(playerid, string);

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} size {E24234}' %d '{FFFFFF} kadar skor verdi.", verenIsim, skinid);
	ADmessage(oyuncu_id, string);

	SetPlayerScore(oyuncu_id, GetPlayerScore(oyuncu_id)+skinid);
	logadmin(playerid,"GiveScore", oyuncu_id, "-");
	return 1;
}

CMD:givecash(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 10 || PlayerInfo[playerid][Animator] >= 10)) return YETERSIZSEVIYE2(playerid, 10), 1;
	new
	    oyuncu_id,
	    skinid
	;
	if (sscanf(params, "dd", oyuncu_id, skinid)) return USmessage(playerid, "givecash [oyuncuid] [para]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'e {E24234}' %d '{FFFFFF} miktar para verdiniz.", oyuncuIsim, skinid);
	ADmessage(playerid, string);

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} hesabiniza {E24234}' %d '{FFFFFF} miktar para yukledi.", verenIsim, skinid);
	ADmessage(oyuncu_id, string);

	GivePlayerMoney(oyuncu_id, skinid);
	logadmin(playerid,"GiveCash", oyuncu_id, "-");
	return 1;
}

CMD:sethealth(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 7 || PlayerInfo[playerid][Animator] >= 7)) return YETERSIZSEVIYE2(playerid, 7), 1;
	new
	    oyuncu_id,
	    skinid
	;
	if (sscanf(params, "dd", oyuncu_id, skinid)) return USmessage(playerid, "sethealth [oyuncuid] [can]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in canini {E24234}' %d '{FFFFFF} olarak ayarladiniz.", oyuncuIsim, skinid);
	ADmessage(playerid, string);

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin caninizi {E24234}' %d.0 '{FFFFFF} olarak ayarladi.", verenIsim, skinid);
	ADmessage(oyuncu_id, string);

	SetPlayerHealth(oyuncu_id, skinid+0.1);
	logadmin(playerid,"GiveScore", oyuncu_id, "-");
	return 1;
}

CMD:setweather(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 3 || PlayerInfo[playerid][Animator] >= 3)) return YETERSIZSEVIYE2(playerid, 3), 1;
	new
	    oyuncu_id,
	    skinid
	;
	if (sscanf(params, "dd", oyuncu_id, skinid)) return USmessage(playerid, "setweather [oyuncuid] [weatherid]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in weatherini {E24234}' %d '{FFFFFF} olarak ayarladiniz.", oyuncuIsim, skinid);
	ADmessage(playerid, string);

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin weatherinizi {E24234}' %d '{FFFFFF} olarak ayarladi.", verenIsim, skinid);
	ADmessage(oyuncu_id, string);

	SetPlayerWeather(oyuncu_id, skinid);
	logadmin(playerid,"Weather", oyuncu_id, "-");
	return 1;
}

CMD:settime(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 3 || PlayerInfo[playerid][Animator] >= 3)) return YETERSIZSEVIYE2(playerid, 3), 1;
	new
	    oyuncu_id,
	    skinid
	;
	if (sscanf(params, "dd", oyuncu_id, skinid)) return USmessage(playerid, "settime [oyuncuid] [saat]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in saatini {E24234}' %d '{FFFFFF} olarak ayarladiniz.", oyuncuIsim, skinid);
	ADmessage(playerid, string);

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin saatinizi {E24234}' %d:00 '{FFFFFF} olarak ayarladi.", verenIsim, skinid);
	ADmessage(oyuncu_id, string);

	SetPlayerTime(oyuncu_id, skinid, 0);
	logadmin(playerid,"Saat", oyuncu_id, "-");
	return 1;
}


CMD:jail(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
	new
	    oyuncu_id,
	    saniye,
	    sebeb[25]
	;
	if (sscanf(params, "ids[25]", oyuncu_id, saniye, sebeb)) return USmessage(playerid, "jail [oyuncuid] [saniye] [sebeb]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (saniye > 800) return INmessage(playerid, "15 Dakika(800 Saniye)'dan fazla jail atamassiniz!");
	if (saniye < 0) return INmessage(playerid, "0 Saniyeden kisa surede hapse gondermeyi nasil amacliyorsun tassaksiz.");
	if (PlayerInfo[oyuncu_id][Jailed] == 1) return INmessage(playerid, "Oyuncu zaten hapisde.");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	JailSave(playerid, oyuncu_id, sebeb);

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} tarafindan {E24234}' %d '{FFFFFF} saniye hapse gonderildiniz!", verenIsim, saniye);
	ADmessage(oyuncu_id, string);

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'i {E24234}' %d '{FFFFFF} saniye hapse gonderdiniz!", oyuncuIsim, saniye);
	ADmessage(playerid, string);

	PlayerInfo[oyuncu_id][Jailed] = 1;
	PlayerInfo[oyuncu_id][JailTime] = saniye;

	format(string, sizeof(string), "~w~~h~~h~~h~[Hapis] ~r~~h~%s ~w~~h~~h~~h~>>> ~r~~h~%s~w~~h~~h~~h~(~r~~h~%d saniye~w~~h~~h~~h~) Sebep: ~r~~h~%s", verenIsim, oyuncuIsim, saniye, sebeb);
	TextMesaj(string, string);
	new iTargetID = oyuncu_id;
	if(PlayerInfo[oyuncu_id][Jailed] != 0)
	{
			SetPlayerVirtualWorld(iTargetID, 696969);
			new rand = random(sizeof(AdminPrisonFloat));
			SetPlayerPos(iTargetID, AdminPrisonFloat[rand][0], AdminPrisonFloat[rand][1], AdminPrisonFloat[rand][2]);
	}
	format(string,sizeof(string), "%s - %d saniye", sebeb, saniye);
	logadmin(playerid,"Jail", oyuncu_id, string);
	return 1;
}

CMD:ojail(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 2 || PlayerInfo[playerid][Animator] >= 2)) return YETERSIZSEVIYE2(playerid, 2), 1;
	new
	    oyuncu_id[24],
	    saniye,
	    sebeb[25]
	;
	if (sscanf(params, "s[24]ds[25]", oyuncu_id, saniye, sebeb)) return USmessage(playerid, "ojail [ad] [saniye] [sebeb]");
	if (saniye > 800) return INmessage(playerid, "15 Dakika(800 Saniye)'dan fazla jail atamassiniz!");
	if (saniye < 0) return INmessage(playerid, "0 Saniyeden kisa surede hapse gondermeyi nasil amacliyorsun tassaksiz.");
	new
	    string[256],
	    verenIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'i {E24234}' %d '{FFFFFF} saniye hapse gonderdiniz!", oyuncu_id, saniye);
	ADmessage(playerid, string);
	format(string, sizeof(string), "UPDATE oyuncular SET Jailed = 1, JailTime = JailTime + %d WHERE kullaniciadi = '%s' AND Level < 8", saniye, oyuncu_id);
	mysql_query(string);
	format(string,sizeof(string), "%s - %d saniye", sebeb, saniye);
	logadmin(playerid,"offlineJail", -1, string);
	return 1;
}

CMD:oban(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 7 || PlayerInfo[playerid][Animator] >= 7)) return YETERSIZSEVIYE2(playerid, 7), 1;
	new
	    oyuncu_id[24],
	    sebeb[25]
	;
	if (sscanf(params, "s[24]ds[25]", oyuncu_id, sebeb)) return USmessage(playerid, "ojail [ad] [sebeb]");
	new
	    string[256],
	    verenIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'i {E24234}' %s '{FFFFFF} sebebiyle banladiniz!", oyuncu_id, sebeb);
	ADmessage(playerid, string);
	format(string, sizeof(string), "UPDATE oyuncular SET banned = 1 WHERE kullaniciadi = '%s' AND Level < 8", oyuncu_id);
	mysql_query(string);
	logadmin(playerid,"offlineBan", -1, sebeb);
	return 1;
}

CMD:unjail(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
	new
	    oyuncu_id
	;
	if (sscanf(params, "d", oyuncu_id)) return USmessage(playerid, "unjail [oyuncuid]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (PlayerInfo[oyuncu_id][Jailed] == 0) return INmessage(playerid, "Oyuncu hapisde degil!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    verenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, verenIsim, sizeof(verenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'i hapisden cikartdiniz", oyuncuIsim);
	ADmessage(playerid, string);

	PlayerInfo[oyuncu_id][Jailed] = 0;
	PlayerInfo[oyuncu_id][JailTime] = 0;

	format(string, sizeof(string), "~w~~h~~h~~h~Yonetici~r~~h~ %s~w~~h~~h~~h~,~r~~h~ %s~w~~h~~h~~h~ adli oyuncuyu hapisten cikardi. ", verenIsim, oyuncuIsim);
	TextMesaj(string, string);
	if(PlayerInfo[oyuncu_id][Jailed] != 0)
	{
	    format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} tarafindan hapisden cikarildiniz.", verenIsim);
	    ADmessage(oyuncu_id, string);
   	    SpawnPlayer(playerid);
	}
	logadmin(playerid,"Jail", oyuncu_id, "-");
	SetPlayerHealth(oyuncu_id, -1);
	return 1;
}

CMD:reconnect(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 10 || PlayerInfo[playerid][Animator] >= 10)) return YETERSIZSEVIYE2(playerid, 10), 1;
	new
	    oyuncu_id
	;
	if (sscanf(params, "d", oyuncu_id)) return USmessage(playerid, "reconnect [oyuncuid]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    cekenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizi relog ettiriyor hicbirsey yazmayin.", cekenIsim);
	ADmessage(oyuncu_id, string);
	ADmessage(oyuncu_id, "8 Saniye icerisinde islem tamamlanacak. Lütfen cikmayin banlanirsiniz!");

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in baglantisini sifirladiniz, re-connect atacak.", oyuncuIsim);
	ADmessage(playerid, string);

	new ip[24], ipd[24];
	GetPlayerIp(playerid, ipd, sizeof(ipd));
	format(ip, sizeof(ip), "banip %s", ipd);
	SetPVarInt(playerid,"reconnecting",1);
	TogglePlayerSpectating(playerid,1);
	SendRconCommand(ip);
	return 1;
}


CMD:disarm(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 2 || PlayerInfo[playerid][Animator] >= 2)) return YETERSIZSEVIYE2(playerid, 2), 1;
	new
	    oyuncu_id
	;
	if (sscanf(params, "d", oyuncu_id)) return USmessage(playerid, "disarm [oyuncuid]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    cekenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin silahlariniza el koydu!", cekenIsim);
	ADmessage(oyuncu_id, string);

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in silahlarinin hepsini sildiniz.", oyuncuIsim);
	ADmessage(playerid, string);

	ResetPlayerWeapons(oyuncu_id);
	return 1;
}

CMD:eject(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 2 || PlayerInfo[playerid][Animator] >= 2)) return YETERSIZSEVIYE2(playerid, 2), 1;
	new
	    oyuncu_id
	;
	if (sscanf(params, "d", oyuncu_id)) return USmessage(playerid, "eject [oyuncuid]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    cekenIsim[24],
		oyuncuIsim[24],
		Float:gg[3]
	;
	GetPlayerPos(oyuncu_id, gg[0], gg[1], gg[2]);
	GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizi aracinizdan atti!", cekenIsim);
	ADmessage(oyuncu_id, string);

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'i aracindan attiniz.", oyuncuIsim);
	ADmessage(playerid, string);

	RemovePlayerFromVehicle(playerid);
	SetPlayerPos(playerid, gg[0], gg[1], gg[2]);
	return 1;
}

CMD:spec(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
	new
	    oyuncu_id
	;
	if (sscanf(params, "d", oyuncu_id)) return USmessage(playerid, "spec [oyuncuid]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (playerid == oyuncu_id) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	StartSpectate(playerid, oyuncu_id);
    Spectekiler[playerid] = oyuncu_id;
	return 1;
}
CMD:slapall(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 6 || PlayerInfo[playerid][Animator] >= 6)) return YETERSIZSEVIYE2(playerid, 6), 1;
	new
	    string[256],
	    cekenIsim[24],
		Float:oyuncu_X,
		Float:oyuncu_Y,
		Float:oyuncu_Z
	;
	GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));

	format(string, sizeof(string), "Bütün oyuncular tokatlandi.");
	ADmessage(playerid, string);

	foreach(new oyuncu_id : Player)
	{
		GetPlayerPos(oyuncu_id,oyuncu_X,oyuncu_Y,oyuncu_Z);
		SetPlayerPos(oyuncu_id,oyuncu_X,oyuncu_Y,oyuncu_Z+4);
		PlayerPlaySound(oyuncu_id,1130,0.0,0.0,0.0);
	}
	format(string, sizeof(string), "~w~~h~~h~~h~Yonetici ~r~~h~%s~w~~h~~h~~h~ butun oyunculari tokatladi.", cekenIsim );
	TextMesaj(string, string);
	return 1;
}
CMD:explodeall(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 6 || PlayerInfo[playerid][Animator] >= 6)) return YETERSIZSEVIYE2(playerid, 6), 1;
	new
	    string[256],
	    cekenIsim[24],
		Float:oyuncu_X,
		Float:oyuncu_Y,
		Float:oyuncu_Z
	;
	GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));

	format(string, sizeof(string), "Bütün sunucuyu patlattýnýz.");
	ADmessage(playerid, string);

	foreach(new oyuncu_id : Player)
	{
		GetPlayerPos(oyuncu_id,oyuncu_X,oyuncu_Y,oyuncu_Z);
		CreateExplosion(oyuncu_X,oyuncu_Y,oyuncu_Z, 15, 4.0);
		PlayerPlaySound(oyuncu_id,1130,0.0,0.0,0.0);
	}
	format(string, sizeof(string), "~w~~h~~h~~h~Yonetici ~r~~h~%s~w~~h~~h~~h~ butun oyunculari patlatti.", cekenIsim );
	TextMesaj(string, string);
	return 1;
}
CMD:givefullweapon(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 9 || PlayerInfo[playerid][Animator] >= 9)) return YETERSIZSEVIYE2(playerid, 9), 1;
	new
	    weap[24],
	    string[256],
	    weapd
	;
	if (sscanf(params, "s[24]", weap)) return USmessage(playerid, "givefullweapon [silah model/silah id]");
	if(IsNumeric(weap)) weapd = GetWeaponIDFromName(weap);
	else weapd = strval(weap);
	foreach(new a : Player)
	{
	    GivePlayerWeapon(a, weapd, 500);
	}
	format(string, sizeof(string), "~w~~h~~h~~h~Yonetici ~r~~h~%s~w~~h~~h~~h~ butun oyunculara ~r~~h~%s~w~~h~~h~~h~(~r~~h~500~w~~h~~h~~h~) verdi.", getName(playerid),weapd);
	TextMesaj(string, string);
	return 1;
}
CMD:givefullcash(playerid, params[]) return komut_givefullmoney(playerid, params);
CMD:givefullmoney(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 9 || PlayerInfo[playerid][Animator] >= 9)) return YETERSIZSEVIYE2(playerid, 9), 1;
	new
	    weap,
	    string[256]
	;
	if (sscanf(params, "d", weap)) return USmessage(playerid, "givefullmoney [miktar]");
	foreach(new a : Player)
	{
		GivePlayerMoney(a, weap);
	}
	format(string, sizeof(string), "~w~~h~~h~~h~Yonetici ~r~~h~%s~w~~h~~h~~h~ butun oyunculara ~r~~h~%d$~w~~h~~h~~h~ kadar para verdi.", getName(playerid),weap);
	TextMesaj(string, string);
	return 1;
}
CMD:givefulldeposit(playerid, params[]) return komut_givefullbankmoney(playerid, params);
CMD:givefullbankmoney(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 9 || PlayerInfo[playerid][Animator] >= 9)) return YETERSIZSEVIYE2(playerid, 9), 1;
	new
	    weap,
	    string[256]
	;
	if (sscanf(params, "d", weap)) return USmessage(playerid, "givefulldeposit [miktar]");
	foreach(new a : Player)
	{
		PlayerInfo[a][Ikramiye] += weap;
	}
	format(string, sizeof(string), "~w~~h~~h~~h~Yonetici ~r~~h~%s~w~~h~~h~~h~ butun oyuncularin banka hesabina ~r~~h~%d$~w~~h~~h~~h~ yukledi.", getName(playerid),weap);
	TextMesaj(string, string);
	return 1;
}
CMD:givefullscore(playerid, params[]) return komut_giveallscore(playerid, params);
CMD:giveallscore(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 10 || PlayerInfo[playerid][Animator] >= 10)) return YETERSIZSEVIYE2(playerid, 10), 1;
	new
	    weap,
	    string[256]
	;
	if (sscanf(params, "d", weap)) return USmessage(playerid, "givefullscore [miktar]");
	foreach(new a : Player)
	{
		SetPlayerScore(a, GetPlayerScore(a)+weap);
	}
	format(string, sizeof(string), "~w~~h~~h~~h~Yonetici ~r~~h~%s~w~~h~~h~~h~ butun oyunculara ~r~~h~%d~w~~h~~h~~h~ kadar skor verdi.", getName(playerid),weap);
	TextMesaj(string, string);
	return 1;
}
CMD:specoff(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
	StopSpectate(playerid);
    Spectekiler[playerid] = -1;
	return 1;
}
CMD:clearchat(playerid, params[]) return komut_clearchat(playerid, params);
CMD:cc(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
	for(new x; x < 26; x++)
	{
	    SendClientMessageToAll(-1, " ");
	}
	new string[256];
	format(string, sizeof(string), "~w~~h~~h~~h~Yonetici ~r~~h~%s~w~~h~~h~~h~ sohbet ekranini temizledi.", getName(playerid));
	TextMesaj(string, string);
	return 1;
}
CMD:offchat(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 5 || PlayerInfo[playerid][Animator] >= 5)) return YETERSIZSEVIYE2(playerid, 5), 1;
	if (noChat == 1)
	{
	noChat = 0;
	new string[256];
	format(string, sizeof(string), "~w~~h~~h~~h~Yonetici ~r~~h~%s~w~~h~~h~~h~ sohbet kanalinin kilidini acti!", getName(playerid));
	TextMesaj(string, string);
	}
	else
	{
	noChat = 1;
	new string[256];
	format(string, sizeof(string), "~w~~h~~h~~h~Yonetici ~r~~h~%s~w~~h~~h~~h~ sohbet kanalini kilitledi!", getName(playerid));
	TextMesaj(string, string);
	}
	return 1;
}
CMD:god(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 4 || PlayerInfo[playerid][Animator] >= 4)) return YETERSIZSEVIYE2(playerid, 4), 1;
	new string[256];
	if(GetPVarInt(playerid, "God") == 0) SetPVarInt(playerid, "God", 1), SetPlayerHealth(playerid, 9999.0), format(string, sizeof(string), "{C3C3C3}« mo-Admin »{FFFFFF} God modunuzu active ettiniz.");
	else SetPVarInt(playerid, "God", 0), SetPlayerHealth(playerid, 9999.0), format(string, sizeof(string), "{C3C3C3}« mo-Admin »{FFFFFF} God modunuzu de-active ettiniz.");
	SendClientMessage(playerid, -1, string), PlayerPlaySound(playerid, 1150, 0, 0, 0);
	return 1;
}
CMD:fire(playerid, params[]) return komut_explode(playerid, params);
CMD:burn(playerid, params[]) return komut_explode(playerid, params);
CMD:get(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
	new
	    oyuncu_id
	;
	if (sscanf(params, "d", oyuncu_id)) return USmessage(playerid, "get [oyuncuid]");
	if(oyuncu_id == playerid) INmessage(playerid, "Bu komutu kendi üzerinizde kullanamassiniz!");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    cekenIsim[24],
		oyuncuIsim[24],
		Float:admin_X,
		Float:admin_Y,
		Float:admin_Z
	;
	GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizi kendi yanina cekti!", cekenIsim);
	ADmessage(oyuncu_id, string);

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'i yaniniza cektiniz.", oyuncuIsim);
	ADmessage(playerid, string);

	GetPlayerPos(playerid, admin_X, admin_Y, admin_Z);
	SetPlayerPos(oyuncu_id, admin_X, admin_Y, admin_Z);
	SetPlayerVirtualWorld(oyuncu_id, GetPlayerVirtualWorld(playerid));
	SetPlayerInterior(oyuncu_id, GetPlayerInterior(playerid));
	return 1;
}
CMD:aka(playerid, params[]) return komut_ip(playerid, params);
CMD:ip(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
	new
 	   oyuncu_id
	;
	if (sscanf(params, "d", oyuncu_id)) return USmessage(playerid, "ip [oyuncuid]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	new
	    ipstring[24]
	;
	GetPlayerIp(oyuncu_id, ipstring, sizeof(ipstring));

    new clanname[MAX_PLAYER_NAME], string[256],stringe[98192], clankills,savingstring[256],stringea[128],stringet[98192],laston[1024];
     format(string, sizeof(string),"SELECT `kullaniciadi`, `score`,`LastOn` FROM `oyuncular` WHERE IP = '%s'", ipstring);
    mysql_query(string);
    mysql_store_result();
    while(mysql_retrieve_row())
    {
        mysql_fetch_field_row(savingstring, "LastOn"); format(laston,30,"%s",savingstring);
        mysql_fetch_field_row(savingstring, "kullaniciadi"); format(clanname,24,"%s",savingstring);
        mysql_fetch_field_row(savingstring, "score"); clankills = strval(savingstring);
        format(string, sizeof(string), "{FFFFFF}%d\t\t\t{00FF00}%s\t\t{FFFFFF}%s\n",clankills,laston, clanname);
        if(clankills > 0){
        strcat(stringe,string,10000);
        }
    }
    mysql_free_result();
    format(stringea, sizeof(stringea),"{FFFF00}Skor\t\t\t{FFFF00}{FFFF00}Oyuna Son Giriþ Tarihi\tNick\n");
    format(stringet, sizeof(stringet),"%s%s",stringea,stringe);
    ShowPlayerDialog( playerid, 1, DIALOG_STYLE_MSGBOX,"{FFFF00}AKA", stringet, "Kapat", "");

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in ip adresi {E24234}' %s '{FFFFFF} seklindedir.", oIsim(oyuncu_id), ipstring);
	ADmessage(playerid, string);
	return 1;
}

CMD:goto(playerid, params[])
{
//	if(IsPlayerInAnyVehicle(playerid)) return Hatamesaj(playerid, "Aractayken bu komutu kullanamassiniz.", "Please exit the this vehicle.");
	new
	    oyuncu_id
	;
	if (sscanf(params, "d", oyuncu_id)) return USmessage(playerid, "goto [oyuncuid]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if(GetPVarInt(oyuncu_id, "T_STATE") == 1 && (PlayerInfo[playerid][Level] == 0 && PlayerInfo[playerid][Animator] == 0)) return INmessage(playerid, "Oyuncunun telesi kapali!");
	if(GetPVarInt(oyuncu_id, "PlayerInDM") == 1 && PlayerInfo[playerid][Level] == 0 && PlayerInfo[playerid][Animator] == 0) return INmessage(playerid, "Oyuncu bir DM'de oldugu icin isinlanamassiniz!");
	if(oyuncu_id == playerid) return INmessage(playerid, "Bu komutu kendi üzerinizde kullanamassiniz!");
	if(ETK[oyuncu_id] != 0 && (PlayerInfo[playerid][Level] == 0 && PlayerInfo[playerid][Animator] == 0)) return INmessage(playerid, "Oyuncu bir etkinlikte oldugu icin isinlanamassiniz!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	if(DDArac[oyuncu_id] != INVALID_VEHICLE_ID && PlayerInfo[playerid][Level] == 0 && PlayerInfo[playerid][Animator] == 0) return INmessage(playerid, "Oyuncu bir DD'de oldugu icin isinlanamassiniz.");
	if(PlayerInfo[playerid][Level] > 0)
	{
		new
		    string[256],
		    cekenIsim[24],
			oyuncuIsim[24],
			Float:admin_X,
			Float:admin_Y,
			Float:admin_Z
		;
		GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));
		GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

		format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} yaniniza isinlandi!", cekenIsim);
		ADmessage(oyuncu_id, string);

		format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in yanina isinlandiniz.", oyuncuIsim);
		ADmessage(playerid, string);

		GetPlayerPos(oyuncu_id, admin_X, admin_Y, admin_Z);
		SetPlayerPos(playerid, admin_X, admin_Y, admin_Z);
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(oyuncu_id));
		SetPlayerInterior(playerid, GetPlayerInterior(oyuncu_id));
	}
	else if(PlayerInfo[playerid][Animator] > 0)
	{
		new
		    string[256],
		    cekenIsim[24],
			oyuncuIsim[24],
			Float:admin_X,
			Float:admin_Y,
			Float:admin_Z
		;
		GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));
		GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

		format(string, sizeof(string), "Animator {E24234}%s{FFFFFF} yaniniza isinlandi!", cekenIsim);
		ADmessage(oyuncu_id, string);

		format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in yanina isinlandiniz.", oyuncuIsim);
		ADmessage(playerid, string);

		GetPlayerPos(oyuncu_id, admin_X, admin_Y, admin_Z);
		SetPlayerPos(playerid, admin_X, admin_Y, admin_Z);
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(oyuncu_id));
		SetPlayerInterior(playerid, GetPlayerInterior(oyuncu_id));
	}
	else
	{
		new
		    string[256],
		    cekenIsim[24],
			oyuncuIsim[24],
			Float:admin_X,
			Float:admin_Y,
			Float:admin_Z
		;
		GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));
		GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

		format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF} yaniniza isinlandi!", cekenIsim);
		ADmessage(oyuncu_id, string);

		format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in yanina isinlandiniz.", oyuncuIsim);
		ADmessage(playerid, string);

		GetPlayerPos(oyuncu_id, admin_X, admin_Y, admin_Z);
		SetPlayerPos(playerid, admin_X, admin_Y, admin_Z);
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(oyuncu_id));
		SetPlayerInterior(playerid, GetPlayerInterior(oyuncu_id));
	}
	return 1;
}

CMD:slap(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 2 || PlayerInfo[playerid][Animator] >= 2)) return YETERSIZSEVIYE2(playerid, 2), 1;
	new
	    oyuncu_id
	;
	if (sscanf(params, "d", oyuncu_id)) return USmessage(playerid, "slap [oyuncuid]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    cekenIsim[24],
		oyuncuIsim[24],
		Float:oyuncu_X,
		Float:oyuncu_Y,
		Float:oyuncu_Z
	;
	GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizi tokatladi!", cekenIsim);
	ADmessage(oyuncu_id, string);

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'i tokatladin.", oyuncuIsim);
	ADmessage(playerid, string);

	PlayerPlaySound(oyuncu_id,1130,0.0,0.0,0.0);
	GetPlayerPos(oyuncu_id,oyuncu_X,oyuncu_Y,oyuncu_Z);
	SetPlayerPos(oyuncu_id,oyuncu_X,oyuncu_Y,oyuncu_Z+4);
	return 1;
}

CMD:warn(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
	new
	    oyuncu_id,
	    sebep[24]
	;
	if (sscanf(params, "is[24]", oyuncu_id, sebep)) return USmessage(playerid, "warn [oyuncuid] [gerekçe]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    cekenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "~w~~h~~h~~h~[Warn] ~r~~h~%s ~w~~h~~h~~h~>>> ~r~~h~%s(%d/3)~w~~h~~h~~h~ Sebep: ~r~~h~%s", cekenIsim, oyuncuIsim, GetPVarInt(playerid, "Warn_Player")+1, sebep);
	TextMesaj(string, string);
//	format(string, sizeof(string), "Oyuncuyu uyaran ~r~~h~%s~w~~h~~h~~h~.", cekenIsim);
//	TextMesaj(string, string);

	SetPVarInt(playerid, "Warn_Player", GetPVarInt(playerid, "Warn_Player")+1);
	Warn(oyuncu_id, sebep, cekenIsim);
	if(GetPVarInt(oyuncu_id, "Warn_Player") > 2) return Kickle(oyuncu_id, "3 Uyari");
	return 1;
}
CMD:explode(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
	new
	    oyuncu_id,
	    sebep[24]
	;
	if (sscanf(params, "is[24]", oyuncu_id, sebep)) return USmessage(playerid, "explode [oyuncuid] [gerekçe]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    cekenIsim[24],
		oyuncuIsim[24],
		Float:oyuncu_X,
		Float:oyuncu_Y,
		Float:oyuncu_Z
	;
	GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizi {E24234}' %s '{FFFFFF} sebebiyle patlatti.", cekenIsim, sebep);
	ADmessage(oyuncu_id, string);

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'i patlattiniz.", oyuncuIsim);
	ADmessage(playerid, string);

	format(string, sizeof(string), "~w~~h~~h~~h~[Explode] ~r~~h~%s ~w~~h~~h~~h~>>> ~r~~h~%s~w~~h~~h~~h~ Sebep: ~r~~h~%s", cekenIsim, oyuncuIsim, sebep);
	TextMesaj(string, string);

	GetPlayerPos(oyuncu_id, oyuncu_X,oyuncu_Y,oyuncu_Z);
	CreateExplosion(oyuncu_X,oyuncu_Y,oyuncu_Z, 5, 4.0);
	return 1;
}
CMD:paracezasi(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 4 || PlayerInfo[playerid][Animator] >= 4)) return YETERSIZSEVIYE2(playerid, 4), 1;
	new
	    oyuncu_id,
	    miktar,
	    sebep[24]
	;
	if (sscanf(params, "iis[24]", oyuncu_id, miktar, sebep)) return USmessage(playerid, "paracezasi [oyuncuid] [miktar] [gerekçe]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	if (miktar < 0)
	{
		SendClientMessage(playerid, 0xC3C3C3C3, "« zr-Admin »{FFFFFF} Yetkinizi kötüye kullandiginiz icin bütün yetkileriniz alinmistir.");
		printf("%s isimli yetkili %s'e %d miktar para cezasi keserken yakalandi.", getName(playerid), getName(oyuncu_id), miktar);
		PlayerInfo[playerid][Level] = 0;
 		ADmessage(oyuncu_id, "Yonetici {E24234}console{FFFFFF} sizi {E24234}' 0 '{FFFFFF} level yonetici yapti!");
		return 1;
	}
	new
	    string[256],
	    cekenIsim[24],
		oyuncuIsim[24]
	;
	GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));

	format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} size {E24234}' %d$ '{FFFFFF} kadar para cezasi kesti. Sebep: {E24234}%s", cekenIsim, miktar, sebep);
	ADmessage(oyuncu_id, string);

	format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'e para cezasi verdiniz. Tutar: {E24234}%d$", oyuncuIsim, miktar);
	ADmessage(playerid, string);

	format(string, sizeof(string), "~w~~h~~h~~h~[Para Cezasi] ~r~~h~%s ~w~~h~~h~~h~>>> ~r~~h~%s~w~~h~~h~~h~ Tutar: ~r~~h~ %d$~w~~h~~h~~h~- Sebep: ~r~~h~%s", cekenIsim, oyuncuIsim, miktar, sebep);
	TextMesaj(string, string);

	format(string, sizeof(string), "%s - %d$", sebep, miktar);
	GivePlayerMoney(oyuncu_id, -miktar);
	logadmin(playerid,"ParaCezasi", oyuncu_id, string);
	return 1;
}
stock Kickle(playerid, sebep[])
{
	new
	    string[300],
	    cekenIsim[24] = "Konsol",
		oyuncuIsim[24],
		yil,
		ay,
		gun
	;
	GetPlayerName(playerid, oyuncuIsim, sizeof(oyuncuIsim));
	getdate(yil, ay, gun);
	format(string, sizeof(string), "{FFFFFF}Sunucudan kicklendiniz ! Detaylar:\n{FFFFFF}Kickleyen:{E24234} %s\n{FFFFFF}Sebep:{E24234} %s\n{FFFFFF}Tarih:{E24234}%d.%d.%d\n\n{FFFFFF}Gereksiz yere kicklendiginizi dusunuyorsaniz zerotr.com adresimizden sikayet olusturun.", cekenIsim, sebep, yil, ay, gun);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Kicklendiniz!", string, "Tamam", "");
	TogglePlayerControllable(playerid, 0);
	SetTimerEx("kPlayer", 100, false, "i", playerid);
	format(string, sizeof(string), "~w~~h~~h~~h~[Kick] ~r~~h~%s ~w~~h~~h~~h~>>> ~r~~h~%s~w~~h~~h~~h~ Sebep: ~r~~h~%s", cekenIsim, oyuncuIsim, sebep);
	TextMesaj(string, string);
	printf("Oyuncu %s kicklendi. Sebep: %s", oIsim(playerid), sebep);
	return 1;
}
stock Banla(playerid, sebep[])
{
	new
	    string[300],
	    cekenIsim[24] = "Konsol",
		oyuncuIsim[24],
		yil,
		ay,
		gun
	;
	GetPlayerName(playerid, oyuncuIsim, sizeof(oyuncuIsim));
	getdate(yil, ay, gun);
	format(string, sizeof(string), "{FFFFFF}Sunucudan banlandiniz ! Detaylar:\n{FFFFFF}Banlayan:{E24234} %s\n{FFFFFF}Sebep:{E24234} %s\n{FFFFFF}Tarih:{E24234}%d.%d.%d\n\n{FFFFFF}Gereksiz yere banlandiginizi dusunuyorsaniz zerotr.com adresimizden sikayet olusturun.", cekenIsim, sebep, yil, ay, gun);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Banlandiniz!", string, "Tamam", "");
	TogglePlayerControllable(playerid, 0);
	SetTimerEx("bPlayer", 100, false, "i", playerid);
	format(string, sizeof(string), "~w~~h~~h~~h~[Ban] ~r~~h~%s ~w~~h~~h~~h~>>> ~r~~h~%s~w~~h~~h~~h~ Sebep: ~r~~h~%s", cekenIsim, oyuncuIsim, sebep);
	TextMesaj(string, string);
	printf("Oyuncu %s kicklendi. Sebep: %s", oIsim(playerid), sebep);
	return 1;
}
stock Surecesk(ms, &h, &m, &s)
{
    h = ms / (60*60*1000);
    ms = ms - h*(60*60*1000);
    m = ms / (60*1000);
    ms = ms - m*(60*1000);
    s = ms / 1000;
    ms = ms - s*1000;
}
CMD:stats(playerid, params[])
{
	new
	    stringStats[1026],
	    h,m,s,
		Float: can,
		Float: zirh,
		etkstring[14],
		dmstring[14],
		derbystring[14],
		racestring[14],
		dilstring[11],
		baslik[128],
		oyuncuid
	;
	if (sscanf(params, "d", oyuncuid)) return USmessage(playerid, "stats [oyuncu ismi/oyuncu id]");
	if(GetPVarInt(oyuncuid, "Language__") == TURKISH) strcat(dilstring, "Türkce");
	if(GetPVarInt(oyuncuid, "Language__") == ENGLISH) strcat(dilstring, "Ingilizce");
	if(ETK[oyuncuid] == 1) strcat(etkstring, "Evet");
	if(ETK[oyuncuid] == 0) strcat(etkstring, "Hayir");
	if(Joined[oyuncuid] == true) strcat(racestring, "Evet");
	if(Joined[oyuncuid] == false) strcat(racestring, "Hayir");

	if(GetPVarInt(oyuncuid, "PlayerInDM") == 0) strcat(dmstring, "Hayýr");
	else strcat(dmstring, "Evet");
	if(DDArac[oyuncuid] == INVALID_VEHICLE_ID) strcat(derbystring, "Hayýr");
	else strcat(derbystring, "Evet");
	if (IsPlayerNPC(oyuncuid)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	GetPlayerHealth(playerid, can);
	GetPlayerArmour(playerid, zirh);
	Surecesk(PlayerInfo[oyuncuid][onlinet]*1000, h, m, s);
	format(stringStats, sizeof(stringStats), "\
	{D6A354}» Can:{FFFFFF}\t\t\t\t%f\n\
	{D6A354}» Zirh:{FFFFFF}\t\t\t\t%f\n\
	{D6A354}» Skin:{FFFFFF}\t\t\t\t%d\n\
	{D6A354}» Oldurme:{FFFFFF}\t\t\t%d\n\
	{D6A354}» Olme:{FFFFFF}\t\t\t%d\n\
	{D6A354}» Ratio:{FFFFFF}\t\t\t\t%f\n\
	{D6A354}» Nakit:{FFFFFF}\t\t\t\t%d\n\
	{D6A354}» Banka Parasi:{FFFFFF}\t\t%d\n\
	{D6A354}» Online Suresi:{FFFFFF}\t\t%d Saat %d Dakika %d Saniye\n\
	{D6A354}» Score:{FFFFFF}\t\t\t%d\n",		can,
		zirh,
		GetPlayerSkin(oyuncuid),
		PlayerInfo[oyuncuid][Kills],
		PlayerInfo[oyuncuid][Deaths],
		Float:PlayerInfo[oyuncuid][Kills]/Float:PlayerInfo[oyuncuid][Deaths],
		GetPlayerMoney(oyuncuid),
		PlayerInfo[oyuncuid][Deposit],
		h, m, s,
		GetPlayerScore(oyuncuid));
	format(stringStats, sizeof(stringStats), "%s\
	{D6A354}» Dil:{FFFFFF}\t\t\t\t%s\n\
	{D6A354}» FPS:{FFFFFF}\t\t\t\t%d\n\
	{D6A354}» Etkinlikte:{FFFFFF}\t\t\t%s\n\
	{D6A354}» Deathmatch:{FFFFFF}\t\t\t%s\n\
	{D6A354}» Race:{FFFFFF}\t\t\t\t%s\n\
	{D6A354}» Derby:{FFFFFF}\t\t\t%s\n\
	",
	    stringStats,
		dilstring,
		GetPlayerFPS(oyuncuid),
		etkstring,
		dmstring,
		racestring,
		derbystring );
	format(baslik, sizeof(baslik), "{E24234}"DIALOG_BASLIK" - Stats - {%06x}%s", GetPlayerColor(oyuncuid) >>> 8, oIsim(oyuncuid));
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, baslik, stringStats, "Tamam", "");
	return 1;
}
stock Warn(playerid, sebep[], kim[])
{
	new
	    string[300],
		oyuncuIsim[24],
		yil,
		ay,
		gun
	;
	GetPlayerName(playerid, oyuncuIsim, sizeof(oyuncuIsim));
	getdate(yil, ay, gun);
	format(string, sizeof(string), "{FFFFFF}Warning aldiniz! Detaylar:\n{FFFFFF}Admin:{E24234} %s\n{FFFFFF}Sebep:{E24234} %s\n{FFFFFF}Uyari Sayiniz:{E24234} %d\n{FFFFFF}Tarih:{E24234}%d.%d.%d\n\n{FFFFFF}Gereksiz yere uyarildiginizi dusunuyorsaniz zerotr.com adresimizden sikayet olusturun.", kim, sebep, GetPVarInt(playerid, "Warn_Player"), yil, ay, gun);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Uyarildiniz!", string, "Tamam", "");
	return 1;
}
CMD:evsahiplerineparaver(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 10 || PlayerInfo[playerid][Animator] >= 10)) return YETERSIZSEVIYE2(playerid, 10), 1;
	new
		string[256]
	;
	format(string, sizeof(string), "UPDATE oyuncular SET deposit = deposit + 900000 WHERE evsayisi = 1");
	mysql_query(string);
	format(string, sizeof(string), "UPDATE oyuncular SET evsayisi = 0");
	mysql_query(string);
	return 1;
}
CMD:varsayilanguncelle(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 10 || PlayerInfo[playerid][Animator] >= 10)) return YETERSIZSEVIYE2(playerid, 10), 1;
	new
		string[256]
	;
	format(string, sizeof(string), "UPDATE oyuncular SET veterantercih = 1, semiprotercih = 1 WHERE veterantercih = 0 AND semiprotercih = 0");
	mysql_query(string);
	foreach(new i :Player)
	{
	    PlayerInfo[playerid][semiprotercih] = 1;
		PlayerInfo[playerid][veterantercih] = 1;
		PlayerInfo[playerid][odultercih] = 1;
	}
	return 1;
}
CMD:kick(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 2 || PlayerInfo[playerid][Animator] >= 2)) return YETERSIZSEVIYE2(playerid, 2), 1;
	new
	    oyuncu_id,
	    sebep[24]
 	;
	if (sscanf(params, "is[24]", oyuncu_id, sebep)) return USmessage(playerid, "kick [oyuncuid] [gerekçe]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    cekenIsim[24],
		oyuncuIsim[24],
		yil,
		ay,
		gun
	;
	GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));
	getdate(yil, ay, gun);
	format(string, sizeof(string), "{FFFFFF}Sunucudan kicklendiniz ! Detaylar:\n{FFFFFF}Kickleyen:{E24234} %s\n{FFFFFF}Sebep:{E24234} %s\n{FFFFFF}Tarih:{E24234}%d.%d.%d\n\n{FFFFFF}Gereksiz yere kicklendiginizi dusunuyorsaniz zerotr.com adresimizden sikayet olusturun.", cekenIsim, sebep, yil, ay, gun);
	ShowPlayerDialog(oyuncu_id, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Kicklendiniz!", string, "Tamam", "");
	TogglePlayerControllable(oyuncu_id, 0);
	SetTimerEx("kPlayer", 500, false, "i", oyuncu_id);
	format(string, sizeof(string), "~r~[~w~~h~~h~~h~KICK~r~]~p~ %s~w~~h~~h~~h~ >>>~p~~h~%s~w~~h~~h~~h~ [Gerekce: ~r~%s~w~~h~~h~~h~]", cekenIsim, oyuncuIsim, sebep);
	TextMesaj(string, string);
	KickSave(playerid, oyuncu_id, sebep);
	return 1;
}

CMD:ban(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 3 || PlayerInfo[playerid][Animator] >= 3)) return YETERSIZSEVIYE2(playerid, 3), 1;
	new
	    oyuncu_id,
	    sebep[24]
 	;
	if (sscanf(params, "is[24]", oyuncu_id, sebep)) return USmessage(playerid, "ban [oyuncuid] [gerekçe]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    cekenIsim[24],
		oyuncuIsim[24],
		yil,
		ay,
		gun
	;
	GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));
	getdate(yil, ay, gun);
	format(string, sizeof(string), "{FFFFFF}Sunucudan banlandiniz ! Detaylar:\n{FFFFFF}Banlayan:{E24234} %s\n{FFFFFF}Sebep:{E24234} %s\n{FFFFFF}Tarih:{E24234}%d.%d.%d\n\n{FFFFFF}Gereksiz yere kicklendiginizi dusunuyorsaniz zerotr.com adresimizden sikayet olusturun.", cekenIsim, sebep, yil, ay, gun);
	ShowPlayerDialog(oyuncu_id, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Banlandiniz!", string, "Tamam", "");
	TogglePlayerControllable(oyuncu_id, 0);
	SetTimerEx("banPlayer", 500, false, "i", oyuncu_id);
	format(string, sizeof(string), "~w~~h~~h~~h~[Ban] ~r~~h~%s ~w~~h~~h~~h~>>> ~r~~h~%s~w~~h~~h~~h~ Sebep: ~r~~h~%s", cekenIsim, oyuncuIsim, sebep);
	TextMesaj(string, string);
	BanSave(playerid, oyuncu_id, sebep);
	return 1;
}

CMD:nban(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 5 || PlayerInfo[playerid][Animator] >= 5)) return YETERSIZSEVIYE2(playerid, 5), 1;
	new
	    oyuncu_id,
	    sebep[24]
 	;
	if (sscanf(params, "is[24]", oyuncu_id, sebep)) return USmessage(playerid, "nban [oyuncuid] [gerekçe]");
	if (!IsPlayerConnected(oyuncu_id)) return INmessage(playerid, "Girmis oldugunuz ide bagli oyuncu bulunmamaktadir!");
	if (IsPlayerNPC(oyuncu_id)) return INmessage(playerid, "Botlara bu komut uygulanamaz.");
	new
	    string[256],
	    cekenIsim[24],
		oyuncuIsim[24],
		yil,
		ay,
		gun
	;
	GetPlayerName(playerid, cekenIsim, sizeof(cekenIsim));
	GetPlayerName(oyuncu_id, oyuncuIsim, sizeof(oyuncuIsim));
	getdate(yil, ay, gun);
	format(string, sizeof(string), "{FFFFFF}Sunucudan name banlandiniz ! Detaylar:\n{FFFFFF}Banlayan:{E24234} %s\n{FFFFFF}Sebep:{E24234} %s\n{FFFFFF}Tarih:{E24234}%d.%d.%d\n\n{FFFFFF}Gereksiz yere n-banlandiginiz dusunuyorsaniz zerotr.com adresimizden sikayet olusturun.", cekenIsim, sebep, yil, ay, gun);
	ShowPlayerDialog(oyuncu_id, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK"{FFFFFF} - N-Banlandiniz!", string, "Tamam", "");
	TogglePlayerControllable(oyuncu_id, 0);
	PlayerInfo[oyuncu_id][banned] = 1;
	SetPVarInt(oyuncu_id, "NameBan", 1);
	SetTimerEx("banPlayer", 500, false, "i", oyuncu_id);
	format(string, sizeof(string), "~w~~h~~h~~h~[N-Ban] ~r~~h~%s ~w~~h~~h~~h~>>> ~r~~h~%s~w~~h~~h~~h~ Sebep: ~r~~h~%s", cekenIsim, oyuncuIsim, sebep);
	TextMesaj(string, string);
	NBanSave(playerid, oyuncu_id, sebep);
	format(string, sizeof(string), "UPDATE oyuncular SET banned = 1 WHERE kullaniciadi = '%s'", oIsim(oyuncu_id));
	mysql_query(string);
	return 1;
}

forward banPlayer(i); public banPlayer(i) return Ban(i);
forward kPlayer(i); public kPlayer(i) return Kick(i);
forward bPlayer(i); public bPlayer(i) return Ban(i);

stock ADmessage(playerid, string[])
{
	new
		stringx[256]
	;
	format(stringx, sizeof(stringx), "{C3C3C3}« mo-Admin » {FFFFFF}%s", string);
	return SendClientMessage(playerid, -1, stringx), PlayerPlaySound(playerid, 1057, 0.0000, 0.0000, 0.0000);
}

stock YETERSIZSEVIYE2(playerid, level)
{
	new
	    stringx[256]
	;
	format(stringx, sizeof(stringx), "Bu komut kullanabilmeniz icin {E24234}' %d '{FFFFFF} level olmalisiniz.", level);
	return Hatamesaj(playerid, stringx, "You are not admin!");
}
stock RegServ(playerid, string[], nasrettin[])
{
	new
		stringx[333]
	;
	if(GetPVarInt(playerid, "Language__") == ENGLISH) format(stringx, sizeof(stringx), "{E24234}<(Bilgi)>{FFFFFF} %s", nasrettin);
	if(GetPVarInt(playerid, "Language__") == TURKISH) format(stringx, sizeof(stringx), "{E24234}<(Bilgi)>{FFFFFF} %s", string);
	return SendClientMessage(playerid, -1, stringx), PlayerPlaySound(playerid, 1085, 0.0000, 0.0000, 0.0000);
}
stock INmessage(playerid, string[])
{
	new
		stringx[256]
	;
	format(stringx, sizeof(stringx), "{E24234}<(Bilgi)>{FFFFFF} %s", string);
	return SendClientMessage(playerid, -1, stringx), PlayerPlaySound(playerid, 1085, 0.0000, 0.0000, 0.0000);
}
stock Kullanimmesaj(playerid, string[], stringa[])
{
	new stringg[256];
	format(stringg, sizeof(stringg), "%s", string);
	strreplace("/", "", stringg);

	new stringgg[256];
	format(stringgg, sizeof(stringgg), "%s", stringa);
	strreplace("/", "", stringgg);
	new
		stringx[256]
	;
	if(GetPVarInt(playerid, "Language__") == TURKISH) format(stringx, sizeof(stringx), "{E24234}<(Bilgi)>{FFFFFF} Dogru Kullanim - {E24234}' /%s '", stringg);
	if(GetPVarInt(playerid, "Language__") == ENGLISH) format(stringx, sizeof(stringx), "{E24234}<(Bilgi)>{FFFFFF} Syntax - {E24234}' /%s '", stringgg);
	return SendClientMessage(playerid, -1, stringx), PlayerPlaySound(playerid, 1085, 0.0000, 0.0000, 0.0000);
}


stock USmessage(playerid, string[])
{
	new stringg[256];
	format(stringg, sizeof(stringg), "%s", string);
	strreplace("/", "", stringg);
	new
		stringx[256]
	;
	format(stringx, sizeof(stringx), "{E24234}<(Syntax)> {FFFFFF}Dogru Kullanim - {E24234}' /%s '", stringg);
	return SendClientMessage(playerid, -1, stringx), PlayerPlaySound(playerid, 1085, 0.0000, 0.0000, 0.0000);
}

CMD:etkbaslat(playerid, params[])
{
if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
new tmp[256];
if(EtkBaslat[playerid] == 1) return HataMesaji(playerid,"Bir etkinlikteyken bu komutu kullanamassin !");
if(Etkinlik == 1) return HataMesaji(playerid,"Þu an bir etkinlik yapiliyor, onun bitmesini bekleyin.");
if (sscanf(params, "s[25]", tmp)) return USmessage(playerid, "etkbaslat [Etkinlik Ismi] '");
format(EtkName,128,"%s",tmp);
EtkBaslat[playerid] = 1;
SetPlayerSpecialAction(playerid,2);
SendClientMessage(playerid, -1, "{F6C30F}« Etkinlik »{FFFFFF} Etkinlik komutlari hakkinda bilgi almak için {1E90FF}/etkyardim {FFFFFF}yazin.");
Etkinlik = 1;
new Float:X,Float:Y,Float:Z,Float:angle;
GetPlayerFacingAngle(playerid,angle);
GetPlayerPos(playerid,X,Y,Z);
ePos[0] = X;
new String[256];
format(String,256, "~w~~h~~h~~h~Yonetici ~r~~h~%s~w~~h~~h~~h~ birazdan ~p~~h~%s~w~~h~~h~~h~ isimli etkinligi yapacak. Gitmek icin ~y~~h~/etkgit~w~~h~~h~~h~ yazin.",oIsim(playerid),EtkName);
TextMesaj(String, String);
ePos[1] = Y;
ePos[2] = Z;
ePos[3] = angle;
format(etkismi,128,"%s",tmp);
SetTimer("KBitti",30000,false);
SetTimer("KBittix",20000,false);
				EtkSave(playerid,EtkName);//aslýnda etkinlikleri sayan sistem var
return 1;
}
KBittix(); public KBittix()
{
	new String[256];
	format(String,256, "~w~~h~~h~~h~Etkinligin baslamasina 10 saniye kaldi - Katilmak icin ~y~~h~/etkgit~w~~h~~h~~h~ yazin.");
	TextMesaj(String, String);
	return 1;
}
KBitti(); public KBitti()
{
//KillTimer(etimer);
TextMesaj("Etkinlige katilim sona ermistir.", "Etkinlige katilim sonra ermistir.");
Etkinlik = false;
for(new i;i<MAX_PLAYERS;i++)
{
if(EtkBaslat[i] == 1)
{
EtkBaslat[i] = 0;
}
}
}
CMD:etkliste(playerid, params[])
{
	return 1;
}
forward EtkSave(adminid,etk[]);
public EtkSave(adminid,etk[])
{
    new query[256],AdminIP[20];
	GetPlayerIp(adminid,AdminIP,20);
	format(query, sizeof(query), "INSERT INTO `etklog` (animator, etkinlik, tarih) VALUES(\"%s\", \"%s\", %d)",getName(adminid), code(etk), gettime());
	mysql_query(query);//	mysql_free_result();
}
forward logadmin(adminid,etk[],yapilan, sebep[]);
public logadmin(adminid,etk[],yapilan, sebep[])
{mysql_free_result();
    new query[320],AdminIP[20],KayitIP[20],hour,minute,second,year,month,day;
	GetPlayerIp(adminid,AdminIP,20);
	GetPlayerIp(yapilan,KayitIP,20);
	gettime(hour, minute, second); getdate(year, month, day);
	format(query, sizeof(query), "INSERT INTO `kayitlar` (adminip,kayitip,kayittip, kayit, tarih, zaman, sebep) VALUES('%s', %d, '%d/%d/%d', '%d:%d:%d', '%s')", AdminIP, KayitIP, etk, yapilan, year,month,day, hour, minute, second, sebep);
	mysql_query(query);	mysql_free_result();
}
CMD:etkgit(playerid, params[])
{
if(ETK[playerid] == 1) return HataMesaji(playerid,"Zaten bir etkinlikte bulunuyorsunuz.");
if(Etkinlik == 0) return HataMesaji(playerid,"Þuan bir etkinlik yapilmamiþ.");
ShowPlayerDialog(playerid, 500000, 3, "_","_","_","_");
new Float:index = 0.5;
ePos[0] += (index * floatsin(-ePos[3],degrees));
ePos[1] += (index * floatcos(-ePos[3],degrees));
index += 0.5;
SetPlayerPos(playerid,ePos[0],ePos[1],ePos[2]);
SetPlayerFacingAngle(playerid,ePos[3] - 180);
ETK[playerid] = 1;
PlayerPlaySound(playerid, 1085, 0.0,0.0,0.0);
SendClientMessage(playerid,0x00FF78FF,"{C3C3C3}» {FFFFFF}Etkinlige katildiniz! {E24234}Lütfen baslamasini bekleyin{FFFFFF}..");
TogglePlayerControllable(playerid,false);
	SetPVarString(playerid, "FreezedBy", "Etkinlik");
return 1;
}
CMD:esilahver(playerid, params[])
{

if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
new tmp[24], weap;
new WeapName[25];
if (sscanf(params, "s[24]", tmp)) return USmessage(playerid, "esilahver [Silah ID] '");
if(!IsNumeric(tmp)) weap = GetWeaponIDFromName(tmp); else weap = strval(tmp);
if(!IsValidWeapon(weap)) return HataMesaji(playerid,"Geçersiz silah idi girdiniz.");
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
new str[256];
GetWeaponName(weap, WeapName, sizeof(WeapName) );
format(str,256,"{F6C30F}« Etkinlik »{FFFFFF} {C0C0C0}%s {FFFFFF}adli yönetici etkinliktekilere{1E90FF} %s(%d){FFFFFF} silahini verdi.",oIsim(playerid),WeapName,weap);
for(new i;i<MAX_PLAYERS;i++)
{
if(IsPlayerInRangeOfPoint(i,10,X,Y,Z))
{
SendClientMessage(i,-1,str);
if(i != playerid)
{
GivePlayerWeapon(i,weap,150);
}
}
}
return 1;
}
CMD:ecan(playerid, params[])
{

if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
new Float:can;

if (sscanf(params, "f", can)) return USmessage(playerid, "ecan [Etkinlik Ismi] '");

if(can <= 0 || can > 100) return HataMesaji(playerid,"Geçersiz can miktarý girdiniz. Gireceðiniz miktar 100.0000-0.0000 arasý olmak zorundadýr.");
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
new str[256];
format(str,256,"{F6C30F}« Etkinlik »{FFFFFF} {C0C0C0}%s {FFFFFF}adli yönetici oyuncularin canini {1E90FF}%1.f{FFFFFF} yapti.",oIsim(playerid),can);
for(new i;i<MAX_PLAYERS;i++)
{
if(!IsPlayerConnected(i)) continue; if(IsPlayerNPC(i)) continue;
if(IsPlayerInRangeOfPoint(i,10,X,Y,Z))
{
SendClientMessage(i,-1,str);
if(i != playerid)
{
SetPlayerHealth(i,can);
}
}
}
return 1;
}
CMD:ezirh(playerid, params[])
{

if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
new Float:can;
if (sscanf(params, "f", can)) return USmessage(playerid, "ezirh [Etkinlik Ismi] '");

if(can <= 0 || can > 100) return HataMesaji(playerid,"Geçersiz zýrh miktarý girdiniz. Gireceðiniz miktar 100.0000-0.0000 arasý olmak zorundadýr.");
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
new str[256];
format(str,256,"{F6C30F}« Etkinlik »{FFFFFF} {C0C0C0}%s {FFFFFF}adli yönetici oyuncularin zirhini {1E90FF}%1.f{FFFFFF} yapti.",oIsim(playerid),can);
for(new i;i<MAX_PLAYERS;i++)
{
if(!IsPlayerConnected(i)) continue; if(IsPlayerNPC(i)) continue;
if(IsPlayerInRangeOfPoint(i,10,X,Y,Z))
{
SendClientMessage(i,-1,str);
if(i != playerid)
{
SetPlayerArmour(i,can);
}
}
}
return 1;
}
CMD:eskin(playerid, params[])
{

if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
new can;
if (sscanf(params, "i", can)) return USmessage(playerid, "eskin [Etkinlik Ismi] '");
if(can > 300 || can < 0) return HataMesaji(playerid,"Geçersiz Skin.");
if(can == 301) return 1;
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
new str[256];
format(str,256,"{F6C30F}« Etkinlik »{FFFFFF} {C0C0C0}%s {FFFFFF}adli yönetici oyuncularin skinini {1E90FF}%d{FFFFFF} yapti.",oIsim(playerid),can);
for(new i;i<MAX_PLAYERS;i++)
{
if(!IsPlayerConnected(i)) continue; if(IsPlayerNPC(i)) continue;
if(IsPlayerInRangeOfPoint(i,10,X,Y,Z))
{
SendClientMessage(i,-1,str);
if(i != playerid)
{
SetPlayerSkin(i,can);
}
}
}
return 1;
}
CMD:erespawn(playerid, params[])
{

if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;

new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
new str[256];
format(str,256,"{F6C30F}« Etkinlik »{FFFFFF} {C0C0C0}%s {FFFFFF}adli yönetici etkinliktekileri spawn etti..",oIsim(playerid));
for(new i;i<MAX_PLAYERS;i++)
{
if(!IsPlayerConnected(i)) continue; if(IsPlayerNPC(i)) continue;
if(IsPlayerInRangeOfPoint(i,10,X,Y,Z))
{
SendClientMessage(i,-1,str);
if(i != playerid)
{
if(IsPlayerInAnyVehicle(i)) DestroyVehicle(GetPlayerVehicleID(i));
SpawnPlayer(i);
ETK[i] = 0;
}
}
}
return 1;
}
CMD:eat(playerid, params[])
{

if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
if (!IsPlayerConnected(strlen(params))) return HataMesaji(playerid, "Oyuncu oyunda deðil.");
if (ETK[strlen(params)] != 1) HataMesaji(playerid, "Oyuncu senin etkinliðinde deðil.");
new str[300];
format(str, sizeof(str), "{F6C30F}« Etkinlik »{FFFFFF} Yetkili {C0C0C0}%s({FFFFFF}%d{C0C0C0}){FFFFFF} tarafýndan {C0C0C0}%s({FFFFFF}%d{C0C0C0}){FFFFFF} adli oyuncu etkinlikten atildi!", getName(playerid), playerid, getName(strlen(params)), strlen(params));
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
SetPlayerHealth(strlen(params), 0.0);
for(new i;i<MAX_PLAYERS;i++)
{
if(!IsPlayerConnected(i)) continue; if(IsPlayerNPC(i)) continue;
if(IsPlayerInRangeOfPoint(i,10,X,Y,Z))
{
SendClientMessage(i,-1,str);
}
}
return 1;
}

CMD:edisarm(playerid, params[])
{


if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
new str[256];
format(str,256,"{F6C30F}« Etkinlik »{FFFFFF} {C0C0C0}%s {FFFFFF}adli yönetici etkinliktekilerin silahýna el koydu.",oIsim(playerid));
for(new i;i<MAX_PLAYERS;i++)
{
if(!IsPlayerConnected(i)) continue; if(IsPlayerNPC(i)) continue;
if(IsPlayerInRangeOfPoint(i,10,X,Y,Z))
{
SendClientMessage(i,-1,str);
if(i != playerid)
{
ResetPlayerWeapons(i);
}
}
}
return 1;
}
CMD:estart(playerid, params[])
{


if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
new str[256];
format(str,256,"{F6C30F}« Etkinlik »{FFFFFF} {C0C0C0}%s {FFFFFF}adli yönetici herkesi cözdü! Etkinlik basladi!.",oIsim(playerid));
for(new i;i<MAX_PLAYERS;i++)
{
if(!IsPlayerConnected(i)) continue; if(IsPlayerNPC(i)) continue;
if(IsPlayerInRangeOfPoint(i,10,X,Y,Z))
{
SendClientMessage(i,-1,str);
if(ETK[i] != 0)
{
if(i != playerid)
{
TogglePlayerControllable(i,1);
SetPVarString(i, "FreezedBy", "Etkinlik");
}
}
}
}
return 1;
}
CMD:eparaver(playerid, params[])
{

if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
new tmp;

if (sscanf(params, "d", tmp)) return USmessage(playerid, "eparaver [Etkinlik Ismi] '");
new para = tmp;
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
new str[256];
format(str,256,"{F6C30F}« Etkinlik »{FFFFFF} {C0C0C0}%s {FFFFFF}adli yönetici etkinliktekilere {1E90FF}%d${FFFFFF} verdi.",oIsim(playerid),para);

for(new i;i<MAX_PLAYERS;i++)
{
if(!IsPlayerConnected(i)) continue; if(IsPlayerNPC(i)) continue;
if(IsPlayerInRangeOfPoint(i,10,X,Y,Z))
{
SendClientMessage(i,-1,str);
if(i != playerid)
{
GivePlayerMoney(i,para);
}
}
}
return 1;
}
CMD:edondur(playerid, params[])
{

if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
for(new i;i<MAX_PLAYERS;i++)
{
if(!IsPlayerConnected(i)) continue; if(IsPlayerNPC(i)) continue;
if(IsPlayerInRangeOfPoint(i,10,X,Y,Z))
{
if(i != playerid)
{
TogglePlayerControllable(i, 0);
//SetPlayerScore(i,GetPlayerScore(i)+para);
}}
}
return 1;
}
CMD:eskor(playerid, params[])
{

if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
new tmp;
if (sscanf(params, "i", tmp)) return USmessage(playerid, "eskor [Skor Miktari] '");
new para = tmp;
if(para > 10) return INmessage(playerid, "En fazla 10 skor verebilirsiniz.");
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
new str[256];
format(str,256,"{F6C30F}« Etkinlik »{FFFFFF} {C0C0C0}%s {FFFFFF}adli yönetici etkinliktekilere {1E90FF}%d{FFFFFF} miktar skor verdi.",oIsim(playerid),para);
for(new i;i<MAX_PLAYERS;i++)
{
if(!IsPlayerConnected(i)) continue; if(IsPlayerNPC(i)) continue;
if(IsPlayerInRangeOfPoint(i,10,X,Y,Z))
{
SendClientMessage(i,-1,str);
if(i != playerid)
{
SetPlayerScore(i,GetPlayerScore(i)+para);
}
}
}
return 1;
}
CMD:esay(playerid, params[])
{

if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
new tmp[256];
//tmp = strrest(cmdtext,idx);
if (sscanf(params, "s[25]", tmp)) return USmessage(playerid, "easay [Yazi] '");
new yazi[256];
format(yazi,256,"{C0C0C0}» Admin(%s): {6896D9}%s",oIsim(playerid),tmp);
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
for(new i;i<MAX_PLAYERS;i++)
{
if(!IsPlayerConnected(i)) continue; if(IsPlayerNPC(i)) continue;
if(IsPlayerInRangeOfPoint(i,10,X,Y,Z))
{
	SendClientMessage(playerid,-1, yazi);
}
}
return 1;
}
CMD:earacsil(playerid, params[])
{

if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
new a[256];
			for(new i=0; i<MAX_VEHICLES; i++){
if(CheckPlayerDistanceToVehicle(40,playerid,i)){
if (GetPlayerVehicleID(playerid) != i) DestroyVehicle(i);
	format(a,256,"{F6C30F}« Etkinlik »{FFFFFF} {C0C0C0}%s {FFFFFF}adli yönetici araclari sildi.",oIsim(playerid) );
}
}
new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
for(new i;i<MAX_PLAYERS;i++)
{
if(!IsPlayerConnected(i)) continue; if(IsPlayerNPC(i)) continue;
if(IsPlayerInRangeOfPoint(i,10,X,Y,Z))
{
SendClientMessage(i,-1, a);
}
}
return 1;
}
stock CheckPlayerDistanceToVehicle(Float:radi, playerid, vehicleid){
	if(IsPlayerConnected(playerid)){
	    new Float:PX,Float:PY,Float:PZ,Float:FX,Float:FY,Float:FZ;
	    GetPlayerPos(playerid,PX,PY,PZ);GetVehiclePos(vehicleid, FX,FY,FZ);
	    new Float:Distance = (FX-PX)*(FX-PX)+(FY-PY)*(FY-PY)+(FZ-PZ)*(FZ-PZ);
	    if(Distance <= radi*radi){return 1;}
	}return 0;
}
CMD:earac( playerid, params[ ] )
{

    if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
    new tmp[256];
    new Float:lX, Float:lY, Float:lZ, Float:lcX,Float:lAngle, Float:lcY, Float:lcZ;
	new a[256], asdffds[25];
    new idx;
	tmp = strtok(params, idx); new miktar = strval(tmp);
	if(!strlen(tmp)){ return USmessage(playerid, "earac [Araç Ismi/ID] '");}
	if(!IsNumeric(tmp)){miktar = GetVehicleModelIDFromName(tmp);}
	else{miktar = strval(tmp);} if(miktar < 400 || miktar > 611){return INmessage(playerid, "Gecersiz arac ID veya isimi girdiniz.");}
  	GetPlayerPos(playerid,lX,lY,lZ);
  	new aaa = GetPlayerVirtualWorld(playerid);
	format(a,256,"{F6C30F}« Etkinlik »{FFFFFF} {C0C0C0}%s {FFFFFF}adli yönetici etkinliktekilere {1E90FF}%s{FFFFFF} model araci verdi.",oIsim(playerid),CarName[miktar-400]);
	foreach (new i : Player){
	if(playerid != i && PlayerInfo[i][Level] < 8){
	if(IsPlayerInRangeOfPoint(i,50,lX,lY,lZ)){
		GetPlayerPos(i,lcX,lcY,lcZ); GetPlayerFacingAngle(i,lAngle);
		CreatePlayerVehicle(i, miktar);
		SetVehicleNumberPlate(asdffds[i], "{FF0015}Zero");
		SetVehicleVirtualWorld(asdffds[i], aaa);
		PutPlayerInVehicle(i,asdffds[i],0);
		SendClientMessage(i,-1, a);
	}
	}
    }
		format(a,sizeof a,"{F6C30F}« Etkinlik »{FFFFFF} {C0C0C0}%s {FFFFFF}model araci yanindakilere verdin.",CarName[miktar-400]);
		SendClientMessage(playerid,-1, a);

    return ( 1 );
}
CMD:esirala(playerid, params[])
{


if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
	new str[256];
	new varmi;
	new Float:lX, Float:lY, Float:lZ, Float:lC;
	new n = 1; GetPlayerPos(playerid,lX,lY,lZ); GetPlayerFacingAngle(playerid,lC);
	new aisim[30]; GetPlayerName(playerid,aisim,sizeof(aisim));
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(IsPlayerInRangeOfPoint(i,50,lX,lY,lZ) && PlayerInfo[playerid][Animator] == 0 && PlayerInfo[playerid][Level] == 0)
			{
				SetPlayerFacingAngle(i,lC);
				SetPlayerPos(i,lX + ((1.0+n) * floatsin(-lC, degrees)),lY + ((1.0+n) * floatcos(-lC, degrees)),lZ); TogglePlayerControllable(i,false);
				varmi ++; n++;
				format(str,256,"{F6C30F}« Etkinlik »{FFFFFF} {C0C0C0}%s {FFFFFF}yakýnýnda ki oyuncularý hizalý bir biçimde sýraladý.",oIsim(playerid));
				SendClientMessage(i,-1, str);
			}
		}
	}
	if(varmi==0){return SendClientMessage(playerid, -1, "{F6C30F}« Etkinlik »{FFFFFF} Yanýnýzda hiç oyuncu bulunmuyor.");}
	format(str,256,"{F6C30F}« Etkinlik »{FFFFFF} {C0C0C0}%s {FFFFFF}yakýnýnda ki oyuncularý hizalý bir biçimde sýraladý.",oIsim(playerid));
	return 1;
}
stock HataMesaji(playerid,mesaj[]) return INmessage(playerid, mesaj);
CMD:banka(playerid, params[]) return komut_hesap(playerid, params);
CMD:hesap(playerid, params[])
{
	if(GetPVarInt(playerid,"vspawner_active") != 0) return Hatamesaj(playerid, "Lütfen açýk olan menüleri kapatýn.", "Lütfen açýk olan menüleri kapatýn.");
	ShowPlayerDialog(playerid, 364, DIALOG_STYLE_LIST, "{E24234}[Z]ero{FFFFFF} - {E24234} Banka", "{00FF00}» {FFFFFF}Para Çek\n{00FF00}»{FFFFFF} Para Yatýr\n{00FF00}» {FFFFFF}Para Transferi\n{00FF00}» {FFFFFF}Prim Hesabýndan Para Çek", "Devam", "Kapat");
/*	new string[256];
	format(string, sizeof(string), "~l~Merhaba ~r~~h~%s", oIsim(playerid));
	PlayerTextDrawSetString(playerid, BankTD12, string);
	format(string, sizeof(string), "~l~Kullanilabilir Bakiye ~r~~h~%d$", PlayerInfo[playerid][Deposit]);
	PlayerTextDrawSetString(playerid, BankTD13, string);
	format(string, sizeof(string), "~l~Prim (Ikramiye): ~r~~h~%d$", PlayerInfo[playerid][Ikramiye]);
	PlayerTextDrawSetString(playerid, BankTD14, string);
	SelectTextDraw(playerid, 0xC4C4C4);
	TextDrawShowForPlayer(playerid, BankTD0);
	PlayerTextDrawShow(playerid, BankTD1);
	TextDrawShowForPlayer(playerid, BankTD2);
	TextDrawShowForPlayer(playerid, BankTD3);
	TextDrawShowForPlayer(playerid, BankTD4);
	TextDrawShowForPlayer(playerid, BankTD5);
	PlayerTextDrawShow(playerid, BankTD6);
	PlayerTextDrawShow(playerid, BankTD7);
	PlayerTextDrawShow(playerid, BankTD8);
	TextDrawShowForPlayer(playerid, BankTD9);
	PlayerTextDrawShow(playerid, BankTD10);
	PlayerTextDrawShow(playerid, BankTD11);
	PlayerTextDrawShow(playerid, BankTD12);
	PlayerTextDrawShow(playerid, BankTD13);
	PlayerTextDrawShow(playerid, BankTD14);
*/	return 1;//Bilgimesaj(playerid, "Görüntüyü kapatmak icin {E24234}' /hpbmn '{FFFFFF} yazin.", "Use the /hpbmn command for hiding.");
}
CMD:hpbmn(playerid, params[])
{
	bankaGizle(playerid);
	return 1;
}
stock bankaGizle(playerid)
{
	new string[256];
	format(string, sizeof(string), "~l~Merhaba ~r~~h~%s", oIsim(playerid));
	PlayerTextDrawSetString(playerid, BankTD12, string);
	format(string, sizeof(string), "~l~Kullanilabilir Bakiye: ~r~~h~%d$", PlayerInfo[playerid][Deposit]);
	PlayerTextDrawSetString(playerid, BankTD13, string);
	format(string, sizeof(string), "~l~Prim (Ikramiye): ~r~~h~%d$", PlayerInfo[playerid][Ikramiye]);
	PlayerTextDrawSetString(playerid, BankTD14, string);
	CancelSelectTextDraw(playerid);
	TextDrawHideForPlayer(playerid, BankTD0);
	PlayerTextDrawHide(playerid, BankTD1);
	TextDrawHideForPlayer(playerid, BankTD2);
	TextDrawHideForPlayer(playerid, BankTD3);
	TextDrawHideForPlayer(playerid, BankTD4);
	TextDrawHideForPlayer(playerid, BankTD5);
	PlayerTextDrawHide(playerid, BankTD6);
	PlayerTextDrawHide(playerid, BankTD7);
	PlayerTextDrawHide(playerid, BankTD8);
	TextDrawHideForPlayer(playerid, BankTD9);
	PlayerTextDrawHide(playerid, BankTD10);
	PlayerTextDrawHide(playerid, BankTD11);
	PlayerTextDrawHide(playerid, BankTD12);
	PlayerTextDrawHide(playerid, BankTD13);
	PlayerTextDrawHide(playerid, BankTD14);
	PlayerTextDrawHide(playerid, BankTD15);
	return 1;
}
CMD:etkyardim(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Animator] >= 1)) return YETERSIZSEVIYE2(playerid, 1), 1;
	new omur[2045];
	strcat(omur, "{FFFFFF} /eat - {E24234}Etkinliðinizde ki bir oyuncuyu etkinlikten atabilirsiniz.\n");
	strcat(omur, "{FFFFFF} /etkbaslat - {E24234}Bir etkinlik baþlatmaniza yarar.\n");
	strcat(omur, "{FFFFFF} /esilahver - {E24234}Etkinlik bolgesindekilere silah vermenize yarar.\n");
	strcat(omur, "{FFFFFF} /ecan - {E24234}Etkinlik bolgesindekilere girdiginiz miktar kadar can verir (/ecan 1).\n");
	strcat(omur, "{FFFFFF} /ezirh - {E24234}Etkinlik bolgesindekilere girdiginiz miktar kadar zirh verir (/ezirh 1).\n");
	strcat(omur, "{FFFFFF} /eskin - {E24234}Etkinliktekilerin skinini degiþtirirsiniz.\n");
	strcat(omur, "{FFFFFF} /erespawn - {E24234}Etkinlikteki herkesi etkinlikten atarsiniz (etkinlik iptal olur).\n");
	strcat(omur, "{FFFFFF} /edisarm - {E24234}Etkinlikteki herkesin silahlarini sifirlarsiniz.\n");
	strcat(omur, "{FFFFFF} /estart - {E24234}Bir etkinlik baþlattiysaniz oyunculari çozebilir yani maçi baþlatabilirsiniz.\n");
	strcat(omur, "{FFFFFF} /eparaver - {E24234}Etkinliktekilere para dagitabilirsiniz.\n");
	strcat(omur, "{FFFFFF} /esay - {E24234}Etkinlikle ilgili duyuru yapabilirsiniz. (tüm oyunculara gider)\n");
	strcat(omur, "{FFFFFF} /earac - {E24234}Etkinliktekilere araç verebilirsiniz.\n");
	strcat(omur, "{FFFFFF} /earacsil - {E24234}Etkinlikteki araçlarý silebilirsiniz.\n");
	strcat(omur, "{FFFFFF} /esirala - {E24234}Etkinliktekileri kuyruk þeklinde hizalica siralayabilirsiniz.\n");
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "ZeroTR - Etkinlik Sistemi", omur, "Tamam", "");
	return 1;
}
