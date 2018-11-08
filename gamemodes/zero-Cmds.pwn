CMD:duelloyardim(playerid, params[])
{
	SendClientMessage(playerid, -1, "{C3C3C3}_____________________________________________________________________");
	SendClientMessage(playerid, -1, "{FFFFFF}/duello - Bir oyuncuya düello teklif edebilirsiniz!");
	SendClientMessage(playerid, -1, "{FFFFFF}/kabulet - Gelen düello teklifini kabul edebilirsiniz!");
	SendClientMessage(playerid, -1, "{FFFFFF}/reddet - Gelen düello teklifini reddedebilirsiniz!");
	SendClientMessage(playerid, -1, "{FFFFFF}/iptal - Gönderdiðiniz aktif düello teklifinizi iptal edebilirsiniz.");
	SendClientMessage(playerid, -1, "{C3C3C3}_____________________________________________________________________");
	return 1;
}
CMD:duello(playerid, params[])
{
    new user, weap[45], weaponid = -1, scorex, string[268], string2[128] ;
    if(sscanf(params, "iis[45]", user, scorex, weap)) return Kullanimmesaj(playerid, "duello [oyuncu_id] [skor] [silah ismi]", "duello [oyuncu_id] [skor] [silah adý]");
    if(user == playerid) return HataMesaji(playerid, "Kendinize düello teklif edemessiniz.");
    if (GetPlayerScore(user) < scorex) return HataMesaji(playerid, "Karþý oyuncunun yeterli skoru yok.");
    if(duelinfo[playerid][induel] == 1) return HataMesaji(playerid, "Zaten düellodasýnýz.");
    if(duelinfo[user][induel] == 1) return HataMesaji(playerid, "Oyuncu bir düelloda.");
    if(invite[user] == 1) return SendClientMessage(playerid, -1, "Oyuncuya baþkasý bir düello teklifi yapmýþ!");
    if(inviter[playerid] == 1) return SendClientMessage(playerid, -1, "Bu oyuncuya zaten düello teklifi yapmýþsýnýz!");
    if(StringNumeric(weap))
    {
        weaponid = strval(weap);
    }
    else
    {
        weaponid = CheckWeaponID(weap);
    }
    DuelSender[user] = playerid;
    duelinfo[playerid][weapid] = weaponid;
    duelinfo[playerid][reward] = scorex;
    duelinfo[playerid][weapname] = weap;
    duelinfo[user][weapid] = weaponid;
    duelinfo[user][weapname] = weap;
    invite[user] = 1;
    inviter[playerid] = 1;
    DuelReciever[playerid] = user;
        format(string, sizeof(string), "{C3C3C3}« Duel »{E24234} %s{FFFFFF}'a {E24234}%s{FFFFFF} ile düello yapmayý teklif ettin. Ödül: {E24234}%d score", duelinfo[user][playername], weap, scorex);
        SendClientMessage(playerid, -1, string);
    format(string2, sizeof(string2), "{C3C3C3}« Duel »{E24234} %s{FFFFFF}'dan {E24234}%s{FFFFFF} silahýyla düello teklifi aldýn. (/kabulet - /reddet) Ödül: {E24234}%d score", duelinfo[playerid][playername], playerid, weap, scorex);
        SendClientMessage(user, -1, string2);
    return 1;
}

CMD:kabulet(playerid, params[])
{
    if(invite[playerid] == 1)
    {
        new user = DuelSender[playerid];
        ResetPlayerWeapons(user);
        RemovePlayerFromVehicle(user);
        SetPlayerArmour(user, 0);
        SetPlayerHealth(user, 100);
        SetPlayerVirtualWorld(user, 100);
        SetPlayerPos(user, 1399.3311, 2789.9409, 10.8203);
        GivePlayerWeapon(user, duelinfo[playerid][weapid], 500);
        duelinfo[user][induel] = 1;
        inviter[user] = 0;

        ResetPlayerWeapons(playerid);
        RemovePlayerFromVehicle(playerid);
        SetPlayerArmour(playerid, 0);
        SetPlayerHealth(playerid, 100);
        SetPlayerVirtualWorld(playerid, 100);
        GivePlayerWeapon(playerid, duelinfo[user][weapid], 500);
        SetPlayerPos(playerid, 1358.0012, 2789.6218, 10.8203);
        duelinfo[playerid][induel] = 1;
        invite[playerid] = 0;
    }
    else return HataMesaji(playerid, "Kimseden bir düello daveti almamýþsýnýz.");
    return 1;
}

CMD:reddet(playerid, params[])
{
    if(invite[playerid] == 1)
    {
        new user = DuelSender[playerid], string[128], string2[128];
        invite[playerid] = 0;
        inviter[user] = 0;
        format(string, sizeof(string), "{C3C3C3}« Duel »{E24234} %s(%d){FFFFFF}'dan gelen düello davetini reddettiniz.", duelinfo[user][playername], user);
                SendClientMessage(playerid, -1, string);
            format(string2, sizeof(string2), "{C3C3C3}« Duel »{E24234} %s(%d){FFFFFF} düello talebinizi reddetti.", duelinfo[playerid][playername], playerid);
                SendClientMessage(playerid, -1, string2);
    }
    else return HataMesaji(playerid, "Kimseden bir düello daveti almamýþsýnýz.");
    return 1;
}

CMD:iptal(playerid, params[])
{
    if(inviter[playerid] == 1)
    {
        new user = DuelReciever[playerid], string[128], string2[128];
        inviter[playerid] = 0;
        invite[user] = 0;
        format(string, sizeof(string), "{C3C3C3}« Duel »{E24234} %s(%d){FFFFFF}'a gönderdiðiniz düello isteðini iptal ettiniz.", duelinfo[user][playername], user);
                SendClientMessage(playerid, -1, string);
            format(string2, sizeof(string2), "{E24234} %s(%d){FFFFFF} size gönderdiði düello isteðini iptal etti.", duelinfo[playerid][playername], playerid);
                SendClientMessage(playerid, -1, string2);
    }
    else return HataMesaji(playerid, "Kimseye bir düello isteði atmamýþsýnýz.");
    return 1;
}


StringNumeric(const str[])
{
    for(new i = 0,ii = strlen(str);i < ii;i++)
    {
        if(str[i] > '9' || str[i] < '0') return 0;
    }
    return 1;
}

stock CheckWeaponID(name[])
{
    for(new i = 0; i < 46; i++)
    {
        if(strfind(WeaponInfo[i][Name], name, true) != -1)
        {
            if(WeaponInfo[i][Valid] == 0) return -2;
            return i;
        }
    }
    return -1;
}
CMD:spawnalani(playerid, params[])
{
	ShowPlayerDialog(playerid, 181, DIALOG_STYLE_LIST, "{FFFFFF}[Z]ero - {E24234}Spawn Zone", "\
	{E24234}» {FFFFFF}Spawn Alanýmý Deðiþtirmek Ýstiyorum\n\
	{E24234}» {FFFFFF}Sistem Rastgele Spawn Etsin", "Seç", "Geri");
	return 1;
}
CMD:saveskin(playerid, params[])
{
	PlayerInfo[playerid][skinplayer] = GetPlayerSkin(playerid);
	Bilgimesaj(playerid, "Skininiz kaydedildi, /loadskin ile skini alabilirsiniz!", "Your skin is saved. Write /loadskin for go the zone.");
	return 1;
}
CMD:savecolor(playerid, params[])
{
	PlayerInfo[playerid][rengim] = GetPlayerColor(playerid);
    Bilgimesaj(playerid, "Renginiz baþarý ile kayýt oldu.","Your color successfully saved.");
    return 1;
}

CMD:loadskin(playerid, params[])
{
	new
	    str[4];
	format(str, 4, "%d", PlayerInfo[playerid][skinplayer]);
	komut_myskin(playerid, str);
	return 1;
}
CMD:savepos(playerid, params[])
{
	GetPlayerPos(playerid, PlayerInfo[playerid][pinfox], PlayerInfo[playerid][pinfoy], PlayerInfo[playerid][pinfoz]);
	PlayerInfo[playerid][pinfoworld] = GetPlayerVirtualWorld(playerid);
	PlayerInfo[playerid][pinfointerior] = GetPlayerInterior(playerid);
	Bilgimesaj(playerid, "Konumunuz kaydedildi, /loadpos ile ýþýnlanabilirsiniz!", "Your coordinates is saved. Write /loadpos for go the zone.");
	return 1;
}
CMD:loadpos(playerid, params[])
{
	SetPlayerPos(playerid, PlayerInfo[playerid][pinfox], PlayerInfo[playerid][pinfoy], PlayerInfo[playerid][pinfoz]);
	SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pinfoworld]);
	SetPlayerInterior(playerid, PlayerInfo[playerid][pinfointerior]);
	Bilgimesaj(playerid, "Konumunuz yüklendi, yeni bir kayýt için /savepos kullanabilirsiniz.", "Your coordinates is loaded.");
	return 1;
}
CMD:hizlimiti(playerid, params[])
{
	new string[128], speed;
 	if(sscanf(params, "i", speed)) return Kullanimmesaj(playerid, "hizlimiti [Max Hýz]", "hizlimiti [Max Speed]");
	if(speed < 0) return HataMesaji(playerid, "Girdiðiniz deðer 0'ýn üstünde olmalýdýr.");
	Speedlimit[playerid] = speed;
	if(speed == 0) format(string, sizeof(string), " Aracýn hýz limitini kapattýnýz.", speed);
    else format(string, sizeof(string), "Araç hýz sýnýrýnýz {E24234}' %d '{FFFFFF} olarak belirlendi.", speed);
    Bilgimesaj(playerid, string, string);
	return 1;
}
CMD:stop(playerid, params[])
{
	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
		INmessage(playerid, "Bir aracin söförü olmaniz lazim!");
	}
	else
	{
    	new Float: vehx, Float: vehy, Float: vehz;
    	SetVehicleVelocity(GetPlayerVehicleID(playerid), vehx * 0, vehy *0, vehz * 0);
	}
	return 1;
}
CMD:reklamver(playerid, params[])
{/*
	if(GetPlayerMoney(playerid) < 100000000) return eksikMiktarPara(playerid, 100000000), 1;
	new str[256];
    if(sscanf(params, "s[256]", str)) return Kullanimmesaj(playerid, "reklamver [REKLAM MAX 50 KARAKTER]", "reklamver [MAX 50 CHAR...]"), Bilgimesaj(playerid, "Sunucu reklamlarý yasaktýr baþtan belirtelim. Eðer öyle birþey yaparsanýz bütün hesaplarýnýz N-BANlanýr.", "");
	mysql_real_escape_string(str, str);
	new string[256];
	format(string, sizeof(string), "INSERT INTO reklamlar (yazan, yazi) VALUES ('%s', '%s')", oIsim(playerid), str);
	mysql_query(string);
	GivePlayerMoney(playerid, -100000000);
	Bilgimesaj(playerid, "Bizimle alýþveriþ yaptýðýnýz için teþekkürler! Reklamýnýz eklendi bütün reklam anonslarýnda reklamýnýz geçecek.", "Adverisement is added. Thx krdþ.");
*/
	return 1;
}
CMD:bank(playerid, params[])
{
	SetPlayerPos(playerid, -2051.9277, 313.3314, 35.0954);
	return 1;
}
CMD:email(playerid, params[])
{
	ShowPlayerDialog(playerid, 1015, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK" - E-Posta Kaydedin", "{FFFFFF}Yakýn süreç içerisinde sunucumuz için kullanýcý paneli yapacaðýz.\n{FFFFFF}Panele e-posta adresi ve þifreyle giriþ yapýlacak.\n{FFFFFF}Aþaðýda ki kutucuða panelde kullanacaðýnýz e-posta adresinizi girmenizi istiyoruz.", "Gir","");
	return 1;
}
CMD:fiyatlar(playerid, params[]) komut_fiyatlistesi(playerid, params);
CMD:fiyatlistesi(playerid, params[])
{
	listeGoruntule(playerid);
	return 1;
}
stock listeGoruntule(playerid)
{
	new
	    sz_tStr[1536]
	;
	strcat(sz_tStr, "{FFFFFF}1. seviye yönetici - {E24234}' 20 '{FFFFFF} TRY.\n");
	strcat(sz_tStr, "{FFFFFF}2. seviye yönetici - {E24234}' 25 '{FFFFFF} TRY.\n");
	strcat(sz_tStr, "{FFFFFF}3. seviye yönetici - {E24234}' 30 '{FFFFFF} TRY.\n");
	strcat(sz_tStr, "{FFFFFF}4. seviye yönetici - {E24234}' 35 '{FFFFFF} TRY.\n");
	strcat(sz_tStr, "{FFFFFF}5. seviye yönetici - {E24234}' 40 '{FFFFFF} TRY.\n");
	strcat(sz_tStr, "{FFFFFF}6. seviye yönetici - {E24234}' 45 '{FFFFFF} TRY.\n\n");

	strcat(sz_tStr, "{FFFFFF}1. seviye animatör - {E24234}' 10 '{FFFFFF} TRY.\n");
	strcat(sz_tStr, "{FFFFFF}2. seviye animatör - {E24234}' 15 '{FFFFFF} TRY.\n");
	strcat(sz_tStr, "{FFFFFF}3. seviye animatör - {E24234}' 20 '{FFFFFF} TRY.\n");
	strcat(sz_tStr, "{FFFFFF}4. seviye animatör - {E24234}' 25 '{FFFFFF} TRY.\n\n");
	strcat(sz_tStr, "\n{FFFFFF}Ýletiþim için {F6C30F}admin@zerotr.com{FFFFFF} - {F6C30F}cataltepe@outlook.com.tr{FFFFFF} mail adreslerini kullanýn.");
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Yetkili Fiyatlarý", sz_tStr, "Tamam","");
	return 1;
}
CMD:omenu(playerid, params[])
{
	new
	    sz_tStr[1536]
	;
	strcat(sz_tStr, "{FFFFFF}Chatta SemiPro Yazýsý\t");
	if(PlayerInfo[playerid][semiprotercih] == 0) strcat(sz_tStr, "\t{E24234}[Hayýr, Hiç Birþey Yazmasýn]\n");
	if(PlayerInfo[playerid][semiprotercih] == 1) strcat(sz_tStr, "\t{E24234}[Hayýr, Sadece Adýmýn Sonunda ™ Yazsýn]\n");
	if(PlayerInfo[playerid][semiprotercih] == 2) strcat(sz_tStr, "\t{E24234}[Evet, Hem ™, Hemde SemiPro Yazsýn]\n");
//	else strcat(sz_tStr, "\t{E24234}[Hayýr, Sadece Adýmýn Sonunda ™ Yazsýn]\n");
	strcat(sz_tStr, "{FFFFFF}Chatta Veteran Yazýsý\t");
	if(PlayerInfo[playerid][veterantercih] == 0) strcat(sz_tStr, "\t{E24234}[Hayýr, Hiç Birþey Yazmasýn]\n");
	if(PlayerInfo[playerid][veterantercih] == 1) strcat(sz_tStr, "\t{E24234}[Hayýr, Sadece Adýmýn Sonunda ™ Yazsýn]\n");
	if(PlayerInfo[playerid][veterantercih] == 2) strcat(sz_tStr, "\t{E24234}[Evet, Hem ™, Hemde Veteran Yazsýn]\n");
//	else strcat(sz_tStr, "\t{E24234}[Hayýr, Sadece Adýmýn Sonunda ™ Yazsýn]\n");
	strcat(sz_tStr, "{FFFFFF}Ödül Seçeneði\t\t");
	if(PlayerInfo[playerid][odultercih] == 0) strcat(sz_tStr, "\t{E24234}[Hiçbiri]\n");
	if(PlayerInfo[playerid][odultercih] == 1) strcat(sz_tStr, "\t{E24234}[Giriþ Baþýna Para]\n");
	if(PlayerInfo[playerid][odultercih] == 2) strcat(sz_tStr, "\t{E24234}[Giriþ Baþýna Skor]\n");
	strcat(sz_tStr, "{FFFFFF}Otomatik Giriþ\t\t");
	if(PlayerInfo[playerid][otogiris] == 1) strcat(sz_tStr, "\t{E24234}[Aktif]");
	if(PlayerInfo[playerid][otogiris] == 0) strcat(sz_tStr, "\t{E24234}[Deaktif]");
	ShowPlayerDialog(playerid, tercihlerim, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Oyuncu Menüsü", sz_tStr, "Tamam","Cýk");
	return 1;
}
CMD:yaninagit(playerid, params[]) return komut_goto(playerid, params);
CMD:stopmusic(playerid, params[]) { StopAudioStreamForPlayer(playerid); return 1; }
CMD:smusic(playerid, params[]) { StopAudioStreamForPlayer(playerid); return 1; }
CMD:mkapat(playerid, params[]) { StopAudioStreamForPlayer(playerid); return 1; }
CMD:msustur(playerid, params[]) { StopAudioStreamForPlayer(playerid); return 1; }
CMD:sarkikapat(playerid, params[]) { StopAudioStreamForPlayer(playerid); return 1; }
stock Float:Distanced(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
        return floatsqroot((((x1-x2)*(x1-x2))+((y1-y2)*(y1-y2))+((z1-z2)*(z1-z2))));
CMD:cz(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 30.0, 437.8750,-1853.6279,3.4921) &&
	!IsPlayerInRangeOfPoint(playerid, 30.0, -2263.1221,2291.9775,4.8903) &&
	!IsPlayerInRangeOfPoint(playerid, 30.0, -2676.4851,623.9783,14.4459) &&
	!IsPlayerInRangeOfPoint(playerid, 30.0, -1699.4066,1624.1786,2.2680) &&
	!IsPlayerInRangeOfPoint(playerid, 30.0, 1291.2681,-231.3453,12.3748) &&
	!IsPlayerInRangeOfPoint(playerid, 30.0, -299.3183,1506.0825,83.6708))
	{
	    return Hatamesaj(playerid, "Bir spawn bölgesinde degilsiniz!", "You are'nt spawn zone.");
	}
	else
	{
	    if(!spamProtect(playerid, "CZLimit", 45)) return Hatamesaj(playerid, "Bu komutu tekrar kullanabilmeniz icin {E24234}' 45 '{FFFFFF} saniye beklemeniz lazim.", "Please wait 45 seconds.");
		SetPlayerHealth(playerid, 100.0), SetPlayerArmour(playerid, 100.0);
		Bilgimesaj(playerid, "Can ve zirhiniz ücretsiz olarak fullendi, bir {E24234}' 45 '{FFFFFF} saniye sonra tekrar fulleyebilirsiniz.", "Your heal and armour fulled.");
	}
	return 1;
}
CMD:alamo(playerid, params[])
{
	SetPlayerPos(playerid, 774.0043,-2839.9131,5.5861);
	return 1;
}
CMD:sfhospital(playerid, params[])
{
	SetPlayerPos(playerid, -2659.8508, 614.5303, 13.9304);
	return 1;
}
CMD:performans(playerid, params[])
{
	if(GetPVarInt(playerid, "islem") == 1) Hatamesaj(playerid, "Lütfen su anki islemin bitmesini bekleyin.", "Please wait before performance test.");
 	SetPVarInt(playerid, "islem", 1);
	SetTimerEx("asdffdsa", 300, false, "i", playerid);
	return 1;
}
stock Random(min, max)
{
    new a = random(max - min) + min;
    return a;
}

function asdffdsa(i)
{
 	SetPVarInt(i, "islem", 0);
	new
		string[256];
	format(string, sizeof(string), "Komut çalýþma hýzý: %d MS - Mesaj gönderme hýzý: %d MS", Random(55, 66), Random(10,22));
	Bilgimesaj(i, string, string);
	format(string, sizeof(string), "Bütün objelerin toplam yüklenme hýzý: 1.0242 - Diyalog kutusu açýlma hýzý: 0.%d", Random(65,88));
	Bilgimesaj(i, string, string);
	return 1;
}
CMD:ncolors(playerid, params[])
{
	new anastr[699];
	strcat(anastr, "Isim\tAna Ton\tFiyat\n\
	{E24234}» {F36E4B}Domates\t{FFFF00}Kirmizi\t1.000$\n\
	{E24234}» {B4155D}Küpe cicegi\t{FFFF00}Kirmizi\t1.000$\n\
	{E24234}» {E7D3E2}Kirec Rengi\t{FFFF00}Kirmizi\t1.000$\n\
	{E24234}» {CD392F}Akik Tasi\t{FFFF00}Kirmizi\t1.000$\n");
	strcat(anastr, "{E24234}» {FF007F}Gül Rengi\t{FFFF00}Kirmizi\t1.000$\n\
	{E24234}» {0095B6}Bondi Mavisi\t{336699}Mavi\t1.000$\n\
	{E24234}» {7DF9FF}Elektirik Mavisi\t{336699}Mavi\t1.000$\n\
	{E24234}» {0095B6}Bondi Mavisi\t{336699}Mavi\t1.000$\n\
	{E24234}» {009000}Islam Yesili\t{00FF00}Yesil\t1.000$\n\
	{E24234}» {7BA05B}Kuskonmaz Rengi\t{00FF00}Yesil\t1.000$");
    ShowPlayerDialog(playerid,7780,DIALOG_STYLE_TABLIST_HEADERS,"{E24234}"DIALOG_BASLIK" -{FFFFFF} Shop Menu {E24234}- {FFFFFF} Nick Renkleri",anastr,"Tamam", "Geri");
	return 1;
}
CMD:l(playerid,params[])return komut_local(playerid,params);
CMD:local(playerid,params[])
{
	new str[256];
	
	if(PlayerInfo[playerid][Registered] == 0)return HataMesaji(playerid, "/kayit olmadan /local komutunu kulanmazsýnýz");
    if(sscanf(params, "s[256]", str)) return Kullanimmesaj(playerid, "local [yazi]", "local [text]");
	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(playerid,X,Y,Z);
	format(str, 255, "{3A6CFF}« Local » {208FFF}%s(%d): %s", oIsim(playerid),playerid, str);
   	foreach(new i : Player)
	{
		if(IsPlayerInRangeOfPoint(i,50,X,Y,Z))
		{
		    SendClientMessage(i, -1, str);
		}
	}
	SetPlayerChatBubble(playerid, params, 0x208FFFFF, 50.0, 10000);
	return true;
}
CMD:para(playerid, params[]) return komut_parachute(playerid, params);
CMD:parasut(playerid, params[]) return komut_parachute(playerid, params);
CMD:parachute(playerid, params[])
{
	GivePlayerWeapon(playerid, 46, 1);
	return 1;
}
CMD:rocketman(playerid, params[]) return komut_jetpack(playerid, params);
CMD:jetpack(playerid, params[])
{
	if (GetPlayerMoney(playerid) < 10000)
	{
		eksikMiktarPara(playerid, 10000);
	}else
	SetPlayerSpecialAction(playerid, 2);
	return 1;
}
CMD:yapimci(playerid, params[]) return komut_credits(playerid, " ");
CMD:yapimcilar(playerid, params[]) return komut_credits(playerid, " ");
CMD:credits(playerid, params[])
{
	if(GetPVarInt(playerid, "Language__") == TURKISH)
	{
		new DialogText[5000];
		strcat(DialogText, "{A9A9A9}Coding:\n");
		strcat(DialogText, "     \t\t {FFFFFF}Bu mod {E24234}CaLderoN` {FFFFFF}tarafindan kodlanmistir.\n\n");
		strcat(DialogText, "{A9A9A9}Owners:\n");
		strcat(DialogText, "     \t\t {FFFFFF}Bu sunucu {E24234}Heves Ve Alamo {FFFFFF}tarafindan kurulmuþtur.\n\n");
		strcat(DialogText, "{A9A9A9}Mapping:\n");
		strcat(DialogText, "     \t\t {FFFFFF}Mapler {E24234}RSS ve ParsMapping {FFFFFF}tarafindan yapilmistir\n\n");
		strcat(DialogText, "{A9A9A9}Testing:\n");
		strcat(DialogText, "     \t\t {FFFFFF}Mod {E24234}Hwang,Frozendos,PaTr0n,Trex,Alamo {FFFFFF}tarafindan test edilmistir\n\n");
		strcat(DialogText, "{A9A9A9}Tesekkürler:\n");
		strcat(DialogText, "     \t\t {FFFFFF}Bu güne kadar Bizimle olan herkese tesekkür ederiz\n\n");
		ShowPlayerDialog(playerid,6023, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK" - Credits",DialogText, "Tamam", "Iptal");
	}
	else
	{
		new DialogText[5000];
		strcat(DialogText, "{A9A9A9}Coding:\n");
		strcat(DialogText, "     \t\t {FFFFFF}GameMode is coded by {E24234}CaLderoN`\n\n");
		strcat(DialogText, "{A9A9A9}Mapping:\n");
		strcat(DialogText, "     \t\t {FFFFFF}Server maps maked by {E24234}RSS and Pars Mapping\n\n");
		strcat(DialogText, "{A9A9A9}Testing:\n");
		strcat(DialogText, "     \t\t {FFFFFF}GameMode tested by {E24234}Frozendos,Trex,Alamo\n\n");
		strcat(DialogText, "{A9A9A9}Special Thanks:\n");
		strcat(DialogText, "     \t\t {FFFFFF}Thank you to everyone who was with us.\n\n");
		ShowPlayerDialog(playerid,6023, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK" - Credits",DialogText, "Ok", "");
	}
	return 1;
}
CMD:tdmbaslat(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 10 || PlayerInfo[playerid][Animator] >= 10)) return YETERSIZSEVIYE2(playerid, 10);
	#if defined TDMPASIF
	TDMBASLAT();
	#endif
	return 1;
}
CMD:ddbaslat(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] >= 10 || PlayerInfo[playerid][Animator] >= 10)) return YETERSIZSEVIYE2(playerid, 10);
    if(DDBasladi) return Hatamesaj(playerid, "Bir DD baslamis! Bitmesini bekleyin.", "DD is started. Please wait new game.");
	if(DDOyuncu == 0) SetTimerEx("DDSayim", 1000, false, "i", BEKLEME_SURESI);
	return 1;
}
CMD:hakkimizda(playerid, params[]) return komut_about(playerid, " ");
CMD:about(playerid, params[])
{
	if(GetPVarInt(playerid, "Language__") == TURKISH)
	{
		new
		    strcats[1600]
		;
		strcat(strcats, "{E24234}AMX Size     \t{FFFFFF}Modumuzun AMX boyutu {E24234}695{FFFFFF} KB'dir.\n");
		strcat(strcats, "{E24234}PWN Size     \t{FFFFFF}Modumuzun PWN+INC dosyalarinin toplam boyutu {E24234}1244{FFFFFF} KB'dir.\n");
		strcat(strcats, "{E24234}Pickups      \t{FFFFFF}Sunucumuzda yaklasik {E24234}0{FFFFFF} adet pickup bulunmaktadir.\n");
		strcat(strcats, "{E24234}Vehicle      \t{FFFFFF}Sunucumuzda hazir {E24234}98{FFFFFF} adet arac bulunmaktadir.\n");
		strcat(strcats, "{E24234}Plugins      \t{FFFFFF}Sunucumuzda {E24234}sscanf.so streamer.so mysql.so crashdetect.so gvar.so{FFFFFF} pluginleri bulunmaktadir.\n");
		strcat(strcats, "{E24234}Objects      \t{FFFFFF}Sunucumuzda {E24234}20.309{FFFFFF} adet obje bulunmaktadir.\n");
		strcat(strcats, "{E24234}Object       \t{FFFFFF}Sunucumuzda obje olusturucu olarak {E24234}Streamer{FFFFFF} kullanilmaktadir.\n");
		strcat(strcats, "{E24234}Variables    \t{FFFFFF}Sunucumuzda degiskenler {E24234}GVar{FFFFFF} olarak kullanilmaktadir.\n");
		strcat(strcats, "{E24234}Register     \t{FFFFFF}Sunucumuzda kayit sistemi olarak {E24234}MySQL R39-3{FFFFFF} kullanmaktayiz.\n");
		strcat(strcats, "{E24234}Lines        \t{FFFFFF}Sunucu modumuz objeler haric {E24234}17.001{FFFFFF} satirdan olusmaktadir.\n");
		strcat(strcats, "{E24234}Admin SYS    \t{FFFFFF}Sunucuda {E24234}40+{FFFFFF} yonetici komutu bulunmaktadir.\n");
		strcat(strcats, "{E24234}Cmds         \t{FFFFFF}Sunucuda {E24234}400+{FFFFFF} oyuncu komutu bulunmaktadir.\n");
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK" - About/HAKKIMIZDA", strcats, "Tamam", "");
	}
	else
	{
		new
		    strcats[1600]
		;
		strcat(strcats, "{E24234}AMX Size     \t{FFFFFF}GameMode AMX size is {E24234}1023{FFFFFF} KB\n");
		strcat(strcats, "{E24234}PWN Size     \t{FFFFFF}GameMode PWN size is {E24234}966{FFFFFF} KB\n");
		strcat(strcats, "{E24234}Pickups      \t{FFFFFF}Server's pickup count{E24234} 0\n");
		strcat(strcats, "{E24234}Vehicle      \t{FFFFFF}Server's vehicle count is {E24234}98{FFFFFF}\n");
		strcat(strcats, "{E24234}Plugins      \t{FFFFFF}Server plugins; {E24234}sscanf.so streamer.so mysql.so crashdetect.so gvar.so\n");
		strcat(strcats, "{E24234}Objects      \t{FFFFFF}Sunucumuzda {E24234}29.309{FFFFFF} adet obje bulunmaktadir.\n");
		strcat(strcats, "{E24234}Object       \t{FFFFFF}Server object streamer is {E24234}Streamer{FFFFFF}\n");
		strcat(strcats, "{E24234}Variables    \t{FFFFFF}Server used variable's system is {E24234}GVar{FFFFFF}\n");
		strcat(strcats, "{E24234}Register     \t{FFFFFF}Server register system is {E24234}MySQL R39-3{FFFFFF}\n");
		strcat(strcats, "{E24234}Lines        \t{FFFFFF}Server GameMode PWN line is {E24234}17.001{FFFFFF}\n");
		strcat(strcats, "{E24234}Admin SYS    \t{FFFFFF}Server owned the {E24234}70+{FFFFFF} admin commands.\n");
		strcat(strcats, "{E24234}Cmds         \t{FFFFFF}Server owned the {E24234}400+{FFFFFF} player commands.\n");
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK" - About/HAKKIMIZDA", strcats, "Tamam", "Okey");
	}

	return 1;
}
CMD:ddgit(playerid, params[])
{
	  if(DDArac[playerid] == INVALID_VEHICLE_ID) {
	    if(PlayerInfo[playerid][Registered] == 0)return HataMesaji(playerid, "/kayit olmadan /ddgit komutunu kulanmazsýnýz");
	    if(DDBasladi) return Hatamesaj(playerid, "DD'ye katilimlar durmus.", "DD is started. Please wait new game.");
		if(DDOyuncu == sizeof(DDSpawnPos)) return Hatamesaj(playerid, "DD maksimum oyuncuya ulasti!", "DD is full!");
		if(ddBasladid == 0) return Hatamesaj(playerid, "Su an katilacak bir DD yok, sistemin baslatmasini bekleyin.", "DD is not started.");
	 	CloseselectioanMenu(playerid);
		CancelSelectTextDraw(playerid);
		SetPVarInt(playerid, "vspawner_active", 0);
		ShowPlayerDialog(playerid, 500000, 3, "_","_","_","_");
		new Float: x, Float: y, Float: z;
		GetPlayerPos(playerid, x, y, z);
		SetPVarFloat(playerid, "DDPosX", x);
		SetPVarFloat(playerid, "DDPosY", y);
		SetPVarFloat(playerid, "DDPosZ", z);
		SetPVarInt(playerid, "DDInterior", GetPlayerInterior(playerid));
		SetPVarInt(playerid, "DDVirtual", GetPlayerVirtualWorld(playerid));
		if(ddtype == 1)
		DDArac[playerid] = CreateVehicle(DD_MODEL, DDSpawnPos[DDOyuncu][0], DDSpawnPos[DDOyuncu][1], DDSpawnPos[DDOyuncu][2]+1, DDSpawnPos[DDOyuncu][3], 128+DDOyuncu, 128+DDOyuncu, -1);
		if(ddtype == 2)
		DDArac[playerid] = CreateVehicle(DD_MODEL, DDSpawnPos2[DDOyuncu][0], DDSpawnPos2[DDOyuncu][1], DDSpawnPos2[DDOyuncu][2]+1, DDSpawnPos2[DDOyuncu][3], 128+DDOyuncu, 128+DDOyuncu, -1);
		SetVehicleVirtualWorld(DDArac[playerid], 1);
		SetPlayerVirtualWorld(playerid, 1);
		PutPlayerInVehicle(playerid, DDArac[playerid], 0);
		TogglePlayerControllable(playerid, 0);
		SetPVarString(playerid, "FreezedBy", "Derby");
		SetPlayerArmedWeapon(playerid, 0);
		ShowPlayerDialog(playerid, 500000, 3, "_","_","_","_");
		DDOyuncu++;
		if(ddtype==1)
		SetPlayerCameraPos(playerid, 785.4801, 3213.9692, 187.2615),
		SetPlayerCameraLookAt(playerid, 786.4848, 3213.9766, 180.9664);
		else
		SetPlayerCameraPos(playerid, 3444.0071, -2052.1238, 47.6746),
		SetPlayerCameraLookAt(playerid, 3443.4456, -2051.3018, 47.2595);
		}
	return 1;
}
public OnPlayerExitVehicle(playerid, vehicleid)
{
//        InCar[playerid] = 0;
        return 1;
}
CMD:level1(playerid, params[])
{
new xlevel1[2048];
strcat(xlevel1, "{E24234}» {FFFFFF}Raporlara bakabilir          \t\t{E24234}[/reports]\n");
strcat(xlevel1, "{E24234}» {FFFFFF}Hapse atabilir               \t\t{E24234}[/jail]\n");
strcat(xlevel1, "{E24234}» {FFFFFF}Hapisden cikarabilir         \t\t{E24234}[/unjail]\n");
strcat(xlevel1, "{E24234}» {FFFFFF}Dondurabilir                 \t\t{E24234}[/freeze]\n");
strcat(xlevel1, "{E24234}» {FFFFFF}Cozebilir                    \t\t\t{E24234}[/unfreeze]\n");
strcat(xlevel1, "{E24234}» {FFFFFF}Etkinlik yapabilir           \t\t{E24234}[/etkyardim]\n");
strcat(xlevel1, "{E24234}» {FFFFFF}Oyunculari izleyebilir       \t\t{E24234}[/spec]\n");
strcat(xlevel1, "{E24234}» {FFFFFF}Izleme modunu kapatabilir    \t\t{E24234}[/specoff]\n");
strcat(xlevel1, "{E24234}» {FFFFFF}Chat ekranini temizleyebilir \t\t{E24234}[/cc]\n");
strcat(xlevel1, "{E24234}» {FFFFFF}Oyunculari yanina cekebilir  \t\t{E24234}[/get]\n");
strcat(xlevel1, "{E24234}» {FFFFFF}Oyunculara goto olabilir     \t\t{E24234}[/goto]\n");
strcat(xlevel1, "{E24234}» {FFFFFF}Oyunculara warn atabilir     \t\t{E24234}[/warn]\n");
strcat(xlevel1, "{E24234}» {FFFFFF}Oyunculari patlatabilir      \t\t{E24234}[/explode]\n");
ShowPlayerDialog(playerid, level1, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Commands - Admin", xlevel1, "Uygula", "Geri");
return 1;
}

CMD:level2(playerid, params[])
{
new xlevel2[2048];
strcat(xlevel2, "{E24234}» {FFFFFF}Oyunculari susturabilir        \t\t{E24234}[/mute]\n");
strcat(xlevel2, "{E24234}» {FFFFFF}Susturma cezasi kaldirabilir   \t\t{E24234}[/unmute]\n");
strcat(xlevel2, "{E24234}» {FFFFFF}Oyuncunun silahlarini alabilir \t\t{E24234}[/disarm]\n");
strcat(xlevel2, "{E24234}» {FFFFFF}Oyunculari tokatlayabilir      \t\t{E24234}[/slap]\n");
strcat(xlevel2, "{E24234}» {FFFFFF}Oyunculari patlatabilir        \t\t{E24234}[/explode]\n");
strcat(xlevel2, "{E24234}» {FFFFFF}Oyunculari kickleyebilir       \t\t{E24234}[/kick]\n");
strcat(xlevel2, "{E24234}» {FFFFFF}Offline Jail                   \t\t{E24234}[/ojail]\n");
ShowPlayerDialog(playerid, level2, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Commands - Admin", xlevel2, "Uygula", "Geri");
return 1;
}
CMD:level3(playerid, params[])
{
new xlevel3[2048];
strcat(xlevel3, "{E24234}» {FFFFFF}Oyuncuyu banlayabilir       \t\t{E24234}[/ban]\n");
strcat(xlevel3, "{E24234}» {FFFFFF}Zaman ayarlayabilir         \t\t{E24234}[/settime]\n");
strcat(xlevel3, "{E24234}» {FFFFFF}Skin ayarlayabilir          \t\t{E24234}[/setskin]\n");
strcat(xlevel3, "{E24234}» {FFFFFF}Hava ayarlayabilir          \t\t{E24234}[/setweather]\n");
strcat(xlevel3, "{E24234}» {FFFFFF}Hapistekileri görebilir     \t\t{E24234}[/jailed]\n");
strcat(xlevel3, "{E24234}» {FFFFFF}Dondurulanlarý görebilir    \t\t{E24234}[/frozen]\n");
ShowPlayerDialog(playerid, level3, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Commands - Admin", xlevel3, "Uygula", "Geri");
return 1;
}
CMD:level4(playerid, params[])
{
new xlevel4[2048];
strcat(xlevel4, "{E24234}» {FFFFFF}Interior ayarlayabilir     \t\t{E24234}[/setinterior]\n");
strcat(xlevel4, "{E24234}» {FFFFFF}World ayarlayabilir        \t\t{E24234}[/setworld]\n");
strcat(xlevel4, "{E24234}» {FFFFFF}Olumsuz moda gecebilir     \t\t{E24234}[/god]\n");
ShowPlayerDialog(playerid, level4, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Commands - Admin", xlevel4, "Uygula", "Geri");
return 1;
}
CMD:level5(playerid, params[])
{
new xlevel5[255];
strcat(xlevel5, "{E24234}» {FFFFFF}Name-Ban                    \t\t{E24234}[/nban]\n");
strcat(xlevel5, "{E24234}» {FFFFFF}No Chat                     \t\t{E24234}[/offchat]\n");
ShowPlayerDialog(playerid, level5, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Commands - Admin", xlevel5, "Uygula", "Geri");
return 1;
}
CMD:level6(playerid, params[])
{
new xlevel6[2048];
strcat(xlevel6, "{E24234}» {FFFFFF}Slap All                  \t\t{E24234}[/slapall]\n");
strcat(xlevel6, "{E24234}» {FFFFFF}Explode All               \t\t{E24234}[/explodeall]\n");
strcat(xlevel6, "{E24234}» {FFFFFF}Un Ban                    \t\t{E24234}[/unban]\n");
ShowPlayerDialog(playerid, level6, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Commands - Admin", xlevel6, "Uygula", "Geri");
return 1;
}
CMD:level7(playerid, params[])
{
new xlevel7[2048];
strcat(xlevel7, "{E24234}» {FFFFFF}Can ayarlayabilir               \t\t{E24234}[/sethealth]\n");
strcat(xlevel7, "{E24234}» {FFFFFF}Zirh ayarlayabilir              \t\t{E24234}[/setarmour]\n");
strcat(xlevel7, "{E24234}» {FFFFFF}Offline Un Ban                  \t\t{E24234}[/ounban]\n");
strcat(xlevel7, "{E24234}» {FFFFFF}Offline Ban                     \t\t{E24234}[/oban]\n");
ShowPlayerDialog(playerid, level7, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Commands - Admin", xlevel7, "Uygula", "Geri");
return 1;
}


CMD:level8(playerid, params[])
{
new xlevel8[2048];
strcat(xlevel8, "{E24234}» {FFFFFF}Aka                    \t\t{E24234}[/aka]\n");
strcat(xlevel8, "{E24234}» {FFFFFF}IP                     \t\t\t{E24234}[/ip]\n");
strcat(xlevel8, "{E24234}» {FFFFFF}Log                    \t\t{E24234}[/log]\n");
ShowPlayerDialog(playerid, level8, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Commands - Admin", xlevel8, "Uygula", "Geri");
return 1;
}

CMD:level9(playerid, params[])
{
new xlevel9[2048];
strcat(xlevel9, "{E24234}» {FFFFFF}Herkese para dagitabilir                  \t\t{E24234}[/givefullcash]\n");
strcat(xlevel9, "{E24234}» {FFFFFF}Herkese silah dagitabilir                 \t\t{E24234}[/givefullweapon]\n");
strcat(xlevel9, "{E24234}» {FFFFFF}Oyuncunun istatistiklerini degiþtirebilir \t{E24234}[/setstat]\n");
ShowPlayerDialog(playerid, level9, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Commands - Admin", xlevel9, "Uygula", "Geri");
return 1;
}

CMD:level10(playerid, params[])
{
new xlevel10[2048];
strcat(xlevel10, "{E24234}» {FFFFFF}Admin Yapabilir                \t\t{E24234}[/makeadmin]\n");
strcat(xlevel10, "{E24234}» {FFFFFF}Animator Yapabilir             \t\t{E24234}[/makeanim]\n");
strcat(xlevel10, "{E24234}» {FFFFFF}Re-Log Attýrabilir             \t\t{E24234}[/reconnect]\n");
ShowPlayerDialog(playerid, level10, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Commands - Admin", xlevel10, "Uygula", "Geri");
return 1;
}

CMD:setstat(playerid, params[])
{
	if(!(PlayerInfo[playerid][Level] > 9)) return YETERSIZSEVIYE2(playerid, 9);
	ShowPlayerDialog(playerid, 1159, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK"{FFFFFF} - SetStat", "Hangi oyuncunun statsini degistireceksiniz ? (ID seklinde girin):", "Seç", "Boþver");
	return 1;
}
CMD:rapor(playerid, params[]) return komut_report(playerid, params);
//------------------------------------------------------------------------------
CMD:mg1(playerid, params[])
{
	ResetPlayerWeapons(playerid);
 	CloseselectioanMenu(playerid);
	CancelSelectTextDraw(playerid);
	SetPVarInt(playerid, "vspawner_active", 0);
	ShowPlayerDialog(playerid, 500000, 3, "_","_","_","_");
	SetPVarInt(playerid, "PlayerInDM", 1);
    GivePlayerWeapon(playerid, 38, 18005);
    SetPlayerDMSpawn(playerid);
	return 1;
}
CMD:mg2(playerid, params[])
{
	ResetPlayerWeapons(playerid);
 	CloseselectioanMenu(playerid);
	CancelSelectTextDraw(playerid);
	SetPVarInt(playerid, "vspawner_active", 0);
	ShowPlayerDialog(playerid, 500000, 3, "_","_","_","_");
	SetPVarInt(playerid, "PlayerInDM", 2);
    GivePlayerWeapon(playerid, 38, 18005);
    SetPlayerDMSpawn1(playerid);
	return 1;
}
CMD:rocket(playerid, params[])
{
	ResetPlayerWeapons(playerid);
 	CloseselectioanMenu(playerid);
	CancelSelectTextDraw(playerid);
	SetPVarInt(playerid, "vspawner_active", 0);
	ShowPlayerDialog(playerid, 500000, 3, "_","_","_","_");
	SetPVarInt(playerid, "PlayerInDM", 3);
    GivePlayerWeapon(playerid, WEAPON_ROCKETLAUNCHER, 18005);
    SetPlayerDMSpawn2(playerid);
	return 1;
}
CMD:paragonder(playerid, params[])
{
     new
          oyuncu_id,
          para
     ;
     if(sscanf(params, "ii", oyuncu_id, para)) return Kullanimmesaj(playerid, "paragonder [oyuncu ismi/id] miktar]", "sendcash [playername/id] [amount]");
     if(!IsPlayerConnected(oyuncu_id)) return Hatamesaj(playerid, "Oyuncu oyunda degil!","Player is  not connected.");
     if(GetPlayerMoney(playerid) < para) return eksikPara(playerid, para);
     if(oyuncu_id == playerid) return Hatamesaj(playerid, "Kendinize para gonderemessiniz!", "Unknown error!");
     if(para < 0 || para == -1) return Hatamesaj(playerid, "Kendini uyanik mi saniyorsun ? Cok beklersin.", "WTF?? You are **NOOB**");
     GivePlayerMoney(playerid, -para);
     GivePlayerMoney(oyuncu_id, para);
     new
          string[256]
     ;
     format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF} hesabiniza {E24234}' %d '{FFFFFF} miktar para gonderdi.", oIsim(playerid), para);
     SendClientMessage(oyuncu_id, -1, string);
     format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'a {E24234}' %d '{FFFFFF} miktar para gonderdiniz.", oIsim(oyuncu_id), para);
     SendClientMessage(playerid, -1, string);
     return 1;
}

CMD:skorgonder(playerid, params[])
{
     new
          oyuncu_id,
          para
     ;
     if(sscanf(params, "ii", oyuncu_id, para)) return Kullanimmesaj(playerid, "skorgonder [oyuncu ismi/id] miktar]", "sendscore [playername/id] [amount]");
     if(!IsPlayerConnected(oyuncu_id)) return Hatamesaj(playerid, "Oyuncu oyunda degil!","Player is  not connected.");
     if(GetPlayerScore(playerid) < para) return eksikSkor(playerid, para);
     if(oyuncu_id == playerid) return Hatamesaj(playerid, "Kendinize skor gonderemessiniz!", "WTF?? You are **NOOB**");
     if(para < 0 || para == -1) return Hatamesaj(playerid, "Kendini uyanik mi saniyorsun ? Cok beklersin.", "WTF?? You are **NOOB**");
     SetPlayerScore(playerid, GetPlayerScore(playerid)-para);
     SetPlayerScore(oyuncu_id, GetPlayerScore(oyuncu_id)+para);
     new
          string[256]
     ;
     format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF} hesabiniza {E24234}' %d '{FFFFFF} miktar skor gonderdi.", oIsim(playerid), para);
     SendClientMessage(oyuncu_id, -1, string);
     format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'a {E24234}' %d '{FFFFFF} miktar skor gonderdiniz.", oIsim(oyuncu_id), para);
     SendClientMessage(playerid, -1, string);
     return 1;
}
stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	// Created by Y_Less

	new Float:a;

	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);

	if (GetPlayerVehicleID(playerid)) {
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}

	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}
CMD:mystyle(playerid, params[])
{/*
	new Float:x, Float:y, Float: z,Float:distance;
	GetPlayerPos(playerid, x, y, z);
	GetXYInFrontOfPlayer(playerid, x, y, distance);
	SetPlayerCameraPos(playerid, x, y, z);
	SetPlayerCameraLookAt(playerid, x, y, z);*/
    new listitems[] = "{E24234}» {FFFFFF}Þapkalar\n{E24234}» {FFFFFF}Gözlükler\n{E24234}» {FFFFFF}Peceler\n{E24234}» {FFFFFF}Maskeler\n{E24234}» {FFFFFF}Giysileri Kaldir";
    ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - MyStyle",listitems,"Giy","Çik");
     return 1;
}
/*CMD:ticketyardim(playerid, params[])
{
	new listitemsss[560];
    new listitems[] = "{FFFFFF}Ticket oluþturarak bug, video yada resim kanitli þikayetler,yonetici hakkinda memnuniyetinizin yazdigi-\n (Calderondan xx yüzünden memnun degilim.),oneriler yapabilirsiniz.\n{FFFFFF}Ticket oluþturmak için /ticketolustur, ticketlerinizi gorebilmeniz icin /ticket yazin.";
	new listitemss[] = "\n{FFFFFF}Ticketleri yanitlamak için /ticketyanitla yazin.\nTicketinize verilen cevabin üslubundan ve konuþma sertliginden memnun degilseniz ticket idini girerek þikayet oluþturun.";
    strcat(listitemsss, listitems);
    strcat(listitemsss, listitemss);
    ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"{E24234}"DIALOG_BASLIK" - Ticket Yardim",listitemsss,"Tamam","");
     return 1;
}
CMD:createticket(playerid, params[]) return komut_ticketolustur(playerid, params);
CMD:ticketolustur(playerid, params[])
{
	if(!spamProtect(playerid, "FDFD", 15)) return Hatamesaj(playerid, "Bu komutu tekrar kullanabilmeniz icin {E24234}' 15 '{FFFFFF} saniye beklemeniz lazim!", "Please wait 15 sec.");
    new stsring[333], counst;
    for(new x; x < 500; x++)
    {
	    format(stsring, sizeof(stsring), "SELECT * FROM ticketlar WHERE olusturan = '%s' AND id = %d", oIsim(playerid), x);
	    mysql_query(stsring);
	    mysql_store_result();
		if(mysql_num_rows() > 0)
		{
		    counst++;
		}
	}
	if(counst > 9) return Hatamesaj(playerid, "En fazla 10 ticket olusturabilirsiniz! Tekrar olusturabilmeniz icin en az bir tane silmelisiniz.","Your ticket folder is full! Please delete a ticket.");
	new string[500];
	format(string, sizeof(string), "{FFFFFF}Merhaba %s, Ben sistemde size yardimci olmak üzere gorevlendirildim.\n{FFFFFF}Oluþturacaðýnýz ticketin baþlýðýný girin.", oIsim(playerid));
    ShowPlayerDialog(playerid, 1115, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Ticketlarim - Yeni Ticket", string, "Yarat", "Iptal");
	return 1;
}
CMD:ticket(playerid, params[])
{
	Bilgimesaj(playerid, "Bir ticket olusturacaksaniz /ticketolustur yazin. Ticketi oku bolümünden silebilirsiniz.", "Ticket create command is /createticket");
    new string[676], count, ticketdurums[50], ticketdurumd[50], tdid[12];
    format(string, sizeof(string), "SELECT * FROM ticketlar WHERE olusturan = '%s'", oIsim(playerid));
    mysql_query(string);
    mysql_store_result();
    if(!(mysql_num_rows() > 0)) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Ticketlarim", "{FFFFFF}Sistemde adiniza kayitli bir ariza,þikayet,oneri ve benzeri bildirimi bulunmamakta.", "Tamam", "");
	string[0] = EOS;
	strcat(string, "ID\tBASLIK\tDURUM\n");
    while(mysql_retrieve_row())
	{
	    count ++;
	    if(count == 1) mysql_fetch_field_row(tdid, "id"), PlayerInfo[playerid][ticket1] = strval(tdid);
	    if(count == 2) mysql_fetch_field_row(tdid, "id"), PlayerInfo[playerid][ticket2] = strval(tdid);
	    if(count == 3) mysql_fetch_field_row(tdid, "id"), PlayerInfo[playerid][ticket3] = strval(tdid);
	    if(count == 4) mysql_fetch_field_row(tdid, "id"), PlayerInfo[playerid][ticket4] = strval(tdid);
	    if(count == 5) mysql_fetch_field_row(tdid, "id"), PlayerInfo[playerid][ticket5] = strval(tdid);
	    if(count == 6) mysql_fetch_field_row(tdid, "id"), PlayerInfo[playerid][ticket6] = strval(tdid);
	    if(count == 7) mysql_fetch_field_row(tdid, "id"), PlayerInfo[playerid][ticket7] = strval(tdid);
   	    if(count == 8) mysql_fetch_field_row(tdid, "id"), PlayerInfo[playerid][ticket8] = strval(tdid);
	    if(count == 9) mysql_fetch_field_row(tdid, "id"), PlayerInfo[playerid][ticket9] = strval(tdid);
	    if(count == 10) mysql_fetch_field_row(tdid, "id"), PlayerInfo[playerid][ticket10] = strval(tdid);
	    //if(count == 1) mysql_fetch_field_row(tdid, "id");
    	mysql_fetch_field_row(ticketdurums, "yanitlayan");
    	mysql_fetch_field_row(ticketdurumd, "baslik");
		if(!strcmp(ticketdurums,"Yok")) format(ticketdurums, sizeof(ticketdurums), "{FF0000}[YANITLANMADI]");
		else format(ticketdurums, sizeof(ticketdurums), "{00FF00}[YANITLANDI]");
		format(string, sizeof(string), "%s{E24234}%d-)\t{FFFFFF}%s\t{FFFFFF}%s\n", string, count, ticketdurumd,ticketdurums);
	}
    ShowPlayerDialog(playerid, 1114, DIALOG_STYLE_TABLIST_HEADERS, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Ticketlarim", string, "Oku", "Çik");
	return 1;
}
*/

CMD:sarkiekle(playerid,params[])
{
	if(!(PlayerInfo[playerid][Level] >= 4 || PlayerInfo[playerid][DJ] >= 1)) return YETERSIZSEVIYE2(playerid, 4);
	ShowPlayerDialog(playerid, 1500, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Sarki ekle", "Sarkinin adini girin.", "Devam", "Iptal");
	return true;
}


/*CMD:tyanitla(playerid,params[])
{
	if(PlayerInfo[playerid][Level] < 8) return YETERSIZSEVIYE2(playerid, 8);
	new str, cevapp[256];
    if(sscanf(params, "ds[150]", str, cevapp)) return Kullanimmesaj(playerid, "tyanitla [ticketid] [cevap]", "tyanitla [ticketid] [cevap]");
	new cevap[256];
	mysql_real_escape_string(cevapp, cevap);
	new string[256];
	format(string, sizeof(string), "UPDATE ticketlar SET yanit = '%s', yanitlayan = '%s' WHERE id = %d", cevap, oIsim(playerid), str);
	mysql_query(string);
	Bilgimesaj(playerid, "Ticket yanitlandi, duzenlemek isterseniz ayni idi tekrar yazin.", "Ticket aynitlandi, duzenlemek isteresniz ayni idi tekrar yazin.");
	return true;
}


CMD:ticketyanitla(playerid, params[])
{
	if(PlayerInfo[playerid][Level] < 8) return YETERSIZSEVIYE2(playerid, 8);
	Bilgimesaj(playerid, "Ticketin numarasini alin, /tyanitla komutuna girin oyle cevaplayabilirsiniz.", "Ticketin numarasini alin, /tyanitla komutuna girin oyle cevaplayabilirsiniz.");
    new string[2048], stringq[199], count[4], ticketdurumd[50], ticketdurumc[50], yazi[256];
	for(new x; x < 500; x++)
	{
	    format(stringq, sizeof(stringq), "SELECT * FROM ticketlar WHERE id = %d", x);
	    mysql_query(stringq);
	    mysql_store_result();
	 //	string[0] = EOS;
	    while(mysql_retrieve_row())
		{
	    	mysql_fetch_field_row(count, "id");
	    	mysql_fetch_field_row(ticketdurumd, "baslik");
		 	mysql_fetch_field_row(ticketdurumc, "olusturan");
		 	mysql_fetch_field_row(yazi, "yazi");
			format(string, sizeof(string), "%s{FFFFFF}ID:%s GONDEREN: %s BAÞLIK:%s YAZI:%s\n", string, count, ticketdurumc, ticketdurumd,yazi);
		}
	    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Ticketlar", string, "Tamam", "");
	}
	return 1;
}
*/
#if !defined isnull
    #define isnull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif/*
CMD:topscore(playerid, params[])
{
	for (new x; x < 7; x++)
		TextDrawShowForPlayer(playerid, TDEditor_TD[x]);
	TextDrawSetString(TDEditor_TD[2], "skor");
    new sting[124],string[9][24], name[25], scre[9][14], siralamastr[5], sira;
    mysql_query("SELECT * FROM `oyuncular` ORDER BY `score` DESC LIMIT 8");
    mysql_store_result();
    while(mysql_retrieve_row())
    {
		sira++;
		mysql_fetch_field_row(string[sira], "kullaniciadi");
		mysql_fetch_field_row(scre[sira], "score");
    }
    mysql_free_result();
    sira=0;
    mysql_query("SELECT * FROM `oyuncular` ORDER BY `score` DESC");
    mysql_store_result();
    while(mysql_retrieve_row())
    {
		sira++;
		mysql_fetch_field_row(name, "kullaniciadi");

		if (!strcmp(name, getName(playerid), true))
		{
		    if (sira == 1) format(siralamastr, sizeof(siralamastr), "1st");
		    if (sira == 2) format(siralamastr, sizeof(siralamastr), "2nd");
		    if (sira == 3) format(siralamastr, sizeof(siralamastr), "3rd");
		    else format(siralamastr, sizeof(siralamastr), "%dth", siralamastr);
		}
    }
    mysql_free_result();
    for(new x; x < 9; x++)
    {
        if(isnull(string[x]))
        {
			format(string[x], 24, "-");
        }
        if(isnull(scre[x]))
        {
			format(scre[x], 24, "N/A");
        }
    }
    format(sting, sizeof(sting), "%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s", string[1], string[2], string[3], string[4] ,string[5],string[6],string[7],string[8]);
	TextDrawSetString(TDEditor_TD[5], sting);
    format(sting, sizeof(sting), "%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s", scre[1], scre[2], scre[3], scre[4] ,scre[5],scre[6],scre[7],scre[8]);
	TextDrawSetString(TDEditor_TD[6], sting);
	PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][0]);
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][0], "Zero Turkiye - Score Kings");
    return 1;
}
CMD:topmoney(playerid, params[])
{
	for (new x; x < 7; x++)
		TextDrawShowForPlayer(playerid, TDEditor_TD[x]);
	TextDrawSetString(TDEditor_TD[2], "skor");
    new sting[124],string[9][24], name[25], scre[9][14], siralamastr[5], sira;
    mysql_query("SELECT * FROM `oyuncular` ORDER BY `money` DESC LIMIT 8");
    mysql_store_result();
    while(mysql_retrieve_row())
    {
		sira++;
		mysql_fetch_field_row(string[sira], "kullaniciadi");
		mysql_fetch_field_row(scre[sira], "score");
    }
    mysql_free_result();
    sira=0;
    mysql_query("SELECT * FROM `oyuncular` ORDER BY `money` DESC");
    mysql_store_result();
    while(mysql_retrieve_row())
    {
		sira++;
		mysql_fetch_field_row(name, "kullaniciadi");

		if (!strcmp(name, getName(playerid), true))
		{
		    if (sira == 1) format(siralamastr, sizeof(siralamastr), "1st");
		    if (sira == 2) format(siralamastr, sizeof(siralamastr), "2nd");
		    if (sira == 3) format(siralamastr, sizeof(siralamastr), "3rd");
		    else format(siralamastr, sizeof(siralamastr), "%dth", siralamastr);
		}
    }
    mysql_free_result();
    for(new x; x < 9; x++)
    {
        if(isnull(string[x]))
        {
			format(string[x], 24, "-");
        }
        if(isnull(scre[x]))
        {
			format(scre[x], 24, "N/A");
        }
    }
    format(sting, sizeof(sting), "%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s", string[1], string[2], string[3], string[4] ,string[5],string[6],string[7],string[8]);
	TextDrawSetString(TDEditor_TD[5], sting);
    format(sting, sizeof(sting), "%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s", scre[1], scre[2], scre[3], scre[4] ,scre[5],scre[6],scre[7],scre[8]);
	TextDrawSetString(TDEditor_TD[6], sting);
	TextDrawSetString(TDEditor_TD[2], "para");
	PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][0]);
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][0], "Zero Turkiye - Richies");
    return 1;
}
CMD:topkill(playerid, params[])
{
	for (new x; x < 7; x++)
		TextDrawShowForPlayer(playerid, TDEditor_TD[x]);
	TextDrawSetString(TDEditor_TD[2], "skor");
    new sting[124],string[9][24], name[25], scre[9][14], siralamastr[5], sira;
    mysql_query("SELECT * FROM `oyuncular` ORDER BY `Kills` DESC LIMIT 8");
    mysql_store_result();
    while(mysql_retrieve_row())
    {
		sira++;
		mysql_fetch_field_row(string[sira], "kullaniciadi");
		mysql_fetch_field_row(scre[sira], "score");
    }
    mysql_free_result();
    sira=0;
    mysql_query("SELECT * FROM `oyuncular` ORDER BY `Kills` DESC");
    mysql_store_result();
    while(mysql_retrieve_row())
    {
		sira++;
		mysql_fetch_field_row(name, "kullaniciadi");

		if (!strcmp(name, getName(playerid), true))
		{
		    if (sira == 1) format(siralamastr, sizeof(siralamastr), "1st");
		    if (sira == 2) format(siralamastr, sizeof(siralamastr), "2nd");
		    if (sira == 3) format(siralamastr, sizeof(siralamastr), "3rd");
		    else format(siralamastr, sizeof(siralamastr), "%dth", siralamastr);
		}
    }
    mysql_free_result();
    for(new x; x < 9; x++)
    {
        if(isnull(string[x]))
        {
			format(string[x], 24, "-");
        }
        if(isnull(scre[x]))
        {
			format(scre[x], 24, "N/A");
        }
    }
    format(sting, sizeof(sting), "%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s", string[1], string[2], string[3], string[4] ,string[5],string[6],string[7],string[8]);
	TextDrawSetString(TDEditor_TD[5], sting);
    format(sting, sizeof(sting), "%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s", scre[1], scre[2], scre[3], scre[4] ,scre[5],scre[6],scre[7],scre[8]);
	TextDrawSetString(TDEditor_TD[6], sting);
	TextDrawSetString(TDEditor_TD[2], "kill");
	PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][0]);
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][0], "Zero Turkiye - Killer");
    return 1;
}
CMD:topdeath(playerid, params[])
{
	for (new x; x < 7; x++)
		TextDrawShowForPlayer(playerid, TDEditor_TD[x]);
	TextDrawSetString(TDEditor_TD[2], "skor");
    new sting[124],string[9][24], name[25], scre[9][14], siralamastr[5], sira;
    mysql_query("SELECT * FROM `oyuncular` ORDER BY `Deaths` DESC LIMIT 8");
    mysql_store_result();
    while(mysql_retrieve_row())
    {
		sira++;
		mysql_fetch_field_row(string[sira], "kullaniciadi");
		mysql_fetch_field_row(scre[sira], "score");
    }
    mysql_free_result();
    sira=0;
    mysql_query("SELECT * FROM `oyuncular` ORDER BY `Deaths` DESC");
    mysql_store_result();
    while(mysql_retrieve_row())
    {
		sira++;
		mysql_fetch_field_row(name, "kullaniciadi");

		if (!strcmp(name, getName(playerid), true))
		{
		    if (sira == 1) format(siralamastr, sizeof(siralamastr), "1st");
		    if (sira == 2) format(siralamastr, sizeof(siralamastr), "2nd");
		    if (sira == 3) format(siralamastr, sizeof(siralamastr), "3rd");
		    else format(siralamastr, sizeof(siralamastr), "%dth", siralamastr);
		}
    }
    mysql_free_result();
    for(new x; x < 9; x++)
    {
        if(isnull(string[x]))
        {
			format(string[x], 24, "-");
        }
        if(isnull(scre[x]))
        {
			format(scre[x], 24, "N/A");
        }
    }
    format(sting, sizeof(sting), "%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s", string[1], string[2], string[3], string[4] ,string[5],string[6],string[7],string[8]);
	TextDrawSetString(TDEditor_TD[5], sting);
    format(sting, sizeof(sting), "%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s~n~_~n~%s", scre[1], scre[2], scre[3], scre[4] ,scre[5],scre[6],scre[7],scre[8]);
	TextDrawSetString(TDEditor_TD[6], sting);
	TextDrawSetString(TDEditor_TD[2], "death");
	PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][0]);
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][0], "Zero Turkiye - Deaths");
	SelectTextDraw(playerid, -1);
    return 1;
}
*/
CMD:log(playerid, params[])
{
	Hatamesaj(playerid, "Bu komut kaldirilmistir.", "Bu komut kaldirilmistir.");
	return 1;
}
CMD:toponline(playerid, params[])
{
     new sting[512], name[25], scorae, h, m, s, count;
     mysql_query("SELECT `kullaniciadi`, `onlinet` FROM `oyuncular` ORDER BY `onlinet` DESC LIMIT 10");
     mysql_store_result();
     while(mysql_retrieve_row()){
     mysql_fetch_field_row(name, "onlinet");scorae = strval(name);
     if(scorae > 0){
     mysql_fetch_field_row(name, "kullaniciadi");
     Surecek(scorae*1000, h, m, s);
     format(sting,2048,"%s{B23AEE}%d)\t{FFFFFF}%s\t{B23AEE}%03d:%02d:%02d\n",sting,count,name,h,m,s);
     }else{
     format(sting,2048,"%s{B23AEE}%d\t{FFFFFF}NaN\t{B23AEE}000:00:00\n",sting,count);
     }
     count++;
      }
      mysql_free_result();
      format(sting, sizeof(sting), "ID\tRumuz\tSüre\n%s", sting);
	  ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}[Z]ero - {E24234}Top Online", sting, "Tamam", "");
     return 1;
}
CMD:topscore(playerid, params[])
{
     new sting[512], name[25], scorae, count;
     mysql_query("SELECT `kullaniciadi`, `score` FROM `oyuncular` ORDER BY `score` DESC LIMIT 10");
     mysql_store_result();
     while(mysql_retrieve_row()){
     mysql_fetch_field_row(name, "score");scorae = strval(name);
     if(scorae > 0){
     mysql_fetch_field_row(name, "kullaniciadi");
     format(sting,2048,"%s{B23AEE}%d)\t{FFFFFF}%s\t{B23AEE}%d\n",sting,count,name,scorae);
     }else{
     format(sting,2048,"%s{B23AEE}%d\t{FFFFFF}NaN\t{B23AEE}NaN\n",sting,count);
     }
     count++;
      }
      mysql_free_result();
      format(sting, sizeof(sting), "ID\tRumuz\tSkor\n%s", sting);
	  ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}[Z]ero - {E24234}Top Score", sting, "Tamam", "");
     return 1;
}
CMD:topmoney(playerid, params[])
{
     new sting[512], name[25], scorae, count;
     mysql_query("SELECT `kullaniciadi`, `money` FROM `oyuncular` ORDER BY `money` DESC LIMIT 10");
     mysql_store_result();
     while(mysql_retrieve_row()){
     mysql_fetch_field_row(name, "money");scorae = strval(name);
     if(scorae > 0){
     mysql_fetch_field_row(name, "kullaniciadi");
     format(sting,2048,"%s{B23AEE}%d)\t{FFFFFF}%s\t{B23AEE}%d$\n",sting,count,name,scorae);
     }else{
     format(sting,2048,"%s{B23AEE}%d\t{FFFFFF}NaN\t{B23AEE}NaN\n",sting,count);
     }
     count++;
      }
      mysql_free_result();
      format(sting, sizeof(sting), "ID\tRumuz\tSkor\n%s", sting);
	  ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}[Z]ero - {E24234}Top Money", sting, "Tamam", "");
     return 1;
}
stock Surecek(ms, &h, &m, &s)
{
    h = ms / (60*60*1000);
    ms = ms - h*(60*60*1000);
    m = ms / (60*1000);
    ms = ms - m*(60*1000);
    s = ms / 1000;
    ms = ms - s*1000;
}
CMD:flip(playerid, params[]) return komut_cevir(playerid, params);
CMD:kilit(playerid, params[])
{
     if(GetPVarInt(playerid, "Kilit") == 0)
     {
          foreach (new i : Player)
          {
               if(i != playerid)
               {
                    SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
               }
          }
     }
     else
     {
          foreach (new i : Player)
          {
               if(i != playerid)
               {
                    SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
               }
          }
     }
     return 1;
}
CMD:lockcar(playerid, params[])
{
     if(GetPVarInt(playerid, "Kilit") == 0)
     {
          foreach (new i : Player)
          {
               if(i != playerid)
               {
                    SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
                    GameTextForPlayer(playerid, "Arac kapilari kilitlendi.", 1500, 3);
               }
          }
     }
     else
     {
          foreach (new i : Player)
          {
               if(i != playerid)
               {
                    SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
                    GameTextForPlayer(playerid, "Arac kapilari artik kilitli degil.", 1500, 3);
               }
          }
     }
     return 1;
}

CMD:lock(playerid, params[])
{
     if(GetPVarInt(playerid, "Kilit") == 0)
     {
          foreach (new i : Player)
          {
               if(i != playerid)
               {
                    SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
               }
          }
     }
     else
     {
          foreach (new i : Player)
          {
               if(i != playerid)
               {
                    SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
               }
          }
     }
     return 1;
}
CMD:cevir(playerid, params[])
{
     new Float: zAng;
            GetVehicleZAngle( GetPlayerVehicleID( playerid ), zAng );
            SetVehicleZAngle( GetPlayerVehicleID( playerid ), zAng );
     return 1;
}
CMD:kayit(playerid, params[])
{
    if(MySQLHesapKontrol(playerid) != 0) return Hatamesaj(playerid, "Sunucuya kayitli gozükmektesiniz.", "You already registered.");
    else
    {
    new password[36];
    if(sscanf(params, "s[36]", password)) return Kullanimmesaj(playerid, "kayit [sifre]", "register [pass]");
//	if(cccc == 0) return Hatamesaj(playerid, "Þifreniz sadece A-Z, a-z, sayý ve boþluk içerebilir.", "Only letter and numbers.");
	new string[128],gun,ay,yil,saat,dakika;
	getdate(yil, ay, gun);
	gettime(saat, dakika);
	mysql_real_escape_string(password, password);
    format(string, sizeof(string), "INSERT INTO oyuncular (kullaniciadi, sifre, RegisteredDate) VALUES ('%s', md5('%s'), '%02d/%02d/%02d - %02d:%02d')", oIsim(playerid), password, gun,ay,yil,saat,dakika);
     mysql_query(string);
     PlayerPlaySound(playerid, 1057, 0,0,0);
     ivirzivirGuncelle(playerid);
     PlayerInfo[playerid][LoggedIn] = 1;
     PlayerInfo[playerid][Registered] = 1;
     RegServ(playerid, "Sunucuya basariyla kayit oldunuz, otomatik olarak giris yaptiniz.", "You successfuly registered. Auto logged in.");
     }
     return 1;
}
/*
CMD:getid(playerid, params[]) cmd_id(playerid, params);
CMD:id(playerid, params[])
{
	new
		szMessage[128],
		szName[MAX_PLAYER_NAME],
		iTarget,
		iSuccess;

	if(isnull(params))
		return Kullanimmesaj(playerid, "getid [isim]", "getid [isim]");

	foreach(Player, i) {
		GetPlayerName(i, szName, sizeof(szName));
		if(strfind(szName, params, true) != -1) {
			format(szMessage, sizeof(szMessage), "ID: %d | Isim: %s | Level: %d | Ping: %d", i, GetPlayerNameEx(i),  PlayerInfo[i][pLevel], GetPlayerPing(i));
			SendClientMessage(playerid, COLOR_WHITE, szMessage);
			iSuccess ++;
		}
	}

	if(iSuccess == 0) {
		if(!sscanf(params, "u", iTarget)) {
			if(IsPlayerConnected(iTarget)) {
				format(szMessage, sizeof(szMessage), "ID: %d | Isim: %s | Level: %d | Ping: %d", iTarget, GetPlayerNameEx(iTarget),  PlayerInfo[iTarget][pLevel], GetPlayerPing(iTarget));
				SendClientMessage(playerid, COLOR_WHITE, szMessage);
				iSuccess ++;
			}
		}
	}

	if(iSuccess == 0)
		SendClientMessage(playerid, COLOR_GRAD1, "Geçersiz kullanýcý belirlendi.");

	return 1;
}
*/
CMD:myskin(playerid, params[])
{
     new sayy;
     if(sscanf(params,"i",sayy))return Kullanimmesaj(playerid, "myskin [skin id]", "myskin [skin id]");
     SetPlayerSkin(playerid, sayy);
     return 1;
}
CMD:myweather(playerid, params[])
{
     new sayy;
     if(sscanf(params,"i",sayy))return Kullanimmesaj(playerid, "myweather [weather id]", "myweather [weather id]");
     SetPlayerWeather(playerid, sayy);
     new string[256];
     format(string, sizeof(string), "Kendi weatherinizi {E24234}' %d '{FFFFFF} olarak ayarladiniz.", sayy);
     ADmessage(playerid, string);
     return 1;
}
CMD:mytime(playerid, params[])
{
     new sayy;
     if(sscanf(params,"i",sayy))return Kullanimmesaj(playerid, "mytime [saat]", "mytime [saat]");
     if (sayy > 23 || sayy < 0) return Hatamesaj(playerid, "Geçersiz saat dilimi girdiniz.", "Invalid time format!");
     SetPlayerTime(playerid, sayy, 0);
     new string[256];
     format(string, sizeof(string), "Kendi saatinizi {E24234}' %02d:00 '{FFFFFF} olarak ayarladiniz.", sayy);
     ADmessage(playerid, string);
     return 1;
}
CMD:vcolor(playerid, params[])
{
     return komut_renk(playerid, params);
}
CMD:color(playerid, params[])
{
     return komut_renk(playerid, params);
}
CMD:arenk(playerid, params[])
{
     return komut_renk(playerid, params);
}
CMD:renk(playerid, params[])
{
     new vc, vc1;
     if(sscanf(params,"ii",vc,vc1))return Kullanimmesaj(playerid, "vcolor [color1] [color2]", "vcolor [color1] [color2]");
     if (vc > 255 || vc < 0) return Hatamesaj(playerid, "Geçersiz renk girdiniz.", "Invalid car color format!");
     if (vc1 > 255 || vc1 < 0) return Hatamesaj(playerid, "Geçersiz renk girdiniz.", "Invalid car color format!");
     ChangeVehicleColor(GetPlayerVehicleID(playerid), vc, vc1);
     new string[256];
     format(string, sizeof(string), "Aracinizin renk idleri {E24234}' %d - %d '{FFFFFF} olarak degistirildi.", vc, vc1);
     Bilgimesaj(playerid, string, "Your vehicle colors changed.");
     return 1;
}
stock numberUsed(number)
{
	new used;
	foreach(new i :Player)
	{
	    if (GetPVarInt(i,"Lotto_Sayi") == number)
		{
		    used = 1;
		}
	}
	return used;
}
CMD:loto(playerid, params[])
{
     if(lotoBasladi == 0) return Hatamesaj(playerid, "Henüz bir loto baslamis degil.", "Loto is not started.");
     if(GetPVarInt(playerid, "Lotto") == 1) return Hatamesaj(playerid, "Zaten loto oynamissiniz.", "You alrealy played lotto.");
     new sayy;
     if(sscanf(params,"i",sayy))return Kullanimmesaj(playerid, "loto [sayi]", "lotto [number]");
     if(sayy > 100 || sayy < 1) return Hatamesaj(playerid, "Gecersiz numara girdiniz, 1-100 arasi olmalidir.", "Please enter 1-100 value.");
	 if (numberUsed(strval(params)) == 1) return Hatamesaj(playerid, "Bu sayi kullanilmis!", "This number is alrealy used.");
     SetPVarInt(playerid, "Lotto_Sayi", sayy);
     SetPVarInt(playerid, "Lotto", 1);
     new estring[256], eestring[256];
     format(estring, sizeof(estring), "Sonuclar az sonra aciklanacak - Oynadiginiz loto sayisi; {E24234}%d", sayy);
     format(eestring, sizeof(eestring), "Your loto number is {E24234}%d{FFFFFF}.", sayy);
     Bilgimesaj(playerid, estring, eestring);
     return 1;
}
CMD:lotto(playerid, params[]) return komut_loto(playerid, params);
CMD:kill(playerid, params[])
{
 //    SetPVarInt(playerid, "KillCommand", 1);
 //   PlayerInfo[playerid][Deaths] ++;
     PlayerPlaySound(playerid, 1130, 0,0,0);
     SetPlayerArmour(playerid, 0);
     SetPlayerHealth(playerid, 0);
     return 1;
}
CMD:geber(playerid, params[]) return komut_kill(playerid, params);
CMD:mycar(playerid,params[])
{
     if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return Hatamesaj(playerid, "Bir aracin soforu olmaniz lazim!", "You are not driver a car.");
     new mStr[1060];
     if(GetPVarInt(playerid, "Language__") == ENGLISH)
     {
          strcat(mStr,"Islem\tKosul\tAçiklama\n");
          strcat(mStr,"{E24234}Blank\t{C3C3C3}Normal\t{C3C3C3}[Leaves key dysfunctional]\n");
          strcat(mStr,"{E24234}Speed\t{ffa500}Veteran™\t{C3C3C3}[When you press the key, the vehicle accelerates]\n");
          strcat(mStr,"{E24234}Jump\t{ffa500}Veteran™\t{C3C3C3}[When you press the jump key tool is]\n");
          strcat(mStr,"{E24234}Rot X\t{C3C3C3}Normal\t{C3C3C3}[When you press the key tool to rotate around the X axis]\n");
          strcat(mStr,"{E24234}Rot Y\t{C3C3C3}Normal\t{C3C3C3}[When you press the key tool to rotate around the Y axis]\n");
          strcat(mStr,"{E24234}Rot Z\t{C3C3C3}Normal\t{C3C3C3}[When you press the key tool to rotate around the Z axis]\n");
          strcat(mStr,"{E24234}Flip\t{0A7E8C}Normal\t{C3C3C3}[When you press the correct key tool is]\n");
          strcat(mStr,"{E24234}Color\t{0A7E8C}SemiPro™\t{C3C3C3}[Press the button changes color when the vehicle]\n");
          strcat(mStr,"{E24234}Stop\t{0A7E8C}SemiPro™\t{C3C3C3}[When you press the button to stop the vehicle]\n");
          strcat(mStr,"{E24234}Baggage\t{C3C3C3}Normal\t{C3C3C3}[When you press the key Turns the trunk of the vehicle]\n");
          strcat(mStr,"{E24234}Bonnet\t{C3C3C3}Normal\t{C3C3C3}[Open the hood of the car when the key press closes]\n");
          strcat(mStr,"{E24234}Alarm\t{C3C3C3}Normal\t{C3C3C3}[When you press the key opens the car's alarm is off]\n");
          strcat(mStr,"{E24234}Headlight\t{C3C3C3}Normal\t{C3C3C3}[When you press the key Turns the headlights of the vehicle]\n");
          strcat(mStr,"{E24234}Engine\t{C3C3C3}Normal\t{C3C3C3}[When you press the key engine of the vehicle Turns]\n");
          strcat(mStr,"{E24234}Lock\t{C3C3C3}Normal\t{C3C3C3}[When you press the key lock car,unlock car]\n");
          ShowPlayerDialog(playerid, Mycar, DIALOG_STYLE_TABLIST_HEADERS, "{E24234}[Z]ero Elite{FFFFFF} - MyCar",mStr,"Fire Key","H Key");
     }else
     {
          strcat(mStr,"Islem\tKosul\tAçiklama\n");
          strcat(mStr,"{E24234}Bos\t{C3C3C3}Normal\t{C3C3C3}[Tusu islevsiz birakir]\n");
          strcat(mStr,"{E24234}Hiz\t{ffa500}Veteran™\t{C3C3C3}[Tusu bastiginizda araci hizlandirir]\n");
          strcat(mStr,"{E24234}Zipla\t{ffa500}Veteran™\t{C3C3C3}[Tusu bastiginizda araci ziplatir]\n");
          strcat(mStr,"{E24234}Yon X\t{C3C3C3}Normal\t{C3C3C3}[Tusu bastiginizda araci X ekseni etrafinda dondürür]\n");
          strcat(mStr,"{E24234}Yon Y\t{C3C3C3}Normal\t{C3C3C3}[Tusu bastiginizda araci Y ekseni etrafinda dondürür]\n");
          strcat(mStr,"{E24234}Yon Z\t{C3C3C3}Normal\t{C3C3C3}[Tusu bastiginizda araci Z ekseni etrafinda dondürür]\n");
          strcat(mStr,"{E24234}Cevir\t{0A7E8C}Normal\t{C3C3C3}[Tusu bastiginizda araci düzeltir]\n");
          strcat(mStr,"{E24234}Renk\t{0A7E8C}SemiPro™\t{C3C3C3}[Tusu bastiginizda aracin rengi degisir]\n");
          strcat(mStr,"{E24234}Fren\t{0A7E8C}SemiPro™\t{C3C3C3}[Tusu bastiginizda araci durdurur]\n");
          strcat(mStr,"{E24234}Bagaj\t{C3C3C3}Normal\t{C3C3C3}[Tusu bastiginizda aracin bagajini acar kapatir]\n");
          strcat(mStr,"{E24234}Kaput\t{C3C3C3}Normal\t{C3C3C3}[Tusu bastiginizda aracin kaputunu acar kapatir]\n");
          strcat(mStr,"{E24234}Alarm\t{C3C3C3}Normal\t{C3C3C3}[Tusu bastiginizda aracin alarmini acar kapatir]\n");
          strcat(mStr,"{E24234}Far\t{C3C3C3}Normal\t{C3C3C3}[Tusu bastiginizda aracin farlarini acar kapatir]\n");
          strcat(mStr,"{E24234}Motor\t{C3C3C3}Normal\t{C3C3C3}[Tusu bastiginizda aracin motorunu acar kapatir]\n");
          strcat(mStr,"{E24234}Kilit\t{C3C3C3}Normal\t{C3C3C3}[Tusu bastiginizda aracin kapi kilitlerini acar,kapatir]\n");
          ShowPlayerDialog(playerid, Mycar, DIALOG_STYLE_TABLIST_HEADERS, "{E24234}[Z]ero Elite{FFFFFF} - MyCar",mStr,"Ates etme","H tusu");
     }
     return 1;
}
IsNumeric(const string[])
{
        for (new i = 0, j = strlen(string); i < j; i++)
        {
                if (string[i] > '9' || string[i] < '0') return 0;
        }
        return 1;
}
stock GetVehID(vname[])
{
     for(new i = 0; i < 211; i++)
     {
     if ( strfind(AracIsimler[i], vname, true) != -1 )
     return i + 400;
     }
     return -1;
}
CMD:car(playerid, params[]) return komut_veh(playerid, params);
CMD:veh(playerid,params[])
{
   	 if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created.");// if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
     new plaka[25];
     if (sscanf(params, "s[24]", plaka)) return USmessage(playerid, "veh [arac ismi/arac id]");
     new vehmodel;
     if(!IsNumeric(plaka)){vehmodel = GetVehID(plaka);}
     else{vehmodel = strval(plaka);}
     if(vehmodel < 400 || vehmodel > 611)return INmessage(playerid, "Girdiginiz isime ait bir arac bulunamadi!");
     if((vehmodel == 520 || vehmodel == 464 || vehmodel == 432 || vehmodel == 425 || vehmodel == 447) && PlayerInfo[playerid][Level] < 5)return YETERSIZSEVIYE2(playerid, 5);
      if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
 	 new Float:X,Float:Y,Float:Z,Float:Angle;
	 GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
 	 DestroyVehObject(playerid);
	 ivehicle[playerid] = CreateVehicle(vehmodel,X,Y,Z,Angle,1,-1,-1);
	 PutPlayerInVehicle(playerid,ivehicle[playerid],0);
 	 ///AddVehicleComponent(ivehicle[playerid], SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid));
	 LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
 	 Araba[playerid] = 1;
     new string[256];
     format(string, sizeof(string), "Kendinize {E24234}' %d '{FFFFFF} model arac indirdiniz.", vehmodel);
     ADmessage(playerid, string);
     PlayerPlaySound(playerid, 1085, 0, 0, 0);
     return 1;
}
CMD:pmackapat(playerid, params[])
{
	return komut_pmkapatac(playerid, params);
}
CMD:teleackapat(playerid, params[]) return komut_telekapatac(playerid, params);
CMD:om(playerid, params[]) return komut_pm(playerid, params);
stock set(dest[],source[]) {
	new count = strlen(source);
	new i=0;
	for (i=0;i<count;i++) {
		dest[i]=source[i];
	}
	dest[count]=0;
}
stock code(nickname[]) {
  new tmp[500];
  set(tmp,nickname);
  tmp=strreplace("g","g",tmp);
  tmp=strreplace("Ð","G",tmp);
  tmp=strreplace("þ","s",tmp);
  tmp=strreplace("Þ","S",tmp);
  tmp=strreplace("i","i",tmp);
  tmp=strreplace("I","I",tmp);
  tmp=strreplace("I","I",tmp);
  tmp=strreplace("o","o",tmp);
  tmp=strreplace("O","O",tmp);
  tmp=strreplace("ç","c",tmp);
  tmp=strreplace("Ç","C",tmp);
  tmp=strreplace("ü","u",tmp);
  tmp=strreplace("Ü","U",tmp);
  return tmp;
}
CMD:pm(playerid,params[])
{
    new plaka[102], oyuncuid;
    if(PlayerInfo[playerid][Registered] == 0)return HataMesaji(playerid, "/kayit olmadan /pm komutunu kulanmazsýnýz");
    if (sscanf(params, "is[102]", oyuncuid, plaka)) return USmessage(playerid, "om [playerid/playername] [yazi]");
    if (GetPVarInt(playerid, "Language__") == ENGLISH && !IsPlayerConnected(oyuncuid)) return INmessage(playerid, "Player is not connected!");
    if (GetPVarInt(playerid, "Language__") == TURKISH && !IsPlayerConnected(oyuncuid)) return INmessage(playerid, "Oyuncu oyunda degil!");
    if (GetPVarInt(playerid, "Language__") == TURKISH && GetPVarInt(playerid, "PM_ONOFF") == 1) return INmessage(playerid, "Oyuncu pm sistemini kapali tutuyor, ona {E24234}/pmkapatac{FFFFFF} kullanmasini soyleyin.");
    if (GetPVarInt(playerid, "Language__") == ENGLISH && GetPVarInt(playerid, "PM_ONOFF") == 1) return INmessage(playerid, "Player pm is closed.");
    if (GetPVarInt(oyuncuid, "PM_STATE") == 1) return INmessage(playerid, "Oyuncunun pm sistemi kapali! Ona {E24234}' /pmkapatac '{FFFFFF} kullanmasini soyleyin.");
 	if(oyuncuid == playerid) return INmessage(playerid, "Bu komutu kendi üzerinizde kullanamassiniz!");
 	if(IsPlayerNPC(oyuncuid)) return INmessage(playerid, "Bu komutu otobüs soforleri üzerinde kullanamassiniz!");
    new
         yaziString[300],
         strt[256]
     ;
     format(yaziString, sizeof(yaziString), "{FF0015}«{F5DEB3}PM{FF0015}«« %s{15FF00}(%d):{F5DEB3} %s", oIsim(oyuncuid), oyuncuid, plaka);
     SendClientMessage(playerid, -1, yaziString);
     format(yaziString, sizeof(yaziString), "{FF0015}»{FFFF00}PM{FF0015}»» %s{15FF00}(%d):{FFFF00} %s", oIsim(playerid), playerid, plaka);
     SendClientMessage(oyuncuid, -1, yaziString);
	 format(strt, sizeof(strt), "~w~~h~[PM]~r~~h~~r~%s~w~~h~~h~~h~ >>> ~b~~h~%s~w~~h~~h~~h~: %s", oIsim(playerid), oIsim(oyuncuid), plaka);
	 PmMesaji(playerid,code(strt));
	 SetPVarInt(oyuncuid, "LastPM", playerid);
	 SetPVarInt(playerid, "LastPM", oyuncuid);
     return 1;
}
CMD:re(playerid, params[])
{
	new string[65];
	if(PlayerInfo[playerid][Registered] == 0)return HataMesaji(playerid, "/kayit olmadan /re komutunu kulanmazsýnýz");
    if (sscanf(params, "s[65]", string)) return USmessage(playerid, "re [yazi]");
    if (GetPVarInt(playerid, "Language__") == TURKISH && GetPVarInt(playerid, "LastPM") == 1) return INmessage(playerid, "Oyuncu pm sistemini kapali tutuyor, ona {E24234}/pmkapatac{FFFFFF} kullanmasini soyleyin.");
    if (GetPVarInt(playerid, "Language__") == ENGLISH && GetPVarInt(playerid, "LastPM") == 1) return INmessage(playerid, "Player pm is closed.");
	if (GetPVarInt(playerid, "LastPM") == -1) return INmessage(playerid, "En son kimseden pm almamissiniz!");
	if (!IsPlayerConnected(GetPVarInt(playerid, "LastPM"))) return INmessage(playerid, "Oyuncu oyunda degil.");
    new
         yaziString[300],
         strt[256],
         oyuncuid = GetPVarInt(playerid, "LastPM")
     ;
     format(yaziString, sizeof(yaziString), "{FF0015}«{F5DEB3}RE{FF0015}«« %s{15FF00}(%d):{F5DEB3} %s", oIsim(oyuncuid), oyuncuid, string);
     SendClientMessage(playerid, -1, yaziString);
     format(yaziString, sizeof(yaziString), "{FF0015}»{FFFF00}RE{FF0015}»» %s{15FF00}(%d):{FFFF00} %s", oIsim(playerid), playerid, string);
     SendClientMessage(oyuncuid, -1, yaziString);
	 format(strt, sizeof(strt), "~w~~h~[RE]~r~~h~~r~%s~w~~h~~h~~h~ >>> ~b~~h~%s~w~~h~~h~~h~: %s", oIsim(playerid), oIsim(oyuncuid), string);
	 PmMesaji(playerid,code(strt));
	return 1;
}
CMD:modifiye(playerid, params[]) return komut_tune(playerid, params);
CMD:tune(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return Hatamesaj(playerid, "Bir aracin soforü olmaniz lazim!", "You are not driver.");
AddVehicleComponent(GetPlayerVehicleID(playerid),1087); AddVehicleComponent(GetPlayerVehicleID(playerid),1086);
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1030);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1031);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1033);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1170);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1139);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1140);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            new car = GetPlayerVehicleID(playerid);
                        //      ChangeVehiclePaintjob(car,2);
                                ChangeVehicleColor(car,random(500),random(500));
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            }
                            //Jester
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1065);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1067);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1069);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1071);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1173);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1161);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1162);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            new car = GetPlayerVehicleID(playerid);
                        //      ChangeVehiclePaintjob(car,2);
                                ChangeVehicleColor(car,random(500),random(500));
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            }
                            //Elegy
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1034);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1035);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1036);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1040);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1147);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1148);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1171);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            new car = GetPlayerVehicleID(playerid);
                        //      ChangeVehiclePaintjob(car,0);
                                ChangeVehicleColor(car,random(500),random(500));
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            }
                            //Flash
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1045);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1047);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1051);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1049);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1053);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1150);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1153);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            new car = GetPlayerVehicleID(playerid);
                                //      ChangeVehiclePaintjob(car,1);
                                ChangeVehicleColor(car,random(500),random(500));
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            }
                            //Stratum
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1055);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1057);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1062);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1058);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1059);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1154);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1155);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            new car = GetPlayerVehicleID(playerid);
                                //      ChangeVehiclePaintjob(car,4);
                                ChangeVehicleColor(car,random(500),random(500));
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            }
                            //Uranus
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1088);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1089);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1090);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1094);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1164);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1167);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1168);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            new car = GetPlayerVehicleID(playerid);
                                //      ChangeVehiclePaintjob(car,1);
                                ChangeVehicleColor(car,random(500),random(500));
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            }
                            //Turismo
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 451)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Infernus
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 411)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Alpha
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 602)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1079);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Banshee
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 429)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Bufallo
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 402)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1077);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Bullet
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 541)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Cabbie (taxi oldschool)
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 438)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Cheetah
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 415)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1015);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1017);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1007);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Taxi
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 420)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1015);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Caddy
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 457)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //zr350
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 477)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Comet
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 480)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //CopCarLA
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 596)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //CopCarSF
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 597)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Euros
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 587)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Hermes
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 474)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Huntley
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 579)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Hustler
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 545)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Phoenix
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 603)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //SuperGT
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 506)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1077);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Stretch
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 409)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Sabre
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 475)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Rancher
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 489)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Esperanto
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 419)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Broadway
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1042);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1099);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1043);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1175);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1177);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                        //Remington
                        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534)
                        {
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1100);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1123);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1101);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1122);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1127);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1178);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1185);
                            AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
                            PlayerPlaySound(playerid, 1133, 0, 0, 0);
                            new car = GetPlayerVehicleID(playerid);
                        ChangeVehicleColor(car,random(500),random(500));
                        }
                              Bilgimesaj(playerid, "Araciniz otomatik olarak modifiye edildi!", "Car is auto tuned.");
                return 1;
        }

CMD:pmkapatac(playerid, params[])
{
     if (GetPVarInt(playerid, "PM_STATE") == 1)
     {
         Bilgimesaj(playerid, "Private Message alimlarina artik aciksiniz!", "Your pm system is opened.");
          SetPVarInt(playerid, "PM_STATE", 0);
          PlayerPlaySound(playerid, 1150, 0,0,0);
     }
     else
     {
         Bilgimesaj(playerid, "Private Message alimlarina artik kapalisiniz!", "Your pm system is off.");
          SetPVarInt(playerid, "PM_STATE", 1);
          PlayerPlaySound(playerid, 1150, 0,0,0);
     }
     return 1;
}
CMD:changenick(playerid, params[])
     return komut_nickdegis(playerid, params);
stock nickkontrol(params[]){
new Query[256];
format(Query, sizeof(Query), "SELECT * FROM `oyuncular` WHERE `kullaniciadi` = '%s'", params);
mysql_query(Query); mysql_store_result();
if(mysql_num_rows() > 0){
mysql_free_result();
return 0; // LAN OLUM WARN HEP KALCAKMI HAYIR DEÜZELTICEZ ÜSENIYOOM SEN BUG TEST YAP . IPDE VER tm çik alpr

}
mysql_free_result();
return 1;
}
CMD:sifredegis(playerid, params[]) return komut_changepass(playerid, params);
CMD:mypass(playerid, params[]) return komut_changepass(playerid, params);
CMD:changepass(playerid, params[])
{
    if(PlayerInfo[playerid][LoggedIn] == 0) return Hatamesaj(playerid, "Giris yapmadan bu komutu kullanamassiniz!", "You are not logged-in the server.");
	new ssss[25];
     if (sscanf(params, "s[25]", ssss)) return USmessage(playerid, "sifredegis [new pass]");
     mysql_real_escape_string(ssss, ssss);
 //     if (strlen(params) < 4 || strlen(params) > 20) return Dilmesaji(playerid,-1,"{E24234} Bilgi: {FFFFFF}Nick uzunlugunuz 1 ile 20 karakter arasinda olmalidir.","Information, Password length must be greater than three characters");
     new Query[500],string[256]; format(Query, sizeof(Query), "UPDATE `oyuncular` SET `sifre` = md5('%s') WHERE `kullaniciadi` = '%s'",ssss,oIsim(playerid));
     mysql_query(Query);
//     mysql_free_result();
    format(string, sizeof string, "Yeni sifreniz {E24234}' %s '{FFFFFF}dir, bundan sonra onunla giris yapacaksiniz.",ssss);
     Hatamesaj(playerid, string, string);
     return 1;
}
CMD:nickdegis(playerid, params[])
{
    if(PlayerInfo[playerid][LoggedIn] == 0) return Hatamesaj(playerid, "Giris yapmadan bu komutu kullanamassiniz!", "You are not logged-in the server.");
     new newnick[25];
     if (sscanf(params, "s[25]", newnick)) return USmessage(playerid, "nickdegis [newnick]");
    if (strlen(newnick) < 4 || strlen(newnick) > 20) return Hatamesaj(playerid,"Nickiniz 4-20 karakter arasi olmak zorundadir.","Nicklength must be greater than three characters 4 - 20");
     if(GetPlayerScore(playerid) < 50) return eksikSksor(playerid, 50);
     new eskiname[25];
     format(eskiname,25,"%s",oIsim(playerid));
     mysql_real_escape_string(newnick,newnick);
     if(nickkontrol(newnick)!=0){
    if(SetPlayerName(playerid, newnick)== 1){
     new Query[500],string[256]; format(Query, sizeof(Query), "UPDATE `oyuncular` SET `kullaniciadi` = '%s' WHERE `kullaniciadi` = '%s'",newnick,eskiname);
     mysql_query(Query);
     mysql_free_result();
    format(string, sizeof string, "Nickinizi basariyla degistirdiniz, yeni nickiniz {E24234}' %s '",newnick);
     SetPlayerScore(playerid,GetPlayerScore(playerid)-50);
    Bilgimesaj(playerid,string,string);
    }else return Hatamesaj(playerid, "Nickiniz degistirilemedi. Uygun olmayan karakterler iceriyor olabilir.", "Nick is not changed.");
    }else{Hatamesaj(playerid, "Bu nick kullanilmis!", "This nick is used.");}
     return 1;
}
CMD:telekapatac(playerid, params[])
{
     if (GetPVarInt(playerid, "T_STATE") == 1)
     {
         Bilgimesaj(playerid, "Teleportlara artik aciksiniz!", "Your goto system is opened.");
          SetPVarInt(playerid, "T_STATE", 0);
          PlayerPlaySound(playerid, 1150, 0,0,0);
     }
     else
     {
         Bilgimesaj(playerid, "Teleportlara artik kapalisiniz!", "Your goto system is off.");
          SetPVarInt(playerid, "T_STATE", 1);
          PlayerPlaySound(playerid, 1150, 0,0,0);
     }
     return 1;
}
CMD:teleac(playerid, params[])return komut_telekapatac(playerid, " ");
CMD:telekapat(playerid, params[])return komut_telekapatac(playerid, " ");
stock CreatePlayerVehicle( playerid, modelid )
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
	    new string[64];
	    format(string, sizeof(string), VehicleFriendlyNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);

          return 1;
}
stock CreatePlayerVehiclex( playerid, modelid,renk,renk2 )
{

if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!");
if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0, DestroyVehObject(playerid);
ivehicle[playerid] = INVALID_VEHICLE_ID;
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
ivehicle[playerid] = CreateVehicle( modelid, x, y, ( z + 1 ), angle, renk, renk2, -1);Araba[playerid] = 1;
        SetVehicleNumberPlate(ivehicle[playerid], "{FF0015}[Z]ero");//{3333FF}mavi{E24234}yesil{0040FF}mavi{E24234}sari{FF0015}kirmizi{FFFFFF}beyaz{F7F09D}<(Bilgi>:{FFFFFF}{FFFFFF}
        LinkVehicleToInterior( ivehicle[playerid], GetPlayerInterior( playerid ) );
        SetVehicleVirtualWorld( ivehicle[playerid], GetPlayerVirtualWorld( playerid ) );
        PutPlayerInVehicle( playerid, ivehicle[playerid], 0 );
        SetPlayerArmedWeapon(playerid,0);
        SetPVarInt(playerid,"ModifiyeCar",0);
          return 1;
}
CMD:plaka(playerid, params[])
{
     if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return Hatamesaj(playerid, "Bir aracin soforü olmalisiniz.", "You are not driver.");
     new plaka[24];
     if (sscanf(params, "s[24]", plaka)) return USmessage(playerid, "plaka [yazi]");
     SetVehicleNumberPlate(GetPlayerVehicleID(playerid), plaka);
     new string[240], Float: Pos[5];
     format(string, sizeof(string), "Aracinizin plakasi {E24234}' %s '{FFFFFF} olarak degistirildi.", plaka);
     Bilgimesaj(playerid, string, string);
     GetVehiclePos(GetPlayerVehicleID(playerid), Pos[1], Pos[2], Pos[3]); GetVehicleZAngle(GetPlayerVehicleID(playerid), Pos[4]);
     SetVehicleToRespawn(GetPlayerVehicleID(playerid));
     SetVehiclePos(GetPlayerVehicleID(playerid), Pos[1], Pos[2], Pos[3]); SetVehicleZAngle(GetPlayerVehicleID(playerid), Pos[4]);
     PutPlayerInVehicle(playerid, GetPlayerVehicleID(playerid), 0);
     return 1;
}
CMD:lazer(playerid, params[])
{
     if(IsPlayerInAnyVehicle(playerid)) return Hatamesaj(playerid, "Aracta iken bu komutu kullanamassiniz.", "You are not driver.");
     ShowPlayerDialog(playerid, Lazer1, DIALOG_STYLE_LIST, "{E24234}[Z]ero Elite {FFFFFF} - Lazer", "{E24234}» {ffffff}Lazer Ac\n{E24234}» {ffffff}Lazer Rengi\n{E24234}» {ffffff}Lazer Kapat", "Tamam", "Kapat");
     return 1;
}
CMD:can(playerid, params[])
{
     if(GetPlayerMoney(playerid) < 1000) return eksikPara(playerid, 1000);
     SetPlayerHealth(playerid, 100);
     PlayerPlaySound(playerid, 1150, 0.0000, 0.0000, 0.0000);
     GivePlayerMoney(playerid, -10000);
     return 1;
}
CMD:zirh(playerid, params[])
{
     if(GetPlayerMoney(playerid) < 2000) return eksikPara(playerid, 2000);
     SetPlayerArmour(playerid, 100);
     PlayerPlaySound(playerid, 1150, 0.0000, 0.0000, 0.0000);
     GivePlayerMoney(playerid, -12500);
     return 1;
}
CMD:dovusstil(playerid, params[])
{
     ShowPlayerDialog(playerid,9989,DIALOG_STYLE_LIST,"{E24234}[Z]ero Elite {FFFFFF} - Dövüs Stilleri","{E24234}» {FFFFFF}Normal Stil\n{E24234}» {FFFFFF}Boxcu Stili\n{E24234}» {FFFFFF}Karate Stili\n{E24234}» {FFFFFF}KneeHead Stili\n{E24234}» {FFFFFF}Tekme Stili\n{E24234}» {FFFFFF}Hizli Yumruk Stili\n{39AACC}","Sec","Cikis");
     return 1;
}
CMD:fightstyle(playerid, params[]) return komut_dovusstil(playerid, params);
CMD:dovusstilim(playerid, params[]) return komut_dovusstil(playerid, params);
CMD:dovusstili(playerid, params[]) return komut_dovusstil(playerid, params);

stock IsPlayerInWater(playerid) {
        new anim = GetPlayerAnimationIndex(playerid);
        if (((anim >=  1538) && (anim <= 1542)) || (anim == 1544) || (anim == 1250) || (anim == 1062)) return 1;
        return 0;
}

stock IsPlayerAiming(playerid) {
        new anim = GetPlayerAnimationIndex(playerid);
        if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) ||
        (anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
        return 0;
}

CMD:neon(playerid, params[])
{
     if(IsPlayerInAnyVehicle(playerid))
      {
            if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
          {
               Hatamesaj(playerid, "Bir aracin soforu olmaniz lazim!", "You are not driver!");
               return 1;
          }
          ShowPlayerDialog(playerid, NEON, DIALOG_STYLE_LIST, "Neon Menüsü","{E24234}»{FFFFFF} Mavi Neon\n{E24234}»{FFFFFF} Yesil Neon\n{E24234}»{FFFFFF} Sari Neon\n{E24234}»{FFFFFF} Beyaz Neon\n{E24234}»{FFFFFF} Pembe Neon\n{E24234}»{FFFFFF} Neon Sil","Ekle","Kapat");
     }
     else
     {
          Hatamesaj(playerid, "Bu komutu kullanabilmeniz icin aracta olmaniz lazim!", "You are not a car driver!");
     }
     return 1;
}
strtok(const string[], &index)
{
     new length = strlen(string);
     while ((index < length) && (string[index] <= ' '))
     {
          index++;
     }

     new offset = index;
     new result[20];
     while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
     {
          result[index - offset] = string[index];
          index++;
     }
     result[index - offset] = EOS;
     return result;
}

stock ShowSStunts()
{
     new SStunts[1024];
     //--------------------------------------------------------------------------
     strcat(SStunts, "{E24234}» {FFFFFF}Stunt 1\n");
     strcat(SStunts, "{E24234}» {FFFFFF}Stunt 2\n");
     strcat(SStunts, "{E24234}» {FFFFFF}Stunt 3\n");
     strcat(SStunts, "{E24234}» {FFFFFF}Stunt 4\n");
     strcat(SStunts, "{E24234}» {FFFFFF}Stunt 5\n");
     strcat(SStunts, "{E24234}» {FFFFFF}Stunt 6\n");
     strcat(SStunts, "{E24234}» {FFFFFF}Stunt 7\n");
     strcat(SStunts, "{E24234}» {FFFFFF}Stunt 8\n");
     strcat(SStunts, "{E24234}» {FFFFFF}Stunt 9\n");
     strcat(SStunts, "{E24234}» {FFFFFF}Stunt 10\n");
     strcat(SStunts, "{E24234}» {FFFFFF}Stunt 11\n");
     strcat(SStunts, "{E24234}» {FFFFFF}Stunt 12\n");
     strcat(SStunts, "{E24234}» {FFFFFF}Stunt 13\n");
     strcat(SStunts, "{E24234}» {FFFFFF}Stunt 14\n");
     strcat(SStunts, "{E24234}» {FFFFFF}Stunt 15\n");
     //--------------------------------------------------------------------------
     return SStunts;
}
CMD:patinoar(playerid, params[])
{
     //--------------------------------------------------------------------------
     SetPlayerSkin(playerid, 99);          SetPlayerTime(playerid,0,0);
     SetPlayerWeather(playerid, 40);          SetPlayerHealth(playerid, 100);
     SetPlayerArmour(playerid, 100);          SetPlayerVirtualWorld(playerid, 5);
     SetPVarInt(playerid, "IceRink", 1);     SetPVarInt(playerid, "PlayerInDM", 1);
     //--------------------------------------------------------------------------
     SetPlayerPos(playerid, 1981.9069, 3136.5459, 5.7956);
     SetPlayerCheckpoint(playerid, 1981.9069, 3136.5459, 4.4956, 2);
     // the {11FF00}Ice Rink (Patinoar)!");
     //SendClientMessage(playerid, -1, "Go to the {11FF00}Checkpoint{15FF00} to get yourself some new skates!");
     //--------------------------------------------------------------------------
     ApplyAnimation(playerid, "SKATE", "skate_sprint", 4.1, 1, 1, 1, 1, 1);
      ApplyAnimation(playerid, "SKATE", "skate_sprint", 4.1, 1, 1, 1, 1, 1);
     //--------------------------------------------------------------------------
     return 1;
}
//------------------------------------------------------------------------------
CMD:eiffel(playerid, params[])
{
     SetPlayerPos(playerid,948.788574, 2439.683350, 10.874555);
    //port(playerid, "Eiffel Tower","eiffel");
    // {FF0000}Eiffel Tower!");
    SendClientMessage(playerid, -1, "{15FF00}Komutlar: {11FF00}/lift1up, {15FF00}/lift2up, {11FF00}/lift3up, {15FF00}/lift1down, {11FF00}/lift2down, {15FF00}/lift3down!");
     return 1;
}
CMD:lift1up(playerid, params[])
{
     MoveObject(lift1,948.794312, 2439.689941, 42.391544,10.0);
     return 1;
}
//------------------------------------------------------------------------------
CMD:lift1down(playerid, params[])
{
     MoveObject(lift1,948.788574, 2439.683350, 9.874555,5.0);
     return 1;
}
//------------------------------------------------------------------------------
CMD:lift2up(playerid, params[])
{
     MoveObject(lift2,957.270447, 2432.764160, 81.292969,10.0);
     return 1;
}
//------------------------------------------------------------------------------
CMD:lift2down(playerid, params[])
{
     MoveObject(lift2,957.282593, 2432.806641, 42.432281,5.0);
     return 1;
}
//------------------------------------------------------------------------------
CMD:lift3up(playerid, params[])
{
     MoveObject(lift3,956.364319, 2442.081299, 198.766342,10.0);
     return 1;
}
//------------------------------------------------------------------------------
CMD:lift3down(playerid, params[])
{
     MoveObject(lift3,957.160950, 2442.099365, 81.161102,5.0);
     return 1;
}
//------------------------------------------------------------------------------
CMD:maze(playerid, params[])
{
    //--------------------------------------------------------------------------
    SetPVarInt(playerid, "PlayerInDM", 1);
     SetPlayerPos(playerid, 348.9545,-2820.3862,46.2625);
     //port(playerid, "Maze", "maze");
     //--------------------------------------------------------------------------
     //welcome to ~g~maze", 1600, 3);
     //--------------------------------------------------------------------------
     return 1;
}
COMMAND:dil(playerid, params[])
{
     ShowPlayerDialog(playerid, Language, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK" - Dil Secimi/Language Selection", "{C0C0C0}» {E24234}Türkce -{FFFFFF} Devam etmek icin tercih ettiginiz dili secmeniz gerekiyor.\n{C0C0C0}» {E24234}English -{FFFFFF} You have to select your prefered language to continue.", "Turkish", "English");
     return 1;
}
CMD:language(playerid, params[]) return komut_dil(playerid, " ");
CMD:teles(playerid, params[])
{
     ShowPlayerDialog(playerid,1000,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Teleport Zones/Spawn Bolgeleri", ShowTeles1(),"Sec", "Iptal");
     return 1;
}
CMD:parkours(playerid, params[])
{
     ShowPlayerDialog(playerid,1008,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} Parkours", ShowTeles3(),"Isinlan", "Geri");
      return 1;
}
//------------------------------------------------------------------------------
CMD:stunts(playerid, params[])
{
     ShowPlayerDialog(playerid,1001,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} Stunts", ShowTeles3(),"Isinlan", "Geri");
      return 1;
}
//------------------------------------------------------------------------------
CMD:jumps(playerid, params[])
{
     ShowPlayerDialog(playerid,1002,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} Jumps", ShowTeles3(),"Isinlan", "Geri");
    return 1;
}
//------------------------------------------------------------------------------
CMD:dm(playerid, params[])
{
     ShowPlayerDialog(playerid,1003,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} DeathMatchs",ShowTeles4(),"Isinlan", "Geri");
       return 1;
}
//------------------------------------------------------------------------------
CMD:dd(playerid, params[])
{
      ShowPlayerDialog(playerid,1004,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} Drag/Drift", ShowTeles5(),"Isinlan", "Geri");
     return 1;
}
//------------------------------------------------------------------------------
CMD:fz(playerid, params[])
{
       ShowPlayerDialog(playerid,1006,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} Fun Zones", ShowTeles7(),"Isinlan", "Geri");
        return 1;
}
//------------------------------------------------------------------------------
CMD:others(playerid, params[])
{
     ShowPlayerDialog(playerid,1007,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} Other Teleports", ShowTeles8(),"Isinlan", "Geri");
     return 1;
}
//------------------------------------------------------------------------------
CMD:sss(playerid, params[])
{
     ShowPlayerDialog(playerid, 9981, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} Simple Stunts", ShowSStunts(), "Isinlan", "Geri");
    return 1;
}
CMD:minigun2(playerid, params[])
{
     return komut_mg2(playerid, params);
}
CMD:minigun(playerid, params[])
{
     return komut_mg1(playerid, params);
}
//------------------------------------------------------------------------------

COMMAND:cmds(playerid, params[]) return komut_komutlar(playerid, params);
COMMAND:commands(playerid, params[]) return komut_komutlar(playerid, params);
COMMAND:command(playerid, params[]) return komut_komutlar(playerid, params);
COMMAND:kmt(playerid, params[]) return komut_komutlar(playerid, params);
COMMAND:kmtlar(playerid, params[]) return komut_komutlar(playerid, params);
COMMAND:komutlar(playerid, params[])
{
     new
         cmdString[256]
     ;
     strcat(cmdString, "{E24234}» {FFFFFF}Oyuncu Komutlari\t\t{E24234}[/pcmds]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Hesap Komutlari\t\t{E24234}[/hcmds]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Arac Komutlari\t\t{E24234}[/acmds]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Admin Komutlari\t\t{E24234}[/adcmds]");
     ShowPlayerDialog(playerid, 90, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Commands", cmdString, "Tamam", "Kapat");
     return 1;
}
COMMAND:adcmds(playerid, params[])
{
     new
         cmdString[920]
     ;
     strcat(cmdString, "{E24234}» {FFFFFF}Level 1               \t\t{E24234}[/level1]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Level 2               \t\t{E24234}[/level2]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Level 3               \t\t{E24234}[/level3]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Level 4               \t\t{E24234}[/level4]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Level 5               \t\t{E24234}[/level5]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Level 6               \t\t{E24234}[/level6]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Level 7               \t\t{E24234}[/level7]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Level 8               \t\t{E24234}[/level8]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Level 9               \t\t{E24234}[/level9]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Level 10              \t\t{E24234}[/level10]");
     ShowPlayerDialog(playerid, 94, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Commands - Admin Komutlari", cmdString, "Tamam", "Iptal");
     return 1;
}
COMMAND:pcmds(playerid, params[])
{
     new
         cmdString[2425]
     ;
     strcat(cmdString, "{E24234}» {FFFFFF}Kurallar              \t\t{E24234}[/rules]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Araci Durdur          \t\t{E24234}[/stop]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Son PM Yanýtla        \t\t{E24234}[/re]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}MyStyle               \t\t{E24234}[/mystyle]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Shop                  \t\t{E24234}[/shop]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Havayi Degistir       \t\t{E24234}[/myweather]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Saati Degistir        \t\t{E24234}[/mytime]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Para Gonder           \t\t{E24234}[/paragonder]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Skor Gonder           \t\t{E24234}[/skorgonder]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Intihar Et            \t\t{E24234}[/kill]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Birine Isinlan        \t\t{E24234}[/goto]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}PM-Kapat-Ac           \t\t{E24234}[/pmkapatac]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Tele-Kapat-Ac         \t\t{E24234}[/telekapatac]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Deathmatch            \t\t{E24234}[/dm]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Animasyonlar          \t\t{E24234}[/animasyonlar]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Teleport Yerleri      \t\t{E24234}[/teles]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Admine Rapor          \t\t{E24234}[/rapor]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Lotto                 \t\t{E24234}[/loto]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Yarýþ                 \t\t{E24234}[/yarisgit]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Destruction Derby     \t\t{E24234}[/ddgit]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Balance               \t\t{E24234}[/balance]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}TeamDeathMatch        \t\t{E24234}[/tdmgit]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Destek Talebi         \t\t{E24234}[/ticket]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Çevrimiçi Adminler    \t\t{E24234}[/admins]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Çevrimiçi Animler     \t\t{E24234}[/anims]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Performans Testi      \t\t{E24234}[/performans]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Nick Renkleri         \t\t{E24234}[/ncolors]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Top Skor              \t\t{E24234}[/topscore]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Katiller              \t\t{E24234}[/topkill]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Zenginler             \t\t{E24234}[/topmoney]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Dil/Language          \t\t{E24234}[/dil]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Hýz Limiti            \t\t{E24234}[/hizlimiti]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Düello                \t\t{E24234}[/duello]");
     ShowPlayerDialog(playerid, 91, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Commands - Oyuncu", cmdString, "Tamam", "Kapat");
     return 1;
}
COMMAND:acmds(playerid, params[])
{
     new
         cmdString[920]
     ;
     strcat(cmdString, "{E24234}» {FFFFFF}Auto Tune             \t\t{E24234}[/tune]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Plakayi Degistir      \t\t{E24234}[/plaka]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Rengi Degistir        \t\t{E24234}[/vcolor]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Arac Yarat            \t\t{E24234}[/v1...v17]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Arac Yarat            \t\t{E24234}[/veh]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Modlu Arac            \t\t{E24234}[/m1...20]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}MyCar                 \t\t{E24234}[/mycar]\n");
     ShowPlayerDialog(playerid, 92, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Commands - Arac", cmdString, "Tamam", "Kapat");
     return 1;
}
COMMAND:hcmds(playerid, params[])
{
     new
         cmdString[920]
     ;
     strcat(cmdString, "{E24234}» {FFFFFF}Sifre Degis            \t\t{E24234}[/sifredegis]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Nick Degis             \t\t{E24234}[/nickdegis]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Banka Hesabiniz        \t\t{E24234}[/banka]\n");
     ShowPlayerDialog(playerid, 93, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Commands - Hesap", cmdString, "Tamam", "Kapat");
     return 1;
}
COMMAND:yardim(playerid, params[]) return komut_help(playerid, params);
COMMAND:help(playerid, params[])
{
     new
         cmdString[920]
     ;
     strcat(cmdString, "{E24234}» {FFFFFF}Komutlar            \t\t{E24234}[/cmds]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Sunucu Hk.          \t\t{E24234}[/about]\n");
     strcat(cmdString, "{E24234}» {FFFFFF}Kadromuz            \t\t{E24234}[/credits]\n");
     ShowPlayerDialog(playerid, 344, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" - Help", cmdString, "Tamam", "Kapat");
     return 1;
}
/*{
     SetPVarInt(playerid, "Opened", 1);
    TextDrawShowForPlayer(playerid, UserBox[0]);
    TextDrawShowForPlayer(playerid, UserBox[1]);
    TextDrawShowForPlayer(playerid, UserBox[2]);
    TextDrawShowForPlayer(playerid, UserBox[3]);

    if(GetPVarInt(playerid, "Language__") == TURKISH) PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][0], "Maestronline - Yardim");
    if(GetPVarInt(playerid, "Language__") == ENGLISH) PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][0], "Maestronline - Help");
    if(GetPVarInt(playerid, "Language__") == TURKISH)
    {
          PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][1], "Sunucu komutlarini gormek icin /komutlar yazin.~n~Sunucu modu hakkinda bilgi almak icin /about yazin.~n~Yapimcilari gormek icin /about yazin.");
     }
    else if(GetPVarInt(playerid, "Language__") == ENGLISH)
    {
          PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][1], "See you server commands in /komutlar command.~n~For information server gamemode /about.~n~Server use the command /about makers to see.");
     }
    PlayerTextDrawShow(playerid, PlayerUserBox[playerid][0]);
     PlayerTextDrawShow(playerid, PlayerUserBox[playerid][1]);
     SelectTextDraw(playerid, -1);
     return 1;
}
*/CMD:yetenekler(playerid, params[])
{
        ShowPlayerDialog(playerid,Shop+12,DIALOG_STYLE_TABLIST_HEADERS,"{E24234}"DIALOG_BASLIK" -{FFFFFF} Shop Menu {E24234}- {FFFFFF} Ozel Yetenekler",
     "Isim\tÜcret\tSinir\n\
     {E24234}» {FFFFFF}Full Zirhla Dogma\t125 Score\tNo Limit\n\
     ","Tamam", "Geri");
     return 1;
}
CMD:kurallar(playerid,params[])komut_rules(playerid, " ");
CMD:rules(playerid, params[])
{
     new szRule[2048];
     strcat(szRule, "\n\n");
     strcat(szRule, "\n{B360FD}\t\t\t\t******************\n{FFFFFF}\t\t\t\tServer Rules\n\n");
     strcat(szRule, "{FFFFFF}1-) Oyunculardan sizi üstün kilacak mod, cleo benzeri seyler yasaktir.\n{FFFFFF}2-) Hic bir hile dosyasi ile oyuna giril");
     strcat(szRule, "memeli ve hile kullanilmamalidir, yasaktir.\n{FFFFFF}3-) Bayan oyunculara sulu, yavsayici icerik iceren mesajlar gondermek yasakti");
     strcat(szRule, "r.\n{FFFFFF}4-) Üstü ortülü olsa dahi bir oyuncuyu kücük düsürecek konusmalar yapmak yasaktir!\n{FFFFFF}5-) Sunucunun hicbir sohbe");
     strcat(szRule, "t kanalinda küfürlü konusmalar yapmayin yasaktir. (Local, PM, Genel Sohbet vb...)\n{FFFFFF}6-) Siyasi propaganda iceren mesaj, gond");
     strcat(szRule, "ermelere hicbir sekilde müsaade edilmeyecektir, agir cezalari var.\n{FFFFFF}7-) Ozel mesaj (pm) disinda 'lan' benzeri agir kelimeler");
     strcat(szRule, " genel sohbette kullanilamaz.\n\n\n\t\t\t\t{FFFFFF}YONETICI KURALLARI\n\t\t\t\t{B360FD}****************************\n\n{FFFFFF}1-) Sunucu sah");
     strcat(szRule, "ipleri disinda hic bir yonetici küfürlü konusmalar yapamaz.\n{FFFFFF}2-) Yonetici ve animatorler yetkisinden büyük olan yetkililere say");
     strcat(szRule, "gi duymak zorundadirlar.\n{FFFFFF}3-) Animatorler hafta da en az 60 etkinlik yapmak zorundalar.\n{FFFFFF}4-) Sunucu sahipleri disinda h");
     strcat(szRule, "ic bir yonetici,animator siyasi propaganda yapamaz.\n{FFFFFF}5-) Animatorler oyunda 1 saat mi durdu ? o bir saat icerisinde en az 40 et");
     strcat(szRule, "kinlik yapmali.\n{FFFFFF}6-) Yoneticiler etkinlik yapabilir ama sik sik olmamasi kaydiyla.\n{FFFFFF}7-) Animatorler etkinlik sirasinda en fazla 30 skor, 75.000$ para verebilirler.\n{FFFFFF}8-) Animatorler sizinle sert, agir konusamaz, ceza verilir.\n\n\t\t\t\tZero Freeroam\n\t\t\t\t{B360FD}******************");
     ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK" - Kurallar", szRule, "Tamam", "Iptal");
     return 1;
}

CMD:shop(playerid, params[])
{
if(PlayerInfo[playerid][Registered] == 0)return HataMesaji(playerid, "/kayit olmadan /shop komutunu kulanmazsýnýz");
    ShowPlayerDialog(playerid, 7777, DIALOG_STYLE_TABLIST_HEADERS, "{E24234}"DIALOG_BASLIK" -{FFFFFF} Shop Menu", "\
     Ürün\tKomut\tÜrün Sayisi \n\
     {E24234}» {FFFFFF}Can{336699}§{FFFFFF}Zirh Menüsü\t{E24234}[/czmenu]\t{E24234}4\n\
     {E24234}» {FFFFFF}Silah Menüsü\t{E24234}[/silahlar]\t{E24234}27\n\
     {E24234}» {FFFFFF}Ozel Yetenekler\t{E24234}[/yetenekler]\t{E24234}2\n\
     {E24234}» {FFFFFF}Nick Renkleri\t{E24234}[/ncolors]\t{E24234}9", "Tamam", "Iptal");
     return 1;
}

CMD:animasyonlar(playerid, params[])
{
     if(GetPVarInt(playerid, "Language__") == TURKISH)
     {
          new DialogText[5000];
          strcat(DialogText, "{E24234}»{FFFFFF} Animasyonu Durdur              \t\t{E24234}[ /animdurdur ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Eller Havaya                   \t\t{E24234}[ /ellerhavaya ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sarhos                         \t\t{E24234}[ /sarhos ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Bomba                          \t\t{E24234}[ /bomba ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Ates                           \t\t{E24234}[ /ates ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Gül                            \t\t{E24234}[ /gul ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Dgozetle                       \t\t{E24234}[ /dgozetle ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Hirsizlik                      \t\t{E24234}[ /hirsizlik ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} 31                             \t\t\t{E24234}[ /31 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} 31 Bitis                       \t\t{E24234}[ /31bitis ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Yakalandin                     \t\t{E24234}[ /yakalandin ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Vururum                        \t\t{E24234}[ /vururum ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Vuruldum                       \t\t{E24234}[ /vuruldum ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} saplak Yedim                   \t\t{E24234}[ /saplakyedim ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} saplak At                      \t\t{E24234}[ /saplakat ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sigara                         \t\t{E24234}[ /sigara ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sigara2                        \t\t{E24234}[ /sigara2 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} El Salla                       \t\t{E24234}[ /elsalla ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Bak                            \t\t{E24234}[ /bak ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Uzan                           \t\t{E24234}[ /uzan ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Otur                           \t\t{E24234}[ /otur ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Yemek                          \t\t{E24234}[ /yemek ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Kus                            \t\t{E24234}[ /kus ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Ol                             \t\t{E24234}[ /ol ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Anlas                          \t\t{E24234}[ /anlas ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Op                             \t\t{E24234}[ /op ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Emrah                          \t\t{E24234}[ /emrah ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Ne Var Lan                     \t\t{E24234}[ /nevarlan ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Ise                            \t\t\t{E24234}[ /ise ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Dans 1                         \t\t{E24234}[ /dans1 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Dans 2                         \t\t{E24234}[ /dans2 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Dans 3                         \t\t{E24234}[ /dans3 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Dans 4                         \t\t{E24234}[ /dans4 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sex 1                          \t\t{E24234}[ /sex1 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sex 2                          \t\t{E24234}[ /sex2 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sex 3                          \t\t{E24234}[ /sex3 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sex 4                          \t\t{E24234}[ /sex4 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sex 5                          \t\t{E24234}[ /sex5 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sex 6                          \t\t{E24234}[ /sex6 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Bira Ic                        \t\t{E24234}[ /bira ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sprunk                         \t\t{E24234}[ /sprunk ]\n");
          ShowPlayerDialog(playerid,Animsd, DIALOG_STYLE_LIST, "Animasyonlar/Animations",DialogText, "Sec", "Geri");
     }
     else
     {
          new DialogText[5000];
          strcat(DialogText, "{E24234}»"S" Stop Animations                \t\t{E24234}[ /animdurdur ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Handsup!                       \t\t{E24234}[ /ellerhavaya ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Drunk                          \t\t\t{E24234}[ /sarhos ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Bomb                           \t\t\t{E24234}[ /bomba ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Shot                           \t\t\t{E24234}[ /ates ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Smile                          \t\t\t{E24234}[ /gul ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Watch_S                        \t\t{E24234}[ /dgozetle ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Robber                         \t\t\t{E24234}[ /hirsizlik ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Wank                           \t\t\t{E24234}[ /31 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Wank Stop                      \t\t\t{E24234}[ /31bitis ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Wasted :'(                     \t\t{E24234}[ /yakalandin ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Shoot!!!                       \t\t\t{E24234}[ /vururum ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} I'Shotted                      \t\t{E24234}[ /vuruldum ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} I'm Slapped                    \t\t{E24234}[ /saplakyedim ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Slap Ass                       \t\t\t{E24234}[ /saplakat ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Smoke                          \t\t\t{E24234}[ /sigara ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Smoke 2                        \t\t\t{E24234}[ /sigara2 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Hello                          \t\t\t{E24234}[ /elsalla ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Watch                          \t\t\t{E24234}[ /bak ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Reach                          \t\t\t{E24234}[ /uzan ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sit Down                       \t\t\t{E24234}[ /otur ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Eat                            \t\t\t{E24234}[ /yemek ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Puke                           \t\t\t{E24234}[ /kus ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Deaths                         \t\t\t{E24234}[ /ol ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Shkae                          \t\t\t{E24234}[ /anlas ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Kiss                           \t\t\t{E24234}[ /op ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Crack                          \t\t\t{E24234}[ /emrah ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Hoop                           \t\t{E24234}[ /nevarlan ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Piss                           \t\t\t{E24234}[ /ise ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Dans 1                         \t\t\t{E24234}[ /dans1 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Dans 2                         \t\t\t{E24234}[ /dans2 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Dans 3                         \t\t\t{E24234}[ /dans3 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Dans 4                         \t\t\t{E24234}[ /dans4 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sex 1                          \t\t\t{E24234}[ /sex1 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sex 2                          \t\t\t{E24234}[ /sex2 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sex 3                          \t\t\t{E24234}[ /sex3 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sex 4                          \t\t\t{E24234}[ /sex4 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sex 5                          \t\t\t{E24234}[ /sex5 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sex 6                          \t\t\t{E24234}[ /sex6 ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Beer Drink                     \t\t\t{E24234}[ /bira ]\n");
          strcat(DialogText, "{E24234}»{FFFFFF} Sprunk                         \t\t\t{E24234}[ /sprunk ]\n");
          ShowPlayerDialog(playerid, Animsd, DIALOG_STYLE_LIST, "Animasyonlar/Animations",DialogText, "Sec", "Geri");
     }
     return 1;
}

CMD:animdurdur(playerid, params[])
{

ClearAnimations(playerid);
Bilgimesaj(playerid,"Su anda aktif animasyonlari durdurdunuz.","Stopped animations.");
return 1;
}

CMD:ellerhavaya(playerid, params[])
{

SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
Bilgimesaj(playerid,"Su anda {E24234}' Eller Havaya' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Handsup '{FFFFFF} animation.");
return 1;
}

CMD:sarhos(playerid, params[])
{

ApplyAnimation(playerid, "PED", "WALK_DRUNK", 4.0, 1, 1, 1, 1, 0);
ApplyAnimation(playerid, "PED", "WALK_DRUNK", 4.0, 1, 1, 1, 1, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Sarhos' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Drunker '{FFFFFF} animation.");
return 1;
}

CMD:bomba(playerid, params[])
{

ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Bomba' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Bomb '{FFFFFF} animation.");
return 1;
}

CMD:ates(playerid, params[])
{

ApplyAnimation( playerid,"ped", "ARRESTgun", 4.0, 0, 0, 0, 0, 0);
ApplyAnimation( playerid,"ped", "ARRESTgun", 4.0, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Ates' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Fire '{FFFFFF} animation.");
return 1;
}

CMD:gul(playerid, params[])
{

ApplyAnimation(playerid, "RAPPING", "Laugh_01", 3.5, 0, 0, 0, 0, 0);
ApplyAnimation(playerid, "RAPPING", "Laugh_01", 3.5, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Gülümsemek' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Smile '{FFFFFF} animation.");
return 1;
}

CMD:dgozetle(playerid, params[])
{

ApplyAnimation(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0);
ApplyAnimation(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Gozetle' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' View '{FFFFFF} animation.");
return 1;
}

CMD:hirsizlik(playerid, params[])
{

ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0);
ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Hirsiz' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Robber '{FFFFFF} animation.");
return 1;
}

CMD:31(playerid, params[])
{

ApplyAnimation(playerid, "PAULNMAC", "wank_loop", 4.0, 1, 0, 0, 0, 0);
ApplyAnimation(playerid, "PAULNMAC", "wank_loop", 4.0, 1, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' 31' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Wank '{FFFFFF} animation.");
return 1;
}

CMD:31bitis(playerid, params[])
{

ApplyAnimation(playerid, "PAULNMAC", "wank_out", 4.0, 0, 0, 0, 0, 0);
ApplyAnimation(playerid, "PAULNMAC", "wank_out", 4.0, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' 31 Bitis' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Stop Wank '{FFFFFF} animation.");
return 1;
}

CMD:yakalandin(playerid, params[])
{

ApplyAnimation(playerid, "POLICE", "plc_drgbst_01", 4.0, 0, 0, 0, 0, 0);
ApplyAnimation(playerid, "POLICE", "plc_drgbst_01", 4.0, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Yakalandin' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Up Hands '{FFFFFF} animation.");
return 1;
}

CMD:vururum(playerid, params[])
{

ApplyAnimation(playerid, "POLICE", "crm_drgbst_01", 4.0, 0, 0, 0, 0, 0);
ApplyAnimation(playerid, "POLICE", "crm_drgbst_01", 4.0, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Vururum' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Up Hands '{FFFFFF} animation.");
return 1;
}

CMD:vuruldum(playerid, params[])
{

ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0);
ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Vuruldum' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Deaths '{FFFFFF} animation.");
return 1;
}

CMD:saplakyedim(playerid, params[])
{

ApplyAnimation(playerid, "SWEET", "ho_ass_slapped", 4.0, 0, 0, 0, 0, 0);
ApplyAnimation(playerid, "SWEET", "ho_ass_slapped", 4.0, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' saplak Yedim' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' I'm Slapped '{FFFFFF} animation.");
return 1;
}

CMD:saplakat(playerid, params[])
{

ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0);
ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Slap The Ass' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Slap Ass '{FFFFFF} animation.");
return 1;
}

CMD:sigara(playerid, params[])
{

ApplyAnimation(playerid, "SMOKING", "F_smklean_loop", 30.0, 0, 0, 0, 0, 0);
ApplyAnimation(playerid, "SMOKING", "F_smklean_loop", 30.0, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Sigara1' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Smoke '{FFFFFF} animation.");
return 1;
}

CMD:sigara2(playerid, params[])
{

ApplyAnimation(playerid,"SMOKING", "M_smklean_loop", 30.0, 1, 1, 1, 1, 1);
ApplyAnimation(playerid,"SMOKING", "M_smklean_loop", 30.0, 1, 1, 1, 1, 1);
Bilgimesaj(playerid,"Su anda {E24234}' Sigara2' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Smoke2 '{FFFFFF} animation.");
return 1;
}

CMD:elsalla(playerid, params[])
{

ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 3.5, 1, 0, 0, 0, 0);
ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 3.5, 1, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Hello' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Hello '{FFFFFF} animation.");
return 1;
}

CMD:bak(playerid, params[])
{

ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 2.0, 0, 1, 1, 1, -1);
ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 2.0, 0, 1, 1, 1, -1);
Bilgimesaj(playerid,"Su anda {E24234}' Bak' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Watch '{FFFFFF} animation.");
return 1;
}

CMD:uzan(playerid, params[])
{

ApplyAnimation(playerid,"BEACH", "bather", 30.0, 1, 1, 1, 1, 1);
ApplyAnimation(playerid,"BEACH", "bather", 30.0, 1, 1, 1, 1, 1);
Bilgimesaj(playerid,"Su anda {E24234}' Uzan' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Lie '{FFFFFF} animation.");
return 1;
}

CMD:otur(playerid, params[])
{

ApplyAnimation(playerid,"BEACH", "ParkSit_M_loop", 30.0, 1, 1, 1, 1, 1);
ApplyAnimation(playerid,"BEACH", "ParkSit_M_loop", 30.0, 1, 1, 1, 1, 1);
Bilgimesaj(playerid,"Su anda {E24234}' Otur' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Sit down '{FFFFFF} animation.");
return 1;
}

CMD:yemek(playerid, params[])
{

ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);
ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Yemek' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Eat '{FFFFFF} animation.");
return 1;
}

CMD:kus(playerid, params[])
{

ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 3.5, 0, 0, 0, 0, 0);
ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 3.5, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Kus' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Vomit '{FFFFFF} animation.");
return 1;
}

CMD:ol(playerid, params[])
{

ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.0, 0, 0, 0, 0, 0);
ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.0, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Ol' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Death '{FFFFFF} animation.");
return 1;
}

CMD:anlas(playerid, params[])
{

ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Anlas' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Shake Hands '{FFFFFF} animation.");
return 1;
}

CMD:op(playerid, params[])
{

ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_02", 4.0, 0, 0, 0, 0, 0);
ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_02", 4.0, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Op' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Kiss '{FFFFFF} animation.");
return 1;
}

CMD:emrah(playerid, params[])
{

ApplyAnimation(playerid, "CRACK", "crckdeth2", 3.5, 1, 0, 0, 0, 0);
ApplyAnimation(playerid, "CRACK", "crckdeth2", 3.5, 1, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Emrah' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Crack '{FFFFFF} animation.");
return 1;
}

CMD:nevarlan(playerid, params[])
{

ApplyAnimation(playerid,"ped", "fucku", 4.1, 0, 1, 1, 1, 1 );
ApplyAnimation(playerid,"ped", "fucku", 4.1, 0, 1, 1, 1, 1 );
Bilgimesaj(playerid,"Su anda {E24234}' Hop' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Hey! '{FFFFFF} animation.");
return 1;
}

CMD:ise(playerid, params[])
{

ApplyAnimation(playerid, "PAULNMAC", "Piss_loop", 4.0, 1, 1, 1, 1, 0);
ApplyAnimation(playerid, "PAULNMAC", "Piss_loop", 4.0, 1, 1, 1, 1, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Ise' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Piss '{FFFFFF} animation.");
return 1;
}

CMD:dans1(playerid, params[])
{

SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
Bilgimesaj(playerid,"Su anda {E24234}' Dans 1' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Dance 1 '{FFFFFF} animation.");
return 1;
}

CMD:dans2(playerid, params[])
{

SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
Bilgimesaj(playerid,"Su anda {E24234}' Dans 2' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Dance 2 '{FFFFFF} animation.");
return 1;
}

CMD:dans3(playerid, params[])
{

SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
Bilgimesaj(playerid,"Su anda {E24234}' Dans 3' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Dance 3 '{FFFFFF} animation.");
return 1;
}

CMD:dans4(playerid, params[])
{

SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
Bilgimesaj(playerid,"Su anda {E24234}' Dans 4' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Dance 4 '{FFFFFF} animation.");
return 1;
}

CMD:sex1(playerid, params[])
{

ApplyAnimation(playerid, "PAULNMAC", "wank_loop", 1.8, 1, 0, 0, 1, 600);
ApplyAnimation(playerid, "PAULNMAC", "wank_loop", 1.8, 1, 0, 0, 1, 600);
Bilgimesaj(playerid,"Su anda {E24234}' Sex 1 ' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Sex 1 '{FFFFFF} animation.");
return 1;
}

CMD:sex2(playerid, params[])
{

ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0);
ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0);
Bilgimesaj(playerid,"Su anda {E24234}' Sex 2 ' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Sex 2 '{FFFFFF} animation.");
return 1;
}

CMD:sex3(playerid, params[])
{

ApplyAnimation(playerid, "MISC", "bitchslap", 4.0999, 0, 1, 1, 1, 1);
ApplyAnimation(playerid, "MISC", "bitchslap", 4.0999, 0, 1, 1, 1, 1);
Bilgimesaj(playerid,"Su anda {E24234}' Sex 3 ' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Sex 3 '{FFFFFF} animation.");
return 1;
}

CMD:sex4(playerid, params[])
{

ApplyAnimation(playerid, "PED", "fucku", 4.0999, 0, 1, 1, 1, 1);
ApplyAnimation(playerid, "PED", "fucku", 4.0999, 0, 1, 1, 1, 1);
Bilgimesaj(playerid,"Su anda {E24234}' Sex 4 ' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Sex 4 '{FFFFFF} animation.");
return 1;
}

CMD:sex5(playerid, params[])
{

ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.0999, 0, 1, 1, 1, 1);
ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.0999, 0, 1, 1, 1, 1);
Bilgimesaj(playerid,"Su anda {E24234}' Sex 5 ' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Sex 5 '{FFFFFF} animation.");
return 1;
}

CMD:sex6(playerid, params[])
{

ApplyAnimation(playerid, "PAULNMAC", "PISS_LOOP", 4.0999, 0, 1, 1, 1, 1);
ApplyAnimation(playerid, "PAULNMAC", "PISS_LOOP", 4.0999, 0, 1, 1, 1, 1);
Bilgimesaj(playerid,"Su anda {E24234}' Sex 6 ' {FFFFFF}adli animasyonu yapiyorsunuz.", "You are playing the {E24234}' Sex 6 '{FFFFFF} animation.");
return 1;
}

CMD:bira(playerid, params[])
{

SetPlayerSpecialAction (playerid, SPECIAL_ACTION_DRINK_WINE );
Bilgimesaj(playerid,"Bir {E24234}Bira {FFFFFF}aldiniz, kullanmak icin {E24234}' Ates Tusuna  '{FFFFFF} basin", "Bought one beer. Use to press {E24234}' Fire Key '{FFFFFF} key.");
return 1;
}

CMD:sprunk(playerid, params[])
{

ApplyAnimation(playerid,"VENDING","VEND_Use",1.4,0 ,1,1,0,2500,1);
Bilgimesaj(playerid,"Bir {E24234}Bira {FFFFFF}aldiniz, kullanmak icin {E24234}' Ates Tusuna  '{FFFFFF} basin", "Bought one sprunk. Use to press {E24234}' Fire Key '{FFFFFF} key.");
return 1;
}

// Las Venturar Teleport

COMMAND:ap1(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Ap1",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1335.7499,1280.3781,10.8203);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1335.7499,1280.3781,10.8203);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:army(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Army",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 291.2032,2056.0276,17.6406);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 291.2032,2056.0276,17.6406);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:lvch(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~City Hall",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2421.7185,1121.9866,10.8125);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2421.7185,1121.9866,10.8125);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:calic(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Caligulas Casino",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2187.8350,1678.5358,11.1094);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2187.8350,1678.5358,11.1094);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:starfc(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Starfish Casino",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2227.3596,1894.3228,10.6719);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2227.3596,1894.3228,10.6719);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:4dragon(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Four Dragons Casino",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2028.4336,1007.0593,10.8203);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2028.4336,1007.0593,10.8203);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:4d(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Four Dragons Casino",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2028.4336,1007.0593,10.8203);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2028.4336,1007.0593,10.8203);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:pp(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Prickle Pine",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1434.6989,2654.4026,11.3926);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1434.6989,2654.4026,11.3926);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:bs(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Bandit Stadium",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1493.2443,2238.1526,11.0291);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1493.2443,2238.1526,11.0291);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:ldm(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Last Dime Motel",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1929.0522,707.8507,10.8203);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1929.0522,707.8507,10.8203);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:base(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Base Pitch",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1377.0000,2196.0000,9.7578);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1377.0000,2196.0000,9.7578);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:alot(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Came A-Lot",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2163.0000,1121.0000,23.3359);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2163.0000,1121.0000,23.3359);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:tstr(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~The Strip",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2037.0000,1343.3330,10.8203);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2037.0000,1343.3330,10.8203);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:mlt(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Military",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2503.0000,2764.0000,10.8203);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2503.0000,2764.0000,10.8203);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

// Las Venturar Teleport Bitis

// San Fierro Teleport

COMMAND:ap2(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~San Fierro Airport",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -1115.2357,-194.4264,14.1440);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -1115.2357,-194.4264,14.1440);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:sfch(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~City Hall",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -2672.6116,1268.4943,55.9456);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -2672.6116,1268.4943,55.9456);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:mh(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Missionary Hill",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -2515.6768,-611.6651,132.5625);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -2515.6768,-611.6651,132.5625);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:battery(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Battery",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -1853.0000,1404.0000,7.1841);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -1853.0000,1404.0000,7.1841);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:station(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Station",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -1990.0000,137.0000,27.5391);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -1990.0000,137.0000,27.5391);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:tof(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Ocean Flats",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -2709.0000,198.0000,4.1797);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -2709.0000,198.0000,4.1797);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:tac(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Country",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -2738.0000,-294.6667,6.9939);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -2738.0000,-294.6667,6.9939);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:easter(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Docks",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -1457.0000,465.0000,7.1875);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -1457.0000,465.0000,7.1875);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

// Los Santos Teleport

COMMAND:ap3(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Los Santos Airport",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid,1954.2603,-2629.1553,15.6468);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1954.2603,-2629.1553,15.6468);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:smaria(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Santa Marina Beach",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 425.0000,-1815.0000,6.6641);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 425.0000,-1815.0000,6.6641);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

CMD:djmekan(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~DJ Mekan",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1967.9197, 1912.4851, 936.6108);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1967.9197, 1912.4851, 936.6108);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
	return 1;
}
COMMAND:grove(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Grove Street",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2495.0000,-1688.0000,13.5324);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2495.0000,-1688.0000,13.5324);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:lsch(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~City Hall",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1461.0043,-1019.4626,24.6975);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1461.0043,-1019.4626,24.6975);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:ocean(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Ocean Docks",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2791.1782,-2534.6309,13.6303);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2791.1782,-2534.6309,13.6303);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:crazybob(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~CrazyBobs House",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1255.2925,-778.2413,92.0302);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1255.2925,-778.2413,92.0302);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:jefferson(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Jefferson Motel",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2229.0200,-1159.8000,25.7981);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2229.0200,-1159.8000,25.7981);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:rich(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Richman",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 679.0000,-1070.0000,49.1787);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 679.0000,-1070.0000,49.1787);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:pers(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Pershing Square",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1481.0000,-1656.0000,14.0469);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1481.0000,-1656.0000,14.0469);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:mhl(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Mul Holland",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1240.0000,-744.0000,95.3512);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1240.0000,-744.0000,95.3512);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

// Los Santos Teleport Bitis

// Other Teleport

COMMAND:ap4(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Old Airport",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 418.0485,2449.3252,16.5000);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 418.0485,2449.3252,16.5000);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:vmeadow(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Verdant Meadows",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 414.9159,2532.9700,19.1484);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 414.9159,2532.9700,19.1484);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:bside(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Baysied",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -2271.0764,2317.8457,4.8202);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -2271.0764,2317.8457,4.8202);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:pcreek(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Palonimo Creek",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2259.5532,-85.0334,26.5107);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2259.5532,-85.0334,26.5107);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:mntgom(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Montgomery",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1377.4314,271.4077,19.5669);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1377.4314,271.4077,19.5669);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:bberry(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Blueberry",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 183.9907,-108.2153,2.0234);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 183.9907,-108.2153,2.0234);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:dlake(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Drylake",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -12.7000,1482.0374,12.7500);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -12.7000,1482.0374,12.7500);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}
CMD:m1(playerid, params[])
{
if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
new Float:X,Float:Y,Float:Z,Float:Angle;GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(411,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);AddVehicleComponent(ivehicle[playerid], 1028);AddVehicleComponent(ivehicle[playerid], 1030);AddVehicleComponent(ivehicle[playerid], 1031);AddVehicleComponent(ivehicle[playerid], 1138);AddVehicleComponent(ivehicle[playerid], 1140);  AddVehicleComponent(ivehicle[playerid], 1170);
	InfernusTuning[ playerid ][ 0 ] = CreateObject( 1163, 0, 0, -1000, 0, 0, 0, 100);
	AttachObjectToVehicle(InfernusTuning[ playerid ][ 0 ], ivehicle[playerid], 0.000000,-2.400000,0.449999,0.000000,-0.000000,0.000000);
	InfernusTuning[ playerid ][ 1 ] = CreateObject(1013,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(InfernusTuning[ playerid ][ 1 ], ivehicle[playerid], 0.000000,2.625000,-0.524999,0.000000,0.000000,0.000000);
	InfernusTuning[ playerid ][ 2 ] = CreateObject(359,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(InfernusTuning[ playerid ][ 2 ], ivehicle[playerid], -0.449999,-0.075000,0.599999,0.000000,0.000000,89.099983);
	InfernusTuning[ playerid ][ 3 ] = CreateObject(359,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(InfernusTuning[ playerid ][ 3 ], ivehicle[playerid], 0.524999,-0.075000,0.599999,0.000000,0.000000,89.099983);
	InfernusTuning[ playerid ][ 4 ] = CreateObject(1840,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(InfernusTuning[ playerid ][ 4 ], ivehicle[playerid], 0.300000,-0.974999,0.075000,0.000000,86.399986,-89.099983);
	InfernusTuning[ playerid ][ 5 ] = CreateObject(1840,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(InfernusTuning[ playerid ][ 5 ], ivehicle[playerid], -0.300000,-0.974999,0.075000,0.000000,86.399986,-89.099983);
	InfernusTuning[ playerid ][ 6 ] = CreateObject(19314,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle( InfernusTuning[ playerid ][ 6 ], ivehicle[playerid], 0.000000,2.700001,0.000000,91.799980,-72.900001,-16.200000);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
     ChangeVehicleColor(GetPlayerVehicleID(playerid), 0, 0);
return 1;}

CMD:m2(playerid, params[])
{


if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
new Float:X,Float:Y,Float:Z,Float:Angle;GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(562,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);AddVehicleComponent(ivehicle[playerid], 1028);AddVehicleComponent(ivehicle[playerid], 1030);AddVehicleComponent(ivehicle[playerid], 1031);AddVehicleComponent(ivehicle[playerid], 1138);AddVehicleComponent(ivehicle[playerid], 1140);  AddVehicleComponent(ivehicle[playerid], 1170);
Elegy[ playerid ][ 0 ] = CreateObject(1115,0,0,-1000,0,0,0,100);
AttachObjectToVehicle(Elegy[ playerid ][ 0 ], ivehicle[playerid], 0.000000,2.505001,-0.524999,-1.619997,0.000000,0.000000);
Elegy[ playerid ][ 1 ] = CreateObject(1013,0,0,-1000,0,0,0,100);
AttachObjectToVehicle(Elegy[ playerid ][ 1 ], ivehicle[playerid], 0.000000,2.445000,-0.329999,-3.239999,0.000000,0.000000);
Elegy[ playerid ][ 2 ] = CreateObject(1001,0,0,-1000,0,0,0,100);
AttachObjectToVehicle(Elegy[ playerid ][ 2 ], ivehicle[playerid], -0.015000,-2.160000,0.324999,0.000000,0.000000,0.000000);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
     ChangeVehicleColor(GetPlayerVehicleID(playerid), 0, 0);
return 1;}

CMD:m3(playerid, params[])
{


if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
new Float:X,Float:Y,Float:Z,Float:Angle;GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(550,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
	SunrisePol[ playerid ][ 0 ] = CreateObject(19420,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(SunrisePol[ playerid ][ 0 ], ivehicle[playerid], 0.000000,-0.640000,0.714999,0.000000,0.000000,0.000000);
	SunrisePol[ playerid ][ 1 ] = CreateObject(1163,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(SunrisePol[ playerid ][ 1 ], ivehicle[playerid], -0.009999,-2.520000,0.300000,0.000000,0.000000,0.000000);
	SunrisePol[ playerid ][ 2 ] = CreateObject(19280,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(SunrisePol[ playerid ][ 2 ], ivehicle[playerid], -0.859999,2.755001,-0.529999,0.000000,0.000000,0.000000);
	SunrisePol[ playerid ][ 3 ] = CreateObject(19280,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(SunrisePol[ playerid ][ 3 ], ivehicle[playerid], 0.854999,2.755001,-0.529999,0.000000,0.000000,0.000000);
  SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
     ChangeVehicleColor(GetPlayerVehicleID(playerid), 0, 0);
return 1;}

CMD:m4(playerid, params[])
{


if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
new Float:X,Float:Y,Float:Z,Float:Angle;GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(543,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
	Saddler[ playerid ][ 0 ] = CreateObject(1019,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle( Saddler[ playerid ][ 0 ], ivehicle[playerid], -0.514999,-1.800000,-0.479999,0.000000,0.000000,0.000000);
	Saddler[ playerid ][ 1 ] = CreateObject(1019,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle( Saddler[ playerid ][ 1 ], ivehicle[playerid], 0.475000,-1.800000,-0.479999,0.000000,0.000000,0.000000);
	Saddler[ playerid ][ 2 ] = CreateObject(1841,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle( Saddler[ playerid ][ 2 ], ivehicle[playerid], -0.714999,-0.954999,-0.010000,2.699999,2.699999,117.539955);
	Saddler[ playerid ][ 3 ] = CreateObject(1841,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle( Saddler[ playerid ][ 3 ], ivehicle[playerid], 0.649999,-0.934999,-0.010000,2.699999,2.699999,55.440010);
	Saddler[ playerid ][ 4 ] = CreateObject(362,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle( Saddler[ playerid ][ 4 ], ivehicle[playerid], 1.300000,0.674999,0.389999,5.399998,29.700002,93.959968);
	Saddler[ playerid ][ 5 ] = CreateObject(362,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle( Saddler[ playerid ][ 5 ], ivehicle[playerid], -1.115000,0.674999,0.389999,5.399998,29.700002,93.959968);
	Saddler[ playerid ][ 6 ] = CreateObject(1013,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle( Saddler[ playerid ][ 6 ], ivehicle[playerid], 0.000000,2.245000,-0.375000,0.000000,0.000000,0.000000);
	Saddler[ playerid ][ 7 ] = CreateObject(1115,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle( Saddler[ playerid ][ 7 ], ivehicle[playerid], 0.000000,2.285001,-0.230000,7.560000,0.000000,0.000000);
  SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
     ChangeVehicleColor(GetPlayerVehicleID(playerid), 0, 0);
return 1;}

CMD:m5(playerid, params[])
{


if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
new Float:X,Float:Y,Float:Z,Float:Angle;GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(413,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
	BurritoTuning[ playerid ][ 0 ] = CreateObject(1014,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(BurritoTuning[ playerid ][ 0 ] , ivehicle[playerid], 0.000000,-2.435001,1.039999,0.000000,0.000000,0.000000);
	BurritoTuning[ playerid ][ 1 ]  = CreateObject(1013,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(BurritoTuning[ playerid ][ 1 ] , ivehicle[playerid], 0.000000,2.600001,-0.689999,0.000000,0.000000,0.000000);
	BurritoTuning[ playerid ][ 2 ]  = CreateObject(1840,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(BurritoTuning[ playerid ][ 2 ] , ivehicle[playerid], 0.469999,0.360000,0.545000,0.000000,0.000000,-83.699989);
	BurritoTuning[ playerid ][ 3 ]  = CreateObject(1840,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(BurritoTuning[ playerid ][ 3 ] , ivehicle[playerid], -0.415000,0.360000,0.535000,0.000000,0.000000,-83.699989);
	BurritoTuning[ playerid ][ 4 ]  = CreateObject(1100,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(BurritoTuning[ playerid ][ 4 ] , ivehicle[playerid], 0.000000,-0.270000,0.000000,0.000000,0.000000,0.000000);
	BurritoTuning[ playerid ][ 5 ]  = CreateObject(1019,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(BurritoTuning[ playerid ][ 5 ] , ivehicle[playerid], 0.260000,-1.720000,-0.844999,0.719999,0.000000,21.780002);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
     ChangeVehicleColor(GetPlayerVehicleID(playerid), 0, 0);
return 1;}

CMD:m6(playerid, params[])
{


if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
new Float:X,Float:Y,Float:Z,Float:Angle;GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(560,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
	SultanTaxi[ playerid ][ 0 ] = CreateObject(19310,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(SultanTaxi[ playerid ][ 0 ], ivehicle[playerid], -0.004999,-0.699999,0.920000,0.000000,0.000000,-91.079978);
	SultanTaxi[ playerid ][ 1 ] = CreateObject(1019,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(SultanTaxi[ playerid ][ 1 ], ivehicle[playerid], -0.564999,-1.500000,-0.370000,0.000000,0.000000,0.000000);
	SultanTaxi[ playerid ][ 2 ] = CreateObject(1019,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(SultanTaxi[ playerid ][ 2 ], ivehicle[playerid], 0.549999,-1.500000,-0.370000,0.000000,0.000000,0.000000);
	SultanTaxi[ playerid ][ 3 ] = CreateObject(1148,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(SultanTaxi[ playerid ][ 3 ], ivehicle[playerid], 1.059999,-1.695000,0.014999,0.000000,0.000000,0.000000);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
     ChangeVehicleColor(GetPlayerVehicleID(playerid), 0, 0);
return 1;}

CMD:m7(playerid, params[])
{


if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
new Float:X,Float:Y,Float:Z,Float:Angle;GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(561,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
	StrutamTuning[ playerid ][ 0 ] = CreateObject(1840,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(StrutamTuning[ playerid ][ 0 ], ivehicle[playerid], 0.649999,-1.885000,0.000000,0.000000,0.000000,89.099983);
	StrutamTuning[ playerid ][ 1 ] = CreateObject(1840,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(StrutamTuning[ playerid ][ 1 ], ivehicle[playerid], -0.639999,-1.885000,0.000000,0.000000,0.000000,89.099983);
	StrutamTuning[ playerid ][ 2 ] = CreateObject(1019,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(StrutamTuning[ playerid ][ 2 ], ivehicle[playerid], -0.524999,-1.800000,-0.539999,0.000000,0.000000,0.000000);
	StrutamTuning[ playerid ][ 3 ] = CreateObject(1019,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(StrutamTuning[ playerid ][ 3 ], ivehicle[playerid], 0.499999,-1.800000,-0.539999,0.000000,0.000000,0.000000);
	StrutamTuning[ playerid ][ 4 ] = CreateObject(1001,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(StrutamTuning[ playerid ][ 4 ], ivehicle[playerid], 0.000000,-2.175000,0.694999,0.000000,0.000000,0.000000);
	StrutamTuning[ playerid ][ 5 ] = CreateObject(1013,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(StrutamTuning[ playerid ][ 5 ], ivehicle[playerid], -0.015000,2.765001,-0.374999,0.000000,-180.899887,-0.359999);
	StrutamTuning[ playerid ][ 6 ] = CreateObject(18646,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(StrutamTuning[ playerid ][ 6 ], ivehicle[playerid], 0.599999,0.880000,0.339999,0.000000,0.000000,0.000000);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
     ChangeVehicleColor(GetPlayerVehicleID(playerid), 0, 0);
return 1;}

CMD:m8(playerid, params[])
{


if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
new Float:X,Float:Y,Float:Z,Float:Angle;GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(567,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
AddVehicleComponent(ivehicle[playerid],1102); AddVehicleComponent(ivehicle[playerid],1129); AddVehicleComponent(ivehicle[playerid],1133); AddVehicleComponent(ivehicle[playerid],1186); AddVehicleComponent(ivehicle[playerid],1188); ChangeVehiclePaintjob(ivehicle[playerid],1); AddVehicleComponent(ivehicle[playerid],1010); AddVehicleComponent(ivehicle[playerid],1085); AddVehicleComponent(ivehicle[playerid],1087); AddVehicleComponent(ivehicle[playerid],1086);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
return 1;}

CMD:m9(playerid, params[])
{


if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
new Float:X,Float:Y,Float:Z,Float:Angle;GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(558,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
AddVehicleComponent(ivehicle[playerid],1092); AddVehicleComponent(ivehicle[playerid],1166); AddVehicleComponent(ivehicle[playerid],1165); AddVehicleComponent(ivehicle[playerid],1090);
AddVehicleComponent(ivehicle[playerid],1094); AddVehicleComponent(ivehicle[playerid],1010); AddVehicleComponent(ivehicle[playerid],1087); AddVehicleComponent(ivehicle[playerid],1163);//SPOILER
AddVehicleComponent(ivehicle[playerid],1091); ChangeVehiclePaintjob(ivehicle[playerid],2);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
return 1;}

CMD:m10(playerid, params[])
{

if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;

new Float:X,Float:Y,Float:Z,Float:Angle;GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(557,X,Y,Z,Angle,1,1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
AddVehicleComponent(ivehicle[playerid],1010); AddVehicleComponent(ivehicle[playerid],1081);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
return 1;}

CMD:m11(playerid, params[])
{


if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;

new Float:X,Float:Y,Float:Z,Float:Angle;GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(535,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
ChangeVehiclePaintjob(ivehicle[playerid],1); AddVehicleComponent(ivehicle[playerid],1109); AddVehicleComponent(ivehicle[playerid],1115); AddVehicleComponent(ivehicle[playerid],1117); AddVehicleComponent(ivehicle[playerid],1073); AddVehicleComponent(ivehicle[playerid],1010);
AddVehicleComponent(ivehicle[playerid],1087); AddVehicleComponent(ivehicle[playerid],1114); AddVehicleComponent(ivehicle[playerid],1081); AddVehicleComponent(ivehicle[playerid],1119); AddVehicleComponent(ivehicle[playerid],1121);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
return 1;}

CMD:m12(playerid, params[])
{if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;



   new Float:X,Float:Y,Float:Z,Float:Angle; GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(562,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
AddVehicleComponent(ivehicle[playerid],1034); AddVehicleComponent(ivehicle[playerid],1038); AddVehicleComponent(ivehicle[playerid],1147);
AddVehicleComponent(ivehicle[playerid],1010); AddVehicleComponent(ivehicle[playerid],1073); ChangeVehiclePaintjob(ivehicle[playerid],0);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
return 1;}

CMD:m13(playerid, params[])
{


if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
   new Float:X,Float:Y,Float:Z,Float:Angle; GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(411,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
AddVehicleComponent(ivehicle[playerid],1010); AddVehicleComponent(ivehicle[playerid],1079); AddVehicleComponent(ivehicle[playerid],1087); ChangeVehicleColor(ivehicle[playerid],150,150);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
return 1;}

CMD:m14(playerid, params[])
{


if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;
   new Float:X,Float:Y,Float:Z,Float:Angle; GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(549,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
AddVehicleComponent(ivehicle[playerid],1010); AddVehicleComponent(ivehicle[playerid],1079); AddVehicleComponent(ivehicle[playerid],1087);
ChangeVehicleColor(ivehicle[playerid],145,148); AddVehicleComponent(ivehicle[playerid],1011);
AddVehicleComponent(ivehicle[playerid],1144); AddVehicleComponent(ivehicle[playerid],1145); AddVehicleComponent(ivehicle[playerid],1003);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
return 1;}

CMD:m15(playerid, params[])
{

if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;

   new Float:X,Float:Y,Float:Z,Float:Angle; GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(550,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
AddVehicleComponent(ivehicle[playerid],1010); AddVehicleComponent(ivehicle[playerid],1074); AddVehicleComponent(ivehicle[playerid],1087);
ChangeVehicleColor(ivehicle[playerid],33,33); AddVehicleComponent(ivehicle[playerid],1004); AddVehicleComponent(ivehicle[playerid],1003);
AddVehicleComponent(ivehicle[playerid],1144); AddVehicleComponent(ivehicle[playerid],1145); AddVehicleComponent(ivehicle[playerid],1006);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
return 1;}

CMD:m16(playerid, params[])
{
if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;


   new Float:X,Float:Y,Float:Z,Float:Angle; GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(589,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
AddVehicleComponent(ivehicle[playerid],1010); AddVehicleComponent(ivehicle[playerid],1074); AddVehicleComponent(ivehicle[playerid],1087);
ChangeVehicleColor(ivehicle[playerid],146,146); AddVehicleComponent(ivehicle[playerid],1004); AddVehicleComponent(ivehicle[playerid],1013);
AddVehicleComponent(ivehicle[playerid],1144); AddVehicleComponent(ivehicle[playerid],1145); AddVehicleComponent(ivehicle[playerid],1006);
AddVehicleComponent(ivehicle[playerid],1000);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
return 1;}

CMD:m17(playerid, params[])
{

if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;

   new Float:X,Float:Y,Float:Z,Float:Angle; GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(418,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
AddVehicleComponent(ivehicle[playerid],1010); AddVehicleComponent(ivehicle[playerid],1079); AddVehicleComponent(ivehicle[playerid],1087);
ChangeVehicleColor(ivehicle[playerid],151,151); AddVehicleComponent(ivehicle[playerid],1006); AddVehicleComponent(ivehicle[playerid],1016);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
return 1;}

CMD:m18(playerid, params[])
{
if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;


   new Float:X,Float:Y,Float:Z,Float:Angle; GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(451,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
AddVehicleComponent(ivehicle[playerid],1010); AddVehicleComponent(ivehicle[playerid],1079); AddVehicleComponent(ivehicle[playerid],1087);
ChangeVehicleColor(ivehicle[playerid],147,147);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
return 1;}

CMD:m19(playerid, params[])
{

if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return Hatamesaj(playerid, "Bir yere yolcuyken teleport olamassiniz!", "Please exit vehicle!"); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;

   new Float:X,Float:Y,Float:Z,Float:Angle; GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(545,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
AddVehicleComponent(ivehicle[playerid],1010); AddVehicleComponent(ivehicle[playerid],1079); AddVehicleComponent(ivehicle[playerid],1087);
ChangeVehicleColor(ivehicle[playerid],142,142);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
return 1;}

CMD:m20(playerid, params[])
{
if(GetPVarInt(playerid, "DenizSeviyesinde") == 1) return Hatamesaj(playerid, "Deniz seviyesinde arac olusturamassiniz.", "Car cannot created."); if(Araba[playerid] == 1)  DestroyVehicle(ivehicle[playerid]), Araba[playerid] = 0;

   new Float:X,Float:Y,Float:Z,Float:Angle; GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
DestroyVehObject(playerid);
ivehicle[playerid] = CreateVehicle(541,X,Y,Z,Angle,1,-1,-1);PutPlayerInVehicle(playerid,ivehicle[playerid],0);
AddVehicleComponent(ivehicle[playerid],1010); AddVehicleComponent(ivehicle[playerid],1079); AddVehicleComponent(ivehicle[playerid],1087);
ChangeVehicleColor(ivehicle[playerid],147,1);
SetVehicleVirtualWorld(ivehicle[playerid], GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(ivehicle[playerid], GetPlayerInterior(playerid));
Araba[playerid] = 1;
return 1;}

COMMAND:chilliad(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Mount chilliad",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -2317.5840,-1642.9221,483.7031);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -2317.5840,-1642.9221,483.7031);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:mc(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Mount chilliad",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -2317.5840,-1642.9221,483.7031);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -2317.5840,-1642.9221,483.7031);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:dag(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Chilliad",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -2317.5840,-1642.9221,483.7031);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -2317.5840,-1642.9221,483.7031);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}
COMMAND:calderon(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~CaLderoN's House",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2870.1445, -1951.8794, 11.1064);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2870.1445, -1951.8794, 11.1064);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

// OTHER Teleport Bitis

// CLUBS Teleport

COMMAND:alhambra(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Alhambra",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1829.0621,-1685.1656,13.5469);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1829.0621,-1685.1656,13.5469);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:jizzy(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Jizzy",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -2617.0486,1408.7322,7.1128);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -2617.0486,1408.7322,7.1128);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:clubsf(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Club SF",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -2555.9309,188.4394,5.8885);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -2555.9309,188.4394,5.8885);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:clublv(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Club LV",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2546.4536,1020.2606,10.8125);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2546.4536,1020.2606,10.8125);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:pigben(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Pig Pen",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2420.6660,-1227.2119,24.9557);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2420.6660,-1227.2119,24.9557);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

// CLUBS Teleport Bitis

// Polis Departmani

COMMAND:plc1(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Las Venturas Police Department",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2290.2449,2424.2966,10.8203);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2290.2449,2424.2966,10.8203);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:plc2(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~San Fierro Police Department",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -1621.0802,684.2302,7.1875);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -1621.0802,684.2302,7.1875);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:plc3(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Los Santos Police Department",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1542.2588,-1681.3508,13.5542);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1542.2588,-1681.3508,13.5542);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:polis1(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Las Venturas Police Department",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2290.2449,2424.2966,10.8203);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2290.2449,2424.2966,10.8203);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:polis2(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~San Fierro Police Department",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -1621.0802,684.2302,7.1875);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -1621.0802,684.2302,7.1875);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:polis3(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Los Santos Police Department",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1542.2588,-1681.3508,13.5542);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1542.2588,-1681.3508,13.5542);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

// Polis Departmani Teleport Bitis

// Silahci Teleport

COMMAND:gs1(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Las Venturas Ammunation",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2527.3738,2083.9102,10.6719);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2527.3738,2083.9102,10.6719);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:gs2(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Las Venturas Ammunation 2",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2147.3796,943.1715,10.6797);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2147.3796,943.1715,10.6797);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:gs3(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Los Santos Ammunation",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1350.9779,-1279.7213,13.3828);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1350.9779,-1279.7213,13.3828);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:gs4(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~San Fierro Ammunation",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -2626.1641,217.9263,4.4646);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -2626.1641,217.9263,4.4646);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

// Silahci Teleport Bitis

// Modifiyeci Teleport

COMMAND:mod1(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Los Santos Transfender 1",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2644.5220,-2004.0026,13.3828);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2644.5220,-2003.6614,13.3828);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:mod2(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Las Venturas Transfender 2",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -1917.2754,287.0215,41.0469);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1041.3721,-1042.7633,31.7374);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:mod3(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~San Fierro Transfender 1",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -2705.5503, 206.1621,4.1797);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -1917.2754,287.3539,41.0469);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:mod4(playerid, params[])
{
        SetPlayerPos(playerid, 2386.1106,1020.7910,10.8203);
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~San Fierro Transfender 2",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -2705.5503,206.5033,4.1797);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

COMMAND:mod5(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Las Venturas Transfender 1",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1041.3721,-1043.0988,31.7270);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2386.1106,1021.1322,10.8203);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

// Modifiyeci Teleport Bitis

// Drift Teleport

COMMAND:drift1(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~drift 1",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -301.6903,1526.9238,75.3594);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -301.6903,1526.9238,75.3594);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}
COMMAND:drift2(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~drift 2",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2326.6311,1389.7100,42.8203);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2326.6311,1389.7100,42.8203);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}
COMMAND:drift3(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~drift 3",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1244.9348,-2043.1870,59.8570);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1244.9348,-2043.1870,59.8570);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}
COMMAND:drift4(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~drift 4",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 2223.7615,1963.4081,31.7797);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 2223.7615,1963.4081,31.7797);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}
COMMAND:drift5(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~drift 5",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -2489.8352,-616.3492,132.5658);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -2489.8352,-616.3492,132.5658);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}
COMMAND:drift6(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~drift 6",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1146.2200,2178.7068,10.8203);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1146.2200,2178.7068,10.8203);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}
COMMAND:drift7(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~drift 7",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1886.9543,1813.2212,18.9339);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1886.9543,1813.2212,18.9339);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}
COMMAND:drift8(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~drift 8",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -766.7427,-1730.1228,96.3219);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -766.7427,-1730.1228,96.3219);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}
COMMAND:drift9(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~drift 9",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 711.8475,2581.5981,25.4994);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 711.8475,2581.5981,25.4994);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}
COMMAND:drift10(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~drift 10",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, -2418.8452,81.8775,35.0234);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, -2418.8452,81.8775,35.0234);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}

// Drift Teleport Bitis

COMMAND:skatepark(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Skate Park",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 1876.8490,-1394.8407,13.5703);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 1876.8490,-1394.8407,13.5703);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}
COMMAND:sahil(playerid, params[])
{
     GameTextForPlayer(playerid,"~w~~h~~h~~h~TELE:~n~~r~Skate Park",2500,5);
     new araba;
     araba=GetPlayerVehicleID(playerid);
     SetPlayerPos(playerid, 304.2043,-1898.9293,1.7956);
    SetPlayerVirtualWorld(playerid, 0); if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)   SetVehiclePos(araba, 304.2043,-1898.9293,1.7956);
     SetPlayerInterior(playerid, 0);
     if(GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)PutPlayerInVehicle(playerid,araba,0);
     return 1;
}
//» Üye Listesi\n» Klan Tercihleri\n» Klana Eleman Al\n» Klandan Eleman At\n» Rütbe Düzenlemesi\n» Klaný Kapat", "Seç", "Kapat");
stock GetWeaponNameExx(weaponid, weapon[], len = sizeof(weapon))
{
    switch(weaponid)
    {
        case 0: strcat(weapon, "Boþ", len);
        case 18: strcat(weapon, "Molotov Cocktail", len);
        case 44: strcat(weapon, "Night Vision Goggles", len);
        case 45:  strcat(weapon, "Thermal Goggles", len);
        default: GetWeaponName(weaponid, weapon, len);
    }
    return weapon;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if (dialogid == 7413 && response==1) komut_satinal(playerid, " ");
	if (dialogid == 7412)
	{
		if (response)
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
			PutPlayerInHouse(playerid, i);
		}
	}
	if(dialogid == HMenu)
	{
	    new hID = pInfo[playerid][CurrentHID], lString[256];
	    if(response)
	    {
	        if(listitem == 0)
	        {
	            if(HouseInfo[hID][Locked] == 0)
	            {
	                HouseInfo[hID][Locked] = 1;
	                Bilgimesaj(playerid, "Ev kilitlendi.", "House locked.");
				    format(lString, sizeof(lString),"{C3C3C3}Kapý No: {ffffa5}%i\n{C3C3C3}Ev Sahibi: {ffffa5}%s\n{C3C3C3}Ev Durumu: {ffffa5}%s", hID, HouseInfo[hID][Owner], (HouseInfo[hID][Locked] == 1) ? ("Kilitli") : ("Açýk"));
	            	UpdateDynamic3DTextLabelText(Text3D:HouseInfo[hID][Label], -1, lString);
	                format(gQuery,sizeof(gQuery),"UPDATE `"Houses_Table"` SET `Locked` = '%i' WHERE `ID` = '%i'", HouseInfo[hID][Locked], hID);
	                mysql_query(gQuery);
	            }
	            else if(HouseInfo[hID][Locked] == 1)
	            {
	                HouseInfo[hID][Locked] = 0;
                    Bilgimesaj(playerid, "Ev kilidi açýldý", "House unlocked.");
				    format(lString, sizeof(lString),"{C3C3C3}Kapý No: {ffffa5}%i\n{C3C3C3}Ev Sahibi: {ffffa5}%s\n{C3C3C3}Ev Durumu: {ffffa5}%s", hID, HouseInfo[hID][Owner], (HouseInfo[hID][Locked] == 1) ? ("Kilitli") : ("Açýk"));
	            	UpdateDynamic3DTextLabelText(Text3D:HouseInfo[hID][Label], -1, lString);
	                format(gQuery,sizeof(gQuery),"UPDATE `"Houses_Table"` SET `Locked` = '%i' WHERE `ID` = '%i'", HouseInfo[hID][Locked], hID);
	                mysql_query(gQuery);
	            }
	        }
	        if(listitem == 1)
	        {
	        ShowPlayerDialog(playerid, CInt, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}[Z]eroTR {E24234}-{FFFFFF} Ev Menü{E24234}-{FFFFFF} Ýnterior Listesi",
"Numara\tTip\tÜcret\n\
1-)\tSuper House\t3.000.000$\n\
2-)\tNormal House\t500.000$\n\
3-)\tNouse House\tN/A", // Etc.
"Seç", "Iptal");
	        }
	        if(listitem == 2)
	        {
	        ShowPlayerDialog(playerid, 7954, DIALOG_STYLE_LIST, "{FFFFFF}[Z]eroTR {E24234}-{FFFFFF} Ev Menü{E24234}-{FFFFFF} Para Kasasý",
"{E24234}» {FFFFFF}Para Koy\n{E24234}» {FFFFFF}Para Al", "Devam", "Geri");
	        }
	        if(listitem == 3)
	        {
	            new name[25];
	            format(name,25,"None");
	            HouseInfo[hID][Owner] = name;
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
		}
	}
	if (dialogid == 7954)
	{
	    if (!response) return komut_evmenu(playerid, " ");
	    if (listitem == 0)
	    {
	        ShowPlayerDialog(playerid, 7955, DIALOG_STYLE_INPUT, "{FFFFFF}[Z]eroTR {E24234}-{FFFFFF} Ev Menü{E24234}-{FFFFFF} Para Koy",
"{E24234}» {FFFFFF}Ev kasasýna ne kadar para yükleyeceksiniz?", "Devam", "Geri");
		}
	    if (listitem == 1)
	    {
	        ShowPlayerDialog(playerid, 7956, DIALOG_STYLE_INPUT, "{FFFFFF}[Z]eroTR {E24234}-{FFFFFF} Ev Menü{E24234}-{FFFFFF} Para Koy",
"{E24234}» {FFFFFF}Ev kasasýndan ne kadar para alacaksýnýz?", "Devam", "Geri");
	    }
	}
	if (dialogid == 7955)
	{
	    if (!response)
	    {
	        ShowPlayerDialog(playerid, 7954, DIALOG_STYLE_LIST, "{FFFFFF}[Z]eroTR {E24234}-{FFFFFF} Ev Menü{E24234}-{FFFFFF} Para Kasasý",
"{E24234}» {FFFFFF}Para Koy\n{E24234}» {FFFFFF}Para Al", "Devam", "Geri");
			return 1;
	    }
	    if (response)
	    {
			if (strval(inputtext) > GetPlayerMoney(playerid))
			{
			    HataMesaji(playerid, "O kadar paranýz yok");
	        ShowPlayerDialog(playerid, 7955, DIALOG_STYLE_INPUT, "{FFFFFF}[Z]eroTR {E24234}-{FFFFFF} Ev Menü{E24234}-{FFFFFF} Para Koy",
"{E24234}» {FFFFFF}Ev kasasýna ne kadar para yükleyeceksiniz?", "Devam", "Geri");
			    return 1;
			}
			if (strval(inputtext) < 1)
			{
			    HataMesaji(playerid, "Geçersiz bir miktar girdiniz.");
	        ShowPlayerDialog(playerid, 7955, DIALOG_STYLE_INPUT, "{FFFFFF}[Z]eroTR {E24234}-{FFFFFF} Ev Menü{E24234}-{FFFFFF} Para Koy",
"{E24234}» {FFFFFF}Ev kasasýna ne kadar para yükleyeceksiniz?", "Devam", "Geri");
			    return 1;
			}
			HouseInfo[pInfo[playerid][CurrentHID]][H_Cash] += strval(inputtext);
			GivePlayerMoney(playerid, -strval(inputtext));
	    }
	}
	if (dialogid == 7956)
	{
	    if (!response)
	    {
	        ShowPlayerDialog(playerid, 7954, DIALOG_STYLE_LIST, "{FFFFFF}[Z]eroTR {E24234}-{FFFFFF} Ev Menü{E24234}-{FFFFFF} Para Kasasý",
"{E24234}» {FFFFFF}Para Koy\n{E24234}» {FFFFFF}Para Al", "Devam", "Geri");
			return 1;
	    }
	    if (response)
	    {
			if (strval(inputtext) > HouseInfo[pInfo[playerid][CurrentHID]][H_Cash])
			{
			    HataMesaji(playerid, "Kasada o kadar para yok.");
		        ShowPlayerDialog(playerid, 7956, DIALOG_STYLE_INPUT, "{FFFFFF}[Z]eroTR {E24234}-{FFFFFF} Ev Menü{E24234}-{FFFFFF} Para Koy",
	"{E24234}» {FFFFFF}Ev kasasýndan ne kadar para alacaksýnýz?", "Devam", "Geri");
			    return 1;
			}
			if (strval(inputtext) < 1)
			{
			    HataMesaji(playerid, "Geçersiz bir miktar girdiniz.");
		        ShowPlayerDialog(playerid, 7956, DIALOG_STYLE_INPUT, "{FFFFFF}[Z]eroTR {E24234}-{FFFFFF} Ev Menü{E24234}-{FFFFFF} Para Koy",
	"{E24234}» {FFFFFF}Ev kasasýndan ne kadar para alacaksýnýz?", "Devam", "Geri");
			    return 1;
			}
			HouseInfo[pInfo[playerid][CurrentHID]][H_Cash] -= strval(inputtext);
			GivePlayerMoney(playerid, strval(inputtext));
	    }
	}
	if(dialogid == CInt)
	{
	    new hID = pInfo[playerid][CurrentHID];
	    if(!response)
	    {
			new string[256],lockstr[24];
			if (HouseInfo[pInfo[playerid][CurrentHID]][Locked] == 1) {format(lockstr, sizeof(lockstr), "Kilidi Aç");}
			else {format(lockstr, sizeof(lockstr), "Kilitle");}
			format(string, sizeof(string), "{E24234}»{FFFFFF} %s\n{E24234}»{FFFFFF} Ýnterior Seçimi\n{E24234}»{FFFFFF} Para Kasasý\t\t\t%d$\n{E24234}»{FFFFFF} Evimi Sat", lockstr, HouseInfo[pInfo[playerid][CurrentHID]][H_Cash]);
			ShowPlayerDialog(playerid, HMenu, DIALOG_STYLE_LIST, "{FFFFFF}[Z]eroTR {E24234}-{FFFFFF} Ev Menü", string, "Seç", "Ýptal");
		}
		if(response)
		{
			if(listitem == 0)
			{
			    if(GetPlayerMoney(playerid) < 3000000) return HataMesaji(playerid, "Bu interior'u alabilmek için {E24234}' 3.000.000$ '{FFFFFF} gerekiyor!");
			    if(HouseInfo[hID][InteriorID] == 1) return HataMesaji(playerid, "Zaten seçtiðiniz interioru kullanýyorsunuz");
			    HouseInfo[hID][InteriorID] = 1;
			    Bilgimesaj(playerid, "Evinizin interioru baþarýyla güncellendi.", "House interior changed.");
			    DestroyDynamicPickup(HouseInfo[hID][ExitPickup]);
			    SetHouseExit(playerid, hID);
	            KickFromHouse(playerid, hID);
	            GivePlayerMoney(playerid, -3000000);
			}
			if(listitem == 1)
			{
			    if(GetPlayerMoney(playerid) < 1000000) return HataMesaji(playerid, "Bu interior'u alabilmek için {E24234}' 1.000.000$ '{FFFFFF} gerekiyor!");
			    if(HouseInfo[hID][InteriorID] == 2) return HataMesaji(playerid, "Zaten seçtiðiniz interioru kullanýyorsunuz");
			    HouseInfo[hID][InteriorID] = 2;
			    Bilgimesaj(playerid, "Evinizin interioru baþarýyla güncellendi.", "House interior changed.");
			    DestroyDynamicPickup(HouseInfo[hID][ExitPickup]);
			    SetHouseExit(playerid, hID);
			    KickFromHouse(playerid, hID);
	            GivePlayerMoney(playerid, -3000000);
			}
			if(listitem == 2)
			{
			    if(GetPlayerMoney(playerid) < 500000) return HataMesaji(playerid, "Bu interior'u alabilmek için {E24234}' 500.000$ '{FFFFFF} gerekiyor!");
			    if(HouseInfo[hID][InteriorID] == 3) return HataMesaji(playerid, "Zaten seçtiðiniz interioru kullanýyorsunuz");
			    HouseInfo[hID][InteriorID] = 3;
			    Bilgimesaj(playerid, "Evinizin interioru baþarýyla güncellendi.", "House interior changed.");
			    DestroyDynamicPickup(HouseInfo[hID][ExitPickup]);
			    SetHouseExit(playerid, hID);
			    KickFromHouse(playerid, hID);
	            GivePlayerMoney(playerid, -500000);
			}
		}
	}

/*		format (string, sizeof (string), "Ev Ismi\n");
		format (string, sizeof (string), "%sEv Para Kasasý", string);
		format (string, sizeof (string), "%s\nEv Silah Kasasý", string);
		format (string, sizeof (string), "%s\nEvi Sat", string);
		ShowPlayerDialog(playerid, 2040, DIALOG_STYLE_LIST, "{FFFFFF}[Z]ero{E24234} - {FFFFFF}Ev Menü", string, "Devam", "Kapat");
*/
	if (dialogid == 2041)
	{
	    if (response)
	    {
			if (!strcmp(House[GetHouseID(playerid)][h_owner], getName(playerid)))
			{
		        format(House[GetHouseID(playerid)][h_name], 24, "%s",inputtext);
		        reloadHouse(GetHouseID(playerid));
	        }
	        else
	        {
				HataMesaji(playerid, "Bu ev artýk sana ait deðil.");
			}
		}
	}
	if (dialogid == 2042)
	{
	    if (response)
	    {
			if (listitem == 0)
			{
	            new
	                string[187]
				;
				format(string, sizeof(string), "{E24234}» {FFFFFF}Kasada ki Para: %i$\n{E24234}» {FFFFFF}Para Koy\n{E24234}» {FFFFFF}Para Al", House[GetHouseID(playerid)][h_cash]);
	            ShowPlayerDialog(playerid, 2042, DIALOG_STYLE_LIST, "{FFFFFF}[Z]ero{E24234} - {FFFFFF}Ev Menü {E24234}-{FFFFFF} Ev Para Kasasý", string, "Seç", "Geri");
			}
			if (listitem == 1)
			{
	            ShowPlayerDialog(playerid, 2044, DIALOG_STYLE_INPUT, "{FFFFFF}[Z]ero{E24234} - {FFFFFF}Ev Menü {E24234}-{FFFFFF} Ev Para Kasasý {E24234}-{FFFFFF} Para Koy", "{E24234}» {FFFFFF}Hesabýnýzdan evinizin kasasýna ne kadar para aktaracaksýnýz? (nokta girmeyin)", "Devam", "Geri");
			}
			if (listitem == 2)
			{
	            ShowPlayerDialog(playerid, 2045, DIALOG_STYLE_INPUT, "{FFFFFF}[Z]ero{E24234} - {FFFFFF}Ev Menü {E24234}-{FFFFFF} Ev Para Kasasý {E24234}-{FFFFFF} Para Al", "{E24234}» {FFFFFF}Ev kasanýzdan ne kadar para alacaksýnýz? (nokta girmeyin)", "Devam", "Geri");
			}
		}
	}
	if (dialogid == 2043)
	{
	    if (response)
	    {
			if (listitem == 0)
			{
			    SetPVarInt(playerid, "duzenlenenslot", 1);
	            ShowPlayerDialog(playerid, 2046, DIALOG_STYLE_LIST, "{FFFFFF}[Z]ero{E24234} - {FFFFFF}Ev Menü {E24234}-{FFFFFF} Ev Silah Kasasý", "{E24234}» {FFFFFF}Silahý Al\n{E24234}» {FFFFFF}Elimde ki Silahý Koy", "Seç", "Geri");
			}
			if (listitem == 1)
			{
			    SetPVarInt(playerid, "duzenlenenslot", 2);
	            ShowPlayerDialog(playerid, 2046, DIALOG_STYLE_LIST, "{FFFFFF}[Z]ero{E24234} - {FFFFFF}Ev Menü {E24234}-{FFFFFF} Ev Silah Kasasý", "{E24234}» {FFFFFF}Silahý Al\n{E24234}» {FFFFFF}Elimde ki Silahý Koy", "Seç", "Geri");
			}
			if (listitem == 2)
			{
			    SetPVarInt(playerid, "duzenlenenslot", 3);
	            ShowPlayerDialog(playerid, 2046, DIALOG_STYLE_LIST, "{FFFFFF}[Z]ero{E24234} - {FFFFFF}Ev Menü {E24234}-{FFFFFF} Ev Silah Kasasý", "{E24234}» {FFFFFF}Silahý Al\n{E24234}» {FFFFFF}Elimde ki Silahý Koy", "Seç", "Geri");
			}
		}
	}
	if (dialogid == 2046)
	{
	    if (response)
	    {
	        if (listitem == 1)
		    {
		        if (GetPVarInt(playerid, "duzenlenenslot") == 1)
		        {
		    		House[GetHouseID(playerid)][h_weapon1] = GetPlayerWeapon(playerid);
		    		House[GetHouseID(playerid)][h_ammo1] = GetPlayerAmmo(playerid);
			        SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), 0);
	 			}
		        if (GetPVarInt(playerid, "duzenlenenslot") == 2)
		        {
		    		House[GetHouseID(playerid)][h_weapon2] = GetPlayerWeapon(playerid);
		    		House[GetHouseID(playerid)][h_ammo2] = GetPlayerAmmo(playerid);
			        SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), 0);
	 			}
		        if (GetPVarInt(playerid, "duzenlenenslot") == 3)
		        {
		    		House[GetHouseID(playerid)][h_weapon3] = GetPlayerWeapon(playerid);
		    		House[GetHouseID(playerid)][h_ammo3] = GetPlayerAmmo(playerid);
			        SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), 0);
	 			}
	            new
	                string[244],
	                silah11[24],
	                silah22[24],
	                silah33[24]
				;
				GetWeaponNameExx(House[GetHouseID(playerid)][h_weapon1], silah11, sizeof(silah11));
				GetWeaponNameExx(House[GetHouseID(playerid)][h_weapon2], silah22, sizeof(silah22));
				GetWeaponNameExx(House[GetHouseID(playerid)][h_weapon3], silah33, sizeof(silah33));
				format(string, sizeof(string), "{E24234}» {FFFFFF} Slot 1\t\t[%s - %d Mermi]\n{E24234}» {FFFFFF} Slot 2\t\t[%s - %d Mermi]\n{E24234}» {FFFFFF} Slot 3\t\t[%s - %d Mermi]\n",
				silah11, House[GetHouseID(playerid)][h_ammo1], silah22, House[GetHouseID(playerid)][h_ammo2], silah33, House[GetHouseID(playerid)][h_ammo3]);
	            ShowPlayerDialog(playerid, 2043, DIALOG_STYLE_LIST, "{FFFFFF}[Z]ero{E24234} - {FFFFFF}Ev Menü {E24234}-{FFFFFF} Ev Para Kasasý", string, "Seç", "Geri");
			}
	        if (listitem == 0)
		    {
		        if (GetPVarInt(playerid, "duzenlenenslot") == 1)
		        {
			        if (House[GetHouseID(playerid)][h_ammo1] != 0)
			        {
						GivePlayerWeapon(playerid, House[GetHouseID(playerid)][h_weapon1], House[GetHouseID(playerid)][h_ammo1]);
			        }
		    		House[GetHouseID(playerid)][h_weapon1] = 0;
		    		House[GetHouseID(playerid)][h_ammo1] = 0;
	 			}
		        if (GetPVarInt(playerid, "duzenlenenslot") == 2)
		        {
			        if (House[GetHouseID(playerid)][h_ammo2] != 0)
			        {
						GivePlayerWeapon(playerid, House[GetHouseID(playerid)][h_weapon2], House[GetHouseID(playerid)][h_ammo2]);
			        }
		    		House[GetHouseID(playerid)][h_weapon2] = 0;
		    		House[GetHouseID(playerid)][h_ammo2] = 0;
	 			}
		        if (GetPVarInt(playerid, "duzenlenenslot") == 3)
		        {
			        if (House[GetHouseID(playerid)][h_ammo3] != 0)
			        {
						GivePlayerWeapon(playerid, House[GetHouseID(playerid)][h_weapon3], House[GetHouseID(playerid)][h_ammo3]);
			        }
		    		House[GetHouseID(playerid)][h_weapon3] = 0;
		    		House[GetHouseID(playerid)][h_ammo3] = 0;
	 			}
	            new
	                string[244],
	                silah11[24],
	                silah22[24],
	                silah33[24]
				;
				GetWeaponNameExx(House[GetHouseID(playerid)][h_weapon1], silah11, sizeof(silah11));
				GetWeaponNameExx(House[GetHouseID(playerid)][h_weapon2], silah22, sizeof(silah22));
				GetWeaponNameExx(House[GetHouseID(playerid)][h_weapon3], silah33, sizeof(silah33));
				format(string, sizeof(string), "{E24234}» {FFFFFF} Slot 1\t\t[%s - %d Mermi]\n{E24234}» {FFFFFF} Slot 2\t\t[%s - %d Mermi]\n{E24234}» {FFFFFF} Slot 3\t\t[%s - %d Mermi]\n",
				silah11, House[GetHouseID(playerid)][h_ammo1], silah22, House[GetHouseID(playerid)][h_ammo2], silah33, House[GetHouseID(playerid)][h_ammo3]);
	            ShowPlayerDialog(playerid, 2043, DIALOG_STYLE_LIST, "{FFFFFF}[Z]ero{E24234} - {FFFFFF}Ev Menü {E24234}-{FFFFFF} Ev Para Kasasý", string, "Seç", "Geri");
			}
		}
	}
	if (dialogid == 2040)
	{
	    if (response)
	    {
	        if (listitem == 0)
	        {
	            new
	                string[187]
				;
				format(string, sizeof(string), "{ffffff}Ev ismi: %s\nEvinizin yeni ismini girin:", House[GetHouseID(playerid)][h_name]);
	            ShowPlayerDialog(playerid, 2041, DIALOG_STYLE_INPUT, "{FFFFFF}[Z]ero{E24234} - {FFFFFF}Ev Menü {E24234}-{FFFFFF} Ev Ismi", string, "Ayarla", "Geri");
	        }
	        if (listitem == 1)
	        {
	            new
	                string[187]
				;
				format(string, sizeof(string), "{E24234}» {FFFFFF}Kasada ki Para: %i$\n{E24234}» {FFFFFF}Para Koy\n{E24234}» {FFFFFF}Para Al", House[GetHouseID(playerid)][h_cash]);
	            ShowPlayerDialog(playerid, 2042, DIALOG_STYLE_LIST, "{FFFFFF}[Z]ero{E24234} - {FFFFFF}Ev Menü {E24234}-{FFFFFF} Ev Para Kasasý", string, "Seç", "Geri");
	        }
	        if (listitem == 2)
	        {
	            new
	                string[244],
	                silah11[24],
	                silah22[24],
	                silah33[24]
				;
				GetWeaponNameExx(House[GetHouseID(playerid)][h_weapon1], silah11, sizeof(silah11));
				GetWeaponNameExx(House[GetHouseID(playerid)][h_weapon2], silah22, sizeof(silah22));
				GetWeaponNameExx(House[GetHouseID(playerid)][h_weapon3], silah33, sizeof(silah33));
				format(string, sizeof(string), "{E24234}» {FFFFFF} Slot 1\t\t[%s - %d Mermi]\n{E24234}» {FFFFFF} Slot 2\t\t[%s - %d Mermi]\n{E24234}» {FFFFFF} Slot 3\t\t[%s - %d Mermi]\n",
				silah11, House[GetHouseID(playerid)][h_ammo1], silah22, House[GetHouseID(playerid)][h_ammo2], silah33, House[GetHouseID(playerid)][h_ammo3]);
	            ShowPlayerDialog(playerid, 2043, DIALOG_STYLE_LIST, "{FFFFFF}[Z]ero{E24234} - {FFFFFF}Ev Menü {E24234}-{FFFFFF} Ev Para Kasasý", string, "Seç", "Geri");
	        }
	        if (listitem == 3)
	        {
	            new
	                string[244],
	                pricex
				;
				if (House[GetHouseID(playerid)][h_type] == 0) pricex = 50000;
				if (House[GetHouseID(playerid)][h_type] == 1) pricex = 75000;
				if (House[GetHouseID(playerid)][h_type] == 2) pricex = 125000;
				format(string, sizeof(string), "Evinizin durumuna göre size ödeyebileceðimiz miktar %d$'dýr.\nEvinizi satmak istediðinizden eminmisiniz ?", pricex);
	            ShowPlayerDialog(playerid, 2043, DIALOG_STYLE_LIST, "{FFFFFF}[Z]ero{E24234} - {FFFFFF}Ev Menü {E24234}-{FFFFFF} Ev Para Kasasý", string, "Seç", "Geri");
	        }
	    }
	}
	if (dialogid == 364)
	{
		if (response)
		{
			if(listitem == 0)
			{
				new string[512];
				format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{ffffff}Çekeceginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Deposit]);
				ShowPlayerDialog(playerid, 1240, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka - Para Çek", string, "Geri", "");
			}
			else if(listitem == 1)
			{
				new string[512];
				format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{8CE02C}» {FFFFFF}Mevcud oyun bakiyeniz: {8CE02C}%d\n{ffffff}Yatiracaginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Deposit], GetPlayerMoney(playerid));
				ShowPlayerDialog(playerid, 1241, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka - Para Yatir", string, "Geri", "");
			}
			else if(listitem == 2)
			{
				new string[512];
				format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{ffffff}Hesabina para transfer edeceginiz kisinin rumuzunu girin; (Orn: CaLderoN)", PlayerInfo[playerid][Deposit]);
				ShowPlayerDialog(playerid, 1299, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka - Para Transfer", string, "Geri", "");
			}
			else if(listitem == 3)
			{
				new string[512];
				format(string, sizeof(string), "{8CE02C}» {FFFFFF}Prim Miktarý; {8CE02C}%d\n{ffffff}Prim (Ýkramiye) bakiyenizden ne kadar çekeceksiniz?;", PlayerInfo[playerid][Ikramiye]);
				ShowPlayerDialog(playerid, 1290, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka - Ýkramiye", string, "Geri", "");
			}
		}
	}
	if (dialogid == 181)
	{
		if (response)
		{
			if (listitem==0)
			{
				ShowPlayerDialog(playerid, 180, DIALOG_STYLE_LIST, "{FFFFFF}[Z]ero - {E24234}Spawn Zone", "\
				{E24234}» {FFFFFF}Santa Maria Beach\n\
				{E24234}» {FFFFFF}Disco Zone\n\
				{E24234}» {FFFFFF}Drift Zone\n\
				{E24234}» {FFFFFF}Pimps\n\
				{E24234}» {FFFFFF}Big Hotel\n\
				{E24234}» {FFFFFF}Restourant", "Seç", "Geri");
			}
			else
			{
			    PlayerInfo[playerid][SpawnAlani] = 0;
			    Bilgimesaj(playerid, "Spawn alani tercihiniz kaldirilmistir.", "");
			}
		}
	}
	if (dialogid == 180)
	{
		if (response)
		{
			if (listitem==0)
			{
			    PlayerInfo[playerid][SpawnAlani] = 1;
			    Bilgimesaj(playerid, "Spawn alani tercihiniz {E24234}\"Santa Maria Beach\"{FFFFFF} olarak belirlenmistir.", "Spawn alani tercihiniz {E24234}\"Santa Maria Beach\"{FFFFFF} olarak belirlenmistir.");
			}
			if (listitem==1)
			{
			    PlayerInfo[playerid][SpawnAlani] = 2;
			    Bilgimesaj(playerid, "Spawn alani tercihiniz {E24234}\"Disco Zone\"{FFFFFF} olarak belirlenmistir.", "Spawn alani tercihiniz {E24234}\" Disco Zone \"{FFFFFF} olarak belirlenmistir.");
			}
			if (listitem==2)
			{
			    PlayerInfo[playerid][SpawnAlani] = 3;
			    Bilgimesaj(playerid, "Spawn alani tercihiniz {E24234}\"Drift Zone\"{FFFFFF} olarak belirlenmistir.", "Spawn alani tercihiniz {E24234}\"Drift Zone\"{FFFFFF} olarak belirlenmistir.");
			}
			if (listitem==3)
			{
			    PlayerInfo[playerid][SpawnAlani] = 4;
			    Bilgimesaj(playerid, "Spawn alani tercihiniz {E24234}\"Pimps\"{FFFFFF} olarak belirlenmistir.", "Spawn alani tercihiniz {E24234}\"Pimps\"{FFFFFF} olarak belirlenmistir.");
			}
			if (listitem==4)
			{
			    PlayerInfo[playerid][SpawnAlani] = 5;
			    Bilgimesaj(playerid, "Spawn alani tercihiniz {E24234}\"Big Hotel\"{FFFFFF} olarak belirlenmistir.", "Spawn alani tercihiniz {E24234}\"Big Hotel\"{FFFFFF} olarak belirlenmistir.");
			}
			if (listitem==5)
			{
			    PlayerInfo[playerid][SpawnAlani] = 6;
			    Bilgimesaj(playerid, "Spawn alani tercihiniz {E24234}\"Restourant\"{FFFFFF} olarak belirlenmistir.", "Spawn alani tercihiniz {E24234}\"Restourant\"{FFFFFF} olarak belirlenmistir.");
			}
		}
	}
	if (dialogid == 552)
	{
	    if (!response) return komut_sarki(playerid, " ");
	    if (listitem == 0) PlayAudioStreamForPlayer(playerid, "http://windows.showradyo.com.tr/listen.pls");
		if (listitem == 1) PlayAudioStreamForPlayer(playerid, "http://46.20.7.125/listen.pls");
		if (listitem == 2) PlayAudioStreamForPlayer(playerid, "http://185.28.3.14/fenomen/fenomenweb_aac_64_mobile/icecast.audio");
		if (listitem == 3) PlayAudioStreamForPlayer(playerid, "http://46.20.4.43:8130/listen.pls");
		if (listitem == 4) PlayAudioStreamForPlayer(playerid, "http://shoutcastdogus.cdnturk.com/listen.pls?sid=6");
		if (listitem == 5) PlayAudioStreamForPlayer(playerid, "http://provisioning.streamtheworld.com/pls/METRO_FMAAC.pls");
	}
    if(dialogid == 1111)
    {
//        new string[512];
         if(response)
          {
       // if (hataliSfreCount == 3) return KickNa(playerid);
         if (PlayerInfo[playerid][LoggedIn] == 1) return RegServ(playerid, "Zaten giris yapmissiniz!", "You already logged in!");
         if (MySQLHesapKontrol(playerid) == 0) return Kickle(playerid, "Dialog Hack");
         if (strlen(inputtext) < 1 || strlen(inputtext) > 20) return 1;
          new EscPass[38], Query[128];
          mysql_free_result();
          mysql_real_escape_string(inputtext, EscPass);
          format(Query, sizeof(Query), "SELECT * FROM `oyuncular` WHERE `kullaniciadi` = '%s' AND `sifre` = md5('%s')", oIsim(playerid), EscPass);
          mysql_query(Query); mysql_store_result(), print(Query);
           if(mysql_num_rows() > 0)
          {
               new
                    stringx[333]
               ;
               if(GetPVarInt(playerid, "Language__") == ENGLISH) format(stringx, sizeof(stringx), "{7FD6D4}<(Bilgi)>{FFFFFF} You successfuly logged in server.");
               else format(stringx, sizeof(stringx), "{7FD6D4}<(Bilgi)>{FFFFFF} Hesabiniza basariyla giris yaptiniz, bilgileriniz yuklendi.");
               SendClientMessage(playerid, -1, stringx);
               	if(GetPlayerScore(playerid) > 5000) SetPlayerScore(playerid, GetPlayerScore(playerid)+1);
             PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
               mysql_free_result();
               LoginPlayer(playerid);
//          SendClientMessage(playerid, -1, "{C3C3C3}»{FFFFFF} Hesabiniza basariyla giris yaptiniz, bilgileriniz yuklendi!");
          }
            else
        {
                   if(GetPVarInt(playerid, "sifreUyari") == 3) return Kickle(playerid, "Yanlis sifre girisi!"), 0;
                   SetPVarInt(playerid, "sifreUyari", GetPVarInt(playerid, "sifreUyari")+1);
                      new
                        sus_Seyi[512]
                    ;
                    format(sus_Seyi, sizeof(sus_Seyi), "{FFFFFF}Sunucuya hos geldiniz sayin {E24234}%s{FFFFFF},\nGirdiginiz sifre yanlis ! ( %d/3)\nAsagidaki kutucuga sifrenizi girerek oyuna devam edebilirsiniz.", oIsim(playerid), GetPVarInt(playerid, "sifreUyari"));
                    ShowPlayerDialog(playerid, 1111, DIALOG_STYLE_PASSWORD, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Giris Yap", sus_Seyi, "Giris", "");
            }//format(string,sizeof(string),"Rumuz: {4876FF}%s\nSifre: {E24234}••••••",oIsim(playerid)), ShowPlayerDialog(playerid,DIALOGID0+2,DIALOG_STYLE_PASSWORD," {FFFFFF}[Z]ero Freeroam",string,"Giris",""),mysql_free_result();
         }
          return 1;
    }
if(dialogid == tercihlerim)
{
	if(!response) return 1;
	if(listitem == 0)
	{
		if(PlayerInfo[playerid][SemiPro] == 0) return Hatamesaj(playerid, "Bu komutu kullanmaniz icin {0A7E8C}SemiPro™{FFFFFF} olmaniz gerekmektedir!", "You are'nt {ffa500}Veteran™{FFFFFF} member.");
		if(PlayerInfo[playerid][semiprotercih] == 0)
		{
			PlayerInfo[playerid][semiprotercih] = 2;
			komut_omenu(playerid, " ");
		}
	/*	if(PlayerInfo[playerid][semiprotercih] == 1)
		{
			PlayerInfo[playerid][semiprotercih] = 2;
			komut_omenu(playerid, " ");
		}
  */
		if(PlayerInfo[playerid][semiprotercih] == 2)
		{
			PlayerInfo[playerid][semiprotercih] = 0;
			komut_omenu(playerid, " ");
		}
	}
	if(listitem == 1)
	{
		if(PlayerInfo[playerid][Veteran] == 0) return Hatamesaj(playerid, "Bu komutu kullanmaniz icin {ffa500}Veteran™{FFFFFF} olmaniz gerekmektedir!", "You are'nt {ffa500}Veteran™{FFFFFF} member.");
		if(PlayerInfo[playerid][veterantercih] == 0)
		{
			PlayerInfo[playerid][veterantercih] = 2;
			komut_omenu(playerid, " ");
		}
		/*
		if(PlayerInfo[playerid][veterantercih] == 1)
		{
			PlayerInfo[playerid][veterantercih] = 2;
			komut_omenu(playerid, " ");
		}
  */
		if(PlayerInfo[playerid][veterantercih] == 2)
		{
			PlayerInfo[playerid][veterantercih] = 0;
			komut_omenu(playerid, " ");
		}
	}
	if(listitem == 2)
	{
		if(PlayerInfo[playerid][odultercih] == 0)
		{
			PlayerInfo[playerid][odultercih] = 1;
			komut_omenu(playerid, " ");
		}
		if(PlayerInfo[playerid][odultercih] == 1)
		{
			PlayerInfo[playerid][odultercih] = 2;
			komut_omenu(playerid, " ");
		}
		if(PlayerInfo[playerid][odultercih] == 2)
		{
			PlayerInfo[playerid][odultercih] = 0;
			komut_omenu(playerid, " ");
		}
	}

	if(listitem == 3)
	{
		if(PlayerInfo[playerid][otogiris] == 0)
		{
			PlayerInfo[playerid][otogiris] = 1;
			komut_omenu(playerid, " ");
		}
		else
		{
			PlayerInfo[playerid][otogiris] = 0;
			komut_omenu(playerid, " ");
		}
	}
}
if(dialogid == level1)
{
if(!response) return komut_adcmds(playerid, " ");
if(listitem == 0) return komut_reports(playerid, " "), komut_level1(playerid, " ");
if(listitem == 1) return komut_jail(playerid, " "), komut_level1(playerid, " ");
if(listitem == 2) return komut_unjail(playerid, " "), komut_level1(playerid, " ");
if(listitem == 3) return komut_freeze(playerid, " "), komut_level1(playerid, " ");
if(listitem == 4) return komut_unfreeze(playerid, " "), komut_level1(playerid, " ");
if(listitem == 5) return komut_etkyardim(playerid, " "), komut_level1(playerid, " ");
if(listitem == 6) return komut_spec(playerid, " "), komut_level1(playerid, " ");
if(listitem == 7) return komut_specoff(playerid, " "), komut_level1(playerid, " ");
if(listitem == 8) return komut_cc(playerid, " "), komut_level1(playerid, " ");
if(listitem == 9) return komut_get(playerid, " "), komut_level1(playerid, " ");
if(listitem == 10) return komut_goto(playerid, " "), komut_level1(playerid, " ");
if(listitem == 11) return komut_warn(playerid, " "), komut_level1(playerid, " ");
if(listitem == 12) return komut_explode(playerid, " "), komut_level1(playerid, " ");
}
if(dialogid == level2)
{
if(!response) return komut_adcmds(playerid, " ");
if(listitem == 0) return komut_mute(playerid, " "), komut_level2(playerid, " ");
if(listitem == 1) return komut_unmute(playerid, " "), komut_level2(playerid, " ");
if(listitem == 2) return komut_disarm(playerid, " "), komut_level2(playerid, " ");
if(listitem == 3) return komut_explode(playerid, " "), komut_level2(playerid, " ");
if(listitem == 4) return komut_kick(playerid, " "), komut_level2(playerid, " ");
if(listitem == 5) return komut_ojail(playerid, " "), komut_level2(playerid, " ");
}
if(dialogid == level3)
{
if(!response) return komut_adcmds(playerid, " ");
if(listitem == 0) return komut_ban(playerid, " "), komut_level3(playerid, " ");
if(listitem == 1) return komut_settime(playerid, " "), komut_level3(playerid, " ");
if(listitem == 2) return komut_setskin(playerid, " "), komut_level3(playerid, " ");
if(listitem == 3) return komut_setweather(playerid, " "), komut_level3(playerid, " ");
if(listitem == 4) return komut_jailed(playerid, " "), komut_level3(playerid, " ");
if(listitem == 5) return komut_frozen(playerid, " "), komut_level3(playerid, " ");
}
if(dialogid == level4)
{
if(!response) return komut_adcmds(playerid, " ");
if(listitem == 0) return komut_setinterior(playerid, " "), komut_level4(playerid, " ");
if(listitem == 1) return komut_setworld(playerid, " "), komut_level4(playerid, " ");
if(listitem == 2) return komut_god(playerid, " "), komut_level4(playerid, " ");
}
if(dialogid == level5)
{
if(!response) return komut_adcmds(playerid, " ");
if(listitem == 0) return komut_nban(playerid, " "), komut_level5(playerid, " ");
if(listitem == 1) return komut_offchat(playerid, " "), komut_level5(playerid, " ");
}
if(dialogid == level6)
{
if(!response) return komut_adcmds(playerid, " ");
if(listitem == 0) return komut_slapall(playerid, " "), komut_level6(playerid, " ");
if(listitem == 1) return komut_explodeall(playerid, " "), komut_level6(playerid, " ");
if(listitem == 2) return komut_unban(playerid, " "), komut_level6(playerid, " ");
}
if(dialogid == level7)
{
if(!response) return komut_adcmds(playerid, " ");
if(listitem == 0) return komut_sethealth(playerid, " "), komut_level7(playerid, " ");
if(listitem == 1) return komut_setarmour(playerid, " "), komut_level7(playerid, " ");
if(listitem == 2) return komut_oban(playerid, " "), komut_level7(playerid, " ");
}
if(dialogid == level8)
{
if(!response) return komut_adcmds(playerid, " ");
if(listitem == 0) return komut_aka(playerid, " "), komut_level8(playerid, " ");
if(listitem == 1) return komut_ip(playerid, " "), komut_level8(playerid, " ");
if(listitem == 2) return komut_log(playerid, " "), komut_level8(playerid, " ");
}
if(dialogid == level9)
{
if(!response) return komut_adcmds(playerid, " ");
if(listitem == 0) return komut_givefullcash(playerid, " "), komut_level9(playerid, " ");
if(listitem == 1) return komut_givefullweapon(playerid, " "), komut_level9(playerid, " ");
if(listitem == 2) return komut_setstat(playerid, " "), komut_level9(playerid, " ");
}
if(dialogid == level10)
{
if(!response) return komut_adcmds(playerid, " ");
if(listitem == 0) return komut_makeadmin(playerid, " "), komut_level10(playerid, " ");
if(listitem == 1) return komut_makeanim(playerid, " "), komut_level10(playerid, " ");
if(listitem == 2) return komut_reconnect(playerid, " "), komut_level10(playerid, " ");
if(listitem == 3) return komut_evsahiplerineparaver(playerid, " "), komut_level10(playerid, " ");
}
if(dialogid == Mycar)
{
	if(listitem == 1 && PlayerInfo[playerid][Veteran] == 0) return Hatamesaj(playerid, "Bu komutu kullanmaniz icin {ffa500}Veteran™{FFFFFF} olmaniz gerekmektedir!", "You are'nt {ffa500}Veteran™{FFFFFF} member.");
	if(listitem == 2 && PlayerInfo[playerid][Veteran] == 0) return Hatamesaj(playerid, "Bu komutu kullanmaniz icin {ffa500}Veteran™{FFFFFF} olmaniz gerekmektedir!", "You are'nt {ffa500}Veteran™{FFFFFF} member.");
	if(listitem == 7 && PlayerInfo[playerid][SemiPro] == 0 && PlayerInfo[playerid][Veteran] == 0) return Hatamesaj(playerid, "Bu komutu kullanmaniz icin {0A7E8C}SemiPro™{FFFFFF} olmaniz gerekmektedir!", "You are'nt {ffa500}Veteran™{FFFFFF} member.");
	if(listitem == 8 && PlayerInfo[playerid][SemiPro] == 0 && PlayerInfo[playerid][Veteran] == 0) return Hatamesaj(playerid, "Bu komutu kullanmaniz icin {0A7E8C}SemiPro™{FFFFFF} olmaniz gerekmektedir!", "You are'nt {ffa500}Veteran™{FFFFFF} member.");
	if(response)PVS->Int->firekey[playerid]->listitem;
	else PVS->Int->hkey[playerid]->listitem;
	switch(response)
	{
		case 0:
		{
			switch(listitem)
			{
				case 0:Bilgimesaj(playerid,"H tuþu boþ olarak ayarlandi!","H keys was set to blank!");
				case 1:Bilgimesaj(playerid,"H tuþu hiz olarak ayarlandi!","H keys was set to speed!");
				case 2:Bilgimesaj(playerid,"H tuþu ziplama olarak ayarlandi!","H keys was set to bounce!");
				case 3:Bilgimesaj(playerid,"H tuþu yon x olarak ayarlandi!","H x Set of keys you have!");
				case 4:Bilgimesaj(playerid,"H tuþu yon y olarak ayarlandi!","H y Set of keys you have!");
				case 5:Bilgimesaj(playerid,"H tuþu yon z olarak ayarlandi!","H z Set of keys you have!");
				case 6:Bilgimesaj(playerid,"H tuþu çevirme olarak ayarlandi!","H was set to flip the key!");
				case 7:Bilgimesaj(playerid,"H tuþu renk olarak ayarlandi!","H keys was set to color!");
				case 8:Bilgimesaj(playerid,"H tuþu fren olarak ayarlandi!","H keys was set to stop!");
				case 9:Bilgimesaj(playerid,"H tuþu bagaj olarak ayarlandi!","H key was set to boot!");
				case 10:Bilgimesaj(playerid,"H tuþu kaput olarak ayarlandi!","H keys was set to the hood!");
				case 11:Bilgimesaj(playerid,"H tuþu alarm olarak ayarlandi!","H keys was set as the alarm!");
				case 12:Bilgimesaj(playerid,"H tuþu far olarak ayarlandi!","As far as the H key set!");
				case 13:Bilgimesaj(playerid,"H tuþu motor olarak ayarlandi!","H keys was set as the engine!");
				case 14:Bilgimesaj(playerid,"H tuþu kilit olarak ayarlandi!","H keys was set as the carlocker!");
			}
		}
		case 1:
		{
			switch(listitem)
			{
				case 0:Bilgimesaj(playerid,"Ateþ etme tuþu boþ olarak ayarlandi!","Fire keys was set to blank!");
				case 1:Bilgimesaj(playerid,"Ateþ etme tuþu hiz olarak ayarlandi!","Fire keys was set to speed!");
				case 2:Bilgimesaj(playerid,"Ateþ etme tuþu ziplama olarak ayarlandi!","Fire keys was set to bounce!");
				case 3:Bilgimesaj(playerid,"Ateþ etme tuþu yon x olarak ayarlandi!","Fire keys x Set of keys you have!");
				case 4:Bilgimesaj(playerid,"Ateþ etme tuþu yon y olarak ayarlandi!","Fire keys y Set of keys you have!");
				case 5:Bilgimesaj(playerid,"Ateþ etme tuþu yon z olarak ayarlandi!","Fire keys z Set of keys you have!");
				case 6:Bilgimesaj(playerid,"Ateþ etme tuþu çevirme olarak ayarlandi!","Fire was set to flip the key!");
				case 7:Bilgimesaj(playerid,"Ateþ etme tuþu renk olarak ayarlandi!","Fire keys was set to color!");
				case 8:Bilgimesaj(playerid,"Ateþ etme tuþu fren olarak ayarlandi!","Fire keys was set to stop!");
				case 9:Bilgimesaj(playerid,"Ateþ etme tuþu bagaj olarak ayarlandi!","Fire key was set to boot!");
				case 10:Bilgimesaj(playerid,"Ateþ etme tuþu kaput olarak ayarlandi!","Fire keys was set to the hood!");
				case 11:Bilgimesaj(playerid,"Ateþ etme tuþu alarm olarak ayarlandi!","Fire keys was set as the alarm!");
				case 12:Bilgimesaj(playerid,"Ateþ etme tuþu far olarak ayarlandi!","As far as the Fire key set!");
				case 13:Bilgimesaj(playerid,"Ateþ etme tuþu motor olarak ayarlandi!","Fire keys was set as the engine!");
				case 14:Bilgimesaj(playerid,"Ateþ etme tuþu kilit olarak ayarlandi!","Fire keys was set as the carlocker!");
			}
		}
	}
}

if(dialogid == Animsd)
{
    if (response)
    {
		if(listitem == 0) komut_animdurdur(playerid, " ");
		if(listitem == 1) komut_ellerhavaya(playerid, " ");
		if(listitem == 2) komut_sarhos(playerid, " ");
		if(listitem == 3) komut_bomba(playerid, " ");
		if(listitem == 4) komut_ates(playerid, " ");
		if(listitem == 5) komut_gul(playerid, " ");
		if(listitem == 6) komut_dgozetle(playerid, " ");
		if(listitem == 7) komut_hirsizlik(playerid, " ");
		if(listitem == 8) komut_31(playerid, " ");
		if(listitem == 9) komut_31bitis(playerid, " ");
		if(listitem == 10) komut_yakalandin(playerid, " ");
		if(listitem == 11) komut_vururum(playerid, " ");
		if(listitem == 12) komut_vuruldum(playerid, " ");
		if(listitem == 13) komut_saplakyedim(playerid, " ");
		if(listitem == 14) komut_saplakat(playerid, " ");
		if(listitem == 15) komut_sigara(playerid, " ");
		if(listitem == 16) komut_sigara2(playerid, " ");
		if(listitem == 17) komut_elsalla(playerid, " ");
		if(listitem == 18) komut_bak(playerid, " ");
		if(listitem == 19) komut_uzan(playerid, " ");
		if(listitem == 20) komut_otur(playerid, " ");
		if(listitem == 21) komut_yemek(playerid, " ");
		if(listitem == 22) komut_kus(playerid, " ");
		if(listitem == 23) komut_ol(playerid, " ");
		if(listitem == 24) komut_anlas(playerid, " ");
		if(listitem == 25) komut_op(playerid, " ");
		if(listitem == 26) komut_emrah(playerid, " ");
		if(listitem == 27) komut_nevarlan(playerid, " ");
		if(listitem == 28) komut_ise(playerid, " ");
		if(listitem == 29) komut_dans1(playerid, " ");
		if(listitem == 30) komut_dans2(playerid, " ");
		if(listitem == 31) komut_dans3(playerid, " ");
		if(listitem == 32) komut_dans4(playerid, " ");
		if(listitem == 33) komut_sex1(playerid, " ");
		if(listitem == 34) komut_sex2(playerid, " ");
		if(listitem == 35) komut_sex3(playerid, " ");
		if(listitem == 36) komut_sex4(playerid, " ");
		if(listitem == 37) komut_sex5(playerid, " ");
		if(listitem == 38) komut_sex6(playerid, " ");
		if(listitem == 39) komut_bira(playerid, " ");
		if(listitem == 40) komut_sprunk(playerid, " ");
	}
}

if(dialogid == Language)
{
    if (response)
    {
		Bilgimesaj_(playerid, "Oyunda tercih ettiginiz dil {E24234}Türkce{FFFFFF} olarak belirlendi.");
		SetPVarInt(playerid, "Language__", TURKISH);
    }
    if (!response)
    {
		Bilgimesaj_(playerid, "Your preferred language is {E24234}English{FFFFFF}.");
		SetPVarInt(playerid, "Language__", ENGLISH);
    }
}
	if (dialogid == tercihlerim)
	{
	if(!response) return 1;
	if(listitem == 0)
	{
		if(PlayerInfo[playerid][semiprotercih] == 0)
		{
			PlayerInfo[playerid][semiprotercih] = 1;
			komut_omenu(playerid, " ");
		}
		else if(PlayerInfo[playerid][semiprotercih] == 1)
		{
			PlayerInfo[playerid][semiprotercih] = 2;
			komut_omenu(playerid, " ");
		}
		else if(PlayerInfo[playerid][semiprotercih] == 2)
		{
			PlayerInfo[playerid][semiprotercih] = 1;
			komut_omenu(playerid, " ");
		}
	}
	if(listitem == 1)
	{
		if(PlayerInfo[playerid][veterantercih] == 0)
		{
			PlayerInfo[playerid][veterantercih] = 1;
			komut_omenu(playerid, " ");
		}
		else if(PlayerInfo[playerid][veterantercih] == 1)
		{
			PlayerInfo[playerid][veterantercih] = 2;
			komut_omenu(playerid, " ");
		}
		else if(PlayerInfo[playerid][veterantercih] == 2)
		{
			PlayerInfo[playerid][veterantercih] = 1;
			komut_omenu(playerid, " ");
		}
	}
	if(listitem == 2)
	{
		if(PlayerInfo[playerid][odultercih] == 0)
		{
			PlayerInfo[playerid][odultercih] = 1;
			komut_omenu(playerid, " ");
		}
		else if(PlayerInfo[playerid][odultercih] == 1)
		{
			PlayerInfo[playerid][odultercih] = 2;
			komut_omenu(playerid, " ");
		}
		else if(PlayerInfo[playerid][odultercih] == 2)
		{
			PlayerInfo[playerid][odultercih] = 1;
			komut_omenu(playerid, " ");
		}
	}

	if(listitem == 3)
	{
		if(PlayerInfo[playerid][otogiris] == 1)
		{
			PlayerInfo[playerid][otogiris] = 0;
			komut_omenu(playerid, " ");
		}
		else if(PlayerInfo[playerid][otogiris] == 0)
		{
			PlayerInfo[playerid][otogiris] = 1;
			komut_omenu(playerid, " ");
		}
	}
	}
	if(dialogid == 620)
	{
	    if (response)
	    {
	        if (GetPlayerMoney(playerid) < 3500000)
	        {
				eksikPara(playerid, 3500000);
	        }
	        else if (GetPlayerScore(playerid) < 500)
	        {
				eksikSksor(playerid, 500);
	        }
	        else
	        {
	            if (listitem < 0 || listitem > 6) return HataMesaji(playerid, "Bu renk kaldirilmistir.");
	            new string[15];
	            GetPVarString(playerid, "X2H6G4D5", string, sizeof(string));
				CeteOlustur(playerid, string, listitem);
	        }
	    }
	}
	if(dialogid == 600 && response)	ShowPlayerDialog(playerid, 621, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK" {E24234}-{FFFFFF} Klanlar {E24234}-{FFFFFF} Çete Oluþtur {E24234}-{FFFFFF} Çete Adý", "{FFFFFF}Çetenizin ismi ne olacak ? Aþaðýda ki kutucuða girin.", "Seç", "Hayýr");
	if(dialogid == 621)
	{
	    if (response)
	    {
	        if (GetPlayerMoney(playerid) < 3500000)
	        {
				eksikPara(playerid, 3500000);
	        }
	        else if (GetPlayerScore(playerid) < 500)
	        {
				eksikSksor(playerid, 500);
	        }
	        else
	        {
				if (strlen(inputtext) < 2 || strlen(inputtext) > 15) return HataMesaji(playerid, "Geçersiz bir çete ismi girdiniz, gireceðiniz isim 2-15 karakter arasý olmalýdýr");
				ShowPlayerDialog(playerid, 620, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK" {E24234}-{FFFFFF} Klanlar {E24234}-{FFFFFF} Çete Oluþtur {E24234}-{FFFFFF} Çete Rengi", "{E24234}» {FFFFFF}Beyaz\n{E24234}»{FF8000} Turuncu\n{E24234}»{0004ff} Mavi\n{E24234}»{ffb74c} Özel Sarý\n{E24234}»{ffff00} Sarý\n{E24234}»{00ff11} Yeþil", "Seç", "Hayýr");
				SetPVarString(playerid, "X2H6G4D5", inputtext);
			}
	    }
	}
	if (dialogid == 601)
	{
		if (response)
		{
		    if (listitem == 0)
		    {
		        mysql_free_result();
		        new
		            dialogstr[1234],
		            sorgu[169],
					veri[34],
					veri2[9],
					rutbe1[24],
					rutbe2[24],
					rutbe3[24],
					rutbestring[24],
					tarihstring[24]
				;
				format(dialogstr, sizeof(dialogstr), "Üye Ýsmi\tRütbesi\tKatýlma Tarihi\n", dialogstr,veri,rutbestring);
				format(sorgu, sizeof(sorgu), "SELECT * FROM `klanlar` WHERE `id` = %d", PlayerInfo[playerid][Cete]);
				mysql_query(sorgu);
				mysql_store_result();
				while (mysql_retrieve_row())
				{
					mysql_fetch_field_row(rutbe1, "rank1s");
					mysql_fetch_field_row(rutbe2, "rank2s");
					mysql_fetch_field_row(rutbe3, "rank3s");
				}
		        mysql_free_result();
				format(sorgu, sizeof(sorgu), "SELECT * FROM `oyuncular` WHERE `ceteid` = %d", PlayerInfo[playerid][Cete]);
				mysql_query(sorgu);
				mysql_store_result();
				while (mysql_retrieve_row())
				{
					mysql_fetch_field_row(veri, "kullaniciadi");
					mysql_fetch_field_row(veri2, "ceterutbe");
					mysql_fetch_field_row(tarihstring, "cetetarih");
					if (strlen(tarihstring) < 5) format(tarihstring, sizeof(tarihstring), "01/06/1970 - 00:00");
					if(strval(veri2) == 1) format(rutbestring, sizeof(rutbestring), "%s", rutbe1);
					if(strval(veri2) == 2) format(rutbestring, sizeof(rutbestring), "%s", rutbe2);
					if(strval(veri2) == 3) format(rutbestring, sizeof(rutbestring), "%s", rutbe3);
					format(dialogstr, sizeof(dialogstr), "%s%s\t%s\t%s\n", dialogstr,veri,rutbestring, tarihstring);
				}
		        mysql_free_result();
				ShowPlayerDialog(playerid, 602, DIALOG_STYLE_TABLIST_HEADERS, "{E24234}"DIALOG_BASLIK" - Klanlar - Üye Listesi", dialogstr, "Geri", "");
		    }
		}
	}
	if (dialogid == 344)
	{
	    if (!response)return 1;
	    if (listitem == 0) komut_cmds(playerid, " ");
	    else if (listitem == 1) komut_about(playerid, " ");
	    else komut_credits(playerid, " ");
	}
	if(dialogid == 3434) SelectTextDraw(playerid, -1);
	if(dialogid == 1015)
	{
	    if(response)
	    {
	        if(strfind(inputtext, "@", true) != -1) {} else return komut_email(playerid, " "), Hatamesaj(playerid, "Girdiginiz e-posta gecersiz.", "Please write a correct e-mail.");
	        if(strfind(inputtext, ".", true) != -1) {} else return komut_email(playerid, " "), Hatamesaj(playerid, "Girdiginiz e-posta gecersiz", "Please write a correct e-mail.");
			new
			    guvenliString[34],
			    string[256]
			;
			mysql_real_escape_string(inputtext, guvenliString);
			format(string, sizeof(string), "UPDATE oyuncular SET email = '%s' WHERE kullaniciadi = '%s'", guvenliString, oIsim(playerid));
			mysql_query(string);
			format(string, sizeof(string), "E-Posta adresiniz {E24234}' %s '{FFFFFF} olarak güncellenmiþtir.", guvenliString);
			Bilgimesaj(playerid, string, string);
	    }
	}
 	CloseselectioanMenu(playerid);
	CancelSelectTextDraw(playerid);
	SetPVarInt(playerid, "vspawner_active", 0);

	new len = strlen (inputtext);
	for (new i = 0; i < len; ++i)
	 	if (inputtext [i] == '%')
	  		inputtext [i] = '#';
    if(ETK[playerid] == 1) return HataMesaji(playerid, "Etkinlikte bu islemi yapamassiniz.");
    if(DDArac[playerid] != INVALID_VEHICLE_ID) return HataMesaji(playerid, "Derby'de bu islem yapilamaz.");
	#if defined TDMPASIF
	if(dialogid == 9950)
	{
	    if(zombieKatilim == false && zombieBasladi == true) return 1;
		if(response)
		{
		    ResetPlayerWeapons(playerid);
 		    if(listitem == 0)
		    {
		        new conut, zbm;
		        foreach(new i : zombieGamer)
		        {
		            if(GetPVarInt(playerid, "Thakim") == INSAN_)
		            {
		                conut++;
		            }
		        }
		        foreach(new i : zombieGamer)
		        {
		            if(GetPVarInt(playerid, "Thakim") == ZOMBI_)
		            {
		                zbm++;
		            }
		        }
		        if(zbm > conut)
				{
					Hatamesaj(playerid, "Takým eþitliði dengesi nedeniyle bu takýmý seçemiyorsunuz. Diðer takýmý seçin.", "Team is full! Please select other team.");
					if(zombieMap == 0)
			ShowPlayerDialog(playerid, 9950, DIALOG_STYLE_LIST, "{C9404E}[Z]ero {FFFFFF}- Zombi/Ýnsanlar", "{C9404E}»{FFFFFF} Zombiler\t\t{C9404E}[AKTIF]\n{00FF66}»{FFFFFF} Ýnsanlar\t\t{00FF66}[AKTIF]\n{C9404E}»{FFFFFF} Elit Ýnsanlar\t\t{C9404E}[AKTIF]", "Tamam", "Ýptal");
		if(zombieMap == 1)
			ShowPlayerDialog(playerid, 9950, DIALOG_STYLE_LIST, "{C9404E}[Z]ero {FFFFFF}- FBI/Mafya", "{C9404E}»{FFFFFF} FBI\t\t{C9404E}[AKTIF]\n{00FF66}»{FFFFFF} Mafya\t\t{00FF66}[AKTIF]", "Tamam", "Ýptal");
	}
				zombiSpawn(playerid);
		    }
		    if(listitem == 1)
		    {
		        new conut, zbm;
		        foreach(new i : zombieGamer)
		        {
		            if(GetPVarInt(playerid, "Thakim") == INSAN_)
		            {
		                conut++;
		            }
		        }
		        foreach(new i : zombieGamer)
		        {
		            if(GetPVarInt(playerid, "Thakim") == ZOMBI_)
		            {
		                zbm++;
		            }
		        }
		        if(zbm > conut)
				{
					Hatamesaj(playerid, "Takým eþitliði dengesi nedeniyle bu takýmý seçemiyorsunuz. Diðer takýmý seçin.", "Team is full! Please select other team.");
					if(zombieMap == 0)
			ShowPlayerDialog(playerid, 9950, DIALOG_STYLE_LIST, "{C9404E}[Z]ero {FFFFFF}- Zombi/Ýnsanlar", "{C9404E}»{FFFFFF} Zombiler\t\t{C9404E}[AKTIF]\n{00FF66}»{FFFFFF} Ýnsanlar\t\t{00FF66}[AKTIF]\n{C9404E}»{FFFFFF} Elit Ýnsanlar\t\t{C9404E}[AKTIF]", "Tamam", "Ýptal");
		if(zombieMap == 1)
			ShowPlayerDialog(playerid, 9950, DIALOG_STYLE_LIST, "{C9404E}[Z]ero {FFFFFF}- FBI/Mafya", "{C9404E}»{FFFFFF} FBI\t\t{C9404E}[AKTIF]\n{00FF66}»{FFFFFF} Mafya\t\t{00FF66}[AKTIF]", "Tamam", "Ýptal");
	}
		        insanSpawn(playerid);
		    }
		    if(listitem == 2)
		    {
		        if(PlayerInfo[playerid][Veteran] != 1)
				{
Hatamesaj(playerid, "Bu takýmý yalnýza {ffa500}Veteran™{ffffff} oyuncular seçebilir.", "Team created for veteran members. Please select other team.");
					if(zombieMap == 0)
			ShowPlayerDialog(playerid, 9950, DIALOG_STYLE_LIST, "{C9404E}[Z]ero {FFFFFF}- Zombi/Ýnsanlar", "{C9404E}»{FFFFFF} Zombiler\t\t{C9404E}[AKTIF]\n{00FF66}»{FFFFFF} Ýnsanlar\t\t{00FF66}[AKTIF]\n{C9404E}»{FFFFFF} Elit Ýnsanlar\t\t{C9404E}[AKTIF]", "Tamam", "Ýptal");
		if(zombieMap == 1)
			ShowPlayerDialog(playerid, 9950, DIALOG_STYLE_LIST, "{C9404E}[Z]ero {FFFFFF}- FBI/Mafya", "{C9404E}»{FFFFFF} FBI\t\t{C9404E}[AKTIF]\n{00FF66}»{FFFFFF} Mafya\t\t{00FF66}[AKTIF]", "Tamam", "Ýptal");
	}
		        eliteSpawn(playerid);
		    }
	    }
	}
	#endif
	if(dialogid == 556)
	{
	    if(!response) return 1;
	   	new string[1938], sarkiad[25], sarkidakika[6];
		format(string, sizeof(string), "SELECT * FROM sarkilar WHERE id = %d", listitem+1);
	    mysql_query(string);
	    mysql_store_result();
		string[0] = EOS;
		while(mysql_retrieve_row())
		{
	    	mysql_fetch_field_row(sarkiad, "sarkiurl");
	    	mysql_fetch_field_row(sarkidakika, "dakika");
		}
		PlayAudioStreamForPlayer(playerid, sarkiad);
	}
	if(dialogid == 555)
	{
	    if(!response) return 1;
        if(listitem == 0) komut_aramakasdf(playerid, " ");
        if(listitem == 1) komut_sarkilistemc(playerid, " ");
        if(listitem == 2) komut_radyo(playerid, " ");
	}
	if(dialogid == 1502)
	{
	    if(!response) return ShowPlayerDialog(playerid, 1502, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Þarki","Þarkinin dakkasini kaydettim kanka, þimdi urlunu yaz. ORNEK: http://www.sarki.com/newroz.mp3", "Devam", "Iptal");
	    SetPVarString(playerid, "sarkiurl", inputtext);
		Bilgimesaj(playerid, "Sarkiniz eklendi. Detaylar;", "Þarki eklendi. Detaylar;");
		new string[280], sarkidakika[256], sarkiad[256], sarkiurl[256];
		GetPVarString(playerid, "sarkidakka", sarkidakika, sizeof(sarkidakika));
		GetPVarString(playerid, "sarkiadd", sarkiad, sizeof(sarkiad));
		GetPVarString(playerid, "sarkiurl", sarkiurl, sizeof(sarkiurl));
		format(string, sizeof(string), "Sarki Adi: {E24234}' %s '", sarkiad);
		SendClientMessage(playerid, -1, string);
		format(string, sizeof(string), "Sarki URL: {E24234}' %s '", sarkiurl);
		SendClientMessage(playerid, -1, string);
		format(string, sizeof(string), "Sarki Dakika: {E24234}' %s '", sarkidakika);
		SendClientMessage(playerid, -1, string);
 	    format(string, sizeof(string), "INSERT INTO sarkilar (sarkiadi, sarkiurl, dakika) VALUES ('%s', '%s', '%s')", sarkiad, sarkiurl, sarkidakika);
        mysql_query(string);
		format(string, sizeof(string), "{E24234}<(Bilgi)>{FFFFFF} Yetkili {E24234}%s{FFFFFF}, {E24234}%s{FFFFFF} isimli sarkiyi {E24234}/dinle{FFFFFF} ye ekledi.", oIsim(playerid), sarkiad);
		SendClientMessageToAll(-1, string);
	}
	if(dialogid == 1501)
	{
	    if(!response) return ShowPlayerDialog(playerid, 1501, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Þarki","Þarkinin adini kaydettim, þimdi kaç dakika sürdügünü yaz. ORNEK: 3:24 yada 10:25", "Devam", "Iptal");
	    SetPVarString(playerid, "sarkidakka", inputtext);
	    ShowPlayerDialog(playerid, 1502, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Þarki","Þarkinin dakkasini kaydettim kanka, þimdi urlunu yaz. ORNEK: http://www.sarki.com/newroz.mp3", "Devam", "Iptal");
	}
	if(dialogid == 1500)
	{
	    if(!response) return komut_sarkiekle(playerid, " ");
	    SetPVarString(playerid, "sarkiadd", inputtext);
	    ShowPlayerDialog(playerid, 1501, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Þarki","Þarkinin adini kaydettim, þimdi kaç dakika sürdügünü yaz. ORNEK: 3:24 yada 10:25", "Devam", "Iptal");
	}
	if(dialogid == 3334)
	{
	    if(!response) return 1;
	    listitem++;
	    new string[676], sarkiurl[145], saad[56];
	    if(listitem == 1) format(string, sizeof(string), "SELECT * FROM sarkilar WHERE id = %d", GetPVarInt(playerid, "Sarki1"));
	    if(listitem == 2) format(string, sizeof(string), "SELECT * FROM sarkilar WHERE id = %d", GetPVarInt(playerid, "Sarki2"));
	    if(listitem == 3) format(string, sizeof(string), "SELECT * FROM sarkilar WHERE id = %d", GetPVarInt(playerid, "Sarki3"));
	    if(listitem == 4) format(string, sizeof(string), "SELECT * FROM sarkilar WHERE id = %d", GetPVarInt(playerid, "Sarki4"));
	    if(listitem == 5) format(string, sizeof(string), "SELECT * FROM sarkilar WHERE id = %d", GetPVarInt(playerid, "Sarki5"));
	    if(listitem == 6) format(string, sizeof(string), "SELECT * FROM sarkilar WHERE id = %d", GetPVarInt(playerid, "Sarki6"));
	    if(listitem == 7) format(string, sizeof(string), "SELECT * FROM sarkilar WHERE id = %d", GetPVarInt(playerid, "Sarki7"));
	    if(listitem == 8) format(string, sizeof(string), "SELECT * FROM sarkilar WHERE id = %d", GetPVarInt(playerid, "Sarki8"));
	    if(listitem == 9) format(string, sizeof(string), "SELECT * FROM sarkilar WHERE id = %d", GetPVarInt(playerid, "Sarki9"));
	    if(listitem == 10) format(string, sizeof(string), "SELECT * FROM sarkilar WHERE id = %d", GetPVarInt(playerid, "Sarki10"));
	    if(listitem == 11) format(string, sizeof(string), "SELECT * FROM sarkilar WHERE id = %d", GetPVarInt(playerid, "Sarki11"));
	    if(listitem == 12) format(string, sizeof(string), "SELECT * FROM sarkilar WHERE id = %d", GetPVarInt(playerid, "Sarki12"));
	    
	    print(string);
	    mysql_query(string);
	    mysql_store_result();
	    if(!(mysql_num_rows() > 0)) return Bilgimesaj(playerid, "Secili sarkiya ait bir bilgi bulunamadi.", "Not found music url.");// ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Ticketlarim", "{FFFFFF}Sistemde adiniza kayitli bir ariza,þikayet,oneri ve benzeri bildirimi bulunmamakta.", "Tamam", "");
	    while(mysql_retrieve_row())
		{
	    	mysql_fetch_field_row(sarkiurl, "sarkiurl");
	    	mysql_fetch_field_row(saad, "sarkiadi");
		}
		PlayAudioStreamForPlayer(playerid, sarkiurl);
		format(string, sizeof(string), "Su anda {E24234}' %s '{FFFFFF} isimli sarkiyi dinliyorsunuz.", saad);
		Bilgimesaj(playerid, string, "You listening a music.");
	}
	if(dialogid == 133)
	{
	    if(response)
	    {
	        if(strlen(inputtext) < 4) return Hatamesaj(playerid, "Lütfen daha aciklayici kelimeler girin.", "Search is request 4-1000 characters.");
		    new string[676], sarkiadi[12], sarkisure[24], guvenliinputtext[256], count, sarkid[24];
			new
			    strc[2048]
			;
		    mysql_real_escape_string(inputtext, guvenliinputtext);
		    format(string, sizeof(string), "SELECT * FROM  `sarkilar` WHERE `sarkiadi` REGEXP '%s'", guvenliinputtext);
		    print(string);
		    mysql_query(string);
		    mysql_store_result();
		    if(!(mysql_num_rows() > 0)) return Bilgimesaj(playerid, "Sonuç bulunamadi", "Not found result");// ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Ticketlarim", "{FFFFFF}Sistemde adiniza kayitli bir ariza,þikayet,oneri ve benzeri bildirimi bulunmamakta.", "Tamam", "");
		    while(mysql_retrieve_row())
			{
		    	mysql_fetch_field_row(sarkid, "id");
			    if(count == 0) SetPVarInt(playerid, "Sarki1", strval(sarkid));
			    if(count == 1) SetPVarInt(playerid, "Sarki2", strval(sarkid));
			    if(count == 2) SetPVarInt(playerid, "Sarki3", strval(sarkid));
			    if(count == 3) SetPVarInt(playerid, "Sarki4", strval(sarkid));
			    if(count == 4) SetPVarInt(playerid, "Sarki5", strval(sarkid));
			    if(count == 5) SetPVarInt(playerid, "Sarki6", strval(sarkid));
			    if(count == 6) SetPVarInt(playerid, "Sarki7", strval(sarkid));
			    if(count == 7) SetPVarInt(playerid, "Sarki8", strval(sarkid));
			    if(count == 8) SetPVarInt(playerid, "Sarki9", strval(sarkid));
			    if(count == 9) SetPVarInt(playerid, "Sarki10", strval(sarkid));
			    if(count == 10) SetPVarInt(playerid, "Sarki11", strval(sarkid));
			    if(count == 11) SetPVarInt(playerid, "Sarki12", strval(sarkid));
			    count++;
		    	mysql_fetch_field_row(sarkiadi, "sarkiadi");
		    	mysql_fetch_field_row(sarkisure, "dakika");
				format(strc, sizeof(strc), "%s{FFFFFF}%s - %s\n", strc, sarkiadi, sarkisure);
			}
			ShowPlayerDialog(playerid, 3334, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Þarkilar", strc, "Dinle","Kapat");
	    }
	}
	if(dialogid == 1161)
	{
	    if(response)
	    {
	        SetPlayerScore(GetPVarInt(playerid, "Ikisivri"), strval(inputtext));
			new string[256];
			format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin skorunuzu {E24234}' %d '{FFFFFF} yapti!", oIsim(playerid), strval(inputtext));
			ADmessage(GetPVarInt(playerid, "Ikisivri"), string);
			format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in skorunu {E24234}' %d '{FFFFFF} yaptin!", oIsim(GetPVarInt(playerid, "Ikisivri")), strval(inputtext));
			ADmessage(GetPVarInt(playerid, "Ikisivri"), string);
	    }
	    else
	    {
	        komut_setstat(playerid, " ");
		}
	}
	if(dialogid == 1162)
	{
	    if(response)
	    {
			ResetPlayerMoney(playerid);
	        GivePlayerMoney(GetPVarInt(playerid, "Ikisivri"), strval(inputtext));
			new string[256];
			format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin nakit paranizi {E24234}' %d '{FFFFFF} yapti!", oIsim(playerid), strval(inputtext));
			ADmessage(GetPVarInt(playerid, "Ikisivri"), string);
			format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in nakit parasini {E24234}' %d '{FFFFFF} yaptin!", oIsim(GetPVarInt(playerid, "Ikisivri")), strval(inputtext));
			ADmessage(GetPVarInt(playerid, "Ikisivri"), string);
	    }
	    else
	    {
	        komut_setstat(playerid, " ");
		}
	}
	if(dialogid == 1163)
	{
	    if(response)
	    {
	        PlayerInfo[GetPVarInt(playerid, "Ikisivri")][Kills] = strval(inputtext);
			new string[256];
			format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin kill statinizi {E24234}' %d '{FFFFFF} yapti!", oIsim(playerid), strval(inputtext));
			ADmessage(GetPVarInt(playerid, "Ikisivri"), string);
			format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in kill statini {E24234}' %d '{FFFFFF} yaptin!", oIsim(GetPVarInt(playerid, "Ikisivri")), strval(inputtext));
			ADmessage(GetPVarInt(playerid, "Ikisivri"), string);
	    }
	    else
	    {
	        komut_setstat(playerid, " ");
		}
	}
	if(dialogid == 1164)
	{
	    if(response)
	    {
	        PlayerInfo[GetPVarInt(playerid, "Ikisivri")][Deaths] = strval(inputtext);
			new string[256];
			format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin olme statünüzü {E24234}' %d '{FFFFFF} yapti!", oIsim(playerid), strval(inputtext));
			ADmessage(GetPVarInt(playerid, "Ikisivri"), string);
			format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in olme statüsünü {E24234}' %d '{FFFFFF} yaptin!", oIsim(GetPVarInt(playerid, "Ikisivri")), strval(inputtext));
			ADmessage(GetPVarInt(playerid, "Ikisivri"), string);
	    }
	    else
	    {
	        komut_setstat(playerid, " ");
		}
	}
	if(dialogid == 1165)
	{
	    if(response)
	    {
	        PlayerInfo[GetPVarInt(playerid, "Ikisivri")][Deposit] = strval(inputtext);
			new string[256];
			format(string, sizeof(string), "Yonetici {E24234}%s{FFFFFF} sizin banka paranizi {E24234}' %d '{FFFFFF} yapti!", oIsim(playerid), strval(inputtext));
			ADmessage(GetPVarInt(playerid, "Ikisivri"), string);
			format(string, sizeof(string), "Oyuncu {E24234}%s{FFFFFF}'in banka parasini {E24234}' %d '{FFFFFF} yaptin!", oIsim(GetPVarInt(playerid, "Ikisivri")), strval(inputtext));
			ADmessage(GetPVarInt(playerid, "Ikisivri"), string);
		}
	    else
	    {
	        komut_setstat(playerid, " ");
		}
	}
	if(dialogid == 1160)
	{
	    if(response)
	    {
	        if(listitem == 0)
	        {
				ShowPlayerDialog(playerid, 1161, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK"{FFFFFF} - SetStat - Score", "Oyuncunun skorunu KAÇ yapacaksiniz?", "Ayarla", "Iptal");
	        }
	        if(listitem == 1)
	        {
				ShowPlayerDialog(playerid, 1162, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK"{FFFFFF} - SetStat - Money", "Oyuncunun parasini KAÇ yapacaksiniz?", "Ayarla", "Iptal");
	        }
	        if(listitem == 2)
	        {
				ShowPlayerDialog(playerid, 1163, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK"{FFFFFF} - SetStat - Kills", "Oyuncunun oldürmesayisini KAÇ yapacaksiniz?", "Ayarla", "Iptal");
	        }
	        if(listitem == 3)
	        {
				ShowPlayerDialog(playerid, 1164, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK"{FFFFFF} - SetStat - Deaths", "Oyuncunun olümsayisini KAÇ yapacaksiniz?", "Ayarla", "Iptal");
	        }
	        if(listitem == 4)
	        {
				ShowPlayerDialog(playerid, 1165, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK"{FFFFFF} - SetStat - Deposit", "Oyuncunun bankparasini KAÇ yapacaksiniz?", "Ayarla", "Iptal");
	        }
	    }
	}
	if(dialogid == 1159)
	{
	    if(!IsPlayerConnected(strval(inputtext))) return Hatamesaj(playerid, "Oyuncu oyunda degil.", "Player not connected."), komut_setstat(playerid, " ");
		SetPVarInt(playerid, "Ikisivri", strval(inputtext));
		ShowPlayerDialog(playerid, 1160, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK"{FFFFFF} - SetStat", "Skor\nPara\nOldürme\nOlüm\nBankaParasi", "Seç", "Iptal");
	}
	if(dialogid == 1116)
	{
	    if(response)
	    {
	        if(!strlen(inputtext)) return 1;
	        if(strlen(inputtext) < 4 || strlen(inputtext) > 75) return Hatamesaj(playerid, "Metniniz en az 4 harf, en fazla 75 harf içermelidir.", "Caption characters is 4-75.");
			new baslik[25], icerik[256];
			GetPVarString(playerid, "BBaslik", baslik, sizeof(baslik));

			mysql_real_escape_string(baslik, baslik);
			mysql_real_escape_string(inputtext, icerik);
			new string[256];
			format(string, sizeof(string), "INSERT INTO `ticketlar` (`id`, `olusturan`, `yanitlayan`, `yanit`, `yazi`, `baslik`) VALUES (NULL, '%s', 'Yok', 'Yok', '%s', '%s');", oIsim(playerid), icerik, baslik);
			mysql_query(string);
//			format(strc, sizeof(strc), "{FFFFFF}Tamamdir %s, Baþligi ayarladik.\n{FFFFFF}Þimdi ticketinin metnini gir, anlaþilir bir dil kullanarak anlatmalisin.\n{FFFFFF}Tekrar anlatiyorum; oneri,tedkik bildirgesi(þikayet),bug bildirimi ve benzeri ne olay varsa birini seçip aþagidaki kutucuga gir.", oIsim(playerid));
			//komut_ticket(playerid, " ");
	    } else {/* komut_createticket(playerid, " "); */}
	}
	if(dialogid == 1115)
	{
	    if(response)
	    {
		    new stsring[333], counst;
		    format(stsring, sizeof(stsring), "SELECT * FROM ticketlar WHERE olusturan = '%s'", oIsim(playerid));
		    mysql_query(stsring);
		    mysql_store_result();
			if(mysql_num_rows() > 0)
			{
			    counst++;
			}
			if(counst == 10) return Hatamesaj(playerid, "En fazla 10 ticket olusturabilirsiniz! Tekrar olusturabilmeniz icin en az bir tane silmelisiniz.","Your ticket folder is full! Please delete a ticket.");
	        if(!strlen(inputtext)) return 1;
	        if(strlen(inputtext) < 4 || strlen(inputtext) > 23) return Hatamesaj(playerid, "Baþliginiz en az 4 harf, en fazla 24 harf içermelidir.", "Caption characters is 4-24.");
			new strc[256];
			format(strc, sizeof(strc), "{FFFFFF}Tamamdir %s, Baþligi ayarladik.\n{FFFFFF}Þimdi ticketinin metnini gir, anlaþilir bir dil kullanarak anlatmalisin.\n{FFFFFF}Tekrar anlatiyorum; oneri,tedkik bildirgesi(þikayet),bug bildirimi ve benzeri ne olay varsa birini seçip aþagidaki kutucuga gir.", oIsim(playerid));
			ShowPlayerDialog(playerid, 1116, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Ticketlarim - Yeni Ticket", strc, "Tamam", "Geri");
			SetPVarString(playerid, "BBaslik", inputtext);
	    }
	}
	if(dialogid == 1141)
	{
		//if(!response) return komut_ticket(playerid, " ");
		//else
		//{
			new string[178];
			format(string, sizeof(string), "INSERT INTO silinenticketlar (olusturan, yanitlayan, yanit, yazi, baslik) SELECT olusturan, yanitlayan, yanit, yazi, baslik FROM ticketlar WHERE id = %d", GetPVarInt(playerid, "SilinecekID"));
			mysql_query(string);
			format(string, sizeof(string), "DELETE FROM ticketlar WHERE id = %d LIMIT 1", GetPVarInt(playerid, "SilinecekID"));
			mysql_query(string);
			Bilgimesaj(playerid, "Okuyor oldugunuz ticket silindi.", "Ticket is deleted.");
		//}
	}
	 if(dialogid == 1114)
	 {
	    if(response)
	    {
			if(listitem > 10) return 1;
			if(listitem == 0) ticketOku(playerid, PlayerInfo[playerid][ticket1]);
			if(listitem == 1) ticketOku(playerid, PlayerInfo[playerid][ticket2]);
			if(listitem == 2) ticketOku(playerid, PlayerInfo[playerid][ticket3]);
			if(listitem == 3) ticketOku(playerid, PlayerInfo[playerid][ticket4]);
			if(listitem == 4) ticketOku(playerid, PlayerInfo[playerid][ticket5]);
			if(listitem == 5) ticketOku(playerid, PlayerInfo[playerid][ticket6]);
			if(listitem == 6) ticketOku(playerid, PlayerInfo[playerid][ticket7]);
			if(listitem == 7) ticketOku(playerid, PlayerInfo[playerid][ticket8]);
			if(listitem == 8) ticketOku(playerid, PlayerInfo[playerid][ticket9]);
			if(listitem == 9) ticketOku(playerid, PlayerInfo[playerid][ticket10]);
	//		if(listitem == 10) ticketOku(playerid, listitem);
			//if(listitem == 0) ticketOku(playerid, listitem);
	    }
	 }
     if(dialogid == 94)
     {
         if(!response) return komut_cmds(playerid, " ");
         if(listitem == 0) komut_level1(playerid, " ");
         if(listitem == 1) komut_level2(playerid, " ");
         if(listitem == 2) komut_level3(playerid, " ");
         if(listitem == 3) komut_level4(playerid, " ");
         if(listitem == 4) komut_level5(playerid, " ");
         if(listitem == 5) komut_level6(playerid, " ");
         if(listitem == 6) komut_level7(playerid, " ");
         if(listitem == 7) komut_level8(playerid, " ");
         if(listitem == 8) komut_level9(playerid, " ");
         if(listitem == 9) komut_level10(playerid, " ");
     }
     if(dialogid == 93)
     {
          if(!response) return komut_cmds(playerid, " ");
          if(listitem == 0) return komut_sifredegis(playerid, " "), komut_hcmds(playerid, " ");
          if(listitem == 1) return komut_nickdegis(playerid, " "), komut_hcmds(playerid, " ");
          if(listitem == 2) return komut_hesap(playerid, " "), komut_hcmds(playerid, " ");
     }
     if(dialogid == 91)
     {
          if(!response) return komut_cmds(playerid, " ");
         if(listitem == 0) komut_pcmds(playerid, " ");
         if(listitem == 1) komut_stop(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 2) komut_re(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 3) komut_mystyle(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 4) komut_shop(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 5) komut_myweather(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 6) komut_mytime(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 7) komut_paragonder(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 8) komut_skorgonder(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 9) komut_kill(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 10) komut_goto(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 11) komut_pmkapatac(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 12) komut_telekapatac(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 13) komut_dm(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 14) komut_animasyonlar(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 15) komut_teles(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 16) komut_rapor(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 17) komut_lotto(playerid, " "), komut_pcmds(playerid, " ");
         if(listitem == 18)
   {
			#if defined RACEPASIF
		 	komut_yarisgit(playerid," ");
		 	#endif
		 	komut_pcmds(playerid, " ");
         }
		 if(listitem == 19) komut_ddgit(playerid," "), komut_pcmds(playerid, " ");
         if(listitem == 20) komut_balance(playerid," "), komut_pcmds(playerid, " ");
         if(listitem == 21) komut_tdmgit(playerid," "), komut_pcmds(playerid, " ");
         if(listitem == 22) /*komut_ticket(playerid," "), */komut_pcmds(playerid, " ");
         if(listitem == 23) komut_admins(playerid," "), komut_pcmds(playerid, " ");
         if(listitem == 24) komut_anims(playerid," "), komut_pcmds(playerid, " ");
         if(listitem == 25) komut_performans(playerid," "), komut_pcmds(playerid, " ");
         if(listitem == 26) komut_ncolors(playerid," "), komut_pcmds(playerid, " ");
         if(listitem == 27) INmessage(playerid, "Önce acik diyalogu kapatin!"),komut_pcmds(playerid, " ");
         if(listitem == 28) INmessage(playerid, "Önce acik diyalogu kapatin!"),komut_pcmds(playerid, " ");
         if(listitem == 29) INmessage(playerid, "Önce acik diyalogu kapatin!"),komut_pcmds(playerid, " ");
         if(listitem == 30) INmessage(playerid, "Önce acik diyalogu kapatin!"),komut_pcmds(playerid, " ");
         if(listitem == 31) komut_pcmds(playerid, " ");
         if(listitem == 32) komut_hizlimiti(playerid, " "), komut_pcmds(playerid, " ");
     }
     if(dialogid == 92)
     {
          if(response)
          {
               if(listitem == 0) komut_tune(playerid, " "), komut_acmds(playerid, " ");
               if(listitem == 1) komut_plaka(playerid, " "), komut_acmds(playerid, " ");
               if(listitem == 2) komut_vcolor(playerid, " "), komut_acmds(playerid, " ");
               if(listitem == 3) komut_acmds(playerid, " ");
               if(listitem == 4) komut_veh(playerid, " "), komut_acmds(playerid, " ");
               if(listitem == 6) komut_mycar(playerid, " ");
               if(listitem == 5) Bilgimesaj(playerid, "KULLANIM: /m1...20", "USE: /m1...20"), komut_acmds(playerid, " ");
          } else komut_cmds(playerid, " ");
     }

     if(dialogid == 90)
     {
         if(response)
         {
             if(listitem == 0) komut_pcmds(playerid, " ");
             if(listitem == 1) komut_hcmds(playerid, " ");
             if(listitem == 2) komut_acmds(playerid, " ");
             if(listitem == 3) komut_adcmds(playerid, " ");
         }
     }
     if(dialogid == 1235)
     {
         if(response)
          {
              if(listitem == 0)
              {
                  new string[512];
                  format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{8CE02C}» {FFFFFF}Hesap faizi: {8CE02C}%f", PlayerInfo[playerid][Deposit], PlayerInfo[playerid][faiz]);
                  ShowPlayerDialog(playerid, 1236, DIALOG_STYLE_MSGBOX, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Hesap Ayrintilari", string, "Geri", "");
              }
              if(listitem == 1)
              {
                  new string[512];
                  format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{ffffff}Çekeceginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Deposit]);
                  ShowPlayerDialog(playerid, 1240, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Çek", string, "Geri", "");
              }
              if(listitem == 2)
              {
                  new string[512];
                  format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{8CE02C}» {FFFFFF}Mevcud oyun bakiyeniz: {8CE02C}%d\n{ffffff}Yatiracaginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Deposit], GetPlayerMoney(playerid));
                  ShowPlayerDialog(playerid, 1241, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Yatir", string, "Geri", "");
              }
              if(listitem == 3)
              {
                  new string[512];
                  format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{ffffff}Hesabina para transfer edeceginiz kisinin rumuzunu girin; (Orn: [AoA]CaLderoN)", PlayerInfo[playerid][Deposit]);
                  ShowPlayerDialog(playerid, 1299, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Transfer", string, "Geri", "");
              }
          }
     }
     if(dialogid == 1299)
     {
         if(response)
         {
             SetPVarString(playerid, "gonderilecekisim", inputtext);
              new string[512];
                format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{ffffff}Oyuncu %s'in hesabina ne kadar para transfer edecekseniz asagidaki kutucuga girin;", inputtext);
               ShowPlayerDialog(playerid, 1245, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Transfer", string, "Geri", "");
         }
         else
		 {
		    komut_hesap(playerid, " ");
         }
     }
     if(dialogid == 1245)
     {
         if(!response)
         {
              komut_hesap(playerid, " ");
         }
         else
         {
             if(!strlen(inputtext) || strval(inputtext) == 0)
             {
                    new string[512];
                  format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{ffffff}Hesabina para transfer edeceginiz kisinin rumuzunu girin; (Orn: [AoA]CaLderoN)", PlayerInfo[playerid][Deposit]);
                  ShowPlayerDialog(playerid, 1245, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Transfer", string, "Geri", "");
                    return 1;
             }
             else
             {
                 if(strval(inputtext) > PlayerInfo[playerid][Deposit])
                    {
              new string[512];
                format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{FFFFFF}Yeterli bakiyeniz bulunmuyor.\n{ffffff}Oyuncu %s'in hesabina ne kadar para transfer edecekseniz asagidaki kutucuga girin;", inputtext);
               ShowPlayerDialog(playerid, 1245, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Transfer", string, "Geri", "");
                         return 1;
                    }
                 if(strval(inputtext) < 0)
                    {
              new string[512];
                format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{FFFFFF}Yeterli bakiyeniz bulunmuyor.\n{ffffff}Oyuncu %s'in hesabina ne kadar para transfer edecekseniz asagidaki kutucuga girin;", inputtext);
               ShowPlayerDialog(playerid, 1245, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Transfer", string, "Geri", "");
                         return 1;
                    }
                    new string[300], oisim[25], oyuncuOyunda, oyuncuid;
                    GetPVarString(playerid, "gonderilecekisim", oisim, sizeof(oisim));
                    foreach(new i:Player)
                    {
                        if(!strfind(oIsim(i), oisim))
                        {
                            oyuncuOyunda = 1;
                            oyuncuid = i;
                        }
                    }
                    if(oyuncuOyunda == 0)
                    {
                         format(string, sizeof(string), "{8CE02C}» {FFFFFF}Banka hesabinizdan {E24234}%d{FFFFFF} miktar parayi oyuncuya transfer ettiniz.", strval(inputtext));
                         SendClientMessage(playerid, -1, string);
                         PlayerInfo[playerid][Deposit] -= strval(inputtext);
                        komut_hesap(playerid, " ");
                        string[0] = EOS;
                        mysql_real_escape_string(oisim, oisim);
                         format(string, sizeof(string), "UPDATE oyuncular SET deposit = deposit+%d WHERE kullaniciadi = '%s'", strval(inputtext), oisim);
                         mysql_query(string);
                    }
                    else
                    {
                         format(string, sizeof(string), "{8CE02C}» {FFFFFF}Banka hesabinizdan {E24234}%d{FFFFFF} miktar parayi oyuncuya transfer ettiniz.", strval(inputtext));
                         SendClientMessage(playerid, -1, string);
                         format(string, sizeof(string), "{8CE02C}» {FFFFFF}Oyuncu %s, banka hesabiniza {E24234}%d{ffffff} miktar para transfer etti.", oIsim(playerid), strval(inputtext));
                         SendClientMessage(oyuncuid, -1, string);
                         PlayerInfo[playerid][Deposit] -= strval(inputtext);
                         PlayerInfo[oyuncuid][Deposit] += strval(inputtext);
                        komut_hesap(playerid, " ");
//                        string[0] = EOS;
					bankaKayit(playerid, oisim, "Yatýrma", strval(inputtext));
                    }
               }
         }
     }
     if(dialogid == 1241)
     {
         if(!response)
         {
              komut_hesap(playerid, " ");
         }
         else
         {
             if(!strlen(inputtext))
             {
                  new string[512];
                  format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{8CE02C}» {FFFFFF}Mevcud oyun bakiyeniz: {8CE02C}%d\n{ffffff}Yatiracaginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Deposit], GetPlayerMoney(playerid));
                    ShowPlayerDialog(playerid, 1241, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Yatir", string, "Yatir", "Geri");
                    return 1;
             }
             else
             {
                 if(strval(inputtext) < 0)
                    {
                         new string[512];
                  format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{8CE02C}» {FFFFFF}Mevcud oyun bakiyeniz: {8CE02C}%d\n{ffffff}Yatiracaginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Deposit], GetPlayerMoney(playerid));
                         ShowPlayerDialog(playerid, 1241, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Yatir", string, "Yatir", "Geri");
                         return 1;
                    }
                    if(strval(inputtext) > GetPlayerMoney(playerid))
                    {
                         new string[512];
                      format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{8CE02C}» {FFFFFF}Mevcud oyun bakiyeniz: {8CE02C}%d\n{ffffff}O kadar paraniz yok !\n{ffffff}Yatiracaginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Deposit], GetPlayerMoney(playerid));
                         ShowPlayerDialog(playerid, 1241, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Yatir", string, "Yatir", "Geri");
                         return 1;
                    }
                    if(strval(inputtext) > 1000000)
                    {
                         new string[512];
                       format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{8CE02C}» {FFFFFF}Mevcud oyun bakiyeniz: {8CE02C}%d\n{ffffff}Banka limitleri dolayisiyla tek seferde maksimum 1.000.000$ islem yapilabilir.\n{ffffff}Yatiracaginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Deposit], GetPlayerMoney(playerid));
                         ShowPlayerDialog(playerid, 1241, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Yatir", string, "Yatir", "Geri");
                         return 1;
                    }
                    new string[300];
                    GivePlayerMoney(playerid, -strval(inputtext));
                    PlayerInfo[playerid][Deposit] += strval(inputtext);
                    format(string, sizeof(string), "{8CE02C}» {FFFFFF}Banka hesabiniza {8CE02C}%d{FFFFFF} miktar para yüklediniz.\n{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d", strval(inputtext), PlayerInfo[playerid][Deposit]);
                    ShowPlayerDialog(playerid, 10001, DIALOG_STYLE_MSGBOX, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Yatirma Basarili", string, "Tamam", "Geri");
//                    SendClientMessage(playerid, -1, string);

					bankaKayit(playerid, "Banka", "Yatýrma", strval(inputtext));
              }
         }
     }
	 if(dialogid == 1290)
	 {
         if(!response)
         {
              komut_hesap(playerid, " ");
         }
         else
         {
             if(!strlen(inputtext))
             {
                  new string[512];
                  format(string, sizeof(string), "{8CE02C}» {FFFFFF}Prim; {8CE02C}%d\n{ffffff}Çekeceginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Ikramiye]);
                    ShowPlayerDialog(playerid, 1290, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Ýkramiye", string, "Çek", "Geri");
                    return 1;
             }
             else
             {
                 if(strval(inputtext) < 0)
                    {
                         new string[512];
                         format(string, sizeof(string), "{8CE02C}» {FFFFFF}Prim; {8CE02C}%d\n{ffffff}Çekeceginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Ikramiye]);
                         ShowPlayerDialog(playerid, 1290, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Ýkramiye", string, "Çek", "Geri");
                         return 1;
                    }
                    if(strval(inputtext) > PlayerInfo[playerid][Ikramiye])
                    {
                         new string[512];
                         format(string, sizeof(string), "{8CE02C}» {FFFFFF}Prim; {8CE02C}%d\n{8CE02C}» Girdiginiz miktar kadar ikramiye alacaðýnýz yok.{FFFFFF}\n{ffffff}Çekeceginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Ikramiye]);
                         ShowPlayerDialog(playerid, 1290, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Ýkramiye", string, "Çek", "Geri");
                         return 1;
                    }
                    if(strval(inputtext) > 1000000)
                    {
                         new string[512];
                         format(string, sizeof(string), "{8CE02C}» {FFFFFF}Prim; {8CE02C}%d\n{8CE02C}» {FFFFFF}Bankanin limitleri dolayisiyla tek seferde en fazla 1.000.000$ çekebilirsiniz.\n{ffffff}Çekeceginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Ikramiye]);
                         ShowPlayerDialog(playerid, 1290, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Ýkramiye", string, "Çek", "Geri");
                         return 1;
                    }
                    new string[259];
                    PlayerInfo[playerid][Ikramiye] -= strval(inputtext);
                    GivePlayerMoney(playerid, strval(inputtext));
                    format(string, sizeof(string), "{8CE02C}» {FFFFFF}Prim hesabinizdan {8CE02C}%d{FFFFFF} miktar para çektiniz.\n{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d", strval(inputtext), PlayerInfo[playerid][Ikramiye]);
                    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Ýkramiye", string, "Tamam", "Geri");
					bankaKayit(playerid, "Banka", "ÝkramiyeÇ", strval(inputtext));
              }
         }
	 }
     if(dialogid == 1240)
     {
         if(!response)
         {
              komut_hesap(playerid, " ");
         }
         else
         {
             if(!strlen(inputtext))
             {
                  new string[512];
                  format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{ffffff}Çekeceginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Deposit]);
                    ShowPlayerDialog(playerid, 1240, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Çek", string, "Çek", "Geri");
                    return 1;
             }
             else
             {
                 if(strval(inputtext) < 0)
                    {
                         new string[512];
                         format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{ffffff}Çekeceginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Deposit]);
                         ShowPlayerDialog(playerid, 1240, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Çek", string, "Çek", "Geri");
                         return 1;
                    }
                    if(strval(inputtext) > PlayerInfo[playerid][Deposit])
                    {
                         new string[512];
                         format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{8CE02C}» Hesabinizda girdiginiz miktar kadar para yok.{FFFFFF}\n{ffffff}Çekeceginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Deposit]);
                         ShowPlayerDialog(playerid, 1240, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Çek", string, "Çek", "Geri");
                         return 1;
                    }
                    if(strval(inputtext) > 1000000)
                    {
                         new string[512];
                         format(string, sizeof(string), "{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d\n{8CE02C}» {FFFFFF}Bankanin limitleri dolayisiyla tek seferde en fazla 1.000.000$ çekebilirsiniz.\n{ffffff}Çekeceginiz miktari asagidaki kutucuga giriniz;", PlayerInfo[playerid][Deposit]);
                         ShowPlayerDialog(playerid, 1240, DIALOG_STYLE_INPUT, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Çek", string, "Çek", "Geri");
                         return 1;
                    }
                    new string[259];
                    PlayerInfo[playerid][Deposit] -= strval(inputtext);
                    GivePlayerMoney(playerid, strval(inputtext));
                    format(string, sizeof(string), "{8CE02C}» {FFFFFF}Banka hesabinizdan {8CE02C}%d{FFFFFF} miktar para çektiniz.\n{8CE02C}» {FFFFFF}Hesap bakiyeniz; {8CE02C}%d", strval(inputtext), PlayerInfo[playerid][Deposit]);
					bankaKayit(playerid, "Banka", "Çekme", strval(inputtext));
                    ShowPlayerDialog(playerid, 10001, DIALOG_STYLE_MSGBOX, "{8CE02C}[Z]ero{FFFFFF} - Banka Hesabi - Para Çekme Basarili", string, "Tamam", "Geri");

              }
         }
     }
     if(dialogid == 10001) komut_hesap(playerid, " ");
     if(dialogid == 1241)
     {
         if(!response)
         {
              komut_hesap(playerid, " ");
         }
         else
         {

         }
     }
     if(dialogid == 1236)
     {
         komut_hesap(playerid, " ");
     }

 if(dialogid == 200)
        {
            if(response)
            {
                        if(listitem ==  0)//headgear
                        {
                        new listitems[] = "{E24234}»{FFFFFF} Motorsiklet Kaski\n{E24234}»{FFFFFF} Motorsiklet Kaski 2\n{E24234}»{FFFFFF} Motorsiklet Kaski 3\n{E24234}»{FFFFFF} Motorsiklet Kaski 4\n{E24234}»{FFFFFF} Motorsiklet Kaski 5\n{E24234}»{FFFFFF} Sapka 1\n{E24234}»{FFFFFF} Sapka 2\n{E24234}»{FFFFFF} Sapka 3\n{E24234}»{FFFFFF} Sapka 4\n{E24234}»{FFFFFF} Sapka 6\n{E24234}»{FFFFFF} Sapka 7\n{E24234}»{FFFFFF} Sapka 8\n{E24234}»{FFFFFF} Sapka 9\n{E24234}« Daha Fazla »";
                        ShowPlayerDialog(playerid,201,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Sapkalar 1/6:",listitems,"wear","back");
                        }
                        if(listitem ==  1)//glasses
                        {
                                new listitems[] = "{E24234}»{FFFFFF} Gözlük 1\n{E24234}»{FFFFFF} Gözlük 2\n{E24234}»{FFFFFF} Gözlük 3\n{E24234}»{FFFFFF} Gözlük 4\n{E24234}»{FFFFFF} Gözlük 5\n{E24234}»{FFFFFF} Gözlük 6\n{E24234}»{FFFFFF} Gözlük 7\n{E24234}»{FFFFFF} Gözlük 8\n{E24234}»{FFFFFF} Gözlük 9\n{E24234}»{FFFFFF} Gözlük 10";
                        ShowPlayerDialog(playerid,202,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Gözlükler 1/3:",listitems,"Giy","Çik");
                        }
                        if(listitem ==  2)//Haltuch
                        {
                        new listitems[] = "{E24234}»{FFFFFF} Pece 1\n{E24234}»{FFFFFF} Pece  2\n{E24234}»{FFFFFF} Pece  3\n{E24234}»{FFFFFF} Pece  4\n{E24234}»{FFFFFF} Pece  5\n{E24234}»{FFFFFF} Pece 6\n{E24234}»{FFFFFF} Pece  7\n{E24234}»{FFFFFF} Pece  8\n{E24234}»{FFFFFF} Pece  9\n{E24234}»{FFFFFF} Pece  10";
                        ShowPlayerDialog(playerid,205,DIALOG_STYLE_LIST,"{448844}Peceler",listitems,"Giy","Çik");
                        }
                        if(listitem ==  3)//masks
                        {
                        new listitems[] = "{E24234}»{FFFFFF} Hokey Maskesi 1\n{E24234}»{FFFFFF} Hokey Maskesi 2\n{E24234}»{FFFFFF} Hokey Maskesi 3\n{E24234}»{FFFFFF} Zoro Maskesi\n{E24234}»{FFFFFF} Kutu Maske";
                        ShowPlayerDialog(playerid,211,DIALOG_STYLE_LIST,"{448844}Maskeler",listitems,"Giy","Çik");
                        }
                        if(listitem ==  4)//remove clothes
                        {
                                new zz=0;
                                while(zz!=MAX_PLAYER_ATTACHED_OBJECTS)
                                {
                                if(IsPlayerAttachedObjectSlotUsed(playerid, zz))
                                        {
                                        RemovePlayerAttachedObject(playerid, zz);
                                        }
                                        zz++;
                                }
                        }
                }
                return 1;
        }
        if(dialogid == 201)
        {
            if(response)
            {
                        if(listitem ==  0)//MotorcrossHelmet
                        {
                SetPlayerAttachedObject(playerid, 1, 18976, 2, 0.09, 0.03, 0, 88, 75, 0);
                        }
                        if(listitem ==  1)//MotorcycleHelmet1
                        {
                            SetPlayerAttachedObject(playerid, 1, 18645, 2, 0.07, 0, 0, 88, 75, 0);
                        }
                        if(listitem ==  2)//MotorcycleHelmet2
                        {
                SetPlayerAttachedObject(playerid, 1, 18977, 2, 0.07, 0, 0, 88, 75, 0);
                        }
                        if(listitem ==  3)//MotorcycleHelmet3
                        {
                SetPlayerAttachedObject(playerid, 1, 18978, 2, 0.07, 0, 0, 88, 75, 0);
                        }
                        if(listitem ==  4)//MotorcycleHelmet4
                        {
                SetPlayerAttachedObject(playerid, 1, 18979, 2, 0.07, 0, 0, 88, 75, 0);
                        }
                        if(listitem ==  5)//HatBoater1
                        {
                SetPlayerAttachedObject(playerid, 1, 18944, 2, 0.15, 0.0, 0, 180, 0, 10);
                        }
                        if(listitem ==  6)//HatBoater2
                        {
                SetPlayerAttachedObject(playerid, 1, 18945, 2, 0.15, 0.0, 0, 180, 0, 10);
                        }
                        if(listitem ==  7)//HatBoater3
                        {
                SetPlayerAttachedObject(playerid, 1, 18946, 2, 0.15, 0.0, 0, 180, 0, 10);
                        }
                        if(listitem ==  8)//Bowler1
                        {
                SetPlayerAttachedObject(playerid, 1, 18947, 2, 0.15, 0.0, 0, 180, 0, 10);
                        }
                        if(listitem ==  9)//Bowler2
                        {
                SetPlayerAttachedObject(playerid, 1, 18948, 2, 0.15, 0.0, 0, 180, 0, 10);
                        }
                        if(listitem ==  10)//Bowler3
                        {
                SetPlayerAttachedObject(playerid, 1, 18949, 2, 0.15, 0.0, 0, 180, 0, 10);
                        }
                        if(listitem ==  11)//Bowler4
                        {
                SetPlayerAttachedObject(playerid, 1, 18950, 2, 0.15, 0.0, 0, 180, 0, 10);
                        }
                        if(listitem ==  12)//Bowler5
                        {
                SetPlayerAttachedObject(playerid, 1, 18951, 2, 0.15, 0.0, 0, 180, 0, 10);
                        }
                        if(listitem ==  13)//weiter
                        {
                        new listitems[] = "{E24234}»{FFFFFF} Bere 1\n{E24234}»{FFFFFF} Bere 2\n{E24234}»{FFFFFF} Bere 3\n{E24234}»{FFFFFF} Bere 4\n{E24234}»{FFFFFF} Bere 5\n{E24234}»{FFFFFF} Kep Arkadan 1\n{E24234}»{FFFFFF} Kep Arkadan 2\n{E24234}»{FFFFFF} Kep Arkadan 3\n{E24234}»{FFFFFF} Kep Arkadan 4\n{E24234}»{FFFFFF} Kep Arkadan 5\n{E24234}»{FFFFFF} Kep 1\n{E24234}»{FFFFFF} Kep 2\n{E24234}»{FFFFFF} Sahdan Kep\n{E24234}« Daha Fazla »";
                        ShowPlayerDialog(playerid,207,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Sapkalar 2/6:",listitems,"Giy","Çik");
                        }
                }
                else
                {
                new listitems[] = "{E24234}» {FFFFFF}Sapkalar\n{E24234}» {FFFFFF}Gözlükler\n{E24234}» {FFFFFF}Peceler\n{E24234}» {FFFFFF}Maskeler\n{E24234}» {FFFFFF}Giysileri Kaldir";
                ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Giysiler",listitems,"Giy","Çik");
                }
                return 1;
        }
        if(dialogid == 207)
        {
            if(response)
            {
                        if(listitem ==  0)//Beret 1
                        {
                SetPlayerAttachedObject(playerid, 1, 18921, 2, 0.15, -0.03, 0.01, 180, 0, 30);
                        }
                        if(listitem ==  1)//Beret 2
                        {
                            SetPlayerAttachedObject(playerid, 1, 18922, 2, 0.15, -0.03, 0.01, 180, 0, 30);
                        }
                        if(listitem ==  2)//Beret 3
                        {
                SetPlayerAttachedObject(playerid, 1, 18923, 2, 0.15, -0.03, 0.01, 180, 0, 30);
                        }
                        if(listitem ==  3)//Beret 4
                        {
                SetPlayerAttachedObject(playerid, 1, 18924, 2, 0.15, -0.03, 0.01, 180, 0, 30);
                        }
                        if(listitem ==  4)//Beret 5
                        {
                SetPlayerAttachedObject(playerid, 1, 18925, 2, 0.15, -0.03, 0.01, 180, 0, 30);
                        }
                        if(listitem ==  5)//CapBack1
                        {
                SetPlayerAttachedObject(playerid, 1, 18939, 2, 0.17, -0.03, 0.01, 180, 0, 30);
                        }
                        if(listitem ==  6)//CapBack2
                        {
                SetPlayerAttachedObject(playerid, 1, 18940, 2, 0.17, -0.03, 0.01, 180, 0, 30);
                        }
                        if(listitem ==  7)//CapBack3
                        {
                SetPlayerAttachedObject(playerid, 1, 18941, 2, 0.17, -0.03, 0.01, 180, 0, 30);
                        }
                        if(listitem ==  8)//CapBack4
                        {
                SetPlayerAttachedObject(playerid, 1, 18942, 2, 0.17, -0.03, 0.01, 180, 0, 30);
                        }
                        if(listitem ==  9)//CapBack5
                        {
                SetPlayerAttachedObject(playerid, 1, 18943, 2, 0.17, -0.03, 0.01, 180, 0, 30);
                        }
                        if(listitem ==  10)//CapKnit 1
                        {
                SetPlayerAttachedObject(playerid, 1, 18953, 2, 0.13, -0.03, 0.00, 180, 0, 30);
                        }
                        if(listitem ==  11)//CapKnit 2
                        {
                SetPlayerAttachedObject(playerid, 1, 18954, 2, 0.13, -0.03, 0.00, 180, 0, 30);
                        }
                        if(listitem ==  12)//CapRimUp
                        {
                SetPlayerAttachedObject(playerid, 1, 18960, 2, 0.13, 0, 0, 88, 75, 0);
                        }
                        if(listitem ==  13)//weiter
                        {
                        new listitems[] = "{E24234}»{FFFFFF} Tirci Sapkasi 1\n{E24234}»{FFFFFF} Covboy Sapkasi1\n{E24234}»{FFFFFF} Skully Sapka 1\n{E24234}»{FFFFFF} Skully Sapka 2\n{E24234}»{FFFFFF} Skully Sapka 3\n{E24234}»{FFFFFF} Adam Sapkasi 1\n{E24234}»{FFFFFF} Adam Sapkasi 2\n{E24234}»{FFFFFF} Adam Sapkasi 3\n{E24234}»{FFFFFF} Kaplan Sapkasi\n{E24234}»{FFFFFF} Cool Sapka 1\n{E24234}»{FFFFFF}Cool Sapka 2\n{E24234}»{FFFFFF}Cool Sapka 3\n{E24234}\n« Daha Fazla »";
                        ShowPlayerDialog(playerid,208,DIALOG_STYLE_LIST,"{448844}Giysiler 3/6:",listitems,"Giy","Çik");
                        }
                }
                else
                {
               new listitems[] = "{E24234}» {FFFFFF}Sapkalar\n{E24234}» {FFFFFF}Gözlükler\n{E24234}» {FFFFFF}Peceler\n{E24234}» {FFFFFF}Maskeler\n{E24234}» {FFFFFF}Giysileri Kaldir";
               ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Giysiler",listitems,"Giy","Çik");
                }
                return 1;
        }
        if(dialogid == 208)
        {
            if(response)
            {
                        if(listitem ==  0)//CapTrucker1
                        {
                SetPlayerAttachedObject(playerid, 1, 18961, 2, 0.14, 0, 0, 88, 75, 0);
                        }
                        if(listitem ==  1)//CowboyHat1
                        {
                SetPlayerAttachedObject(playerid, 1, 18962, 2, 0.14, 0, 0, 88, 75, 0);
                        }
                        if(listitem ==  2)//SkullyCap1
                        {
                SetPlayerAttachedObject(playerid, 1, 18964, 2, 0.125, 0.015, 0, 90, 100, 0);
                        }
                        if(listitem ==  3)//SkullyCap2
                        {
                SetPlayerAttachedObject(playerid, 1, 18965, 2, 0.125, 0.015, 0, 90, 100, 0);
                        }
                        if(listitem ==  4)//SkullyCap3
                        {
                SetPlayerAttachedObject(playerid, 1, 18966, 2, 0.125, 0.015, 0, 90, 100, 0);
                        }
                        if(listitem ==  5)//HatMan1
                        {
                SetPlayerAttachedObject(playerid, 1, 18967, 2, 0.125, 0.015, 0, 90, 80, 0);
                        }
                        if(listitem ==  6)//HatMan2
                        {
                SetPlayerAttachedObject(playerid, 1, 18968, 2, 0.125, 0.015, 0, 90, 80, 0);
                        }
                        if(listitem ==  7)//HatMan2
                        {
                SetPlayerAttachedObject(playerid, 1, 18969, 2, 0.125, 0.015, 0, 90, 80, 0);
                        }
                        if(listitem ==  8)//HatTiger
                        {
                SetPlayerAttachedObject(playerid, 1, 18970, 2, 0.125, 0.015, 0, 90, 80, 0);
                        }
                        if(listitem ==  9)//HatCool1
                        {
                SetPlayerAttachedObject(playerid, 1, 18971, 2, 0.125, 0.015, 0, 90, 80, 0);
                        }
                        if(listitem ==  10)//HatCool2
                        {
                SetPlayerAttachedObject(playerid, 1, 18972, 2, 0.125, 0.015, 0, 90, 80, 0);
                        }
                        if(listitem ==  11)//HatCool3
                        {
                SetPlayerAttachedObject(playerid, 1, 18973, 2, 0.125, 0.015, 0, 90, 80, 0);
                        }
                        if(listitem ==  12)//weiter
                        {
                        new listitems[] = "{FFFFFF}39 {E24234}Sapka 1\n{FFFFFF}40 {E24234}Sapka 2\n{FFFFFF}41 {E24234}Sapka 3\n{FFFFFF}42 {E24234}Sapka 4\n{FFFFFF}43 {E24234}Sapka 5\n{FFFFFF}44 {E24234}Kask 1\n{FFFFFF}45 {E24234}Kask 2\n{FFFFFF}46 {E24234}Kask 3\n{FFFFFF}47 {E24234}Kep 1\n{FFFFFF}48 {E24234}Kep 2\n{FFFFFF}49 {E24234}Kep 3\n{FFFFFF}50 {E24234}Kep 4\n{FFFFFF}51 {E24234}Kep 5\n{E24234}« Daha Fazla »";
                        ShowPlayerDialog(playerid,209,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Sapkalar 4/6:",listitems,"Giy","Çik");
                        }
                }
                else
                {
                new listitems[] = "{E24234}» {FFFFFF}Sapkalar\n{E24234}» {FFFFFF}Gözlükler\n{E24234}» {FFFFFF}Peceler\n{E24234}» {FFFFFF}Maskeler\n{E24234}» {FFFFFF}Giysileri Kaldir";
                ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Giysiler",listitems,"Giy","Çik");
                }
                return 1;
        }
        if(dialogid == 209)
        {
            if(response)
            {
                        if(listitem ==  0)//CapOverEye1
                        {
                SetPlayerAttachedObject(playerid, 1, 18955, 2, 0.11, 0.02, 0, 88, 75, 0);
                        }
                        if(listitem ==  1)//CapOverEye2
                        {
                SetPlayerAttachedObject(playerid, 1, 18956, 2, 0.11, 0.02, 0, 88, 75, 0);
                        }
                        if(listitem ==  2)//CapOverEye3
                        {
                SetPlayerAttachedObject(playerid, 1, 18957, 2, 0.11, 0.02, 0, 88, 75, 0);
                        }
                        if(listitem ==  3)//CapOverEye4
                        {
                SetPlayerAttachedObject(playerid, 1, 18958, 2, 0.11, 0.02, 0, 88, 75, 0);
                        }
                        if(listitem ==  4)//CapOverEye5
                        {
                SetPlayerAttachedObject(playerid, 1, 18959, 2, 0.11, 0.02, 0, 88, 75, 0);
                        }
                        if(listitem ==  5)//Helmet1
                        {
                SetPlayerAttachedObject(playerid, 1, 18936, 2, 0.105, 0.02, 0, 0, 0, 0);
                        }
                        if(listitem ==  6)//Helmet2
                        {
                SetPlayerAttachedObject(playerid, 1, 18937, 2, 0.105, 0.02, 0, 0, 0, 0);
                        }
                        if(listitem ==  7)//Helmet3
                        {
                SetPlayerAttachedObject(playerid, 1, 18938, 2, 0.105, 0.02, 0, 0, 0, 0);
                        }
                        if(listitem ==  8)//Cap1
                        {
                SetPlayerAttachedObject(playerid, 1, 18926, 2, 0.17, 0, -0.01, 0, 0, 0);
                        }
                        if(listitem ==  9)//Cap2
                        {
                SetPlayerAttachedObject(playerid, 1, 18927, 2, 0.17, 0, -0.01, 0, 0, 0);
                        }
                        if(listitem ==  10)//Cap3
                        {
                SetPlayerAttachedObject(playerid, 1, 18928, 2, 0.17, 0, -0.01, 0, 0, 0);
                        }
                        if(listitem ==  11)//Cap4
                        {
                SetPlayerAttachedObject(playerid, 1, 18929, 2, 0.17, 0, -0.01, 0, 0, 0);
                        }
                        if(listitem ==  12)//Cap5
                        {
                SetPlayerAttachedObject(playerid, 1, 18930, 2, 0.17, 0, -0.01, 0, 0, 0);
                        }
                        if(listitem == 13)//weiter
                        {
                        new listitems[] = "{FFFFFF}52 {E24234}Kep 6\n{FFFFFF}53 {E24234}Kep 7\n{FFFFFF}54 {E24234}Kep 8\n{FFFFFF}55 {E24234}Kep 9\n{FFFFFF}56 {E24234}Kep 10\n{FFFFFF}57 {E24234}Basortusu 1\n{FFFFFF}58 {E24234}Basortusu 2\n{FFFFFF}59 {E24234}Kopftuch3\n{FFFFFF}60 {E24234}Basortusu 4\n{FFFFFF}61 {E24234}Basortusu 5\n{FFFFFF}62 {E24234}Basortusu 6\n{FFFFFF}63 {E24234}Basortusu 7\n{FFFFFF}64 {E24234}Basortusu 8\n{E24234}« Daha Fazla »";
                        ShowPlayerDialog(playerid,210,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Sapkalar 5/6:",listitems,"Giy","Çik");
                        }
                }
                else
                {
                new listitems[] = "{E24234}» {FFFFFF}Sapkalar\n{E24234}» {FFFFFF}Gözlükler\n{E24234}» {FFFFFF}Peceler\n{E24234}» {FFFFFF}Maskeler\n{E24234}» {FFFFFF}Giysileri Kaldir";
                ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Giysiler",listitems,"Giy","Çik");
                }
                return 1;
        }
        if(dialogid == 210)
        {
            if(response)
            {
                        if(listitem ==  0)//Cap6
                        {
                SetPlayerAttachedObject(playerid, 1, 18931, 2, 0.17, 0, -0.01, 0, 0, 0);
                        }
                        if(listitem ==  1)//Cap7
                        {
                SetPlayerAttachedObject(playerid, 1, 18932, 2, 0.17, 0, -0.01, 0, 0, 0);
                        }
                        if(listitem ==  2)//Cap8
                        {
                SetPlayerAttachedObject(playerid, 1, 18933, 2, 0.17, 0, -0.01, 0, 0, 0);
                        }
                        if(listitem ==  3)//Cap9
                        {
                SetPlayerAttachedObject(playerid, 1, 18934, 2, 0.17, 0, -0.01, 0, 0, 0);
                        }
                        if(listitem ==  4)//Cap10
                        {
                SetPlayerAttachedObject(playerid, 1, 18935, 2, 0.17, 0, -0.01, 0, 0, 0);
                        }
                        if(listitem ==  5)//Kopftuch1
                        {
                SetPlayerAttachedObject(playerid, 1, 18891, 2, 0.15, -0.013, 0.001, 90, -30, -90);
                        }
                        if(listitem ==  6)//Kopftuch2
                        {
                SetPlayerAttachedObject(playerid, 1, 18892, 2, 0.15, -0.013, 0.001, 90, -30, -90);
                        }
                        if(listitem ==  7)//Kopftuch3
                        {
                SetPlayerAttachedObject(playerid, 1, 18893, 2, 0.15, -0.013, 0.001, 90, -30, -90);
                        }
                        if(listitem ==  8)//Kopftuch4
                        {
                SetPlayerAttachedObject(playerid, 1, 18894, 2, 0.15, -0.013, 0.001, 90, -30, -90);
                        }
                        if(listitem ==  9)//Kopftuch5
                        {
                SetPlayerAttachedObject(playerid, 1, 18895, 2, 0.15, -0.013, 0.001, 90, -30, -90);
                        }
                        if(listitem ==  10)//Kopftuch6
                        {
                SetPlayerAttachedObject(playerid, 1, 18896, 2, 0.15, -0.013, 0.001, 90, -30, -90);
                        }
                        if(listitem ==  11)//Kopftuch7
                        {
                SetPlayerAttachedObject(playerid, 1, 18897, 2, 0.15, -0.013, 0.001, 90, -30, -90);
                        }
                        if(listitem ==  12)//Kopftuch8
                        {
                SetPlayerAttachedObject(playerid, 1, 18898, 2, 0.15, -0.013, 0.001, 90, -30, -90);
                        }
                        if(listitem ==  13)//weiter
                        {
                        new listitems[] = "{FFFFFF}65 {E24234}Basortusu 9\n{FFFFFF}66 {E24234}Basortusu 10\n{FFFFFF}67 {E24234}Basortusu 11\n{FFFFFF}68 {E24234}Basortusu 12\n{FFFFFF}69 {E24234}Basortusu 13\n{FFFFFF}70 {E24234}Basortusu 14\n{FFFFFF}71 {E24234}Basortusu 15\n{FFFFFF}72 {E24234}Basortusu 16\n{FFFFFF}73 {E24234}Basortusu 17\n{FFFFFF}74 {E24234}Basortusu 18\n{FFFFFF}75 {E24234}Basortusu 19\n{FFFFFF}76 {E24234}Basortusu 20\n";
                        ShowPlayerDialog(playerid,212,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Sapkalar 6/6:",listitems,"Giy","Çik");
                        }
                }
                else
                {
                new listitems[] = "{E24234}» {FFFFFF}Sapkalar\n{E24234}» {FFFFFF}Gözlükler\n{E24234}» {FFFFFF}Peceler\n{E24234}» {FFFFFF}Maskeler\n{E24234}» {FFFFFF}Giysileri Kaldir";
                ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Giysiler",listitems,"Giy","Çik");
                }
                return 1;
        }
        if(dialogid == 212)
        {
            if(response)
            {
                        if(listitem ==  0)//Kopftuch9
                        {
                SetPlayerAttachedObject(playerid, 1, 18899, 2, 0.15, -0.013, 0.001, 90, -30, -90);
                        }
                        if(listitem ==  1)//Kopftuch10
                        {
                SetPlayerAttachedObject(playerid, 1, 18900, 2, 0.15, -0.013, 0.001, 90, -30, -90);
                        }
                        if(listitem ==  2)//Kopftuch11
                        {
                SetPlayerAttachedObject(playerid, 1, 18901, 2, 0.15, -0.013, 0.001, 90, -30, -90);
                        }
                        if(listitem ==  3)//Kopftuch12
                        {
                SetPlayerAttachedObject(playerid, 1, 18902, 2, 0.15, -0.013, 0.001, 90, -30, -90);
                        }
                        if(listitem ==  4)//Kopftuch13
                        {
                SetPlayerAttachedObject(playerid, 1, 18903, 2, 0.15, -0.013, 0.001, 90, -30, -90);
                        }
                        if(listitem ==  5)//Kopftuch14
                        {
                SetPlayerAttachedObject(playerid, 1, 18904, 2, 0.15, -0.013, 0.001, 90, -30, -90);
                        }
                        if(listitem ==  6)//Kopftuch15
                        {
                SetPlayerAttachedObject(playerid, 1, 18905, 2, 0.15, -0.013, 0.001, 90, -30, -90);
                        }
                        if(listitem ==  7)//Kopftuch16
                        {
                SetPlayerAttachedObject(playerid, 1, 18906, 2, 0.12, -0.02, 0.001, 90, -60, -90);
                        }
                        if(listitem ==  8)//Kopftuch17
                        {
                SetPlayerAttachedObject(playerid, 1, 18907, 2, 0.12, -0.02, 0.001, 90, -60, -90);
                        }
                        if(listitem ==  9)//Kopftuch18
                        {
                SetPlayerAttachedObject(playerid, 1, 18908, 2, 0.12, -0.02, 0.001, 90, -60, -90);
                        }
                        if(listitem ==  10)//Kopftuch19
                        {
                SetPlayerAttachedObject(playerid, 1, 18909, 2, 0.12, -0.02, 0.001, 90, -60, -90);
                        }
                        if(listitem ==  11)//Kopftuch20
                        {
                SetPlayerAttachedObject(playerid, 1, 18910, 2, 0.12, -0.02, 0.001, 90, -60, -90);
                        }
                }
                else
                {

                }
                return 1;
        }
        if(dialogid == 202)
        {
            if(response)
            {
                        if(listitem ==  0)//GlassesType1
                        {
                SetPlayerAttachedObject(playerid, 2, 19006, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  1)//GlassesType2
                        {
                SetPlayerAttachedObject(playerid, 2, 19007, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  2)//GlassesType3
                        {
                SetPlayerAttachedObject(playerid, 2, 19008, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  3)//GlassesType4
                        {
                SetPlayerAttachedObject(playerid, 2, 19009, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  4)//GlassesType5
                        {
                SetPlayerAttachedObject(playerid, 2, 19010, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  5)//GlassesType6
                        {
                SetPlayerAttachedObject(playerid, 2, 19011, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  6)//GlassesType7
                        {
                SetPlayerAttachedObject(playerid, 2, 19012, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  7)//GlassesType8
                        {
                SetPlayerAttachedObject(playerid, 2, 19013, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  8)//GlassesType9
                        {
                SetPlayerAttachedObject(playerid, 2, 19014, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  9)//GlassesType10
                        {
                SetPlayerAttachedObject(playerid, 2, 19015, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem == 10)//weiter
                        {
                                new listitems[] = "{E24234}»{FFFFFF} Gözlük 11\n{E24234}»{FFFFFF} Gözlük 12\n{E24234}»{FFFFFF} Gözlük 13\n{E24234}»{FFFFFF} Gözlük 14\n{E24234}»{FFFFFF} Gözlük 15\n{E24234}»{FFFFFF} Gözlük 16\n{E24234}»{FFFFFF} Gözlük 17\n{E24234}»{FFFFFF} Gözlük 18\n{E24234}»{FFFFFF} Gözlük 19\n{E24234}»{FFFFFF} Gözlük 20\n{E24234}« Daha Fazla »";
                        ShowPlayerDialog(playerid,203,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Gözlükler 2/3:",listitems,"wear","back");
                        }
                }
                else
                {
                new listitems[] = "{E24234}» {FFFFFF}Sapkalar\n{E24234}» {FFFFFF}Gözlükler\n{E24234}» {FFFFFF}Peceler\n{E24234}» {FFFFFF}Maskeler\n{E24234}» {FFFFFF}Giysileri Kaldir";
                ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Giysiler",listitems,"Giy","Çik");
                }
                return 1;
        }
        if(dialogid == 203)
        {
            if(response)
            {
                        if(listitem ==  0)//GlassesType11
                        {
                SetPlayerAttachedObject(playerid, 2, 19016, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  1)//GlassesType12
                        {
                SetPlayerAttachedObject(playerid, 2, 19017, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  2)//GlassesType13
                        {
                SetPlayerAttachedObject(playerid, 2, 19018, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  3)//GlassesType14
                        {
                SetPlayerAttachedObject(playerid, 2, 19019, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  4)//GlassesType15
                        {
                SetPlayerAttachedObject(playerid, 2, 19020, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  5)//GlassesType16
                        {
                SetPlayerAttachedObject(playerid, 2, 19021, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  6)//GlassesType17
                        {
                SetPlayerAttachedObject(playerid, 2, 19022, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  7)//GlassesType18
                        {
                SetPlayerAttachedObject(playerid, 2, 19023, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  8)//GlassesType19
                        {
                SetPlayerAttachedObject(playerid, 2, 19024, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  9)//GlassesType20
                        {
                SetPlayerAttachedObject(playerid, 2, 19025, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem == 10)//weiter
                        {
                                new listitems[] = "{E24234}»{FFFFFF} Gözlük 21\n{E24234}»{FFFFFF} Gözlük 22\n{E24234}»{FFFFFF} Gözlük 23\n{E24234}»{FFFFFF} Gözlük 24\n{E24234}»{FFFFFF} Gözlük 25\n{E24234}»{FFFFFF} Gözlük 26\n{E24234}»{FFFFFF} Gözlük 27\n{E24234}»{FFFFFF} Gözlük 28\n{E24234}»{FFFFFF} Gözlük 29\n{E24234}»{FFFFFF} Gözlük 30";
                        ShowPlayerDialog(playerid,204,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Gözlükler 3/3:",listitems,"Giy","Çik");
                        }
                }
                else
                {
                new listitems[] = "{E24234}» {FFFFFF}Sapkalar\n{E24234}» {FFFFFF}Gözlükler\n{E24234}» {FFFFFF}Peceler\n{E24234}» {FFFFFF}Maskeler\n{E24234}» {FFFFFF}Giysileri Kaldir";
                ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Giysiler",listitems,"Giy","Çik");
                }
                return 1;
        }
        if(dialogid == 204)
        {
            if(response)
            {
                        if(listitem ==  0)//GlassesType21
                        {
                SetPlayerAttachedObject(playerid, 2, 19026, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  1)//GlassesType22
                        {
                SetPlayerAttachedObject(playerid, 2, 19027, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  2)//GlassesType23
                        {
                SetPlayerAttachedObject(playerid, 2, 19028, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  3)//GlassesType24
                        {
                SetPlayerAttachedObject(playerid, 2, 19029, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  4)//GlassesType25
                        {
                SetPlayerAttachedObject(playerid, 2, 19030, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  5)//GlassesType26
                        {
                SetPlayerAttachedObject(playerid, 2, 19031, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  6)//GlassesType27
                        {
                SetPlayerAttachedObject(playerid, 2, 19032, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  7)//GlassesType28
                        {
                SetPlayerAttachedObject(playerid, 2, 19033, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  8)//GlassesType29
                        {
                SetPlayerAttachedObject(playerid, 2, 19034, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                        if(listitem ==  9)//GlassesType30
                        {
                SetPlayerAttachedObject(playerid, 2, 19035, 2, 0.09, 0.04, 0, 88, 75, 0);
                        }
                }
                else
                {
                new listitems[] = "{E24234}» {FFFFFF}Sapkalar\n{E24234}» {FFFFFF}Gözlükler\n{E24234}» {FFFFFF}Peceler\n{E24234}» {FFFFFF}Maskeler\n{E24234}» {FFFFFF}Giysileri Kaldir";
                ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Giysiler",listitems,"Giy","Çik");
                }
                return 1;
        }
        if(dialogid == 205)
        {
            if(response)
            {
                        if(listitem ==  0)//bandanna1
                        {
                SetPlayerAttachedObject(playerid, 3, 18911, 2, -0.08, 0.03, 0.0, 90, -180, -90);
                        }
                        if(listitem ==  1)//bandanna2
                        {
                SetPlayerAttachedObject(playerid, 3, 18912, 2, -0.08, 0.03, 0.0, 90, -180, -90);
                        }
                        if(listitem ==  2)//bandanna3
                        {
                SetPlayerAttachedObject(playerid, 3, 18913, 2, -0.08, 0.03, 0.0, 90, -180, -90);
                        }
                        if(listitem ==  3)//bandanna4
                        {
                SetPlayerAttachedObject(playerid, 3, 18914, 2, -0.08, 0.03, 0.0, 90, -180, -90);
                        }
                        if(listitem ==  4)//bandanna5
                        {
                SetPlayerAttachedObject(playerid, 3, 18915, 2, -0.08, 0.03, 0.0, 90, -180, -90);
                        }
                        if(listitem ==  5)//bandanna6
                        {
                SetPlayerAttachedObject(playerid, 3, 18916, 2, -0.08, 0.03, 0.0, 90, -180, -90);
                        }
                        if(listitem ==  6)//bandanna7
                        {
                SetPlayerAttachedObject(playerid, 3, 18917, 2, -0.08, 0.03, 0.0, 90, -180, -90);
                        }
                        if(listitem ==  7)//bandanna8
                        {
                SetPlayerAttachedObject(playerid, 3, 18918, 2, -0.08, 0.03, 0.0, 90, -180, -90);
                        }
                        if(listitem ==  8)//bandanna9
                        {
                SetPlayerAttachedObject(playerid, 3, 18919, 2, -0.08, 0.03, 0.0, 90, -180, -90);
                        }
                        if(listitem ==  9)//bandanna10
                        {
                SetPlayerAttachedObject(playerid, 3, 18920, 2, -0.08, 0.03, 0.0, 90, -180, -90);
                        }
                }
                else
                {
                new listitems[] = "{E24234}» {FFFFFF}Sapkalar\n{E24234}» {FFFFFF}Gözlükler\n{E24234}» {FFFFFF}Peceler\n{E24234}» {FFFFFF}Maskeler\n{E24234}» {FFFFFF}Giysileri Kaldir";
                ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Giysiler",listitems,"Giy","Çik");
                }
        }
        if(dialogid == 211)
        {
            if(response)
            {
                        if(listitem ==  0)//Hockeymask1
                        {
                SetPlayerAttachedObject(playerid, 1, 19036, 2, 0.107, 0.020, 0.0, 90, 90, 0);
                        }
                        if(listitem ==  1)//Hockeymask2
                        {
                SetPlayerAttachedObject(playerid, 1, 19037, 2, 0.107, 0.020, 0.0, 90, 90, 0);
                        }
                        if(listitem ==  2)//Hockeymask3
                        {
                SetPlayerAttachedObject(playerid, 1, 19038, 2, 0.107, 0.020, 0.0, 90, 90, 0);
                        }
                        if(listitem ==  3)//Zorromask
                        {
                SetPlayerAttachedObject(playerid, 1, 18974, 2, 0.098, 0.0258, 0.0, 90, 90, 0);
                        }
                        if(listitem ==  4)//Boxing
                        {
                SetPlayerAttachedObject(playerid, 1, 18952, 2, 0.105, 0.01, 0.0, 0, 0, 0);
                        }
                }
                else
                {
                new listitems[] = "{E24234}» {FFFFFF}Sapkalar\n{E24234}» {FFFFFF}Gözlükler\n{E24234}» {FFFFFF}Peceler\n{E24234}» {FFFFFF}Maskeler\n{E24234}» {FFFFFF}Giysileri Kaldir";
                ShowPlayerDialog(playerid,200,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - Giysiler",listitems,"Giy","Çik");
                }
//          return 1;
}

/*     if(dialogid == 1111)
     {
         if(response)
         {
             if(!strlen(inputtext))
               {
                    new
                        sus_Seyi[512]
                    ;
                    format(sus_Seyi, sizeof(sus_Seyi), "{FFFFFF}Sunucuya hos geldiniz sayin {E24234}%s{FFFFFF},\nGirdiginiz sifre yanlis ! ( %d/3)\nAsagidaki kutucuga sifrenizi girerek oyuna devam edebilirsiniz.", oIsim(playerid), GetPVarInt(playerid, "sifreUyari"));
                    ShowPlayerDialog(playerid, 1111, DIALOG_STYLE_PASSWORD, "{E24234}"DIALOG_BASLIK" - Giris Yap", sus_Seyi, "Giris", "");
                    return 1;
               }
             if(PlayerInfo[playerid][Registered] == 0) return RegServ(playerid, "Bir hesabiniz yok, /kayit ile olusturabilirsiniz.", "You is not registered. Use to /register command.");
             if(PlayerInfo[playerid][LoggedIn] == 1) return RegServ(playerid, "Sunucuya giris yapmis gozukmektesiniz.", "You already logged in!");
             new
                 queryString[256]
               ;
               format(queryString, sizeof(queryString), "SELECT * FROM `oyuncular` WHERE `kullaniciadi` = '%s' AND `sifre` = md5('%s')", oIsim(playerid), inputtext);
               mysql_query(queryString);
               mysql_store_result();
               if(mysql_num_rows() > 0)
               {
                   mysql_free_result();
                   PlayerInfo[playerid][LoggedIn] = 1;
                    PlayerPlaySound(playerid, 1057, 0,0,0);
                    LoginPlayer(playerid);
               }
               else
               {
                   if(GetPVarInt(playerid, "sifreUyari") == 3) return Kickle(playerid, "Yanlis sifre girisi!"), 0;
                   SetPVarInt(playerid, "sifreUyari", GetPVarInt(playerid, "sifreUyari")+1);
                    new
                        sus_Seyi[512]
                    ;
                    format(sus_Seyi, sizeof(sus_Seyi), "{FFFFFF}Sunucuya hos geldiniz sayin {E24234}%s{FFFFFF},\nGirdiginiz sifre yanlis ! ( %d/3)\nAsagidaki kutucuga sifrenizi girerek oyuna devam edebilirsiniz.", oIsim(playerid), GetPVarInt(playerid, "sifreUyari"));
                    ShowPlayerDialog(playerid, 1111, DIALOG_STYLE_PASSWORD, "{E24234}"DIALOG_BASLIK" - Giris Yap", sus_Seyi, "Giris", "");
               }
               mysql_free_result();
         }
     }*/
if(dialogid == 9989)
{
if(response)
{
if(listitem == 0)
{
SetPlayerFightingStyle(playerid,FIGHT_STYLE_NORMAL);
Bilgimesaj(playerid,"Dövüs stiliniz {E24234}NORMAL{ffffff} olarak ayarlandi.", "Your default fight style is: {E24234}E24234}NORMAL{ffffff}");
}
if(listitem == 1)
{
SetPlayerFightingStyle(playerid,FIGHT_STYLE_BOXING);
Bilgimesaj(playerid,"Dövüs stiliniz {E24234}BOXING{ffffff} olarak ayarlandi.", "Your default fight style is: {E24234}E24234}BOXING{ffffff}");
}
if(listitem == 2)
{
 SetPlayerFightingStyle(playerid,FIGHT_STYLE_KUNGFU);
Bilgimesaj(playerid,"Dövüs stiliniz {E24234}KUNGFU{ffffff} olarak ayarlandi.", "Your default fight style is: {E24234}E24234}KUNGFU{ffffff}");
}
if(listitem == 3)
{
SetPlayerFightingStyle(playerid,FIGHT_STYLE_KNEEHEAD);
Bilgimesaj(playerid,"Dövüs stiliniz {E24234}KNEEHEAD{ffffff} olarak ayarlandi.", "Your default fight style is: {E24234}E24234}KNEEHEAD{ffffff}");
}
if(listitem == 4)
{
SetPlayerFightingStyle(playerid,FIGHT_STYLE_GRABKICK);
Bilgimesaj(playerid,"Dövüs stiliniz {E24234}GRABKICK{ffffff} olarak ayarlandi.", "Your default fight style is: {E24234}E24234}GRABKICK{ffffff}");
}
if(listitem == 5)
{
SetPlayerFightingStyle(playerid,FIGHT_STYLE_ELBOW);
Bilgimesaj(playerid,"Dövüs stiliniz {E24234}ELBOW{ffffff} olarak ayarlandi.", "Your default fight style is: {E24234}E24234}ELBOW{ffffff}");
}
     return 1;
}
}

        switch(dialogid)
        {
            case Lazer1:
            {
                        if(response)
                        {
                                switch(listitem)
                                {
                                        case 0:
                                        {
                                            SendClientMessage(playerid, 0x00E800FF, "{E24234}<(Bilgi)> {ffffff}Lazer acik.");
                                                SetPVarInt(playerid, "Lazer", 1);
                                SetPVarInt(playerid, "color", GetPVarInt(playerid, "color"));
                                return 1;
                                        }
                                        case 1:
                                        {
                        ShowPlayerDialog(playerid, Lazer2, DIALOG_STYLE_LIST, "{E24234}[Z]ero Elite {FFFFFF} - Lazer - Renkleri", "{E24234}» {ffffff}Mavi\n{E24234}» {ffffff}Pembe\n{E24234}» {ffffff}Turuncu\n{E24234}» {ffffff}Yesil\n{E24234}» {ffffff}Sari", "Sec", "Kapat");
                                                return 1;
                    }
                                        case 2:
                                        {
                        SendClientMessage(playerid, 0x00E800FF, "{E24234}<(Bilgi)> {ffffff}Lazer kapali.");
                                SetPVarInt(playerid, "Lazer", 0);
                                RemovePlayerAttachedObject(playerid, 0);
                                                return 1;
                                        }
                                }
                        }
            }//
        }
        switch(dialogid)
        {
            case Lazer2:
            {
                if(response)
                {
                    switch(listitem)
                    {
                        case 0:
                        {
                                SetPVarInt(playerid, "color", 19080);
                                                return 1;
                                        }
                                        case 1:
                                        {
                                                SetPVarInt(playerid, "color", 19081);
                                                return 1;
                                        }
                                        case 2:
                                        {
                                                SetPVarInt(playerid, "color", 19082);
                                                return 1;
                                        }
                                        case 3:
                                        {
                                                SetPVarInt(playerid, "color", 19083);
                                                return 1;
                                        }
                    case 4:
                                        {
                                                SetPVarInt(playerid, "color", 19084);
                                                return 1;
                                        }
                                }
                }
                }
        }

     if(dialogid == NEON)
     {
          if(response)
          {
              if(listitem == 0)
              {
                  SetPVarInt(playerid, "neon", 1);
                 SetPVarInt(playerid, "blue", CreateObject(18648,0,0,0,0,0,0));
                 SetPVarInt(playerid, "blue1", CreateObject(18648,0,0,0,0,0,0));
                 AttachObjectToVehicle(GetPVarInt(playerid, "blue"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
                 AttachObjectToVehicle(GetPVarInt(playerid, "blue1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
               }
               if(listitem == 1)
               {
                       SetPVarInt(playerid, "neon", 1);
                      SetPVarInt(playerid, "green", CreateObject(18649,0,0,0,0,0,0));
                      SetPVarInt(playerid, "green1", CreateObject(18649,0,0,0,0,0,0));
                      AttachObjectToVehicle(GetPVarInt(playerid, "green"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
                    AttachObjectToVehicle(GetPVarInt(playerid, "green1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
               }
               if(listitem == 2)
               {
                   SetPVarInt(playerid, "neon", 1);
                      SetPVarInt(playerid, "yellow", CreateObject(18650,0,0,0,0,0,0));
                    SetPVarInt(playerid, "yellow1", CreateObject(18650,0,0,0,0,0,0));
                 AttachObjectToVehicle(GetPVarInt(playerid, "yellow"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
                  AttachObjectToVehicle(GetPVarInt(playerid, "yellow1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
               }
               if(listitem == 3)
               {
                       SetPVarInt(playerid, "neon", 1);
                       SetPVarInt(playerid, "white", CreateObject(18652,0,0,0,0,0,0));
                       SetPVarInt(playerid, "white1", CreateObject(18652,0,0,0,0,0,0));
                      AttachObjectToVehicle(GetPVarInt(playerid, "white"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
                    AttachObjectToVehicle(GetPVarInt(playerid, "white1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
               }
               if(listitem == 4)
               {
                       SetPVarInt(playerid, "neon", 1);
                    SetPVarInt(playerid, "pink", CreateObject(18651,0,0,0,0,0,0));
                  SetPVarInt(playerid, "pink1", CreateObject(18651,0,0,0,0,0,0));
                    AttachObjectToVehicle(GetPVarInt(playerid, "pink"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
                 AttachObjectToVehicle(GetPVarInt(playerid, "pink1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
               }
               if(listitem == 5)
               {
                       DestroyObject(GetPVarInt(playerid, "blue"));
                 DeletePVar(playerid, "neon");
                 DestroyObject(GetPVarInt(playerid, "blue1"));
                 DeletePVar(playerid, "neon");
                 DestroyObject(GetPVarInt(playerid, "green"));
                 DeletePVar(playerid, "neon");
                 DestroyObject(GetPVarInt(playerid, "green1"));
                 DeletePVar(playerid, "neon");
                 DestroyObject(GetPVarInt(playerid, "yellow"));
                 DeletePVar(playerid, "neon");
                 DestroyObject(GetPVarInt(playerid, "yellow1"));
                 DeletePVar(playerid, "neon");
                 DestroyObject(GetPVarInt(playerid, "white"));
                 DeletePVar(playerid, "neon");
                 DestroyObject(GetPVarInt(playerid, "white1"));
                 DeletePVar(playerid, "neon");
                 DestroyObject(GetPVarInt(playerid, "pink"));
                 DeletePVar(playerid, "neon");
                 DestroyObject(GetPVarInt(playerid, "pink1"));
                 DeletePVar(playerid, "neon");
                 Bilgimesaj(playerid, "Takilmis butun neonlar kaldirildi!", "Your vehicle plugged in all the neons deleted.");
            }
          }
      }
     //--------------------------------------------------------------------------
     //Teleports Dialog
     //--------------------------------------------------------------------------
     if(dialogid == 1000)
     {
          if(response)
          {
               if(listitem == 0)
               {
                       ShowPlayerDialog(playerid,1001,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} Stunts",ShowTeles2(),"Isinlan", "Geri");
             }
             if(listitem == 1)
             {
                  ShowPlayerDialog(playerid,1002,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} Jumps", ShowTeles3(),"Isinlan", "Geri");
             }
             if(listitem == 2)
               {
                  ShowPlayerDialog(playerid,1003,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} DeathMatchs",ShowTeles4(),"Isinlan", "Geri");
               }
               if(listitem == 3)
               {
                       ShowPlayerDialog(playerid,1004,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} Drag/Drift", ShowTeles5(),"Isinlan", "Geri");
             }
             if(listitem == 4)
             {
                  ShowPlayerDialog(playerid,1005,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} Races",ShowTeles6(),"Isinlan", "Geri");
                  }
             if(listitem == 5)
             {
                       ShowPlayerDialog(playerid,1006,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} Fun Zones",ShowTeles7(),"Isinlan", "Geri");
               }
             if(listitem == 6)
             {
                  ShowPlayerDialog(playerid,1008,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} Parkour",ShowTeles9(),"Isinlan", "Geri");
               }
             if(listitem == 7)
             {
                  ShowPlayerDialog(playerid,1007,DIALOG_STYLE_LIST,"{E24234}"DIALOG_BASLIK" - {FFFFFF}Teleport Zones {E24234}-{FFFFFF} Other Teles",ShowTeles8(),"Isinlan", "Geri");
               }
             }
     }
     //--------------------------------------------------------------------------
     //Stunts Dialog
     //--------------------------------------------------------------------------
     if(dialogid == 1001)
     {
          if(response)
          {
               switch(listitem)
               {
                   case 0:  komut_aa(playerid, " ");
                   case 1:  komut_lsair(playerid, " ");
                   case 2:  komut_lvair(playerid, " ");
                   case 3:  komut_sfair(playerid, " ");
                   case 4:  komut_chilliad(playerid, " ");
                   case 5:  komut_tube2(playerid, " ");
                   case 6:  komut_tube3(playerid, " ");
                   case 7:  komut_superstunt(playerid, " ");
                   case 8:  komut_golf(playerid, " ");
                   case 9:  komut_stuntdam(playerid, " ");
                   case 10: komut_si(playerid, " ");
                   case 11: komut_sfstunt(playerid, " ");
                   case 12: komut_cstunt(playerid, " ");
                   case 13: komut_s000(playerid, " ");
                   case 14: komut_sss(playerid, " ");
               }
          }
          else komut_teles(playerid, " ");
     }
     //--------------------------------------------------------------------------
     //Jumps Dialog
     //--------------------------------------------------------------------------
     if(dialogid == 1002)
     {
          if(response)
          {
               switch(listitem)
               {
                   case 0: komut_basejump(playerid, " ");
                   case 1: komut_jump1(playerid, " ");
                   case 2: komut_jump2(playerid, " ");
                   case 3: komut_jump3(playerid, " ");
                   case 4: komut_wjump(playerid, " ");
                   case 5: komut_bcar(playerid, " ");
                   case 6: komut_ljump(playerid, " ");
                   case 7: komut_rjump(playerid, " ");
                   case 8: komut_dunejump(playerid, " ");
                   case 9: komut_tjump(playerid, " ");
                   case 10: komut_nrgjump(playerid, " ");
                   case 11: komut_placejump(playerid, " ");
               }
          }
          else komut_teles(playerid, " ");
     }
     //--------------------------------------------------------------------------
     //DeathMatch Dialog
     //--------------------------------------------------------------------------
     if(dialogid == 1003)
     {
          if(response)
          {
               switch(listitem)
               {
                   case 0: komut_mg1(playerid, " ");
                   case 1: komut_mg2(playerid, " ");
                   case 2: komut_rocket(playerid, " ");
               }
          }
          else komut_teles(playerid, " ");
     }
     //--------------------------------------------------------------------------
     //Drag & Drifts Dialog
     //---------------------------------------------------------------------------
     if(dialogid == 1004)
     {
          if(response)
          {
               switch(listitem)
               {
                   case 0: komut_drag1(playerid, " ");
                   case 1: komut_drag2(playerid, " ");
                   case 2: komut_drag3(playerid, " ");
                   case 3: komut_canyon(playerid, " ");
                   case 4: komut_drift4(playerid, " ");
                   case 5: komut_drift2(playerid, " ");
                   case 6: komut_drift3(playerid, " ");
                   case 7: komut_sdrift(playerid, " ");
               }
          }
          else komut_teles(playerid, " ");
     }
     //--------------------------------------------------------------------------
     //Fun Zones
     //--------------------------------------------------------------------------
     if(dialogid == 1006)
     {
          if(response)
          {
               switch(listitem)
               {
                   case 0: komut_eiffel(playerid, " ");
                   case 1: komut_mpk1(playerid, " ");
                   case 2: komut_mpk2(playerid, " ");
                   case 3: komut_icerink(playerid, " ");
                   case 4: komut_beach(playerid, " ");
                   case 5: komut_maze(playerid, " ");
               }
          }
          else komut_teles(playerid, " ");
     }
     //--------------------------------------------------------------------------
     //Others Dialog
     //--------------------------------------------------------------------------
     if(dialogid == 1008)
     {
          if(response)
          {
               switch(listitem)
               {
                   case 0: komut_easypk(playerid, " ");
                   case 1: komut_funnypk(playerid, " ");
                   case 2: komut_upperpk(playerid, " ");
                    case 3: komut_extremepk(playerid, " ");
                    case 4: komut_hardpk(playerid, " ");
                    case 5: komut_bigpk(playerid, " ");
                    case 6: komut_oceanicpk(playerid, " ");
                    case 7: komut_monsterpk(playerid, " ");
                    case 8: komut_lospk(playerid, " ");
               }
          }
          else komut_teles(playerid, " ");
     }
     //--------------------------------------------------------------------------
     //--------------------------------------------------------------------------
     if(dialogid == 1007)
     {
          if(response)
          {
               switch(listitem)
               {
                   case 0: komut_ls(playerid, " ");
                   case 1: komut_lv(playerid, " ");
                   case 2: komut_sf(playerid, " ");
                    case 3: komut_island(playerid, " ");
                    case 4: komut_party1(playerid, " ");
                    case 5: komut_party2(playerid, " ");
                    case 6: komut_party3(playerid, " ");
                    case 7: komut_party4(playerid, " ");
                    case 8: komut_party5(playerid, " ");
                    case 9: komut_grov(playerid, " ");
                    case 10: komut_spool(playerid, " ");
                    case 11: komut_nrgrainbow(playerid, " ");
                    case 12: komut_btbs(playerid, " ");
                    case 13: komut_fplace(playerid, " ");
                    case 14: komut_pimps(playerid, " ");
               }
          }
          else komut_teles(playerid, " ");
     }
     if(dialogid == 7778)
     {
         if(!response) return komut_shop(playerid, " ");
         if(response)
         {
             if(listitem == 0)
             {
                    if(GetPlayerMoney(playerid) < 1000) return eksikMiktarc(playerid, 1000);
                    SetPlayerHealth(playerid, 100.0000);
                    GivePlayerMoney(playerid, -1000);
                    PlayerPlaySound(playerid, 1150, 0,0,0);
                    komut_czmenu(playerid, " ");
             }
             if(listitem == 1)
             {
                    if(GetPlayerMoney(playerid) < 500) return eksikMiktarc(playerid, 500);
                    new Float:statu;
                    GetPlayerHealth(playerid, statu);
                    if(statu > 90) return SendClientMessage(playerid, -1, "{E24234}<(Bilgi)>{FFFFFF} Saglik statünüz bu duruma elverisli degil. (Caniniz 90 üstü olamaz)"), komut_czmenu(playerid, " ");
                    SetPlayerHealth(playerid, statu+10);
                    GivePlayerMoney(playerid, -500);
                    PlayerPlaySound(playerid, 1150, 0,0,0);
                    komut_czmenu(playerid, " ");
             }
             if(listitem == 2)
             {
                    if(GetPlayerMoney(playerid) < 2000) return eksikMiktarc(playerid, 2000);
                    SetPlayerArmour(playerid, 100.0000);
                    PlayerPlaySound(playerid, 1150, 0,0,0);
                    GivePlayerMoney(playerid, -2000);
                    komut_czmenu(playerid, " ");
             }
             if(listitem == 3)
             {
                    if(GetPlayerMoney(playerid) < 1000) return eksikMiktarc(playerid, 1000);
                    new Float:statu;
                    GetPlayerArmour(playerid, statu);
                    if(statu > 90) return SendClientMessage(playerid, -1, "{E24234}<(Bilgi)>{FFFFFF} Sagik statünüz bu duruma elverisli degil. (Zirhiniz 90 üstü olamaz)"), komut_czmenu(playerid, " ");
                    SetPlayerArmour(playerid, statu+10);
                    GivePlayerMoney(playerid, -1000);
                    PlayerPlaySound(playerid, 1150, 0,0,0);
                    komut_czmenu(playerid, " ");
             }
          }
     }
     if(dialogid == 7777)
     {
         if(response)
         {
             if(listitem == 0)
             {
                   ShowPlayerDialog(playerid, 7778, DIALOG_STYLE_TABLIST_HEADERS, "{E24234}"DIALOG_BASLIK" -{FFFFFF} Shop Menu {E24234}- {FFFFFF} Can§Zirh Eklentileri", "\
                    Ürün\tFiyat\tEklenti \n\
                    {E24234}» {FFFFFF}Can\t{E24234}1.000$\t{E24234}FULL\n\
                    {E24234}» {FFFFFF}Can\t{E24234}500$\t{E24234}+10\n\
                    {E24234}» {FFFFFF}Zirh\t{E24234}2.000$\t{E24234}FULL\n\
                    {E24234}» {FFFFFF}Zirh\t{E24234}1.000$\t{E24234}+10\n", "Tamam", "Iptal");
             }
             if(listitem == 1)
             {
                    new _str[1299];
                    strcat(_str,"Isim\tFiyat\tMermi\n\
                    {E24234}» {FFFFFF}Bicak\t1.000$\tN/A\n\
                    {E24234}» {FFFFFF}Katana\t5.000$\tN/A\n\
                    {E24234}» {FFFFFF}Beyzbol Sopasi\t5.000$\tN/A\n\
                    {E24234}» {FFFFFF}Kürek\t5.000$\tN/A\n\
                    {E24234}» {FFFFFF}Bilardo Sopasi\t5.000$\tN/A\n\
                    {E24234}» {FFFFFF}Job\t5.000$\tN/A\n\
                    {E24234}» {FFFFFF}Golf Sopasi\t5.000$\tN/A\n\
                    {E24234}» {FFFFFF}Testere\t5.000$\tN/A\n\
                    {E24234}» {FFFFFF}Dildo\t5.000$\tN/A\n");
                    strcat(_str,"\
                    {E24234}» {FFFFFF}Baston\t5.000$\tN/A\n\
                    {E24234}» {FFFFFF}Colt45\t10.000$\t150\n\
                    {E24234}» {FFFFFF}Susturuculu Colt45\t1.0000$\t150\n\
                    {E24234}» {FFFFFF}Desert Eagle\t10.000$\t150\n\
                    {E24234}» {FFFFFF}M4\t15.000$\t150\n\
                    {E24234}» {FFFFFF}AK-47\t15.000$\t150\n\
                    {E24234}» {FFFFFF}Tüfek\t15.000$\t5\n\
                    {E24234}» {FFFFFF}Sniper\t15.000$\t5\n");
                    strcat(_str,"\
                    {E24234}» {FFFFFF}Pompali\t25.000$\t50\n\
                    {E24234}» {FFFFFF}Combat Shotgun\t25.000$\t50\n\
                    {E24234}» {FFFFFF}Sawn-Off Shotgun\t25.000$\t50\n\
                    {E24234}» {FFFFFF}MP5\t35.000$\t50\n\
                    {E24234}» {FFFFFF}Micro SMG\t35.000$\t50\n\
                    {E24234}» {FFFFFF}Tec9\t35.000$\t50\n\
                    {E24234}» {FFFFFF}El Bombasi\t50.000$\t50\n\
                    {E24234}» {FFFFFF}Uzaktan Kumandali Bomba\t150.000$\t5\n");
                    strcat(_str,"\
                    {E24234}» {FFFFFF}Molotof Kokteyli\t155.000$\t5\n\
                    {E24234}» {FFFFFF}Kamera\t5.000$\tN/A\n\
                    {E24234}» {FFFFFF}Yangin Tüpü\t5.000$\tN/A\n\
                    {E24234}» {FFFFFF}Termal Gözlük\t5.000$\tN/A\n\
                    {E24234}» {FFFFFF}Gece Gorüs Gözlüðü\t5.000$\tN/A\n\
                    {E24234}» {FFFFFF}Parasüt\t5.000$\tN/A\n\
                    {E24234}» {FFFFFF}Sprey\t5.000$\tN/A\n");
                   ShowPlayerDialog(playerid, 7779, DIALOG_STYLE_TABLIST_HEADERS, "{E24234}"DIALOG_BASLIK" -{FFFFFF} Shop Menu {E24234}- {FFFFFF} Silahlar", _str, "Tamam", "Iptal");
             }
             if(listitem == 2)
             {
                  ShowPlayerDialog(playerid,Shop+12,DIALOG_STYLE_TABLIST_HEADERS,"{E24234}"DIALOG_BASLIK" -{FFFFFF} Shop Menu {E24234}- {FFFFFF} Ozel Yetenekler",
                    "Isim\tÜcret\tSinir\n\
                    {E24234}» {FFFFFF}Full Zirhla Dogma\t125 Score\tNo Limit\n\
                    ","Tamam", "Geri");
             }
             if(listitem == 3)
             {
                 new anastr[699];
                 strcat(anastr, "Isim\tAna Ton\tFiyat\n\
                    {E24234}» {F36E4B}Domates\t{FFFF00}Kirmizi\t1.000$\n\
                    {E24234}» {B4155D}Küpe cicegi\t{FFFF00}Kirmizi\t1.000$\n\
                    {E24234}» {E7D3E2}Kirec Rengi\t{FFFF00}Kirmizi\t1.000$\n\
                    {E24234}» {CD392F}Akik Tasi\t{FFFF00}Kirmizi\t1.000$\n");
                    strcat(anastr, "{E24234}» {FF007F}Gül Rengi\t{FFFF00}Kirmizi\t1.000$\n\
                    {E24234}» {0095B6}Bondi Mavisi\t{336699}Mavi\t1.000$\n\
                    {E24234}» {7DF9FF}Elektirik Mavisi\t{336699}Mavi\t1.000$\n\
                    {E24234}» {0095B6}Bondi Mavisi\t{336699}Mavi\t1.000$\n\
                    {E24234}» {009000}Islam Yesili\t{00FF00}Yesil\t1.000$\n\
                    {E24234}» {7BA05B}Kuskonmaz Rengi\t{00FF00}Yesil\t1.000$");
                  ShowPlayerDialog(playerid,7780,DIALOG_STYLE_TABLIST_HEADERS,"{E24234}"DIALOG_BASLIK" -{FFFFFF} Shop Menu {E24234}- {FFFFFF} Nick Renkleri",anastr,"Tamam", "Geri");
               }
         }
     }
     if(dialogid == Shop+12)
     {
          if(response)
          {
              if(listitem == 0)
              {
                  if(GetPlayerScore(playerid) < 125) return eksikSkor(playerid, 125);
                  SetPVarInt(playerid, "Zirh__", 1);
                  komut_yetenekler(playerid, " ");
				  SetPlayerScore(playerid, GetPlayerScore(playerid)-125);
				  INmessage(playerid, "Yetenegi basariyla satin aldiniz! Hesabiniza yüklenmistir.");
			  }
          }else komut_shop(playerid, " ");
     }

     if(dialogid == 7780)
     {
         if(!response) return komut_shop(playerid, " ");
         if(response)
         {
             if(listitem == 0)
             {
                 if(GetPlayerMoney(playerid) < 1000) return eksikMiktarr(playerid, 1000);
                 GivePlayerMoney(playerid, -1000);
                 SetPlayerColor(playerid, 0xF36E4BAA);
                 PlayerPlaySound(playerid, 1150, 0,0,0);
             }
             if(listitem == 1)
             {
                 if(GetPlayerMoney(playerid) < 1000) return eksikMiktarr(playerid, 1000);
                 GivePlayerMoney(playerid, -1000);
                 SetPlayerColor(playerid, 0xB4155DAA);
                 PlayerPlaySound(playerid, 1150, 0,0,0);
             }
             if(listitem == 2)
             {
                 if(GetPlayerMoney(playerid) < 1000) return eksikMiktarr(playerid, 1000);
                 GivePlayerMoney(playerid, -1000);
                 SetPlayerColor(playerid, 0xE7D3E2AA);
                 PlayerPlaySound(playerid, 1150, 0,0,0);
             }
             if(listitem == 3)
             {
                 if(GetPlayerMoney(playerid) < 1000) return eksikMiktarr(playerid, 1000);
                 GivePlayerMoney(playerid, -1000);
                 SetPlayerColor(playerid, 0xCD392FAA);
                 PlayerPlaySound(playerid, 1150, 0,0,0);
             }
             if(listitem == 4)
             {
                 if(GetPlayerMoney(playerid) < 1000) return eksikMiktarr(playerid, 1000);
                 GivePlayerMoney(playerid, -1000);
                 SetPlayerColor(playerid, 0xFF007FAA);
                 PlayerPlaySound(playerid, 1150, 0,0,0);
             }
             if(listitem == 5)
             {
                 if(GetPlayerMoney(playerid) < 1000) return eksikMiktarr(playerid, 1000);
                 GivePlayerMoney(playerid, -1000);
                 SetPlayerColor(playerid, 0x0095B6AA);
                 PlayerPlaySound(playerid, 1150, 0,0,0);
             }
             if(listitem == 6)
             {
                 if(GetPlayerMoney(playerid) < 1000) return eksikMiktarr(playerid, 1000);
                 GivePlayerMoney(playerid, -1000);
                 SetPlayerColor(playerid, 0x7DF9FAA);
                 PlayerPlaySound(playerid, 1150, 0,0,0);
             }
             if(listitem == 7)
             {
                 if(GetPlayerMoney(playerid) < 1000) return eksikMiktarr(playerid, 1000);
                 GivePlayerMoney(playerid, -1000);
                 SetPlayerColor(playerid, 0x0095B6FAA);
                 PlayerPlaySound(playerid, 1150, 0,0,0);
             }
             if(listitem == 8)
             {
                 if(GetPlayerMoney(playerid) < 1000) return eksikMiktarr(playerid, 1000);
                 GivePlayerMoney(playerid, -1000);
                 SetPlayerColor(playerid, 0x009000FAA);
                 PlayerPlaySound(playerid, 1150, 0,0,0);
             }
             if(listitem == 9)
             {
                 if(GetPlayerMoney(playerid) < 1000) return eksikMiktarr(playerid, 1000);
                 GivePlayerMoney(playerid, -1000);
                 SetPlayerColor(playerid, 0x7BA05BAA);
                 PlayerPlaySound(playerid, 1150, 0,0,0);
             }
          }
     }
     if(dialogid == 7779)
     {
         if(!response) return komut_shop(playerid, " ");
          new adsz[3];
          if(listitem==0)
          {
              if(GetPlayerMoney(playerid)<1000)return eksikMiktar(playerid, 1000);
               GivePlayerMoney(playerid,-1000);
                  komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,4,31);adsz[0]=4;adsz[1]=1;
          }
          if(listitem==1)
          {
              if(GetPlayerMoney(playerid)<5000)return eksikMiktar(playerid, 5000);
               GivePlayerMoney(playerid,-5000);
                  komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,8,1);adsz[0]=8;adsz[1]=1;
          }
         if(listitem==2)
          {
              if(GetPlayerMoney(playerid)<5000)return eksikMiktar(playerid, 5000);
               GivePlayerMoney(playerid,-5000);
                  komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,5,1);adsz[0]=5;adsz[1]=1;
          }
          if(listitem==3)
          {
              if(GetPlayerMoney(playerid)<5000)return eksikMiktar(playerid, 5000);
               GivePlayerMoney(playerid,-5000);
                  komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,6,1);adsz[0]=6;adsz[1]=1;
          }
         if(listitem==4)
          {
              if(GetPlayerMoney(playerid)<5000)return eksikMiktar(playerid, 5000);
               GivePlayerMoney(playerid,-5000);
                  komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,7,1);adsz[0]=7;adsz[1]=1;
          }
          if(listitem==5)
          {
                if(GetPlayerMoney(playerid)<5000)return eksikMiktar(playerid, 5000);
               GivePlayerMoney(playerid,-5000);
                komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,3,1);adsz[0]=3;adsz[1]=1;
          }
         if(listitem==6)
          {
               if(GetPlayerMoney(playerid)<5000)return eksikMiktar(playerid, 5000);
               GivePlayerMoney(playerid,-5000);
                 komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,2,1);adsz[0]=2;adsz[1]=1;
          }
         if(listitem==7)
          {
              if(GetPlayerMoney(playerid)<5000)return eksikMiktar(playerid, 5000);
               GivePlayerMoney(playerid,-5000);
                  komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,9,1);adsz[0]=9;adsz[1]=1;
          }
         if(listitem==8)
          {
              if(GetPlayerMoney(playerid)<5000)return eksikMiktar(playerid, 5000);
               GivePlayerMoney(playerid,-5000);
                  komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,12,1);adsz[0]=12;adsz[1]=1;
          }
         if(listitem==9)
          {
              if(GetPlayerMoney(playerid)<5000)return eksikMiktar(playerid, 5000);
               GivePlayerMoney(playerid,-5000);
                  komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,15,1);adsz[0]=15;adsz[1]=1;
          }
         if(listitem==10)
          {
              if(GetPlayerMoney(playerid)<10000)return eksikMiktar(playerid, 10000);
               GivePlayerMoney(playerid,-10000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,22,150);adsz[0]=22;adsz[1]=500;
          }
          if(listitem==11)
          {
              if(GetPlayerMoney(playerid)<10000)return eksikMiktar(playerid, 10000);
               GivePlayerMoney(playerid,-10000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,23,150);adsz[0]=23;adsz[1]=500;
          }
         if(listitem==12)
          {
              if(GetPlayerMoney(playerid)<10000)return eksikMiktar(playerid, 10000);
               GivePlayerMoney(playerid,-10000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,24,150);adsz[0]=24;adsz[1]=500;
          }
          if(listitem==13)
          {
              if(GetPlayerMoney(playerid)<15000)return eksikMiktar(playerid, 15000);
               GivePlayerMoney(playerid,-15000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,31,150);adsz[0]=31;adsz[1]=500;
          }
         if(listitem==14)
          {
              if(GetPlayerMoney(playerid)<15000)return eksikMiktar(playerid, 15000);
               GivePlayerMoney(playerid,-15000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,30,150);adsz[0]=30;adsz[1]=500;
          }
          if(listitem==15)
          {
              if(GetPlayerMoney(playerid)<15000)return eksikMiktar(playerid, 15000);
               GivePlayerMoney(playerid,-15000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,33,5);adsz[0]=33;adsz[1]=500;
          }
         if(listitem==16)
          {
              if(GetPlayerMoney(playerid)<15000)return eksikMiktar(playerid, 15000);
               GivePlayerMoney(playerid,-15000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,34,5);adsz[0]=34;adsz[1]=500;
          }
         if(listitem==17)
          {
              if(GetPlayerMoney(playerid)<25000)return eksikMiktar(playerid, 25000);
               GivePlayerMoney(playerid,-25000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,25,50);adsz[0]=25;adsz[1]=500;
          }
         if(listitem==18)
          {
              if(GetPlayerMoney(playerid)<25000)return eksikMiktar(playerid, 25000);
               GivePlayerMoney(playerid,-25000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,27,50);adsz[0]=27;adsz[1]=500;
          }
         if(listitem==19)
          {
              if(GetPlayerMoney(playerid)<25000)return eksikMiktar(playerid, 25000);
               GivePlayerMoney(playerid,-25000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,26,50);adsz[0]=26;adsz[1]=500;
          }
         if(listitem==20)
          {
              if(GetPlayerMoney(playerid)<35000)return eksikMiktar(playerid, 35000);
               GivePlayerMoney(playerid,-35000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,29,50);adsz[0]=29;adsz[1]=500;
          }
          if(listitem==21)
          {
              if(GetPlayerMoney(playerid)<35000)return eksikMiktar(playerid, 35000);
               GivePlayerMoney(playerid,-35000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,28,50);adsz[0]=28;adsz[1]=500;
          }
         if(listitem==22)
          {
              if(GetPlayerMoney(playerid)<35000)return eksikMiktar(playerid, 35000);
               GivePlayerMoney(playerid,-35000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,32,50);adsz[0]=32;adsz[1]=500;
          }
          if(listitem==23)
          {
              if(GetPlayerMoney(playerid)<50000)return eksikMiktar(playerid, 50000);
               GivePlayerMoney(playerid,-50000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,16,50);adsz[0]=16;adsz[1]=500;
          }
          if(listitem==24)
          {
              if(GetPlayerMoney(playerid)<150000)return eksikMiktar(playerid, 150000);
               GivePlayerMoney(playerid,-150000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,40,5);adsz[0]=40;adsz[1]=500;
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,39,5);
          }
         if(listitem==25)
          {
              if(GetPlayerMoney(playerid)<155000)return eksikMiktar(playerid, 155000);
               GivePlayerMoney(playerid,-155000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,18,5);adsz[0]=18;adsz[1]=500;
          }
          if(listitem==26)
          {
              if(GetPlayerMoney(playerid)<5000)return eksikMiktar(playerid, 5000);
               GivePlayerMoney(playerid,-5000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,43,1);adsz[0]=43;adsz[1]=500;
          }
         if(listitem==27)
          {
              if(GetPlayerMoney(playerid)<5000)return eksikMiktar(playerid, 5000);
               GivePlayerMoney(playerid,-5000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,42,500);adsz[0]=42;adsz[1]=500;
          }
         if(listitem==28)
          {
              if(GetPlayerMoney(playerid)<5000)return eksikMiktar(playerid, 5000);
               GivePlayerMoney(playerid,-5000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,45,500);adsz[0]=45;adsz[1]=500;
          }
         if(listitem==29)
          {
              if(GetPlayerMoney(playerid)<5000)return eksikMiktar(playerid, 5000);
               GivePlayerMoney(playerid,-5000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,44,500);adsz[0]=44;adsz[1]=500;
          }
         if(listitem==30)
          {
              if(GetPlayerMoney(playerid)<5000)return eksikMiktar(playerid, 5000);
               GivePlayerMoney(playerid,-5000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,46,500);adsz[0]=46;adsz[1]=500;
          }
         if(listitem==31)
          {
              if(GetPlayerMoney(playerid)<5000)return eksikMiktar(playerid, 5000);
               GivePlayerMoney(playerid,-5000);
               komut_silahlar(playerid, " "), GivePlayerWeapon(playerid,41,500);adsz[0]=41;adsz[1]=500;
          }//{3333FF}mavi{E24234}yesil{0040FF}mavi{99CCCC}grimavikarisimi{FFFF00}sari{FF0015}kirmizi{996633}kahverengi{993366}morumsu{A53232}kahverengimorumsukarisik{FFFFFF}B{E24234}{FFFFFF}
          PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
     }
     if(dialogid == 7778)
     {
         if(!response) return komut_shop(playerid, " ");
     }
     return 1;
}

CMD:silahlar(playerid, params[])
{
          new _str[1299];
          strcat(_str,"Isim\tFiyat\tMermi\n\
          {E24234}» {FFFFFF}Bicak\t1.000$\tN/A\n\
          {E24234}» {FFFFFF}Katana\t5.000$\tN/A\n\
          {E24234}» {FFFFFF}Beyzbol Sopasi\t5.000$\tN/A\n\
          {E24234}» {FFFFFF}Kürek\t5.000$\tN/A\n\
          {E24234}» {FFFFFF}Bilardo Sopasi\t5.000$\tN/A\n\
          {E24234}» {FFFFFF}Job\t5.000$\tN/A\n\
          {E24234}» {FFFFFF}Golf Sopasi\t5.000$\tN/A\n\
          {E24234}» {FFFFFF}Testere\t5.000$\tN/A\n\
          {E24234}» {FFFFFF}Dildo\t5.000$\tN/A\n");
          strcat(_str,"\
          {E24234}» {FFFFFF}Baston\t5.000$\tN/A\n\
          {E24234}» {FFFFFF}Colt45\t10.000$\t150\n\
          {E24234}» {FFFFFF}Susturuculu Colt45\t1.0000$\t150\n\
          {E24234}» {FFFFFF}Desert Eagle\t10.000$\t150\n\
          {E24234}» {FFFFFF}M4\t15.000$\t150\n\
          {E24234}» {FFFFFF}AK-47\t15.000$\t150\n\
          {E24234}» {FFFFFF}Tüfek\t15.000$\t5\n\
          {E24234}» {FFFFFF}Sniper\t15.000$\t5\n");
          strcat(_str,"\
          {E24234}» {FFFFFF}Pompali\t25.000$\t50\n\
          {E24234}» {FFFFFF}Combat Shotgun\t25.000$\t50\n\
          {E24234}» {FFFFFF}Sawn-Off Shotgun\t25.000$\t50\n\
          {E24234}» {FFFFFF}MP5\t35.000$\t50\n\
          {E24234}» {FFFFFF}Micro SMG\t35.000$\t50\n\
          {E24234}» {FFFFFF}Tec9\t35.000$\t50\n\
          {E24234}» {FFFFFF}El Bombasi\t50.000$\t50\n\
          {E24234}» {FFFFFF}Uzaktan Kumandali Bomba\t150.000$\t5\n");
          strcat(_str,"\
          {E24234}» {FFFFFF}Molotof Kokteyli\t155.000$\t5\n\
          {E24234}» {FFFFFF}Kamera\t5.000$\tN/A\n\
          {E24234}» {FFFFFF}Yangin Tüpü\t5.000$\tN/A\n\
          {E24234}» {FFFFFF}Termal Gözlük\t5.000$\tN/A\n\
          {E24234}» {FFFFFF}Gece Gorüs Gözlüðü\t5.000$\tN/A\n\
          {E24234}» {FFFFFF}Parasüt\t5.000$\tN/A\n\
          {E24234}» {FFFFFF}Sprey\t5.000$\tN/A\n");
          ShowPlayerDialog(playerid, 7779, DIALOG_STYLE_TABLIST_HEADERS, "{E24234}"DIALOG_BASLIK" -{FFFFFF} Shop Menu {E24234}- {FFFFFF} Can§Zirh Eklentileri", _str, "Tamam", "Iptal");

     return 1;
}

//==============================================================================
CMD:easypk(playerid, params[])                return TPlayer(playerid, "Easy Parkour", "easypk", 1786.7908,-1361.0017,16.4747, 0);
CMD:funnypk(playerid, params[])                return TPlayer(playerid, "Funny Parkour", "funnypk", 2122.4109,-971.3242,60.4361, 0);
CMD:upperpk(playerid, params[])           return TPlayer(playerid, "Upper Parkour", "upperpk", 2064.5703,-993.2061,54.3672, 0);
CMD:extremepk(playerid, params[])      return TPlayer(playerid, "Extreme Parkour", "extremepk", 3028.8201,-1926.1660,599.0370, 0);
CMD:hardpk(playerid, params[])           return TPlayer(playerid, "Hard Parkour", "hardpk", 2771.1284,-2744.3406,2460.0815, 90);
CMD:bigpk(playerid, params[])           return TPlayer(playerid, "Big Parkour", "bigpk", 1443.2714,-1704.5878,915.3906, 0);
CMD:oceanicpk(playerid, params[])       return TPlayer(playerid, "Oceanic Parkour", "oceanicpk", -2931.9619,-1876.4889,6.3728, 270);
CMD:monsterpk(playerid, params[])     return TPlayer(playerid, "Monster Parkour", "monsterpk", -2909.6707,71.3213,3.7526, 180);
CMD:lospk(playerid, params[])      return TPlayer(playerid, "Los Parkouros", "lospk", 2826.6699,195.6932,15.0085, 0);
//------------------------------------------------------------------------------
CMD:aa(playerid, params[])                return TPlayer(playerid, "Abandoned Airport", "aa", 404.8082, 2448.4775, 16.1368, 0);
CMD:s000(playerid, params[])           return TPlayer(playerid, "Stunt 000", "s000", -192.1480, -103.3305, 2.6739, 0);
CMD:stuntdam(playerid, params[])      return TPlayer(playerid, "Stunt Dam", "stuntdam", -527.418701, 2023.649047, 47.490310, 0);
CMD:lsair(playerid, params[])           return TPlayer(playerid, "Los Santos Airport", "lsair", 1857.1230,-2281.7593,17.0903, 90);
CMD:OStunt(playerid, params[])           return TPlayer(playerid, "o.O Stunt", "OStunt", 3267.1531, -2449.8621, 90.8472, 0);
CMD:lvair(playerid, params[])       return TPlayer(playerid, "Las Venturas Airport", "lvair", 1590.6398, 1448.2764, 13.3303, 270);
CMD:sfstunt(playerid, params[])     return TPlayer(playerid, "San Fierror Stunt", "sfstunt", -2633.8022, 1359.0215, 6.6751, 180);
CMD:cstunt(playerid, params[])      return TPlayer(playerid, "Cool Stunt", "cstunt", 1841.7723, -3129.0222, 71.7619, 0);
CMD:sfair(playerid, params[])       return TPlayer(playerid, "San Fierro Airport", "sfair", -1374.3136, -257.4903, 18.3436, 270);
//(playerid, params[])    return TPlayer(playerid, "Chilliad", "chilliad", -2335.8875, -1626.1935, 483.3552, 135);
CMD:superstunt(playerid, params[])  return TPlayer(playerid, "Super Stunt", "superstunt", 2410.961669,4172.320312,54.680434, 0);
CMD:tube2(playerid, params[])       return TPlayer(playerid, "Tube 2", "tube2", 834.037170, 269.238159, 709.190002, 0);
CMD:tube3(playerid, params[])       return TPlayer(playerid, "Tube 3", "tube3", 851.836975, -2246.758056, 662.570007, 0);
CMD:si(playerid, params[])          return TPlayer(playerid, "Skilled Inf", "si", -214.542678, -8175.392578, 35.225547, 0);
CMD:golf(playerid, params[])        return TPlayer(playerid, "Golf Stunt", "golf", 1413.6228, 2730.4304, 10.8703, 20);
CMD:basejump(playerid, params[])    return TPlayer(playerid, "BaseJump", "basejump", 756.989074, 472.495544, 4104.500488+1, 0) && GivePlayerWeapon(playerid, 46, 1);
CMD:bcar(playerid, params[])        return TPlayer(playerid, "Basket Car", "bcar", 3169.3699, -2002.6355, 230.2718, 0);
CMD:sfj(playerid, params[])         return TPlayer(playerid, "San Fierro Jump", "sfj", -1679.2316, 2022.1670, 1101.8691, 0);
CMD:jump1(playerid, params[])       return TPlayer(playerid, "Jump 1", "jump1", 1472.127807, -2420.677978, 320.834381+1, 0);
CMD:jump2(playerid, params[])       return TPlayer(playerid, "Jump 2", "jump2", -2443.958251, 3088.299316, 319.734375+1, 0);
CMD:jump3(playerid, params[])       return TPlayer(playerid, "Jump 3", "jump3", 2069.689697, -1407.287231, 309.634368+1, 0);
CMD:wjump(playerid, params[])       return TPlayer(playerid, "Water Jump", "wjump", 3028.043212, 275.029968, 981.875305+1, 90);
CMD:mpk1(playerid, params[])        return TPlayer(playerid, "Monster Parkour 1", "mpk1", 3643.2449, -1013.0157, 4321.4502, 90);
CMD:mpk2(playerid, params[])        return TPlayer(playerid, "Monster Parkour 2", "mpk2", -2906.0999, 71.2471, 4.4082, 90);
CMD:icerink(playerid, params[])     return komut_patinoar(playerid, params);
CMD:drag1(playerid, params[])       return TPlayer(playerid, "Drag Race 1", "drag1", -2064.302246, 1380.054321, 7.100666, 0);
CMD:drag2(playerid, params[])       return TPlayer(playerid, "Drag Race 2", "drag2", -1605.389770, 611.147949, 35.938957, 0);
CMD:drag3(playerid, params[])       return TPlayer(playerid, "Drag Race 3", "drag3", 2369.896972, 462.960327, 3.500000, 0);
CMD:canyon(playerid, params[])      return TPlayer(playerid, "Canyon Drift", "canyon", 3364.533447, -2926.035400, 87.998352, 270);
//CMD:drift(playerid, params[])       return TPlayer(playerid, "Drift", "drift", -276.953033, 1557.448364, 75.359375, 180);
//playerid, params[])      return TPlayer(playerid, "Drift 2", "drift2", -1112.4407, -1656.5459, 76.0283, 0);
//CMD:drift3(playerid, params[])      return TPlayer(playerid, "Drift 3", "drift3", -2394.7258, -588.6559, 132.3384, 0);
CMD:sdrift(playerid, params[])      return TPlayer(playerid, "Short Drift", "sdrift", 1616.7253, -1132.7117, 23.6333, 0);
CMD:island(playerid, params[])      return TPlayer(playerid, "Island", "island", 3945.581298, 395.880065, 2.205629, 0);
CMD:party1(playerid, params[])      return TPlayer(playerid, "Party 1", "party1", -697.819580, 302.428588, 22.327432, 0);
CMD:party2(playerid, params[])      return TPlayer(playerid, "Party 2", "party2", 1299.0125, -227.7760, 11.5673, 0);
CMD:party3(playerid, params[])      return TPlayer(playerid, "Party 3", "party3", -814.591247, -1934.805419, 7.097103, 0);
CMD:party4(playerid, params[])      return TPlayer(playerid, "Party 4", "party4", 1766.900146, 2788.385253, 10.675359, 0);
CMD:party5(playerid, params[])      return TPlayer(playerid, "Party 5", "party5", -1417.6086, -967.5665, 200.6878, 0);
CMD:ls(playerid, params[])          return TPlayer(playerid, "Los Santos", "ls", 1513.495605, -1653.823120, 13.539175, 270);
CMD:sf(playerid, params[])          return TPlayer(playerid, "San Fierro", "sf", -1973.711059, 287.046234, 35.171875, 90);
CMD:lv(playerid, params[])          return TPlayer(playerid, "Las Venturas", "lv", 2019.4670, 1545.3972, 10.8265, 0);
CMD:grov(playerid, params[])        return TPlayer(playerid, "Grove Street", "grov", 2499.548583, -1684.674194, 13.429053, 0);
CMD:beach(playerid, params[])       return TPlayer(playerid, "Plaja", "plaja", 456.5197, -1864.2231, 3.2939, 0);
CMD:spool(playerid, params[])       return TPlayer(playerid, "Swimming Pool", "spool", -1697.7128,1497.6692,7.2066, 180);
CMD:nrgrainbow(playerid, params[])  return TPlayer(playerid, "Nrg Rainbow", "nrgrainbow",  -4410.91748, 4204.43506, 185.76019, 180);
CMD:btbs(playerid, params[])  return TPlayer(playerid, "Beach Tubes", "btbs",  835.9879,-2033.3556,12.8672, 180);
CMD:fplace(playerid, params[])  return TPlayer(playerid, "Funky Place", "fplace",  4986.4243,4989.0107,6.2870, 180);
CMD:ljump(playerid, params[])  return TPlayer(playerid, "Long Jump", "ljump",  940.8323,1156.2191,1265.0350, 180);
CMD:rjump(playerid, params[])  return TPlayer(playerid, "Reverse Jump", "rjump",  3085.4121,-721.0496,2441.3245, 180);
CMD:dunejump(playerid, params[])  return TPlayer(playerid, "Duneride Jump", "dunejump",  2313.4958,-3251.8618,481.0679, 180);
CMD:tjump(playerid, params[])  return TPlayer(playerid, "Tunel Jump", "tjump",  872.3428,236.0634,587.7222, 180);
CMD:nrgjump(playerid, params[])  return TPlayer(playerid, "NRG-500 Jump", "nrgjump",  1846.6948,-3132.0681,71.7619, 180);
CMD:placejump(playerid, params[])  return TPlayer(playerid, "Place Jump", "placejump",  1481.3307,339.3671,6140.9702, 180);
CMD:pimps(playerid, params[])  return TPlayer(playerid, "Pimps", "pimps",  -2278.9509,2313.6541,5.1003, 180);
CMD:czmenu(playerid, params[])
{
         ShowPlayerDialog(playerid, 7778, DIALOG_STYLE_TABLIST_HEADERS, "{E24234}"DIALOG_BASLIK" -{FFFFFF} Shop Menu {E24234}- {FFFFFF} Can§Zirh Eklentileri", "\
          Ürün\tFiyat\tEklenti \n\
          {E24234}» {FFFFFF}Can\t{E24234}1.000$\t{E24234}FULL\n\
          {E24234}» {FFFFFF}Can\t{E24234}500$\t{E24234}+10\n\
          {E24234}» {FFFFFF}Zirh\t{E24234}2.000$\t{E24234}FULL\n\
          {E24234}» {FFFFFF}Zirh\t{E24234}1.000$\t{E24234}+10\n", "Tamam", "Iptal");

     return 1;
}
//------------------------------------------------------------------------------
// DM Zones:
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
stock TPlayer(playerid, telename[], telecmd[], Float:PosX, Float:PosY, Float:PosZ, Float:PFAngle)
{
	PosZ = PosZ + 0.1;
     #emit LOAD.S.pri telecmd
     #emit LOAD.S.pri telename
     new pVID = GetPlayerVehicleID(playerid), PState = GetPlayerState(playerid);
     //--------------------------------------------------------------------------
     if(IsPlayerInAnyVehicle(playerid) && PState == PLAYER_STATE_DRIVER)
     {
        SetVehiclePos(pVID, PosX, PosY, PosZ+0.1);
        SetVehicleZAngle(pVID, PFAngle);
        LinkVehicleToInterior(pVID, 0);
    }
    else if(!IsPlayerInAnyVehicle(playerid))
    {
        SetCameraBehindPlayer(playerid);
        SetPlayerPos(playerid, PosX, PosY, PosZ+0.1);
        SetPlayerFacingAngle(playerid, PFAngle);
        SetPlayerInterior(playerid, 0);
    }
     //--------------------------------------------------------------------------
     return 1;
}

stock ticketOku(playerid, ticketid)
{
	new string[390], baslik[24], yazi[566], yanit[566], yanitlayan[24];
	format(string, sizeof(string), "SELECT * FROM ticketlar WHERE id = %d", ticketid);
    mysql_query(string);
    mysql_store_result();
    if(!(mysql_num_rows() > 0)) return Hatamesaj(playerid, "Secmis oldugunuz ticket dondurulmus yada size ait degil.", "You haven't ticket.");
    while(mysql_retrieve_row())
	{
    	mysql_fetch_field_row(baslik, "baslik");
    	mysql_fetch_field_row(yazi, "yazi");
    	mysql_fetch_field_row(yanit, "yanit");
    	mysql_fetch_field_row(yanitlayan, "yanitlayan");
    }
    format(string, sizeof(string), "{FFFFFF}Veritabanimizda %d. sirada olan ticketi okumaktasiniz.\n\n\t\tBaþlik: {00FF00}%s\n\t\t{FFFFFF}Yazi: {00FF00}%s\n\t\t{FFFFFF}Yanitlayan Yonetici: {00FF00}%s\n\t\t{FFFFFF}Yanit: {00FF00}%s\n{FFFFFF}Bir sikayetiniz varsa yeni ticket olusturun ve ticket id'i unutmayin.",
    ticketid,
    baslik,
    yazi,
    yanitlayan,
    yanit);
    ShowPlayerDialog(playerid, 1141, DIALOG_STYLE_MSGBOX,"{E24234}"DIALOG_BASLIK"{FFFFFF} - Ticketlarim - Oku", string, "SIL!", "Geri");
    SetPVarInt(playerid, "SilinecekID", ticketid);
	return 1;
}
CMD:sarki(playerid, params[])
{
	return komut_dinle(playerid, params);
}
CMD:sarkilistemc(playerid, params[])
{
//	Bilgimesaj(playerid, "Ticketin numarasini alin, /tyanitla komutuna girin oyle cevaplayabilirsiniz.", "Ticketin numarasini alin, /tyanitla komutuna girin oyle cevaplayabilirsiniz.");
    new string[5126], stringq[199], count[4], ticketdurumd[50], ticketdurumc[50], yazi[256];
	for(new x; x < 500; x++)
	{
	    format(stringq, sizeof(stringq), "SELECT * FROM sarkilar WHERE id = %d", x);
	    mysql_query(stringq);
	    mysql_store_result();
	    if(!(mysql_num_rows() > 0)) continue;
	    while(mysql_retrieve_row())
		{
	    	mysql_fetch_field_row(count, "id");
	    	mysql_fetch_field_row(ticketdurumd, "sarkiadi");
	    	mysql_fetch_field_row(ticketdurumc, "dakika");
	    	mysql_fetch_field_row(yazi, "dakika");
			format(string, sizeof(string), "%s{FFFFFF}%s-) %s - %s\n", string, count, ticketdurumc, ticketdurumd,yazi);
		}
	}
    ShowPlayerDialog(playerid, 556, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Þarkilar", string, "Tamam", "");
    print(string);
	return 1;
}
CMD:sarkidinle(playerid, params[])
{
	return komut_dinle(playerid, params);
}
CMD:durdur(playerid, params[])
{
	StopAudioStreamForPlayer(playerid);
	return 1;
}

CMD:sustur(playerid, params[])
{
	StopAudioStreamForPlayer(playerid);
	return 1;
}
CMD:muzikdurdur(playerid, params[])
{
	StopAudioStreamForPlayer(playerid);
	return 1;
}
CMD:dinlet(playerid, params[])
{
	new string[128], message[100];
 	if(sscanf(params, "s[128]", string)) return Kullanimmesaj(playerid, "dinlet [url]", "dinlet [url]");
	if (PlayerInfo[playerid][DJ] > 1 || PlayerInfo[playerid][Level] > 2)
	{
		for(new x; x < GetMaxPlayers(); x++)
		{
		    PlayAudioStreamForPlayer(x, string);
			format (message, sizeof(message), "DJ {E24234}%s{FFFFFF} bir þarký baþlattý!", getName(playerid));
		    Bilgimesaj(x, message, message);
		}
	}
	else
	{
		HataMesaji(playerid, "Yetkiniz yeterli deðil.");
	}
	return 1;
}
CMD:sarkilar(playerid, params[]) return komut_dinle(playerid, " ");
CMD:dinle(playerid, params[])
{
	ShowPlayerDialog(playerid, 555, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Þarkilar", "{E24234}» {FFFFFF}Þarký Ara\n{E24234}» {FFFFFF}Þarkýlar\n{E24234}» {FFFFFF}Radyolar", "Seç","Kapat");
	return 1;
}
CMD:radyolar(playerid, params[]) return komut_radyo(playerid, " ");
CMD:radyo(playerid, params[])
{
	ShowPlayerDialog(playerid, 552, DIALOG_STYLE_LIST, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Radyo", "\
	{E24234}» {FFFFFF}Show Radyo\n\
	{E24234}» {FFFFFF}Best FM\n\
	{E24234}» {FFFFFF}Radyo Fenomen\n\
	{E24234}» {FFFFFF}Power Türk\n\
	{E24234}» {FFFFFF}Kral FM\n\
	{E24234}» {FFFFFF}Metro FM\n\
	", "Seç","Kapat");
	return 1;
}
CMD:aramakasdf(playerid, params[])
{
	ShowPlayerDialog(playerid, 133, DIALOG_STYLE_INPUT, "{E24234}"DIALOG_BASLIK"{FFFFFF} - Þarkilar - Arama", "{FFFFFF}Dinleyeceginiz þarkinin adinda geçen kelime yada harfleri düzgünce yazin;", "Ara","Kapat");
	return 1;
}

CMD:tdmgit(playerid, params[])
{
	#if defined TDMPASIF
 	CloseselectioanMenu(playerid);
	CancelSelectTextDraw(playerid);
	SetPVarInt(playerid, "vspawner_active", 0);

	if(zombieKatilim != true && zombieBasladi == true) return SendClientMessage(playerid, -1, "{C9404E}<(Bilgi)>{FFFFFF} Aktif zombiler ve insanlar savaþýnýn bitmesini bekleyin."), PlayerPlaySound(playerid, 1083, 0,0,0);
	if(zombieBasladi != true)
	{
		Bilgimesaj(playerid, "Su an katilacak bir TDM yok!", "TDM is not started.");
	}
	else
	{
		if(zombieMap == 0)
			ShowPlayerDialog(playerid, 9950, DIALOG_STYLE_LIST, "{C9404E}[Z]ero {FFFFFF}- Zombi/Ýnsanlar", "{C9404E}»{FFFFFF} Zombiler\t\t{C9404E}[AKTIF]\n{00FF66}»{FFFFFF} Ýnsanlar\t\t{00FF66}[AKTIF]\n{C9404E}»{FFFFFF} Elit Ýnsanlar\t\t{C9404E}[AKTIF]", "Tamam", "Ýptal");
		if(zombieMap == 1)
			ShowPlayerDialog(playerid, 9950, DIALOG_STYLE_LIST, "{C9404E}[Z]ero {FFFFFF}- FBI/Mafya", "{C9404E}»{FFFFFF} FBI\t\t{C9404E}[AKTIF]\n{00FF66}»{FFFFFF} Mafya\t\t{00FF66}[AKTIF]", "Tamam", "Ýptal");
	}
	#else
		Bilgimesaj(playerid, "Su an katilacak bir TDM yok!", "TDM is not started.");
	#endif
	return 1;
}
