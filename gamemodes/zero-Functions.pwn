

CreateBoostPickup(id, Float: piX, Float: piY, Float: piZ)
{
	Boost[id] = CreatePickup(1254, 14, piX, piY, piZ);
}

stock DeleteObjects(playerid)
{
	RemoveBuildingForPlayer(playerid, 5535, 1918.8516, -1776.3281, 16.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 1910.1641, -1779.6641, 18.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, 1904.0703, -1797.5313, 12.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 5681, 1921.4844, -1778.9141, 18.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 5409, 1918.8516, -1776.3281, 16.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 1676, 1941.6563, -1778.4531, 14.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 1676, 1941.6563, -1774.3125, 14.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 955, 1928.7344, -1772.4453, 12.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1676, 1941.6563, -1771.3438, 14.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 1676, 1941.6563, -1767.2891, 14.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, 1949.8750, -1798.2031, 12.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1955.6641, -1793.0938, 16.3906, 0.25);
	return 1;
}
forward SetPlayerDMSpawn(playerid); //MG1
new Float:DMRandomSpawns[4][3] = {
{977.5675,2306.1077,11.4609},
{984.1692,2311.0964,11.4609},
{973.0589,2316.3159,11.4609},
{986.7195,2325.2646,11.4609}
};
//------------------------------------------------------------------------------
forward SetPlayerDMSpawn1(playerid); // Mg2
new Float:DMRandomSpawns1[6][3] = {
{2218.3000,1615.1300,999.9827},
{2176.3562,1625.3459,999.9714},
{2219.9700,1566.6801,1001.2764},
{2188.0300,1578.4500,999.9680},
{2182.2371,1592.2139,999.9789},
{2205.7495,1580.5636,999.9791}
};
//------------------------------------------------------------------------------
forward SetPlayerDMSpawn2(playerid); //Rocket
new Float:DMRandomSpawns2[8][3] = {
{-651.2111,2102.5742,75.5539},
{-651.1140,2145.9756,75.5606},
{-781.2228,2097.1052,75.6219},
{-781.2612,2140.2732,75.5837},
{-755.1909,2039.2512,77.8984},
{-833.0229,2003.4594,77.0000},
{-674.6271,2042.0963,77.8939},
{-596.2531,2014.8854,77.0000}
};
//------------------------------------------------------------------------------
public SetPlayerDMSpawn(playerid){ //mg1
SetPlayerVirtualWorld(playerid, 4000);
new rand = random(sizeof(DMRandomSpawns));
SetPlayerPos(playerid, DMRandomSpawns[rand][0], DMRandomSpawns[rand][1], DMRandomSpawns[rand][2]);
return 1;}
//------------------------------------------------------------------------------
public SetPlayerDMSpawn1(playerid){ //mg2
SetPlayerInterior(playerid,1);
SetPlayerVirtualWorld(playerid, 4000);
new rand = random(sizeof(DMRandomSpawns1));
SetPlayerPos(playerid, DMRandomSpawns1[rand][0], DMRandomSpawns1[rand][1], DMRandomSpawns1[rand][2]);
return 1;}
public SetPlayerDMSpawn2(playerid){ //rocket
SetPlayerVirtualWorld(playerid, 4000);
new rand = random(sizeof(DMRandomSpawns2));
SetPlayerPos(playerid, DMRandomSpawns2[rand][0], DMRandomSpawns2[rand][1], DMRandomSpawns2[rand][2]);
return 1;}

TotalGameTime(playerid, &h=0, &m=0, &s=0)
{
    PlayerInfo[playerid][TotalTime] = ( (gettime() - PlayerInfo[playerid][ConnectTime]) + (PlayerInfo[playerid][phours]*60*60) + (PlayerInfo[playerid][pmins]*60) + (PlayerInfo[playerid][psecs]) );

    h = floatround(PlayerInfo[playerid][TotalTime] / 3600, floatround_floor);
    m = floatround(PlayerInfo[playerid][TotalTime] / 60,   floatround_floor) % 60;
    s = floatround(PlayerInfo[playerid][TotalTime] % 60,   floatround_floor);

    return PlayerInfo[playerid][TotalTime];
}

forward CeteOlustur(playerid, ceteadd[], ceterenk);
public CeteOlustur(playerid, ceteadd[], ceterenk)
{
	new cetead[16];
	new Query[1024],savingstring[256];
	format(cetead, sizeof(cetead), "%s", ceteadd);
	mysql_real_escape_string(cetead, cetead);
	format(Query, sizeof(Query), "SELECT * FROM `klanlar` WHERE `name` = '%s'", cetead);
	mysql_query(Query);
	mysql_store_result();
	if(mysql_num_rows() > 0){
	    HataMesaji(playerid, "Çeteniz oluþturulamadý, ismi kullanýlýyor olabilir.");
	    return 1;
	}
	mysql_free_result();
	format(Query, sizeof(Query), "INSERT INTO `klanlar` (`name`,`color`,`leader`) VALUES ('%s','%d','%s')",cetead, ceterenk, getName(playerid));
	mysql_query(Query);
	mysql_free_result();
	format(Query, sizeof(Query), "SELECT * FROM `klanlar` WHERE `name` = '%s'", cetead);
	mysql_query(Query);
	mysql_store_result();
	if(mysql_num_rows() > 0){
 	if(mysql_fetch_row(Query)){
 	mysql_fetch_field_row(savingstring, "id");PlayerInfo[playerid][Cete] = strval(savingstring);
 	}
	}
	mysql_free_result();
    INmessage(playerid,"Çeteniz oluþturulmuþtur, {E24234}' /clan '{FFFFFF} veya {E24234}' /cete '{FFFFFF} ile yönetebilirsiniz.");
	return 1;
}
stock Comma(numbers) //by Gamer931215
{
	new temp[24],counter = -1;
	valstr(temp,numbers);
	for(new i = strlen(temp);i > 0; i--)
	{
	    counter++;
		if(counter == 3)
		{
		    strins(temp,",",i);
		    counter = 0;
		}
	}
	return temp;
}
/*enum enumsa
{
	names[25]
}
new komutlarx[277][enumsa] =
{
	{"/cete"},
	{"/klan"},
	{"/reklamver"},
	{"/bank"},
	{"/email"},
	{"/fiyatlistesi"},
	{"/omenu"},
	{"/yaninagit"},
	{"/stopmusic"},
	{"/smusic"},
	{"/mkapat"},
	{"/msustur"},
	{"/sarkikapat"},
	{"/cz"},
	{"/franetec"},
	{"/performans"},
	{"/ncolors"},
	{"/l"},
	{"/local"},
	{"/para"},
	{"/parasut"},
	{"/parachute"},
	{"/rocketman"},
	{"/jetpack"},
	{"/yapimci"},
	{"/yapimcilar"},
	{"/credits"},
	{"/tdmbaslat"},
	{"/ddbaslat"},
	{"/hakkimizda"},
	{"/about"},
	{"/ddgit"},
	{"/level1"},
	{"/level2"},
	{"/level3"},
	{"/level4"},
	{"/level5"},
	{"/level6"},
	{"/level7"},
	{"/level8"},
	{"/level9"},
	{"/level10"},
	{"/setstat"},
	{"/rapor"},
	{"/paragonder"},
	{"/skorgonder"},
	{"/mystyle"},
	{"/ticketyardim"},
	{"/createticket"},
	{"/ticketolustur"},
	{"/ticket"},
	{"/sarkiekle"},
	{"/tyanitla"},
	{"/ticketyanitla"},
	{"/topscore"},
	{"/topmoney"},
	{"/topkill"},
	{"/toponline"},
	{"/toponline"},
	{"/topscore"},
	{"/topmoney"},
	{"/topkill"},
	{"/topkills"},
	{"/topderby"},
	{"/topfallout"},
	{"/topyaris"},
	{"/toprace"},
	{"/topracer"},
	{"/topsavas"},
	{"/toptdm"},
	{"/topwars"},
	{"/flip"},
	{"/kilit"},
	{"/lockcar"},
	{"/lock"},
	{"/cevir"},
	{"/kayit"},
	{"/myskin"},
	{"/myweather"},
	{"/mytime"},
	{"/vcolor"},
	{"/color"},
	{"/arenk"},
	{"/renk"},
	{"/loto"},
	{"/lotto"},
	{"/kill"},
	{"/geber"},
	{"/mycar"},
	{"/car"},
	{"/veh"},
	{"/pmackapat"},
	{"/teleackapat"},
	{"/om"},
	{"/pm"},
	{"/modifiye"},
	{"/tune"},
	{"/pmkapatac"},
	{"/changenick"},
	{"/sifredegis"},
	{"/mypass"},
	{"/changepass"},
	{"/nickdegis"},
	{"/telekapatac"},
	{"/teleac"},
	{"/telekapat"},
	{"/plaka"},
	{"/lazer"},
	{"/can"},
	{"/zirh"},
	{"/dovusstil"},
	{"/neon"},
	{"/duello"},
	{"/pdm"},
	{"/patinoar"},
	{"/eiffel"},
	{"/lift1up"},
	{"/lift1down"},
	{"/lift2up"},
	{"/lift2down"},
	{"/lift3up"},
	{"/lift3down"},
	{"/maze"},
	{"/language"},
	{"/teles"},
	{"/parkours"},
	{"/stunts"},
	{"/jumps"},
	{"/dm"},
	{"/dd"},
	{"/fz"},
	{"/others"},
	{"/sss"},
	{"/minigun2"},
	{"/minigun"},
	{"/kdm"},
	{"/mg2"},
	{"/jdm"},
	{"/yetenekler"},
	{"/rules"},
	{"/shop"},
	{"/animasyonlar"},
	{"/animdurdur"},
	{"/ellerhavaya"},
	{"/sarhos"},
	{"/bomba"},
	{"/ates"},
	{"/gul"},
	{"/dgozetle"},
	{"/hirsizlik"},
	{"/31"},
	{"/31bitis"},
	{"/yakalandin"},
	{"/vururum"},
	{"/vuruldum"},
	{"/saplakyedim"},
	{"/saplakat"},
	{"/sigara"},
	{"/sigara2"},
	{"/elsalla"},
	{"/bak"},
	{"/uzan"},
	{"/otur"},
	{"/yemek"},
	{"/kus"},
	{"/ol"},
	{"/anlas"},
	{"/op"},
	{"/emrah"},
	{"/nevarlan"},
	{"/ise"},
	{"/dans1"},
	{"/dans2"},
	{"/dans3"},
	{"/dans4"},
	{"/sex1"},
	{"/sex2"},
	{"/sex3"},
	{"/sex4"},
	{"/sex5"},
	{"/sex6"},
	{"/bira"},
	{"/sprunk"},
	{"/m1"},
	{"/m2"},
	{"/m3"},
	{"/m4"},
	{"/m5"},
	{"/m6"},
	{"/m7"},
	{"/m8"},
	{"/m9"},
	{"/m10"},
	{"/m11"},
	{"/m12"},
	{"/m13"},
	{"/m14"},
	{"/m15"},
	{"/m16"},
	{"/m17"},
	{"/m18"},
	{"/m19"},
	{"/m20"},
	{"/silahlar"},
	{"/easypk"},
	{"/funnypk"},
 	{"/upperpk"},
	{"/extremepk"},
	{"/hardpk"},
	{"/bigpk"},
	{"/oceanicpk"},
	{"/monsterpk"},
	{"/lospk"},
	{"/aa"},
	{"/stuntdam"},
	{"/lsair"},
	{"/OStunt"},
	{"/lvair"},
	{"/sfstunt"},
	{"/cstunt"},
	{"/sfair"},
	{"/superstunt"},
	{"/tube2"},
	{"/tube3"},
	{"/si"},
	{"/golf"},
	{"/basejump"},
	{"/bcar"},
	{"/sfj"},
	{"/jump1"},
	{"/jump2"},
	{"/jump3"},
	{"/wjump"},
	{"/mpk1"},
	{"/mpk2"},
	{"/icerink"},
	{"/drag1"},
	{"/drag2"},
	{"/drag3"},
	{"/canyon"},
	{"/drift"},
	{"/drift3"},
	{"/sdrift"},
	{"/island"},
	{"/party1"},
	{"/party2"},
	{"/party3"},
	{"/party4"},
	{"/party5"},
	{"/ls"},
	{"/sf"},
	{"/lv"},
	{"/grov"},
	{"/beach"},
	{"/spool"},
	{"/nrgrainbow"},
	{"/btbs"},
	{"/fplace"},
	{"/ljump"},
	{"/rjump"},
	{"/dunejump"},
	{"/tjump"},
	{"/nrgjump"},
	{"/placejump"},
	{"/pimps"},
	{"/czmenu"},
	{"/gdm"},
	{"/sdm"},
	{"/sniper"},
	{"/1hp"},
	{"/mg"},
	{"/sarki"},
	{"/sarkilistemc"},
	{"/sarkidinle"},
	{"/dinlet"},
	{"/dinle"},
	{"/tdmgit"}
};

stock yakinKomutuBul(komut[])
{
     new cmdname[15], iptal, komut1[2], komut2[2];
     format(komut1, sizeof(komut1), "%s", komut);
     for(new x; x < sizeof(komutlarx); x++)
     {
  	     format(komut2, sizeof(komut2), "%s", komutlarx[x][names]);
		 if (!strcmp(komut1, komut2))
		 {
			format(cmdname, sizeof(cmdname), "%s", komutlarx[x][names]);
			iptal=1;
		 }
		 if(iptal==1) break;
	 }
	 return cmdname;
}
stock yakinKomutuBul2(komut[])
{
     new cmdname[15], iptal;
     for(new x; x < sizeof(komutlarx); x++)
     {
		 if (!strcmp(komut, komutlarx[x][names], false, 1))
		 {
			format(cmdname, sizeof(cmdname), "%s", komutlarx[x][names]);
			iptal=1;
		 }
		 if(iptal==1) break;
	 }
	 return cmdname;
}*/
stock LevenshteinDistance(str1[], str2[])
{
        new strlen1 = strlen(str1), strlen2 = strlen(str2);

        if (strlen1 > 32 || strlen2 > 32)
            return -1; // can't handle strings this size

        new d[33][33] =
        {
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
        };

        for (new i = 0; i < strlen1; i++)
                d[i][0] = i;

        for (new i = 0; i < strlen2; i++)
                d[0][i] = i;

        new cost = 0, i2 = 1, j2 = 1;
        for (i2 = 1; i2 < strlen1; i2++)
                for (j2 = 1; j2 < strlen2; j2++)
                {
                if (str1[i2-1] == str2[j2-1])
                                cost = 0;
                else
                                cost = 1;

                        new delcost = d[i2-1][j2] + 1;
                        new inscost = d[i2][j2-1] + 1;
                        new subcost = d[i2-1][j2-1] + cost;

                        if (delcost < inscost && delcost < subcost)
                            d[i2][j2] = delcost;
                        else if (inscost < delcost && inscost < subcost)
                            d[i2][j2] = inscost;
                        else
                            d[i2][j2] = subcost;
       }

        return d[i2-1][j2-1];
}
stock MekanlariYukle()
{
CreateDynamicObject(5706, 1762.72900, 62.13300, 32.38400, 0.00000, 0.00000, 80.75000);
CreateDynamicObject(13752, 1676.48401, 86.50300, 12.22500, 0.00000, 0.00000, 170.00000);
CreateDynamicObject(9193, 1624.89600, 85.09000, 41.00900, 0.00000, 0.00000, 72.25000);
CreateDynamicObject(1422, 1625.61096, 90.31100, 36.76800, 0.00000, 0.00000, 52.75000);
CreateDynamicObject(3865, 1649.72900, 88.03900, 39.70800, 0.00000, 0.00000, 260.00000);
CreateDynamicObject(3567, 1645.59802, 88.88200, 37.14300, 0.00000, 0.00000, 260.00000);
CreateDynamicObject(3865, 1631.00403, 89.43100, 38.00800, 0.00000, 0.00000, 95.99854);
CreateDynamicObject(738, 1726.68701, 60.23300, 36.25400, 0.00000, 0.00000, 351.00000);
CreateDynamicObject(3504, 1773.81799, 75.71400, 37.54700, 0.00000, 0.00000, 80.25000);
CreateDynamicObject(19362, 1630.50098, 87.17800, 34.76800, 0.00000, 0.50000, 26.49997);
CreateDynamicObject(19362, 1629.09302, 90.03400, 34.51400, 0.00000, 0.00000, 26.25000);
CreateDynamicObject(19362, 1627.68994, 92.86900, 34.51400, 0.00000, 0.00000, 26.24634);
CreateDynamicObject(19362, 1624.77600, 101.01300, 34.76400, 0.00000, 359.75000, 350.25000);
CreateDynamicObject(1422, 1624.19800, 87.27900, 36.76800, 0.00000, 0.00000, 79.99695);
CreateDynamicObject(1422, 1633.57397, 92.32500, 36.67600, 0.00000, 0.00000, 4.24536);
CreateDynamicObject(1422, 1629.61804, 91.97100, 36.67600, 0.00000, 0.00000, 7.49377);
CreateDynamicObject(1422, 1637.54700, 92.22100, 36.67600, 0.00000, 0.00000, 351.49072);
CreateDynamicObject(1422, 1641.80701, 91.52100, 36.67600, 0.00000, 0.00000, 351.48560);
CreateDynamicObject(1422, 1645.92004, 90.84900, 36.67600, 0.00000, 0.00000, 350.23560);
CreateDynamicObject(1422, 1657.11401, 86.28800, 36.67600, 0.00000, 0.00000, 123.23315);
CreateDynamicObject(1422, 1650.06152, 90.09277, 36.67600, 0.00000, 0.00000, 350.23315);
CreateDynamicObject(1422, 1654.31104, 88.95800, 36.67600, 0.00000, 0.00000, 335.48315);
CreateDynamicObject(5706, 1740.18555, 65.76367, 32.43400, 0.00000, 0.00000, 80.75000);
CreateDynamicObject(10789, 1757.49597, 62.70900, 38.74900, 0.00000, 0.00000, 260.65002);
CreateDynamicObject(19377, 1770.56897, 50.91000, 36.09300, 0.00000, 0.00000, 350.75000);
CreateDynamicObject(19377, 1772.11707, 60.41500, 36.09300, 0.00000, 0.00000, 350.74951);
CreateDynamicObject(19377, 1773.64099, 69.75600, 36.09300, 0.00000, 0.00000, 350.74951);
CreateDynamicObject(996, 1740.18896, 82.42600, 36.70300, 0.00000, 0.00000, 350.75000);
CreateDynamicObject(996, 1730.86035, 83.96777, 36.70300, 0.00000, 0.00000, 350.74951);
CreateDynamicObject(996, 1743.79504, 48.51600, 36.70300, 0.00000, 0.24719, 350.99670);
CreateDynamicObject(996, 1759.31641, 79.37695, 36.70300, 0.00000, 0.24719, 350.74951);
CreateDynamicObject(994, 1762.16101, 45.59200, 36.03300, 0.00000, 0.00000, 350.74951);
CreateDynamicObject(997, 1769.94299, 47.54400, 36.03300, 0.00000, 0.00000, 261.00000);
CreateDynamicObject(996, 1725.38599, 51.50800, 36.70300, 0.00000, 0.00000, 350.74951);
CreateDynamicObject(996, 1734.76294, 49.99400, 36.70300, 0.00000, 0.00000, 350.75000);
CreateDynamicObject(996, 1749.77148, 80.89355, 36.70300, 0.00000, 0.24719, 350.99670);
CreateDynamicObject(996, 1753.37695, 47.02000, 36.70300, 0.00000, 0.24719, 350.74951);
CreateDynamicObject(994, 1767.96582, 77.93457, 36.03300, 0.00000, 0.00000, 350.74951);
CreateDynamicObject(997, 1774.79688, 76.87695, 36.03300, 0.00000, 0.00000, 260.99670);
CreateDynamicObject(996, 1725.89795, 59.21600, 36.70300, 0.00000, 0.00000, 260.75000);
CreateDynamicObject(996, 1727.36206, 68.18100, 36.70300, 0.00000, 0.00000, 260.74951);
CreateDynamicObject(738, 1728.20105, 69.55500, 36.25400, 0.00000, 0.00000, 350.99670);
CreateDynamicObject(738, 1730.42297, 83.24300, 36.25400, 0.00000, 0.00000, 350.99670);
CreateDynamicObject(738, 1738.80200, 82.09700, 36.25400, 0.00000, 0.00000, 350.99670);
CreateDynamicObject(738, 1725.35254, 52.15137, 36.25400, 0.00000, 0.00000, 350.99670);
CreateDynamicObject(738, 1733.56934, 50.96582, 36.25400, 0.00000, 0.00000, 350.99670);
CreateDynamicObject(1676, 1745.71997, 60.78300, 37.91600, 0.00000, 0.00000, 80.75000);
CreateDynamicObject(1676, 1746.84900, 68.29300, 37.91600, 0.00000, 0.00000, 80.74951);
CreateDynamicObject(1676, 1756.11401, 66.79000, 37.91600, 0.00000, 0.00000, 80.74951);
CreateDynamicObject(1676, 1754.80005, 59.10300, 37.91600, 0.00000, 0.00000, 80.74951);
CreateDynamicObject(19425, 1728.72705, 78.97600, 36.26400, 0.00000, 0.00000, 260.75000);
CreateDynamicObject(19425, 1728.01953, 74.58398, 36.26400, 0.00000, 0.00000, 260.74951);
CreateDynamicObject(3529, 1632.97998, 86.14500, 35.75300, 0.00000, 270.00000, 349.99817);
CreateDynamicObject(3529, 1632.43005, 87.39900, 35.75300, 0.00000, 270.00000, 349.99695);
CreateDynamicObject(3529, 1631.36401, 89.49200, 35.55300, 0.00000, 270.00000, 349.99692);
CreateDynamicObject(3529, 1630.81494, 90.58000, 35.55300, 0.00000, 270.00000, 349.99695);
CreateDynamicObject(1226, 1722.62500, 83.06300, 40.19600, 0.00000, 0.00000, 78.50000);
CreateDynamicObject(1226, 1703.28699, 86.56300, 40.19600, 0.00000, 0.00000, 78.49731);
CreateDynamicObject(1226, 1658.50195, 94.35200, 40.19600, 0.00000, 0.00000, 78.49731);
CreateDynamicObject(1226, 1629.38904, 99.44500, 40.19600, 0.00000, 0.00000, 78.49731);
CreateDynamicObject(1226, 1642.65295, 85.98500, 40.19600, 0.00000, 0.00000, 258.49734);
CreateDynamicObject(1226, 1679.97205, 79.46200, 40.19600, 0.00000, 0.00000, 258.49731);
CreateDynamicObject(1226, 1703.65405, 75.31600, 40.19600, 0.00000, 0.00000, 258.49731);
CreateDynamicObject(1226, 1722.86902, 71.93100, 40.19600, 0.00000, 0.00000, 258.49731);
CreateDynamicObject(1223, 1754.14502, 55.28900, 34.90400, 0.00000, 0.00000, 260.00000);
CreateDynamicObject(1223, 1745.02100, 56.79700, 34.90400, 0.00000, 0.00000, 259.99695);
CreateDynamicObject(1223, 1762.49902, 47.63700, 34.90400, 0.00000, 0.00000, 169.74689);
CreateDynamicObject(1223, 1747.51465, 72.27051, 34.90400, 0.00000, 0.00000, 81.99646);
CreateDynamicObject(1223, 1756.72266, 70.78418, 34.90400, 0.00000, 0.00000, 81.99646);
CreateDynamicObject(1223, 1767.01563, 75.27344, 34.90400, 0.00000, 0.00000, 171.99646);
//benzinlik yuhkardaki
CreateDynamicObject(13816, 2883.9521484375, -1951.6357421875, 7.7612962722778, 0, 0, 90);
CreateDynamicObject(642, 2901.9680175781, -1951.9155273438, 11.553796768188, 0, 0, 0);
CreateDynamicObject(1215, 2903.1591796875, -1967.5517578125, 10.694890975952, 0, 0, 0);
CreateDynamicObject(2406, 2900.5310058594, -1945.7279052734, 11.455825805664, 0, 0, 0);
CreateDynamicObject(1643, 2885.185546875, -1953.1618652344, 10.130567550659, 0, 0, 48);
CreateDynamicObject(1598, 2887.0393066406, -1957.4340820313, 10.435567855835, 0, 0, 0);
CreateDynamicObject(1692, 2899.9780273438, -1941.3822021484, 15.285704612732, 0, 0, 0);
CreateDynamicObject(1692, 2881.4619140625, -1941.4193115234, 15.296304702759, 0, 0, 0);
CreateDynamicObject(1536, 2873.3908691406, -1951.9829101563, 10.130574226379, 0, 0, 270);
CreateDynamicObject(1536, 2873.4436035156, -1954.9970703125, 10.130574226379, 0, 0, 90.449981689453);
CreateDynamicObject(10184, 2874.8217773438, -1973.0665283203, 7.5743656158447, 0, 0, 90);
CreateDynamicObject(10184, 2894.7861328125, -1967.5908203125, 7.3159437179565, 0, 0, 90);
CreateDynamicObject(10184, 2894.771484375, -1967.6118164063, 2.7404651641846, 0, 0, 90);
CreateDynamicObject(10184, 2903.1306152344, -1959.2508544922, 7.5770606994629, 0, 0, 180);
CreateDynamicObject(10184, 2903.1452636719, -1959.3023681641, 2.9863398075104, 0, 0, 179.99450683594);
CreateDynamicObject(10184, 2894.7307128906, -1947.4814453125, 7.5836906433105, 0, 0, 270.01489257813);
CreateDynamicObject(10184, 2894.7783203125, -1947.4692382813, 3.3204455375671, 0, 0, 270.01098632813);
CreateDynamicObject(10184, 2903.1491699219, -1955.802734375, 3.5369970798492, 0, 0, 179.99450683594);
CreateDynamicObject(10184, 2903.1457519531, -1955.7886962891, 7.4608082771301, 0, 0, 179.99450683594);
CreateDynamicObject(10184, 2884.3310546875, -1967.5771484375, 7.4118528366089, 0, 0, 90);
CreateDynamicObject(10184, 2883.1496582031, -1964.7456054688, 7.5352754592896, 0, 0, 179.99450683594);
CreateDynamicObject(10184, 2881.75390625, -1947.4904785156, 7.2759099006653, 0, 0, 270.01098632813);
CreateDynamicObject(1215, 2883.1892089844, -1968.0378417969, 10.726249694824, 0, 0, 0);
CreateDynamicObject(1215, 2882.8679199219, -1972.8660888672, 10.694896697998, 0, 0, 0);
CreateDynamicObject(1215, 2873.2409667969, -1973.0404052734, 10.694897651672, 0, 0, 0);
CreateDynamicObject(1215, 2873.1196289063, -1928.4554443359, 10.672689437866, 0, 0, 0);
CreateDynamicObject(1215, 2910.1640625, -1947.5629882813, 10.694895744324, 0, 0, 0);
CreateDynamicObject(1215, 2910.171875, -1935.8681640625, 10.697998046875, 0, 0, 0);
CreateDynamicObject(1215, 2910.1911621094, -1940.8107910156, 10.697998046875, 0, 0, 0);
CreateDynamicObject(1215, 2903.1618652344, -1947.9311523438, 10.694890975952, 0, 0, 0);
CreateDynamicObject(1215, 2903.162109375, -1954.0561523438, 10.694890975952, 0, 0, 0);
CreateDynamicObject(1215, 2903.1689453125, -1960.8004150391, 10.694890975952, 0, 0, 0);
CreateDynamicObject(1215, 2892.8801269531, -1967.6088867188, 10.694890975952, 0, 0, 0);
CreateDynamicObject(1643, 2885.0419921875, -1958.0063476563, 10.130567550659, 0, 0, 47.999267578125);
CreateDynamicObject(16500, 2873.54296875, -1930.9189453125, 12.027318000793, 0, 0, 0);
CreateDynamicObject(880, 2907.2075195313, -1944.5594482422, 0.79807060956955, 0, 0, 242);
CreateDynamicObject(880, 2909.7524414063, -1936.4901123047, 0.50846326351166, 0, 0, 153.99584960938);
CreateDynamicObject(4206, 2890.4033203125, -1955.1069335938, 9.8414268493652, 0, 0, 0);
CreateDynamicObject(1255, 2900.6105957031, -1951.9995117188, 10.704464912415, 0, 0, 234);
CreateDynamicObject(2233, 2883.5734863281, -1945.482421875, 10.130572319031, 0, 0, 58);
CreateDynamicObject(2233, 2898.8068847656, -1945.5830078125, 10.130572319031, 0, 0, 357.99682617188);
CreateDynamicObject(2233, 2883.1105957031, -1965.2436523438, 10.130567550659, 0, 0, 117.99499511719);
CreateDynamicObject(749, 2883.0173339844, -1928.5537109375, 3.9331588745117, 0, 0, 0);
CreateDynamicObject(749, 2881.5417480469, -1927.6677246094, 4.2546582221985, 0, 0, 34);
CreateDynamicObject(749, 2879.8122558594, -1927.3521728516, 5.8928594589233, 0, 0, 33.997192382813);
CreateDynamicObject(749, 2878.0590820313, -1927.8594970703, 4.8422441482544, 0, 0, 97.997192382813);
CreateDynamicObject(749, 2876.7292480469, -1927.9312744141, 4.5729646682739, 0, 0, 159.99255371094);
CreateDynamicObject(749, 2875.3491210938, -1927.4382324219, 5.3283424377441, 0, 0, 279.98840332031);
CreateDynamicObject(749, 2883.9826660156, -1930.6190185547, 5.1150641441345, 0, 0, 279.98657226563);
CreateDynamicObject(749, 2883.9682617188, -1932.0133056641, 5.2168025970459, 0, 0, 359.98657226563);
CreateDynamicObject(749, 2883.8090820313, -1934.6607666016, 5.1586170196533, 0, 0, 181.98352050781);
CreateDynamicObject(749, 2883.4978027344, -1936.5050048828, 4.0262584686279, 0, 0, 213.98303222656);
CreateDynamicObject(749, 2883.7065429688, -1938.134765625, 4.4858112335205, 0, 0, 317.98071289063);
CreateDynamicObject(749, 2883.037109375, -1940.3544921875, 4.1271820068359, 0, 0, 57.977294921875);
CreateDynamicObject(749, 2882.8977050781, -1942.4796142578, 3.2308235168457, 0, 0, 117.9748840332);
CreateDynamicObject(749, 2882.8815917969, -1944.2292480469, 4.3246397972107, 0, 0, 27.971221923828);
CreateDynamicObject(749, 2883.5048828125, -1946.1015625, 3.1520719528198, 0, 0, 75.970458984375);
CreateDynamicObject(632, 2873.3190917969, -1955.6834716797, 10.130574226379, 0, 0, 0);
CreateDynamicObject(632, 2873.1760253906, -1951.4541015625, 10.130574226379, 0, 0, 0);
CreateDynamicObject(1215, 2873.078125, -1965.6119384766, 10.694897651672, 0, 0, 0);
CreateDynamicObject(1215, 2872.9396972656, -1951.3519287109, 10.694897651672, 0, 0, 0);
CreateDynamicObject(1215, 2873.0222167969, -1955.6452636719, 10.694897651672, 0, 0, 0);
CreateDynamicObject(1215, 2873.1384277344, -1933.4720458984, 10.672689437866, 0, 0, 0);
CreateDynamicObject(3663, 1832.453125, -2388.4375, 14.46875, 0, 0, 270);
CreateDynamicObject(8947, 1793.3953857422, -2401.708984375, 15.607467651367, 0, 0, 0);
CreateDynamicObject(8947, 1808.1392822266, -2401.7145996094, 15.607467651367, 0, 0, 0);
CreateDynamicObject(3666, 1815.6356201172, -2413.8845214844, 13.06837272644, 0, 0, 0);
CreateDynamicObject(3666, 1786.1311035156, -2414.1672363281, 13.06837272644, 0, 0, 333.63830566406);
CreateDynamicObject(3666, 1815.6613769531, -2389.5522460938, 13.06837272644, 0, 0, 0);
CreateDynamicObject(3526, 1830.3217773438, -2407.4245605469, 22.049192428589, 0, 0, 251.52993774414);
CreateDynamicObject(1682, 1833.8298339844, -2401.4709472656, 27.958040237427, 0, 0, 218);
CreateDynamicObject(16101, 1787.5987548828, -2412.8752441406, 18.661010742188, 0, 0, 0);
CreateDynamicObject(10810, 1827.7623291016, -2400.4213867188, 16.980773925781, 0, 0, 200);
CreateDynamicObject(3526, 1834.5744628906, -2393.4575195313, 22.049192428589, 0, 0, 71.906555175781);
CreateDynamicObject(7666, 1800.7666015625, -2414, 15.95149230957, 0, 0, 299.72985839844);
CreateDynamicObject(2790, 1789.4176025391, -2389.8503417969, 15.468205451965, 0, 0, 0);
CreateDynamicObject(10244, 1817.5740966797, -2405.298828125, 15.118701934814, 0, 0, 90);
CreateDynamicObject(1290, 1800.7056884766, -2418.5297851563, 18.578109741211, 0, 0, 178.98974609375);
CreateDynamicObject(1290, 1800.4338378906, -2440.0627441406, 18.578109741211, 0, 0, 178.9892578125);
CreateDynamicObject(10250, 1826.1831054688, -2392.5075683594, 38.960624694824, 0, 0, 358);
CreateDynamicObject(3934, 1800.3682861328, -2400.9389648438, 19.830978393555, 0, 0, 0);
CreateDynamicObject(16782, 1786.7250976563, -2391.2846679688, 15.345844268799, 0, 0, 0);
CreateDynamicObject(16368, 1787.6080322266, -2412.8745117188, 29.548221588135, 0, 0, 0);
CreateDynamicObject(16782, 1801.5102539063, -2391.3405761719, 15.364438056946, 0, 0, 0);
CreateDynamicObject(2790, 1804.2133789063, -2389.8203125, 15.452939987183, 0, 0, 0);
CreateDynamicObject(3877, 1810.6643066406, -2410.1569824219, 21.478525161743, 0, 0, 0);
CreateDynamicObject(3391, 1786.9643554688, -2391.4838867188, 12.5546875, 0, 0, 179.55004882813);
CreateDynamicObject(3391, 1801.7674560547, -2391.4194335938, 12.5546875, 0, 0, 179.54956054688);
CreateDynamicObject(2921, 1815.3294677734, -2413.9184570313, 17.832878112793, 0, 0, 56);
CreateDynamicObject(3115, 1800.5139160156, -2401.1232910156, 19.518049240112, 0, 0, 0);
CreateDynamicObject(3877, 1790.3605957031, -2410.1740722656, 21.520708084106, 0, 0, 0);
CreateDynamicObject(3877, 1790.3563232422, -2392.0778808594, 21.521160125732, 0, 0, 0);
CreateDynamicObject(3877, 1810.6695556641, -2392.1030273438, 21.461511611938, 0, 0, 0.089996337890625);
CreateDynamicObject(2939, 1816.6848144531, -2400.7805175781, 17.230825424194, 1.0799865722656, 0, 90.179992675781);
CreateDynamicObject(2356, 1803.0841064453, -2391.7546386719, 12.5546875, 0, 0, 160);
CreateDynamicObject(2356, 1788.2550048828, -2391.3857421875, 12.5546875, 0, 0, 117.99938964844);
CreateDynamicObject(16500, 1803.6762695313, -2394.3371582031, 14.548896789551, 0, 0, 272);
CreateDynamicObject(16500, 1788.9484863281, -2394.2951660156, 14.548896789551, 0, 0, 272);
CreateDynamicObject(2677, 2326.689453125, -1259.01171875, 21.779039382935, 0, 0, 0);
CreateDynamicObject(2674, 2347.2319335938, -1231.8076171875, 21.521739959717, 0, 0, 0);
CreateDynamicObject(2670, 2323.4655761719, -1273.1569824219, 21.592052459717, 0, 0, 132);
CreateDynamicObject(2062, 2322.8671875, -1274.9013671875, 22.068634033203, 0, 0, 0);
CreateDynamicObject(1334, 2323.162109375, -1223.1801757813, 22.401788711548, 0, 0, 270);
CreateDynamicObject(1333, 2323.0915527344, -1225.4832763672, 22.19075012207, 0, 0, 269.10021972656);
CreateDynamicObject(1264, 2323.6711425781, -1226.8480224609, 21.886665344238, 0, 0, 302);
CreateDynamicObject(1337, 2322.8820800781, -1227.1010742188, 22.218368530273, 0, 0, 90);
CreateDynamicObject(1442, 2326.7802734375, -1274.7575683594, 22.098484039307, 0, 0, 0);
CreateDynamicObject(1238, 2344.8972167969, -1240.3989257813, 21.818180084229, 0, 0, 0);
CreateDynamicObject(1490, 2352.0234375, -1224.9616699219, 23.308679580688, 0, 0, 0);
CreateDynamicObject(1526, 2352.0234375, -1253.0377197266, 23.065439224243, 0, 0, 0);
CreateDynamicObject(17070, 2333.341796875, -1243.6252441406, 20.760782241821, 0, 0, 272);
CreateDynamicObject(17969, 2351.9768066406, -1234.1466064453, 22.906179428101, 0, 0, 0);
CreateDynamicObject(3085, 2324.5087890625, -1275.4913330078, 21.5, 0, 0, 0);
CreateDynamicObject(7312, 2349.7082519531, -1244.7779541016, 23.711471557617, 0, 0, 0);
CreateDynamicObject(8843, 2341.1870117188, -1244.3122558594, 21.510599136353, 0, 0, 0);
CreateDynamicObject(8843, 2333.6916503906, -1244.6268310547, 21.5, 0, 0, 179.61950683594);
CreateDynamicObject(8851, 2337.4597167969, -1244.5568847656, 21.613124847412, 0, 0, 0);
CreateDynamicObject(2062, 2322.8996582031, -1274.0056152344, 22.068634033203, 0, 0, 0);
CreateDynamicObject(2062, 2322.8728027344, -1274.4627685547, 23.208576202393, 0, 0, 0);
CreateDynamicObject(1238, 2344.8857421875, -1248.9353027344, 21.818180084229, 0, 0, 0);
CreateDynamicObject(3461, 2326.77734375, -1274.7481689453, 21.039978027344, 0, 0, 0);
CreateDynamicObject(3095, 2350.0771484375, -1248.5404052734, 21.5, 0, 90.480102539063, 270.20056152344);
CreateDynamicObject(3095, 2350.15234375, -1240.6234130859, 21.5, 0, 90.477905273438, 90.19775390625);
CreateDynamicObject(1215, 2337.4658203125, -1234.8072509766, 22.175693511963, 0, 0, 0);
CreateDynamicObject(1215, 2337.4685058594, -1254.3314208984, 22.175693511963, 0, 0, 0);
CreateDynamicObject(10183, 2325.3662109375, -1249.9870605469, 21.522542953491, 0, 0, 135.52987670898);
CreateDynamicObject(1215, 2313.2253417969, -1221.6687011719, 23.73589515686, 0, 0, 0);
CreateDynamicObject(1215, 2313.2377929688, -1214.3833007813, 23.712493896484, 0, 0, 0);
CreateDynamicObject(1215, 2361.1496582031, -1275.6398925781, 23.562767028809, 0, 0, 0);
CreateDynamicObject(1215, 2361.15625, -1268.5783691406, 23.576078414917, 0, 0, 0);
}
stock str_replace (newstr [], oldstr [], srcstr [], deststr [], bool: ignorecase = false, size = sizeof (deststr))
{
	new
	    newlen = strlen (newstr),
	    oldlen = strlen (oldstr),
	    srclen = strlen (srcstr),
	    idx,
		rep;

	for (new i = 0; i < srclen; ++i)
	{
	    if ((i + oldlen) <= srclen)
	    {
	        if (!strcmp (srcstr [i], oldstr, ignorecase, oldlen))
	        {
				deststr [idx] = '\0';
				strcat (deststr, newstr, size);
				++rep;
				idx += newlen;
				i += oldlen - 1;
			}
			else
			{
		        if (idx < (size - 1))
		            deststr [idx++] = srcstr [i];
				else
					return rep;
		    }
	    }
	    else
	    {
	        if (idx < (size - 1))
	            deststr [idx++] = srcstr [i];
			else
				return rep;
	    }
	}
	deststr [idx] = '\0';
	return rep;
}
stock LoadPlaces()
{
	CreateInfoPlace( 1, 1, -306.8323,1529.7595,75.3594, 0, "{FF3000}:: {7bb489}[Place{FFFFFF}/{7bb489}Pickup] {FF3000}::\n{FFFFFF}Araçlar / Vehicles" );
	CreateInfoPlace( 0, 2, -304.0841,1529.8256,75.3594, 0, "{FF3000}:: {7bb489}[Place{FFFFFF}/{7bb489}Pickup] {FF3000}::\n{FFFFFF}Iþýnlanma Bölgeleri / Teleport Zones" );
	//
	CreateInfoPlace( 1, 3, -2269.9338,2302.5544,4.8903, 0, "{FF3000}:: {7bb489}[Place{FFFFFF}/{7bb489}Pickup] {FF3000}::\n{FFFFFF}Araçlar / Vehicles" );
	CreateInfoPlace( 0, 4, -2270.2151,2297.3416,4.8903, 0, "{FF3000}:: {7bb489}[Place{FFFFFF}/{7bb489}Pickup] {FF3000}::\n{FFFFFF}Iþýnlanma Bölgeleri / Teleport Zones" );
	//
	CreateInfoPlace( 1, 5, 440.5571,-1844.7742,3.8540, 0, "{FF3000}:: {7bb489}[Place{FFFFFF}/{7bb489}Pickup] {FF3000}::\n{FFFFFF}Araçlar / Vehicles" );
	CreateInfoPlace( 0, 6, 440.3061,-1841.3267,4.0858, 0, "{FF3000}:: {7bb489}[Place{FFFFFF}/{7bb489}Pickup] {FF3000}::\n{FFFFFF}Iþýnlanma Bölgeleri / Teleport Zones" );
	//
	CreateInfoPlace( 1, 7, 1300.8013,-236.3739,11.5896, 0, "{FF3000}:: {7bb489}[Place{FFFFFF}/{7bb489}Pickup] {FF3000}::\n{FFFFFF}Araçlar / Vehicles" );
	CreateInfoPlace( 0, 8, 1299.6154,-232.7395,11.5819, 0, "{FF3000}:: {7bb489}[Place{FFFFFF}/{7bb489}Pickup] {FF3000}::\n{FFFFFF}Iþýnlanma Bölgeleri / Teleport Zones" );
	print ("Number of places: 8");
	return 1;
}
stock CreateInfoPlace( type, i, Float:X, Float:Y, Float:Z, Virtualworld, message[ ] )
{
    CreatePickup( 19130, 0, X, Y, Z, Virtualworld );
	InfoPlace[ i ] = CreateDynamicCP(X,Y,Z, 2.0);
	TypePalace[i] = type;
	CreateDynamic3DTextLabel( message, 0xF67E0FF, X, Y, Z, 100, INVALID_PLAYER_ID,INVALID_VEHICLE_ID, 0, 0, -1, -1, 100.0 );
	return 1;
}
function Reklamlar()
{
	new savingstring[512], savingstring2[512], string[256], Query[256];
	format(Query, sizeof(Query), "SELECT * FROM `reklamlar`");
	mysql_query(Query);
	printf(Query);
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
		while(mysql_retrieve_row())
		{
			mysql_fetch_field_row(savingstring, "yazi");
			mysql_fetch_field_row(savingstring2, "yazan");
			format(string, sizeof(string), "Reklam Sahibi: {E24234}' %s '{FFFFFF} - {00FF7F}%s", savingstring2, savingstring);
			foreach(new i :Player) Reklam(i, string, string);
		}
	}
	mysql_free_result();
	foreach(new i : Player) Bilgimesaj(i, "Sende reklam vermek istiyorsan {E24234}' /reklamver '{FFFFFF} yaz.","");
	return 1;
}
stock mapiconYukle(playerid)
{
	SetPlayerMapIcon(playerid,49,822.6,-1590.3,13.5,7,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,50,-2570.1,245.4,10.3,7,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,51,2726.6,-2026.4,17.5,7,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,52,2080.3,2119.0,10.8,7,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,53,675.7,-496.6,16.8,7,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,54,-1805.7,943.2,24.8,29,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,55,2750.9,2470.9,11.0,29,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,56,2351.8,2529.0,10.8,29,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,57,2635.5,1847.4,11.0,29,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,58,2083.4,2221.0,11.0,29,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,59,-1719.1,1359.4,8.6,29,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,60,2330.2,75.2,31.0,29,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,61,203.2,-200.4,6.5,29,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,62,812.9,-1616.1,13.6,10,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,63,1199.1,-924.0,43.3,10,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,64,2362.2,2069.9,10.8,10,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,65,2469.5,2033.8,10.8,10,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,66,2172.9,2795.7,10.8,10,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,67,1875.3,2072.0,10.8,10,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,68,1161.5,2072.0,10.8,10,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,69,-2356.0,1009.0,49.0,10,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,70,-1913.3,826.2,36.9,10,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,71,-2335.6,-165.6,39.5,10,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,72,2397.8,-1895.6,13.7,14,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,73,2421.6,-1509.6,24.1,14,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,74,-2671.6,257.4,4.6,14,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,75,2392.4,2046.5,10.8,14,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,76,2844.5,2401.1,11.0,14,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,77,2635.5,1674.3,11.0,14,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,78,2105.7,2228.7,11.0,14,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,79,-2154.0,-2461.2,30.8,14,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,80,-1816.2,620.8,37.5,14,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,81,-1216.0,1831.4,45.3,14,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,82,172.73,1176.76,13.7,14,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,83,932.0,-1353.0,14.0,14,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,84,1971.7,-2036.6,13.5,39,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,85,2071.6,-1779.9,13.5,39,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,86,2094.6,2119.0,10.8,39,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,87,-2490.5,-40.1,39.3,39,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,88,1372.9,-1278.8,12.5,6,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,89,2400.5,-1978.4,13.5,6,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,90,-2626.6,209.4,4.9,6,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,91,2535.9,2083.5,10.8,6,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,92,2156.5,943.2,10.8,6,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,93,779.7,1874.3,4.9,6,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,94,-2092.7,-2463.8,30.6,6,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,95,240.0,-178.2,2.0,6,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,96,-1509.4,2611.8,58.5,6,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,97,-315.67,829.87,13.43,6,0,MAPICON_LOCAL);
	SetPlayerMapIcon(playerid,98,2332.9,63.6,31.0,6,0,MAPICON_LOCAL);
	return 1;
}
stock bankaKayit(playerid, kime[], ne[], miktar)
{
	new tarih[34], yil, ay, gun, saat, dakika, saniye;
	getdate(yil, ay, gun);
	gettime(saat, dakika, saniye);
	format(tarih, sizeof(tarih), "%d/%d/%d %d:%d:%d", yil, ay, gun, saat, dakika, saniye);
	new string[256];
	format(string, sizeof(string), "INSERT INTO `dokumanlar` (`sahip`, `islem`, `mevla`, `tarih`, `kime`) VALUES ('%s', '%s', '%d', '%s', '%s');", oIsim(playerid), ne, miktar, tarih, kime);
	mysql_query(string);
                    SelectTextDraw(playerid, -1);
	return 1;
}
stock LoadTextDraws()
{/*
DigitalTd[0] = TextDrawCreate(535.000000, 139.000000, "~n~");
TextDrawAlignment(DigitalTd[0], 2);
TextDrawBackgroundColor(DigitalTd[0], 255);
TextDrawFont(DigitalTd[0], 1);
TextDrawLetterSize(DigitalTd[0], 0.500000, 2.100000);
TextDrawColor(DigitalTd[0], -1);
TextDrawSetOutline(DigitalTd[0], 0);
TextDrawSetProportional(DigitalTd[0], 1);
TextDrawSetShadow(DigitalTd[0], 1);
TextDrawUseBox(DigitalTd[0], 1);
TextDrawBoxColor(DigitalTd[0], 118);
TextDrawTextSize(DigitalTd[0], 0.000000, 60.000000);
TextDrawSetSelectable(DigitalTd[0], 0);

DigitalTd[1] = TextDrawCreate(510.000000, 140.000000, "I");
TextDrawBackgroundColor(DigitalTd[1], 255);
TextDrawFont(DigitalTd[1], 2);
TextDrawLetterSize(DigitalTd[1], 0.190000, 1.000000);
TextDrawColor(DigitalTd[1], -1);
TextDrawSetOutline(DigitalTd[1], 0);
TextDrawSetProportional(DigitalTd[1], 1);
TextDrawSetShadow(DigitalTd[1], 0);
TextDrawSetSelectable(DigitalTd[1], 0);

DigitalTd[2] = TextDrawCreate(510.000000, 147.000000, "I");
TextDrawBackgroundColor(DigitalTd[2], 255);
TextDrawFont(DigitalTd[2], 2);
TextDrawLetterSize(DigitalTd[2], 0.190000, 1.000000);
TextDrawColor(DigitalTd[2], -1);
TextDrawSetOutline(DigitalTd[2], 0);
TextDrawSetProportional(DigitalTd[2], 1);
TextDrawSetShadow(DigitalTd[2], 0);
TextDrawSetSelectable(DigitalTd[2], 0);

DigitalTd[3] = TextDrawCreate(511.000000, 150.000000, "-");
TextDrawBackgroundColor(DigitalTd[3], 255);
TextDrawFont(DigitalTd[3], 2);
TextDrawLetterSize(DigitalTd[3], 0.609999, 1.000000);
TextDrawColor(DigitalTd[3], -1);
TextDrawSetOutline(DigitalTd[3], 0);
TextDrawSetProportional(DigitalTd[3], 1);
TextDrawSetShadow(DigitalTd[3], 0);
TextDrawSetSelectable(DigitalTd[3], 0);

DigitalTd[4] = TextDrawCreate(511.000000, 143.000000, "-");
TextDrawBackgroundColor(DigitalTd[4], 255);
TextDrawFont(DigitalTd[4], 2);
TextDrawLetterSize(DigitalTd[4], 0.609999, 1.000000);
TextDrawColor(DigitalTd[4], -1);
TextDrawSetOutline(DigitalTd[4], 0);
TextDrawSetProportional(DigitalTd[4], 1);
TextDrawSetShadow(DigitalTd[4], 0);
TextDrawSetSelectable(DigitalTd[4], 0);

DigitalTd[5] = TextDrawCreate(511.000000, 137.000000, "-");
TextDrawBackgroundColor(DigitalTd[5], 255);
TextDrawFont(DigitalTd[5], 2);
TextDrawLetterSize(DigitalTd[5], 0.609999, 1.000000);
TextDrawColor(DigitalTd[5], -1);
TextDrawSetOutline(DigitalTd[5], 0);
TextDrawSetProportional(DigitalTd[5], 1);
TextDrawSetShadow(DigitalTd[5], 0);
TextDrawSetSelectable(DigitalTd[5], 0);

DigitalTd[6] = TextDrawCreate(517.000000, 140.000000, "I");
TextDrawBackgroundColor(DigitalTd[6], 255);
TextDrawFont(DigitalTd[6], 2);
TextDrawLetterSize(DigitalTd[6], 0.190000, 1.000000);
TextDrawColor(DigitalTd[6], -1);
TextDrawSetOutline(DigitalTd[6], 0);
TextDrawSetProportional(DigitalTd[6], 1);
TextDrawSetShadow(DigitalTd[6], 0);
TextDrawSetSelectable(DigitalTd[6], 0);

DigitalTd[7] = TextDrawCreate(517.000000, 147.000000, "I");
TextDrawBackgroundColor(DigitalTd[7], 255);
TextDrawFont(DigitalTd[7], 2);
TextDrawLetterSize(DigitalTd[7], 0.190000, 1.000000);
TextDrawColor(DigitalTd[7], -1);
TextDrawSetOutline(DigitalTd[7], 0);
TextDrawSetProportional(DigitalTd[7], 1);
TextDrawSetShadow(DigitalTd[7], 0);
TextDrawSetSelectable(DigitalTd[7], 0);

DigitalTd[8] = TextDrawCreate(520.000000, 140.000000, "I");
TextDrawBackgroundColor(DigitalTd[8], 255);
TextDrawFont(DigitalTd[8], 2);
TextDrawLetterSize(DigitalTd[8], 0.190000, 1.000000);
TextDrawColor(DigitalTd[8], -1);
TextDrawSetOutline(DigitalTd[8], 0);
TextDrawSetProportional(DigitalTd[8], 1);
TextDrawSetShadow(DigitalTd[8], 0);
TextDrawSetSelectable(DigitalTd[8], 0);

DigitalTd[9] = TextDrawCreate(520.000000, 147.000000, "I");
TextDrawBackgroundColor(DigitalTd[9], 255);
TextDrawFont(DigitalTd[9], 2);
TextDrawLetterSize(DigitalTd[9], 0.190000, 1.000000);
TextDrawColor(DigitalTd[9], -1);
TextDrawSetOutline(DigitalTd[9], 0);
TextDrawSetProportional(DigitalTd[9], 1);
TextDrawSetShadow(DigitalTd[9], 0);
TextDrawSetSelectable(DigitalTd[9], 0);

DigitalTd[10] = TextDrawCreate(521.000000, 150.000000, "-");
TextDrawBackgroundColor(DigitalTd[10], 255);
TextDrawFont(DigitalTd[10], 2);
TextDrawLetterSize(DigitalTd[10], 0.609999, 1.000000);
TextDrawColor(DigitalTd[10], -1);
TextDrawSetOutline(DigitalTd[10], 0);
TextDrawSetProportional(DigitalTd[10], 1);
TextDrawSetShadow(DigitalTd[10], 0);
TextDrawSetSelectable(DigitalTd[10], 0);

DigitalTd[11] = TextDrawCreate(521.000000, 143.000000, "-");
TextDrawBackgroundColor(DigitalTd[11], 255);
TextDrawFont(DigitalTd[11], 2);
TextDrawLetterSize(DigitalTd[11], 0.609999, 1.000000);
TextDrawColor(DigitalTd[11], -1);
TextDrawSetOutline(DigitalTd[11], 0);
TextDrawSetProportional(DigitalTd[11], 1);
TextDrawSetShadow(DigitalTd[11], 0);
TextDrawSetSelectable(DigitalTd[11], 0);

DigitalTd[12] = TextDrawCreate(521.000000, 137.000000, "-");
TextDrawBackgroundColor(DigitalTd[12], 255);
TextDrawFont(DigitalTd[12], 2);
TextDrawLetterSize(DigitalTd[12], 0.609999, 1.000000);
TextDrawColor(DigitalTd[12], -1);
TextDrawSetOutline(DigitalTd[12], 0);
TextDrawSetProportional(DigitalTd[12], 1);
TextDrawSetShadow(DigitalTd[12], 0);
TextDrawSetSelectable(DigitalTd[12], 0);

DigitalTd[13] = TextDrawCreate(527.000000, 140.000000, "I");
TextDrawBackgroundColor(DigitalTd[13], 255);
TextDrawFont(DigitalTd[13], 2);
TextDrawLetterSize(DigitalTd[13], 0.190000, 1.000000);
TextDrawColor(DigitalTd[13], -1);
TextDrawSetOutline(DigitalTd[13], 0);
TextDrawSetProportional(DigitalTd[13], 1);
TextDrawSetShadow(DigitalTd[13], 0);
TextDrawSetSelectable(DigitalTd[13], 0);

DigitalTd[14] = TextDrawCreate(527.000000, 147.000000, "I");
TextDrawBackgroundColor(DigitalTd[14], 255);
TextDrawFont(DigitalTd[14], 2);
TextDrawLetterSize(DigitalTd[14], 0.190000, 1.000000);
TextDrawColor(DigitalTd[14], -1);
TextDrawSetOutline(DigitalTd[14], 0);
TextDrawSetProportional(DigitalTd[14], 1);
TextDrawSetShadow(DigitalTd[14], 0);
TextDrawSetSelectable(DigitalTd[14], 0);

DigitalTd[15] = TextDrawCreate(539.000000, 140.000000, "I");
TextDrawBackgroundColor(DigitalTd[15], 255);
TextDrawFont(DigitalTd[15], 2);
TextDrawLetterSize(DigitalTd[15], 0.190000, 1.000000);
TextDrawColor(DigitalTd[15], -1);
TextDrawSetOutline(DigitalTd[15], 0);
TextDrawSetProportional(DigitalTd[15], 1);
TextDrawSetShadow(DigitalTd[15], 0);
TextDrawSetSelectable(DigitalTd[15], 0);

DigitalTd[16] = TextDrawCreate(539.000000, 147.000000, "I");
TextDrawBackgroundColor(DigitalTd[16], 255);
TextDrawFont(DigitalTd[16], 2);
TextDrawLetterSize(DigitalTd[16], 0.190000, 1.000000);
TextDrawColor(DigitalTd[16], -1);
TextDrawSetOutline(DigitalTd[16], 0);
TextDrawSetProportional(DigitalTd[16], 1);
TextDrawSetShadow(DigitalTd[16], 0);
TextDrawSetSelectable(DigitalTd[16], 0);

DigitalTd[17] = TextDrawCreate(540.000000, 150.000000, "-");
TextDrawBackgroundColor(DigitalTd[17], 255);
TextDrawFont(DigitalTd[17], 2);
TextDrawLetterSize(DigitalTd[17], 0.609999, 1.000000);
TextDrawColor(DigitalTd[17], -1);
TextDrawSetOutline(DigitalTd[17], 0);
TextDrawSetProportional(DigitalTd[17], 1);
TextDrawSetShadow(DigitalTd[17], 0);
TextDrawSetSelectable(DigitalTd[17], 0);

DigitalTd[18] = TextDrawCreate(540.000000, 143.000000, "-");
TextDrawBackgroundColor(DigitalTd[18], 255);
TextDrawFont(DigitalTd[18], 2);
TextDrawLetterSize(DigitalTd[18], 0.609999, 1.000000);
TextDrawColor(DigitalTd[18], -1);
TextDrawSetOutline(DigitalTd[18], 0);
TextDrawSetProportional(DigitalTd[18], 1);
TextDrawSetShadow(DigitalTd[18], 0);
TextDrawSetSelectable(DigitalTd[18], 0);

DigitalTd[19] = TextDrawCreate(540.000000, 137.000000, "-");
TextDrawBackgroundColor(DigitalTd[19], 255);
TextDrawFont(DigitalTd[19], 2);
TextDrawLetterSize(DigitalTd[19], 0.609999, 1.000000);
TextDrawColor(DigitalTd[19], -1);
TextDrawSetOutline(DigitalTd[19], 0);
TextDrawSetProportional(DigitalTd[19], 1);
TextDrawSetShadow(DigitalTd[19], 0);
TextDrawSetSelectable(DigitalTd[19], 0);

DigitalTd[20] = TextDrawCreate(546.000000, 140.000000, "I");
TextDrawBackgroundColor(DigitalTd[20], 255);
TextDrawFont(DigitalTd[20], 2);
TextDrawLetterSize(DigitalTd[20], 0.190000, 1.000000);
TextDrawColor(DigitalTd[20], -1);
TextDrawSetOutline(DigitalTd[20], 0);
TextDrawSetProportional(DigitalTd[20], 1);
TextDrawSetShadow(DigitalTd[20], 0);
TextDrawSetSelectable(DigitalTd[20], 0);

DigitalTd[21] = TextDrawCreate(546.000000, 147.000000, "I");
TextDrawBackgroundColor(DigitalTd[21], 255);
TextDrawFont(DigitalTd[21], 2);
TextDrawLetterSize(DigitalTd[21], 0.190000, 1.000000);
TextDrawColor(DigitalTd[21], -1);
TextDrawSetOutline(DigitalTd[21], 0);
TextDrawSetProportional(DigitalTd[21], 1);
TextDrawSetShadow(DigitalTd[21], 0);
TextDrawSetSelectable(DigitalTd[21], 0);

DigitalTd[22] = TextDrawCreate(549.000000, 140.000000, "I");
TextDrawBackgroundColor(DigitalTd[22], 255);
TextDrawFont(DigitalTd[22], 2);
TextDrawLetterSize(DigitalTd[22], 0.190000, 1.000000);
TextDrawColor(DigitalTd[22], -1);
TextDrawSetOutline(DigitalTd[22], 0);
TextDrawSetProportional(DigitalTd[22], 1);
TextDrawSetShadow(DigitalTd[22], 0);
TextDrawSetSelectable(DigitalTd[22], 0);

DigitalTd[23] = TextDrawCreate(549.000000, 147.000000, "I");
TextDrawBackgroundColor(DigitalTd[23], 255);
TextDrawFont(DigitalTd[23], 2);
TextDrawLetterSize(DigitalTd[23], 0.190000, 1.000000);
TextDrawColor(DigitalTd[23], -1);
TextDrawSetOutline(DigitalTd[23], 0);
TextDrawSetProportional(DigitalTd[23], 1);
TextDrawSetShadow(DigitalTd[23], 0);
TextDrawSetSelectable(DigitalTd[23], 0);

DigitalTd[24] = TextDrawCreate(550.000000, 150.000000, "-");
TextDrawBackgroundColor(DigitalTd[24], 255);
TextDrawFont(DigitalTd[24], 2);
TextDrawLetterSize(DigitalTd[24], 0.609999, 1.000000);
TextDrawColor(DigitalTd[24], -1);
TextDrawSetOutline(DigitalTd[24], 0);
TextDrawSetProportional(DigitalTd[24], 1);
TextDrawSetShadow(DigitalTd[24], 0);
TextDrawSetSelectable(DigitalTd[24], 0);

DigitalTd[25] = TextDrawCreate(550.000000, 143.000000, "-");
TextDrawBackgroundColor(DigitalTd[25], 255);
TextDrawFont(DigitalTd[25], 2);
TextDrawLetterSize(DigitalTd[25], 0.609999, 1.000000);
TextDrawColor(DigitalTd[25], -1);
TextDrawSetOutline(DigitalTd[25], 0);
TextDrawSetProportional(DigitalTd[25], 1);
TextDrawSetShadow(DigitalTd[25], 0);
TextDrawSetSelectable(DigitalTd[25], 0);

DigitalTd[26] = TextDrawCreate(550.000000, 137.000000, "-");
TextDrawBackgroundColor(DigitalTd[26], 255);
TextDrawFont(DigitalTd[26], 2);
TextDrawLetterSize(DigitalTd[26], 0.609999, 1.000000);
TextDrawColor(DigitalTd[26], -1);
TextDrawSetOutline(DigitalTd[26], 0);
TextDrawSetProportional(DigitalTd[26], 1);
TextDrawSetShadow(DigitalTd[26], 0);
TextDrawSetSelectable(DigitalTd[26], 0);

DigitalTd[27] = TextDrawCreate(556.000000, 140.000000, "I");
TextDrawBackgroundColor(DigitalTd[27], 255);
TextDrawFont(DigitalTd[27], 2);
TextDrawLetterSize(DigitalTd[27], 0.190000, 1.000000);
TextDrawColor(DigitalTd[27], -1);
TextDrawSetOutline(DigitalTd[27], 0);
TextDrawSetProportional(DigitalTd[27], 1);
TextDrawSetShadow(DigitalTd[27], 0);
TextDrawSetSelectable(DigitalTd[27], 0);

DigitalTd[28] = TextDrawCreate(556.000000, 147.000000, "I");
TextDrawBackgroundColor(DigitalTd[28], 255);
TextDrawFont(DigitalTd[28], 2);
TextDrawLetterSize(DigitalTd[28], 0.190000, 1.000000);
TextDrawColor(DigitalTd[28], -1);
TextDrawSetOutline(DigitalTd[28], 0);
TextDrawSetProportional(DigitalTd[28], 1);
TextDrawSetShadow(DigitalTd[28], 0);
TextDrawSetSelectable(DigitalTd[28], 0);

DigitalTd[29] = TextDrawCreate(533.000000, 144.000000, "I");
TextDrawBackgroundColor(DigitalTd[29], 255);
TextDrawFont(DigitalTd[29], 2);
TextDrawLetterSize(DigitalTd[29], 0.190000, 0.499999);
TextDrawColor(DigitalTd[29], -1);
TextDrawSetOutline(DigitalTd[29], 0);
TextDrawSetProportional(DigitalTd[29], 1);
TextDrawSetShadow(DigitalTd[29], 0);
TextDrawSetSelectable(DigitalTd[29], 0);

DigitalTd[30] = TextDrawCreate(533.000000, 150.000000, "I");
TextDrawBackgroundColor(DigitalTd[30], 255);
TextDrawFont(DigitalTd[30], 2);
TextDrawLetterSize(DigitalTd[30], 0.190000, 0.499999);
TextDrawColor(DigitalTd[30], -1);
TextDrawSetOutline(DigitalTd[30], 0);
TextDrawSetProportional(DigitalTd[30], 1);
TextDrawSetShadow(DigitalTd[30], 0);
TextDrawSetSelectable(DigitalTd[30], 0);

DigitalTd[31] = TextDrawCreate(503.000000, 139.000000, "~n~");
TextDrawAlignment(DigitalTd[31], 2);
TextDrawBackgroundColor(DigitalTd[31], 255);
TextDrawFont(DigitalTd[31], 1);
TextDrawLetterSize(DigitalTd[31], 0.500000, 2.100000);
TextDrawColor(DigitalTd[31], -1);
TextDrawSetOutline(DigitalTd[31], 0);
TextDrawSetProportional(DigitalTd[31], 1);
TextDrawSetShadow(DigitalTd[31], 1);
TextDrawUseBox(DigitalTd[31], 1);
TextDrawBoxColor(DigitalTd[31], -16776961);
TextDrawTextSize(DigitalTd[31], 0.000000, -3.000000);
TextDrawSetSelectable(DigitalTd[31], 0);

DigitalTd[32] = TextDrawCreate(567.000000, 139.000000, "~n~");
TextDrawAlignment(DigitalTd[32], 2);
TextDrawBackgroundColor(DigitalTd[32], 255);
TextDrawFont(DigitalTd[32], 1);
TextDrawLetterSize(DigitalTd[32], 0.500000, 2.100000);
TextDrawColor(DigitalTd[32], -1);
TextDrawSetOutline(DigitalTd[32], 0);
TextDrawSetProportional(DigitalTd[32], 1);
TextDrawSetShadow(DigitalTd[32], 1);
TextDrawUseBox(DigitalTd[32], 1);
TextDrawBoxColor(DigitalTd[32], -16776961);
TextDrawTextSize(DigitalTd[32], 0.000000, -3.000000);
TextDrawSetSelectable(DigitalTd[32], 0);

DigitalTd[33] = TextDrawCreate(535.000000, 162.000000, "~n~");
TextDrawAlignment(DigitalTd[33], 2);
TextDrawBackgroundColor(DigitalTd[33], 255);
TextDrawFont(DigitalTd[33], 1);
TextDrawLetterSize(DigitalTd[33], 0.500000, -0.399999);
TextDrawColor(DigitalTd[33], -1);
TextDrawSetOutline(DigitalTd[33], 0);
TextDrawSetProportional(DigitalTd[33], 1);
TextDrawSetShadow(DigitalTd[33], 1);
TextDrawUseBox(DigitalTd[33], 1);
TextDrawBoxColor(DigitalTd[33], -16776961);
TextDrawTextSize(DigitalTd[33], 0.000000, 61.000000);
TextDrawSetSelectable(DigitalTd[33], 0);

DigitalTd[34] = TextDrawCreate(535.000000, 139.000000, "~n~");
TextDrawAlignment(DigitalTd[34], 2);
TextDrawBackgroundColor(DigitalTd[34], 255);
TextDrawFont(DigitalTd[34], 1);
TextDrawLetterSize(DigitalTd[34], 0.500000, -0.399999);
TextDrawColor(DigitalTd[34], -1);
TextDrawSetOutline(DigitalTd[34], 0);
TextDrawSetProportional(DigitalTd[34], 1);
TextDrawSetShadow(DigitalTd[34], 1);
TextDrawUseBox(DigitalTd[34], 1);
TextDrawBoxColor(DigitalTd[34], -16776961);
TextDrawTextSize(DigitalTd[34], 0.000000, 61.000000);
TextDrawSetSelectable(DigitalTd[34], 0);*/
}

stock ShowDigitalClock(playerid)
{
TextDrawShowForPlayer(playerid,DigitalTd[0]);
TextDrawShowForPlayer(playerid,DigitalTd[29]);
TextDrawShowForPlayer(playerid,DigitalTd[30]);
TextDrawShowForPlayer(playerid,DigitalTd[31]);
TextDrawShowForPlayer(playerid,DigitalTd[32]);
TextDrawShowForPlayer(playerid,DigitalTd[33]);
TextDrawShowForPlayer(playerid,DigitalTd[34]);
}
stock HideDigitalClock(playerid)
{
for(new t;t<31;t++)
{
TextDrawHideForPlayer(playerid,DigitalTd[t]);
}
}
stock SetStringForFrstNumber(playerid,number)
{
if(number == 0)
{
TextDrawShowForPlayer(playerid,DigitalTd[1]);
TextDrawShowForPlayer(playerid,DigitalTd[2]);
TextDrawShowForPlayer(playerid,DigitalTd[3]);
TextDrawHideForPlayer(playerid,DigitalTd[4]);
TextDrawShowForPlayer(playerid,DigitalTd[5]);
TextDrawShowForPlayer(playerid,DigitalTd[6]);
TextDrawShowForPlayer(playerid,DigitalTd[7]);
}
if(number == 1)
{
TextDrawHideForPlayer(playerid,DigitalTd[1]);
TextDrawHideForPlayer(playerid,DigitalTd[2]);
TextDrawHideForPlayer(playerid,DigitalTd[3]);
TextDrawHideForPlayer(playerid,DigitalTd[4]);
TextDrawHideForPlayer(playerid,DigitalTd[5]);
TextDrawShowForPlayer(playerid,DigitalTd[6]);
TextDrawShowForPlayer(playerid,DigitalTd[7]);
}
if(number == 2)
{
TextDrawHideForPlayer(playerid,DigitalTd[1]);
TextDrawShowForPlayer(playerid,DigitalTd[2]);
TextDrawShowForPlayer(playerid,DigitalTd[3]);
TextDrawShowForPlayer(playerid,DigitalTd[4]);
TextDrawShowForPlayer(playerid,DigitalTd[5]);
TextDrawShowForPlayer(playerid,DigitalTd[6]);
TextDrawHideForPlayer(playerid,DigitalTd[7]);
}
}
stock SetStringForSecondNumber(playerid,number)
{
if(number == 0 || number == 10 || number == 20 || number == 30 || number == 40 || number == 50)
{
TextDrawShowForPlayer(playerid,DigitalTd[8]);
TextDrawShowForPlayer(playerid,DigitalTd[9]);
TextDrawShowForPlayer(playerid,DigitalTd[10]);
TextDrawHideForPlayer(playerid,DigitalTd[11]);
TextDrawShowForPlayer(playerid,DigitalTd[12]);
TextDrawShowForPlayer(playerid,DigitalTd[13]);
TextDrawShowForPlayer(playerid,DigitalTd[14]);
}
if(number == 1 || number == 11 || number == 21 || number == 31 || number == 41 || number == 51)
{
TextDrawHideForPlayer(playerid,DigitalTd[8]);
TextDrawHideForPlayer(playerid,DigitalTd[9]);
TextDrawHideForPlayer(playerid,DigitalTd[10]);
TextDrawHideForPlayer(playerid,DigitalTd[11]);
TextDrawHideForPlayer(playerid,DigitalTd[12]);
TextDrawShowForPlayer(playerid,DigitalTd[13]);
TextDrawShowForPlayer(playerid,DigitalTd[14]);
}
if(number == 2 || number == 12 || number == 22 || number == 32 || number == 42 || number == 52)
{
TextDrawHideForPlayer(playerid,DigitalTd[8]);
TextDrawShowForPlayer(playerid,DigitalTd[9]);
TextDrawShowForPlayer(playerid,DigitalTd[10]);
TextDrawShowForPlayer(playerid,DigitalTd[11]);
TextDrawShowForPlayer(playerid,DigitalTd[12]);
TextDrawShowForPlayer(playerid,DigitalTd[13]);
TextDrawHideForPlayer(playerid,DigitalTd[14]);
}
if(number == 3 || number == 13 || number == 23 || number == 33 || number == 43 || number == 53)
{
TextDrawHideForPlayer(playerid,DigitalTd[8]);
TextDrawHideForPlayer(playerid,DigitalTd[9]);
TextDrawShowForPlayer(playerid,DigitalTd[10]);
TextDrawShowForPlayer(playerid,DigitalTd[11]);
TextDrawShowForPlayer(playerid,DigitalTd[12]);
TextDrawShowForPlayer(playerid,DigitalTd[13]);
TextDrawShowForPlayer(playerid,DigitalTd[14]);
}
if(number == 4 || number == 14 || number == 24 || number == 34 || number == 44 || number == 54)
{
TextDrawShowForPlayer(playerid,DigitalTd[8]);
TextDrawHideForPlayer(playerid,DigitalTd[9]);
TextDrawHideForPlayer(playerid,DigitalTd[10]);
TextDrawShowForPlayer(playerid,DigitalTd[11]);
TextDrawHideForPlayer(playerid,DigitalTd[12]);
TextDrawShowForPlayer(playerid,DigitalTd[13]);
TextDrawShowForPlayer(playerid,DigitalTd[14]);
}
if(number == 5 || number == 15 || number == 25 || number == 35 || number == 45 || number == 55)
{
TextDrawShowForPlayer(playerid,DigitalTd[8]);
TextDrawHideForPlayer(playerid,DigitalTd[9]);
TextDrawShowForPlayer(playerid,DigitalTd[10]);
TextDrawShowForPlayer(playerid,DigitalTd[11]);
TextDrawShowForPlayer(playerid,DigitalTd[12]);
TextDrawHideForPlayer(playerid,DigitalTd[13]);
TextDrawShowForPlayer(playerid,DigitalTd[14]);
}
if(number == 6 || number == 16 || number == 26 || number == 36 || number == 46 || number == 56)
{
TextDrawShowForPlayer(playerid,DigitalTd[8]);
TextDrawShowForPlayer(playerid,DigitalTd[9]);
TextDrawShowForPlayer(playerid,DigitalTd[10]);
TextDrawShowForPlayer(playerid,DigitalTd[11]);
TextDrawShowForPlayer(playerid,DigitalTd[12]);
TextDrawHideForPlayer(playerid,DigitalTd[13]);
TextDrawShowForPlayer(playerid,DigitalTd[14]);
}
if(number == 7 || number == 17 || number == 27 || number == 37 || number == 47 || number == 57)
{
TextDrawShowForPlayer(playerid,DigitalTd[8]);
TextDrawHideForPlayer(playerid,DigitalTd[9]);
TextDrawHideForPlayer(playerid,DigitalTd[10]);
TextDrawHideForPlayer(playerid,DigitalTd[11]);
TextDrawShowForPlayer(playerid,DigitalTd[12]);
TextDrawShowForPlayer(playerid,DigitalTd[13]);
TextDrawShowForPlayer(playerid,DigitalTd[14]);
}
if(number == 8 || number == 18 || number == 28 || number == 38 || number == 48 || number == 58)
{
TextDrawShowForPlayer(playerid,DigitalTd[8]);
TextDrawShowForPlayer(playerid,DigitalTd[9]);
TextDrawShowForPlayer(playerid,DigitalTd[10]);
TextDrawShowForPlayer(playerid,DigitalTd[11]);
TextDrawShowForPlayer(playerid,DigitalTd[12]);
TextDrawShowForPlayer(playerid,DigitalTd[13]);
TextDrawShowForPlayer(playerid,DigitalTd[14]);
}
if(number == 9 || number == 19 || number == 29 || number == 39 || number == 49 || number == 59)
{
TextDrawShowForPlayer(playerid,DigitalTd[8]);
TextDrawHideForPlayer(playerid,DigitalTd[9]);
TextDrawShowForPlayer(playerid,DigitalTd[10]);
TextDrawShowForPlayer(playerid,DigitalTd[11]);
TextDrawShowForPlayer(playerid,DigitalTd[12]);
TextDrawShowForPlayer(playerid,DigitalTd[13]);
TextDrawShowForPlayer(playerid,DigitalTd[14]);
}
}


stock SetStringForThirdNumber(playerid,number)
{
if(number == 0 || number == 10 || number == 20 || number == 30 || number == 40 || number == 50)
{
TextDrawShowForPlayer(playerid,DigitalTd[15]);
TextDrawShowForPlayer(playerid,DigitalTd[16]);
TextDrawShowForPlayer(playerid,DigitalTd[17]);
TextDrawHideForPlayer(playerid,DigitalTd[18]);
TextDrawShowForPlayer(playerid,DigitalTd[19]);
TextDrawShowForPlayer(playerid,DigitalTd[20]);
TextDrawShowForPlayer(playerid,DigitalTd[21]);
}
if(number == 1 || number == 11 || number == 21 || number == 31 || number == 41 || number == 51)
{
TextDrawShowForPlayer(playerid,DigitalTd[15]);
TextDrawShowForPlayer(playerid,DigitalTd[16]);
TextDrawHideForPlayer(playerid,DigitalTd[17]);
TextDrawHideForPlayer(playerid,DigitalTd[18]);
TextDrawHideForPlayer(playerid,DigitalTd[19]);
TextDrawHideForPlayer(playerid,DigitalTd[20]);
TextDrawHideForPlayer(playerid,DigitalTd[21]);
}
if(number == 2 || number == 12  || number == 22 || number == 32 || number == 42 || number == 52)
{
TextDrawHideForPlayer(playerid,DigitalTd[15]);
TextDrawShowForPlayer(playerid,DigitalTd[16]);
TextDrawShowForPlayer(playerid,DigitalTd[17]);
TextDrawShowForPlayer(playerid,DigitalTd[18]);
TextDrawShowForPlayer(playerid,DigitalTd[19]);
TextDrawShowForPlayer(playerid,DigitalTd[20]);
TextDrawHideForPlayer(playerid,DigitalTd[21]);
}
if(number == 3 || number == 13 || number == 23 || number == 33 || number == 43 || number == 53)
{
TextDrawHideForPlayer(playerid,DigitalTd[15]);
TextDrawHideForPlayer(playerid,DigitalTd[16]);
TextDrawShowForPlayer(playerid,DigitalTd[17]);
TextDrawShowForPlayer(playerid,DigitalTd[18]);
TextDrawShowForPlayer(playerid,DigitalTd[19]);
TextDrawShowForPlayer(playerid,DigitalTd[20]);
TextDrawShowForPlayer(playerid,DigitalTd[21]);
}
if(number == 4 || number == 14 || number == 24 || number == 34 || number == 44 || number == 54)
{
TextDrawShowForPlayer(playerid,DigitalTd[15]);
TextDrawHideForPlayer(playerid,DigitalTd[16]);
TextDrawHideForPlayer(playerid,DigitalTd[17]);
TextDrawShowForPlayer(playerid,DigitalTd[18]);
TextDrawHideForPlayer(playerid,DigitalTd[19]);
TextDrawShowForPlayer(playerid,DigitalTd[20]);
TextDrawShowForPlayer(playerid,DigitalTd[21]);
}
if(number == 5 || number == 15 || number == 25 || number == 35 || number == 45 || number == 55)
{
TextDrawShowForPlayer(playerid,DigitalTd[15]);
TextDrawHideForPlayer(playerid,DigitalTd[16]);
TextDrawShowForPlayer(playerid,DigitalTd[17]);
TextDrawShowForPlayer(playerid,DigitalTd[18]);
TextDrawShowForPlayer(playerid,DigitalTd[19]);
TextDrawHideForPlayer(playerid,DigitalTd[20]);
TextDrawShowForPlayer(playerid,DigitalTd[21]);
}
if(number == 6)
{
TextDrawShowForPlayer(playerid,DigitalTd[15]);
TextDrawShowForPlayer(playerid,DigitalTd[16]);
TextDrawShowForPlayer(playerid,DigitalTd[17]);
TextDrawShowForPlayer(playerid,DigitalTd[18]);
TextDrawShowForPlayer(playerid,DigitalTd[19]);
TextDrawHideForPlayer(playerid,DigitalTd[20]);
TextDrawShowForPlayer(playerid,DigitalTd[21]);
}
if(number == 7 || number == 17 || number == 27 || number == 37 || number == 47 || number == 57)
{
TextDrawShowForPlayer(playerid,DigitalTd[15]);
TextDrawHideForPlayer(playerid,DigitalTd[16]);
TextDrawHideForPlayer(playerid,DigitalTd[17]);
TextDrawHideForPlayer(playerid,DigitalTd[18]);
TextDrawShowForPlayer(playerid,DigitalTd[19]);
TextDrawShowForPlayer(playerid,DigitalTd[20]);
TextDrawShowForPlayer(playerid,DigitalTd[21]);
}
if(number == 8 || number == 18 || number == 28 || number == 38 || number == 48 || number == 58)
{
TextDrawShowForPlayer(playerid,DigitalTd[15]);
TextDrawShowForPlayer(playerid,DigitalTd[16]);
TextDrawShowForPlayer(playerid,DigitalTd[17]);
TextDrawShowForPlayer(playerid,DigitalTd[18]);
TextDrawShowForPlayer(playerid,DigitalTd[19]);
TextDrawShowForPlayer(playerid,DigitalTd[20]);
TextDrawShowForPlayer(playerid,DigitalTd[21]);
}
if(number == 9 || number == 19 || number == 29 || number == 39 || number == 49 || number == 59)
{
TextDrawShowForPlayer(playerid,DigitalTd[15]);
TextDrawHideForPlayer(playerid,DigitalTd[16]);
TextDrawShowForPlayer(playerid,DigitalTd[17]);
TextDrawShowForPlayer(playerid,DigitalTd[18]);
TextDrawShowForPlayer(playerid,DigitalTd[19]);
TextDrawShowForPlayer(playerid,DigitalTd[20]);
TextDrawShowForPlayer(playerid,DigitalTd[21]);
}
}


stock SetStringForFourthNumber(playerid,number)
{
if(number == 0 || number == 10 || number == 20 || number == 30 || number == 40 || number == 50)
{
TextDrawShowForPlayer(playerid,DigitalTd[22]);
TextDrawShowForPlayer(playerid,DigitalTd[23]);
TextDrawShowForPlayer(playerid,DigitalTd[24]);
TextDrawHideForPlayer(playerid,DigitalTd[25]);
TextDrawShowForPlayer(playerid,DigitalTd[26]);
TextDrawShowForPlayer(playerid,DigitalTd[27]);
TextDrawShowForPlayer(playerid,DigitalTd[28]);
}
if(number == 1 || number == 11 || number == 21 || number == 31 || number == 41 || number == 51)
{
TextDrawHideForPlayer(playerid,DigitalTd[22]);
TextDrawHideForPlayer(playerid,DigitalTd[23]);
TextDrawHideForPlayer(playerid,DigitalTd[24]);
TextDrawHideForPlayer(playerid,DigitalTd[25]);
TextDrawHideForPlayer(playerid,DigitalTd[26]);
TextDrawShowForPlayer(playerid,DigitalTd[27]);
TextDrawShowForPlayer(playerid,DigitalTd[28]);
}
if(number == 2 || number == 12 || number == 22 || number == 32 || number == 42 || number == 52)
{
TextDrawHideForPlayer(playerid,DigitalTd[22]);
TextDrawShowForPlayer(playerid,DigitalTd[23]);
TextDrawShowForPlayer(playerid,DigitalTd[24]);
TextDrawShowForPlayer(playerid,DigitalTd[25]);
TextDrawShowForPlayer(playerid,DigitalTd[26]);
TextDrawShowForPlayer(playerid,DigitalTd[27]);
TextDrawHideForPlayer(playerid,DigitalTd[28]);
}
if(number == 3 || number == 13 || number == 23 || number == 33 || number == 43 || number == 53)
{
TextDrawHideForPlayer(playerid,DigitalTd[22]);
TextDrawHideForPlayer(playerid,DigitalTd[23]);
TextDrawShowForPlayer(playerid,DigitalTd[24]);
TextDrawShowForPlayer(playerid,DigitalTd[25]);
TextDrawShowForPlayer(playerid,DigitalTd[26]);
TextDrawShowForPlayer(playerid,DigitalTd[27]);
TextDrawShowForPlayer(playerid,DigitalTd[28]);
}
if(number == 4 || number == 14 || number == 24 || number == 34 || number == 44 || number == 54)
{
TextDrawShowForPlayer(playerid,DigitalTd[22]);
TextDrawHideForPlayer(playerid,DigitalTd[23]);
TextDrawHideForPlayer(playerid,DigitalTd[24]);
TextDrawShowForPlayer(playerid,DigitalTd[25]);
TextDrawHideForPlayer(playerid,DigitalTd[26]);
TextDrawShowForPlayer(playerid,DigitalTd[27]);
TextDrawShowForPlayer(playerid,DigitalTd[28]);
}
if(number == 5 || number == 15 || number == 25 || number == 35 || number == 45 || number == 55)
{
TextDrawShowForPlayer(playerid,DigitalTd[22]);
TextDrawHideForPlayer(playerid,DigitalTd[23]);
TextDrawShowForPlayer(playerid,DigitalTd[24]);
TextDrawShowForPlayer(playerid,DigitalTd[25]);
TextDrawShowForPlayer(playerid,DigitalTd[26]);
TextDrawHideForPlayer(playerid,DigitalTd[27]);
TextDrawShowForPlayer(playerid,DigitalTd[28]);
}
if(number == 6 || number == 16 || number == 26 || number == 36 || number == 46 || number == 56)
{
TextDrawShowForPlayer(playerid,DigitalTd[22]);
TextDrawShowForPlayer(playerid,DigitalTd[23]);
TextDrawShowForPlayer(playerid,DigitalTd[24]);
TextDrawShowForPlayer(playerid,DigitalTd[25]);
TextDrawShowForPlayer(playerid,DigitalTd[26]);
TextDrawHideForPlayer(playerid,DigitalTd[27]);
TextDrawShowForPlayer(playerid,DigitalTd[28]);
}
if(number == 7 || number == 17 || number == 27 || number == 37 || number == 47 || number == 57)
{
TextDrawShowForPlayer(playerid,DigitalTd[22]);
TextDrawHideForPlayer(playerid,DigitalTd[23]);
TextDrawHideForPlayer(playerid,DigitalTd[24]);
TextDrawHideForPlayer(playerid,DigitalTd[25]);
TextDrawShowForPlayer(playerid,DigitalTd[26]);
TextDrawShowForPlayer(playerid,DigitalTd[27]);
TextDrawShowForPlayer(playerid,DigitalTd[28]);
}
if(number == 8 || number == 18 || number == 28 || number == 38 || number == 48 || number == 58)
{
TextDrawShowForPlayer(playerid,DigitalTd[22]);
TextDrawShowForPlayer(playerid,DigitalTd[23]);
TextDrawShowForPlayer(playerid,DigitalTd[24]);
TextDrawShowForPlayer(playerid,DigitalTd[25]);
TextDrawShowForPlayer(playerid,DigitalTd[26]);
TextDrawShowForPlayer(playerid,DigitalTd[27]);
TextDrawShowForPlayer(playerid,DigitalTd[28]);
}
if(number == 9 || number == 19 || number == 29 || number == 39 || number == 49 || number == 59)
{
TextDrawShowForPlayer(playerid,DigitalTd[22]);
TextDrawHideForPlayer(playerid,DigitalTd[23]);
TextDrawShowForPlayer(playerid,DigitalTd[24]);
TextDrawShowForPlayer(playerid,DigitalTd[25]);
TextDrawShowForPlayer(playerid,DigitalTd[26]);
TextDrawShowForPlayer(playerid,DigitalTd[27]);
TextDrawShowForPlayer(playerid,DigitalTd[28]);
}
}
new hostsira;
public Timer()
{
switch(hostsira)
{
	case 0: SendRconCommand("hostname (Z) » Zero Online « - Eðlence Serveri [Ultra-H.com]"), hostsira=1;
	case 1: SendRconCommand("hostname (Z) » Zero Online « - International Server [Ultra-H.com]"), hostsira=2;
	case 2: SendRconCommand("hostname (Z) » Zero Online « - Stunt/DM/Race [Ultra-H.com]"), hostsira=0;
}
for(new playerid;playerid<MAX_PLAYERS;playerid++)
{
new h,m,s;
gettime(h,m,s);
if(IsPlayerSpawned[playerid] == 1)
{
SetHours(playerid,h+1);
SetMin(playerid,m);
}
}
return 1;
}

stock SetHours(playerid,hour)
{
if(hour == 0)
{
SetStringForFrstNumber(playerid,0);
SetStringForSecondNumber(playerid,0);
return 1;
}
if(hour <= 9)
{
SetStringForFrstNumber(playerid,0);
SetStringForSecondNumber(playerid,hour);
return 1;
}
if(hour <= 19)
{
SetStringForFrstNumber(playerid,1);
SetStringForSecondNumber(playerid,hour);
return 1;
}
if(hour <= 23)
{
SetStringForFrstNumber(playerid,2);
SetStringForSecondNumber(playerid,hour);
return 1;
}
return 1;
}

stock SetMin(playerid,min)
{
if(min == 0)
{
SetStringForThirdNumber(playerid,0);
SetStringForFourthNumber(playerid,0);
return 1;
}
if(min <= 9)
{
SetStringForThirdNumber(playerid,0);
SetStringForFourthNumber(playerid,min);
return 1;
}
if(min <= 19)
{
SetStringForThirdNumber(playerid,1);
SetStringForFourthNumber(playerid,min);
return 1;
}
if(min <= 29)
{
SetStringForThirdNumber(playerid,2);
SetStringForFourthNumber(playerid,min);
return 1;
}
if(min <= 39)
{
SetStringForThirdNumber(playerid,3);
SetStringForFourthNumber(playerid,min);
return 1;
}
if(min <= 49)
{
SetStringForThirdNumber(playerid,4);
SetStringForFourthNumber(playerid,min);
return 1;
}
if(min <= 59)
{
SetStringForThirdNumber(playerid,5);
SetStringForFourthNumber(playerid,min);
return 1;
}
return 1;
}








stock TimeConverter(time){
new Float:vard = floatdiv(time, 60000);
new as = floatround(vard, floatround_tozero);
new ass = floatround(floatmul(vard - as, 60), floatround_tozero);
new a[128];
if(as == 0){
format(a,128,"{0077FF}%d{FFFFFF} saniye",ass);
}else if(ass == 0){
format(a,128,"{0077FF}%d{FFFFFF} dakika",as);
}else{
format(a,128,"{0077FF}%d{FFFFFF} dakika {0077FF}%d{FFFFFF} saniye",as,ass);
}
return a;
}
stock TimeConverterz(time){
new Float:vard = floatdiv(time, 60000);
new as = floatround(vard, floatround_tozero);
new ass = floatround(floatmul(vard - as, 60), floatround_tozero);
new a[128];
if(as == 0){
format(a,128,"00:00:%02d",ass);
}else if(ass == 0){
format(a,128,"00:%02d:00",as);
}else{
format(a,128,"00:%02d:%02d",as,ass);
}
return a;
}
stock TusName(tusid)
{
	new stre[16];
	switch(tusid)
	{
	    case 1:strcat(stre,"Hiz");
	    case 2:strcat(stre,"Ziplama");
	    case 3:strcat(stre,"Yon_X");
	    case 4:strcat(stre,"Yon_X");
	    case 5:strcat(stre,"Yon_Z");
	    case 6:strcat(stre,"Cevirme");
	    case 7:strcat(stre,"Renk");
		case 8:strcat(stre,"Fren");
		case 9:strcat(stre,"Bagaj");
		case 10:strcat(stre,"Kaput");
		case 11:strcat(stre,"Alarm");
		case 12:strcat(stre,"Far");
		case 13:strcat(stre,"Motor");
	    default:strcat(stre,"Bos");
	}
	return stre;
}
stock AdvanceSpectate(playerid)
{
    if(Iter_Count(Player) == 2)
	{
		StopSpectate(playerid);
		return 1;
	}
	if(PVG->Int->specplayer[playerid] == INVALID_PLAYER_ID)PVS->Int->specplayer[playerid]->-1;
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
	{
	    for(new x=PVG->Int->specplayer[playerid]+1; x<MAX_PLAYERS; x++)
		{
	        if(IsPlayerConnected(x) && x != playerid && PlayerInfo[playerid][Level] > PlayerInfo[x][Level])
			{
				if(GetPlayerState(x) == PLAYER_STATE_SPECTATING || (GetPlayerState(x) != 1 && GetPlayerState(x) != 2 && GetPlayerState(x) != 3))
				{
					continue;
				}
				else
				{
					StartSpectate(playerid, x);
					break;
				}
			}
		}
	}
	return 1;
}
stock StartSpectate(playerid, specplayerid)
{
	for(new x=0; x<MAX_PLAYERS; x++)
	{
	    if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PVG->Int->specplayer[playerid] == playerid)
		{
	       AdvanceSpectate(x);
		}
	}
	new str[129];
	PVS->Int->spectime[playerid]->gettime();
	SetPlayerInterior(playerid,GetPlayerInterior(specplayerid));
	SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(specplayerid));
	TogglePlayerSpectating(playerid, 1);
	PlayerInfo[playerid][spec] = 1;
	PVS->Int->specplayer[playerid]->specplayerid;
	format(str,128,"~y~~h~%s~r~~h~(~w~~h~~h~~h~%d~r~~h~)~n~Money:~r~~h~%d~n~Score:~r~~h~%d",getName(specplayerid),specplayerid,GetPlayerMoney(specplayerid),GetPlayerScore(specplayerid));
	PlayerTextDrawSetString(playerid, SpecTD[1][playerid], str);
	format(str,128,"~y~~h~Mycar~n~~g~~h~~h~Y:~w~~h~~h~~h~%s_~g~~h~N:~w~~h~~h~~h~%s",TusName(PVG->Int->firekey[specplayerid]),TusName(PVG->Int->hkey[specplayerid]));
	PlayerTextDrawSetString(playerid, SpecTD[2][playerid], str);
	format(str,128,"~p~~h~Suphe: ~w~~h~~h~~h~%s",GetPlayerSuphe(specplayerid));
	PlayerTextDrawSetString(playerid, SpecTD[4][playerid], str);
	for(new i;i < 5;i++)PlayerTextDrawShow(playerid, SpecTD[i][playerid]);
	if(IsPlayerInAnyVehicle(specplayerid))
	{
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specplayerid));
	}
	else
	{
		PlayerSpectatePlayer(playerid, specplayerid);
	}
	return 1;
}
stock StopSpectate(playerid)
{
	PlayerInfo[playerid][spec] = 0;
	for(new i;i < 5;i++)PlayerTextDrawHide(playerid, SpecTD[i][playerid]);
	TogglePlayerSpectating(playerid, 0);
	SetPlayerVirtualWorld(playerid,0);
	PVS->Int->specplayer[playerid]->INVALID_PLAYER_ID;
	PlayerInfo[playerid][spectime] += (gettime()-PVG->Int->spectime[playerid]);
	return 1;
}
stock GetPlayerSuphe(playerid)
{
	new
	    supheSTR[512]
	;
	if(GetPVarInt(playerid, "suphe") == 6) strcat(supheSTR, "Airbreak_FLY_Hack");
	if(GetPVarInt(playerid, "suphe") == 5) strcat(supheSTR, "Airbreak");
	if(GetPVarInt(playerid, "suphe") == 4) strcat(supheSTR, "FLY_Hack");
	if(GetPVarInt(playerid, "suphe") == 0) strcat(supheSTR, "Supheli durum yok.");
	return supheSTR;
}
stock PutPlayerInInVehicle(playerid, a, b)
{
	if(GetPVarInt(playerid, "Spawned") == 0)
	{
		return 0;
	}
	PutPlayerInVehicle(playerid, a, b);
	return 1;
}
#undef PutPlayerInVehicle
#define PutPlayerInVehicle PutPlayerInInVehicle
//;
stock onlyLetterNumbers(playerid, string[])
{
	new
	   dddd[][] =
	   {
	        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
	        "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
	        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
	        "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
	        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ", "ç", "Ç",
			"ö", "Ö", "ü", "Ü", "ð", "Ð", "ý", "Ý"
		};
	new cccc;
	for(new x; x < sizeof(dddd); x++)
	{
		if(strfind(string, dddd[x][0], true) != -1) return cccc++;
	}
	if(cccc == 0) return Hatamesaj(playerid, "Mesajýnýz sadece harf ve sayý içermelidir.", "Only letter and numbers.");
	else Hatamesaj(playerid, "Tamam uygun.", "Okey, correct text.");
	return 1;
}

//function ipSifirla()
//{/
	//ipGirebilir = 0;
	//return 1;
//}
stock isNumeric(const string[])
{
    for (new i = 0, j = strlen(string); i < j; i++)
    {
        if (string[i] > '9' || string[i] < '0') return 0;
    }
    return 1;
}
forward CheckAFK();
public CheckAFK()
{
    foreach(new i:Player){
        AFK[i] ++;
    }
}
forward JailSave(adminid,kickerid,sebep[]);
public JailSave(adminid,kickerid,sebep[])
{
    new query[256],AdminIP[20],PidIP[20],hour,minute,second,year,month,day;
	if(adminid != -1){
		GetPlayerIp(adminid,AdminIP,20); GetPlayerIp(kickerid, PidIP, 20);
		gettime(hour, minute, second); getdate(year, month, day);
		format(query, sizeof(query), "INSERT INTO `kayitlar` (kayittip, kayit, kayitip, admin, adminip, sebep, zaman, tarih) VALUES(\"Jail\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%d:%d:%d\", \"%d.%d.%d\")", oIsim(kickerid), PidIP, oIsim(adminid), AdminIP, code(sebep), hour, minute, second, day, month, year);
		mysql_query(query);//	mysql_free_result();
	}else{
		GetPlayerIp(kickerid, PidIP, 20); gettime(hour, minute, second); getdate(year, month, day);
		format(query, sizeof(query), "INSERT INTO `kayitlar` (kayittip, kayit, kayitip, admin, adminip, sebep, zaman, tarih) VALUES(\"Jail\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%d:%d:%d\", \"%d.%d.%d\")", oIsim(kickerid), PidIP, "Sistem", "localhost", code(sebep), hour, minute, second, day, month, year);
		mysql_query(query);//	mysql_free_result();
	}
}
forward WarnSave(adminid,kickerid,sebep[]);
public WarnSave(adminid,kickerid,sebep[])
{
    new query[256],AdminIP[20],PidIP[20],hour,minute,second,year,month,day;
	if(adminid != -1){
		GetPlayerIp(adminid,AdminIP,20); GetPlayerIp(kickerid, PidIP, 20);
		gettime(hour, minute, second); getdate(year, month, day);
		format(query, sizeof(query), "INSERT INTO `kayitlar` (kayittip, kayit, kayitip, admin, adminip, sebep, zaman, tarih) VALUES(\"WARN\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%d:%d:%d\", \"%d.%d.%d\")", oIsim(kickerid), PidIP, oIsim(adminid), AdminIP, code(sebep), hour, minute, second, day, month, year);
		mysql_query(query); //mysql_free_result();
	}else{
		GetPlayerIp(kickerid, PidIP, 20); gettime(hour, minute, second); getdate(year, month, day);
		format(query, sizeof(query), "INSERT INTO `kayitlar` (kayittip, kayit, kayitip, admin, adminip, sebep, zaman, tarih) VALUES(\"WARN\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%d:%d:%d\", \"%d.%d.%d\")", oIsim(kickerid), PidIP, "Sistem", "localhost", code(sebep), hour, minute, second, day, month, year);
		mysql_query(query); //mysql_free_result();
	}
}

forward KickSave(adminid,kickerid,sebep[]);
public KickSave(adminid,kickerid,sebep[])
{
    new query[256],AdminIP[20],PidIP[20],hour,minute,second,year,month,day;
	if(adminid != -1){
		GetPlayerIp(adminid,AdminIP,20); GetPlayerIp(kickerid, PidIP, 20);
		gettime(hour, minute, second); getdate(year, month, day);
		format(query, sizeof(query), "INSERT INTO `kayitlar` (kayittip, kayit, kayitip, admin, adminip, sebep, zaman, tarih) VALUES(\"KICK\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%02d:%02d:%02d\", \"%d.%d.%d\")", oIsim(kickerid), PidIP, oIsim(adminid), AdminIP, code(sebep), hour, minute, second, day, month, year);
		mysql_query(query); //mysql_free_result();
	}else{
		GetPlayerIp(kickerid, PidIP, 20); gettime(hour, minute, second); getdate(year, month, day);
		format(query, sizeof(query), "INSERT INTO `kayitlar` (kayittip, kayit, kayitip, admin, adminip, sebep, zaman, tarih) VALUES(\"KICK\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%02d:%02d:%02d\", \"%d.%d.%d\")", oIsim(kickerid), PidIP, "Sistem", "localhost", code(sebep), hour, minute, second, day, month, year);
		mysql_query(query); //mysql_free_result();
	}
}

forward BanSave(adminid,kickerid,sebep[]);
public BanSave(adminid,kickerid,sebep[])
{
	new query[256],AdminIP[20],PidIP[20],hour,minute,second,year,month,day;
	if(adminid != -1){
		GetPlayerIp(adminid,AdminIP,20); GetPlayerIp(kickerid, PidIP, 20);
		gettime(hour, minute, second); getdate(year, month, day);
		format(query, sizeof(query), "INSERT INTO `kayitlar` (kayittip, kayit, kayitip, admin, adminip, sebep, zaman, tarih) VALUES(\"BAN\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%d:%d:%d\", \"%d.%d.%d\")", oIsim(kickerid), PidIP, oIsim(adminid), AdminIP, code(sebep), hour, minute, second, day, month, year);
		mysql_query(query); //mysql_free_result();
	}else{
	    GetPlayerIp(adminid,AdminIP,20); GetPlayerIp(kickerid, PidIP, 20);
		gettime(hour, minute, second); getdate(year, month, day);
		format(query, sizeof(query), "INSERT INTO `kayitlar` (kayittip, kayit, kayitip, admin, adminip, sebep, zaman, tarih) VALUES(\"BAN\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%d:%d:%d\", \"%d.%d.%d\")", oIsim(kickerid), PidIP, "Sistem", "localhost", code(sebep), hour, minute, second, day, month, year);
		mysql_query(query); //mysql_free_result();
 	}
}

forward NBanSave(adminid,kickerid,sebep[]);
public NBanSave(adminid,kickerid,sebep[])
{
	new query[256],AdminIP[20],PidIP[20],hour,minute,second,year,month,day;
	if(adminid != -1){
		GetPlayerIp(adminid,AdminIP,20); GetPlayerIp(kickerid, PidIP, 20);
		gettime(hour, minute, second); getdate(year, month, day);
		format(query, sizeof(query), "INSERT INTO `kayitlar` (kayittip, kayit, kayitip, admin, adminip, sebep, zaman, tarih) VALUES(\"NBAN\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%d:%d:%d\", \"%d.%d.%d\")", oIsim(kickerid), PidIP, oIsim(adminid), AdminIP, code(sebep), hour, minute, second, day, month, year);
		mysql_query(query); //mysql_free_result();
	}else{
	    GetPlayerIp(adminid,AdminIP,20); GetPlayerIp(kickerid, PidIP, 20);
		gettime(hour, minute, second); getdate(year, month, day);
		format(query, sizeof(query), "INSERT INTO `kayitlar` (kayittip, kayit, kayitip, admin, adminip, sebep, zaman, tarih) VALUES(\"NBAN\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%d:%d:%d\", \"%d.%d.%d\")", oIsim(kickerid), PidIP, "Sistem", "localhost", code(sebep), hour, minute, second, day, month, year);
		mysql_query(query);// mysql_free_result();
 	}
}

forward MessageToAdmins(color,const string[]);
public MessageToAdmins(color,const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1) if (PlayerInfo[i][Level] >= 2) SendClientMessage(i, color, string);
	}
	return 1;
}

forward MessageToAnims(color,const string[]);
public MessageToAnims(color,const string[]){
	for(new i = 0; i < MAX_PLAYERS; i++){
		if(IsPlayerConnected(i) == 1)
			if(PlayerInfo[i][Level] >= 1 || PlayerInfo[i][Animator] >= 1)
				SendClientMessage(i, color, string);
	}
	return 1;
}

/*
function MessageToAdmins(renk, const str[])
{
	foreach(new a:Player)
	{
	    if(PlayerInfo[a][Level] > 0) return SendClientMessage(a, renk, str);
	}
	return 1;
}
function MessageToAnims(renk, const str[])
{
	foreach(new a:Player)
	{
	    if(PlayerInfo[a][Animator] > 0 || PlayerInfo[a][Level] > 0) return SendClientMessage(a, renk, str);
	}
	return 1;
}
*/
function chatText()
{
	switch(random(11))
	{
		case 0: SendClientMessageToAll(-1, "{C3C3C3}« Information »{FFFFFF} Unutma! Websitemiz www.zerotr.com'dur, üye olabilirsin.");
		case 1: SendClientMessageToAll(-1, "{C3C3C3}« Information »{FFFFFF} Yoksa aracsiz mi kaldin hadi adamim uzme beni ve /v1-17|/m1-20 kullan.");
		case 2: SendClientMessageToAll(-1, "{C3C3C3}« Information »{FFFFFF} Hey adamim! Araca bindin de ne yapiyorsun! /teles'den stuntlarda eglen.");
		case 3: SendClientMessageToAll(-1, "{C3C3C3}« Information »{FFFFFF} Hey ahbap! Üzme beni ve sunucumu favorilere ekle ["SERVER_IP":7777]");
		case 4: SendClientMessageToAll(-1, "{C3C3C3}« Information »{FFFFFF} Bir hileci mi gordün ? /report [rapor yazisi] ile adminlere bildir!");
		case 5: SendClientMessageToAll(-1, "{C3C3C3}« Information »{FFFFFF} Hey ahbap! Üzme beni ve sunucumu favorilere ekle ["SERVER_IP":7777]");
		case 6: SendClientMessageToAll(-1, "{C3C3C3}« Information »{FFFFFF} Kokoþ bir hileci mi gordün ? /report [rapor yazisi] ile adminlere bildir!");
	}
	return 1;
}
function derbyUz()
{
    if(DDBasladi == true || ddStarted == 1) return 1;
	if(DDOyuncu == 0) SetTimerEx("DDSayim", 1000, false, "i", BEKLEME_SURESI);
	return 1;
}
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                ANTI-CRASH 2
        if(weaponid != 38 && weaponid != WEAPON_TEC9	)
        {
                if((gettime() - shotTime[playerid]) < 1)
                {
                    shot[playerid]+=1;
                }
                else
                {
                    shot[playerid]=0;
                }
                if(shot[playerid] > 10)
                {
                        Kickle(playerid, "Rapid Fire");
                }
                shotTime[playerid] = gettime();
        }
if( hittype != BULLET_HIT_TYPE_NONE )
    {
        if( !( -1000.0 <= fX <= 1000.0 ) || !( -1000.0 <= fY <= 1000.0 ) || !( -1000.0 <= fZ <= 1000.0 ) )
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
	format(string, sizeof(string), "{FFFFFF}Sunucudan name banlandiniz ! Detaylar:\n{FFFFFF}Banlayan:{E24234} Console\n{FFFFFF}Sebep:{E24234} Crasher\n{FFFFFF}Tarih:{E24234}%d.%d.%d\n\n{FFFFFF}Gereksiz yere n-banlandiginiz dusunuyorsaniz zerotr.com/forum adresimizden sikayet olusturun.", yil, ay, gun);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK"{FFFFFF} - N-Banlandiniz!", string, "Tamam", "");
	TogglePlayerControllable(playerid, 0);
	PlayerInfo[playerid][banned] = 1;
	SetPVarInt(playerid, "NameBan", 1);
	SetTimerEx("banPlayer", 500, false, "i", playerid);
	format(string, sizeof(string), "~r~[~w~~h~~h~~h~N-BAN~r~]~p~ Console~w~~h~~h~~h~ >>>~p~~h~%s~w~~h~~h~~h~ [Gerekce: ~r~Crasher~w~~h~~h~~h~]", oIsim(playerid));
	TextMesaj(string, string);
	NBanSave(playerid, playerid, "Crasher");
            return 0; //
             }
            }


         if(hittype != BULLET_HIT_TYPE_NONE)//0.3.7 Aim Crash
{

	if((fX <= -1000.0 || fX >= 1000.0) || (fY <= -1000.0 || fY >= 1000.0) || (fZ <= -1000.0 || fZ >= 1000.0) || ((hittype != BULLET_HIT_TYPE_PLAYER) && (hittype != BULLET_HIT_TYPE_VEHICLE) && (hittype != BULLET_HIT_TYPE_OBJECT) && (hittype != BULLET_HIT_TYPE_PLAYER_OBJECT)))
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
	format(string, sizeof(string), "{FFFFFF}Sunucudan name banlandiniz ! Detaylar:\n{FFFFFF}Banlayan:{E24234} Console\n{FFFFFF}Sebep:{E24234} Crasher\n{FFFFFF}Tarih:{E24234}%d.%d.%d\n\n{FFFFFF}Gereksiz yere n-banlandiginiz dusunuyorsaniz zerotr.com/forum adresimizden sikayet olusturun.", yil, ay, gun);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK"{FFFFFF} - N-Banlandiniz!", string, "Tamam", "");
	TogglePlayerControllable(playerid, 0);
	PlayerInfo[playerid][banned] = 1;
	SetPVarInt(playerid, "NameBan", 1);
	SetTimerEx("banPlayer", 500, false, "i", playerid);
	format(string, sizeof(string), "~r~[~w~~h~~h~~h~N-BAN~r~]~p~ Console~w~~h~~h~~h~ >>>~p~~h~%s~w~~h~~h~~h~ [Gerekce: ~r~Crasher~w~~h~~h~~h~]", oIsim(playerid));
	TextMesaj(string, string);
	NBanSave(playerid, playerid, "Crasher");
		return 0; //Para desincronizar o tiro e não crashar ninguém
	}
}
if(hittype != BULLET_HIT_TYPE_NONE) //0.3z -  Bullet Crashing uses just this hittype
{

	if(!(-1000.0 <= fX <= 1000.0) || !(-1000.0 <= fY <= 1000.0) || !(-1000.0 <= fZ <= 1000.0)) // 0.3z Bullet Crash
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
	format(string, sizeof(string), "{FFFFFF}Sunucudan name banlandiniz ! Detaylar:\n{FFFFFF}Banlayan:{E24234} Console\n{FFFFFF}Sebep:{E24234} Crasher\n{FFFFFF}Tarih:{E24234}%d.%d.%d\n\n{FFFFFF}Gereksiz yere n-banlandiginiz dusunuyorsaniz zerotr.com/forum adresimizden sikayet olusturun.", yil, ay, gun);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{E24234}"DIALOG_BASLIK"{FFFFFF} - N-Banlandiniz!", string, "Tamam", "");
	TogglePlayerControllable(playerid, 0);
	PlayerInfo[playerid][banned] = 1;
	SetPVarInt(playerid, "NameBan", 1);
	SetTimerEx("banPlayer", 500, false, "i", playerid);
	format(string, sizeof(string), "~r~[~w~~h~~h~~h~N-BAN~r~]~p~ Console~w~~h~~h~~h~ >>>~p~~h~%s~w~~h~~h~~h~ [Gerekce: ~r~Crasher~w~~h~~h~~h~]", oIsim(playerid));
	TextMesaj(string, string);
	NBanSave(playerid, playerid, "Crasher");
		return 0; //Para desincronizar o tiro e não crashar ninguém
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/*if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER && hittype == BULLET_HIT_TYPE_PLAYER){
	    new gVeh = GetVehicleModel(GetPlayerVehicleID(playerid));
	    if(gVeh == 581 || gVeh == 522 || gVeh == 461 || gVeh == 521 || gVeh == 523 || gVeh == 463 || gVeh == 586 || gVeh == 468 || gVeh == 471){
		new Float:Health, Float:x, Float:y, Float:z,player1=playerid; GetPlayerHealth(player1,Health); SetPlayerHealth(player1,Health-10);
		GetPlayerPos(player1,x,y,z); SetPlayerPos(player1,x,y,z+5); PlayerPlaySound(playerid,1190,0.0,0.0,0.0); PlayerPlaySound(player1,1190,0.0,0.0,0.0);
	    SendClientMessage(playerid,-1,"{E24234}Motor Bug: {FFFFFF}Motor bug tespit edildi!");
		}
	}
    return 1;
}*/ return 1;
         }

forward public DDSayim(sure);
forward public DDKontrol();
public DDSayim(sure)
{
    new string[145], id = 1056;
	sure--;
	if(sure == 29 || sure == 15)
	{
	    ddtype = random(2);
	    if (ddtype == 0) ddtype = 1;
		if(ddtype == 1) format(string, sizeof(string),"~g~[DD]~w~~h~~h~~h~ Birazdan ~r~~h~Trumpth~w~~h~~h~~h~ isimli DD baslayacak. Gitmek icin ~y~~h~/ddgit~w~~h~~h~~h~ yazin.");
		if(ddtype == 2) format(string, sizeof(string),"~g~[DD]~w~~h~~h~~h~ Birazdan ~r~~h~Prumpy~w~~h~~h~~h~ isimli DD baslayacak. Gitmek icin ~y~~h~/ddgit~w~~h~~h~~h~ yazin.");
		ddBasladid = 1, TextMesaj(string,string);
	}
	if(sure < 1) {
	    if(DDOyuncu < 2) {
	        ddStarted = 0;
			TextMesaj("~g~[DD]~w~~h~~h~~h~ Yeterli katilim olmadigi icin iptal edildi.","~g~[DD]~w~~h~~h~~h~ Yeterli katilim olmadigi icin iptal edildi.");
			for(new i; i < MAX_PLAYERS; ++i)
			{
			    if(!IsPlayerConnected(i)) continue;
			    DDCikar(i, 5);
			}
            ddBasladid = 0;
			DDOyuncu = 0;
			DDBasladi = false;
			DDTimer = -1;
			return 1;
	    }else{
			for(new i; i < MAX_PLAYERS; ++i)
			{
			    if(!IsPlayerConnected(i)) continue;
		    	if(DDArac[i] != INVALID_VEHICLE_ID)
				{
				     SetCameraBehindPlayer(i);
				}
			}
	        DDBasladi = true;
			TextMesaj("~g~[DD]~w~~h~~h~~h~ Katilimlar durdu.","~g~[DD]~w~~h~~h~~h~ Katilimlar durdu.");
	        DDTimer = SetTimer("DDKontrol", 1000, true);
		    format(string, sizeof(string), "START!");
		    id = 1057;
	    }
	}else{
	    ddBasladid = 1;
	    format(string, sizeof(string), "~y~DERBY STARTED IN~n~~y~- ~w~~h~~h~~h~%i~y~ -~n~~y~SECONDS", sure);
	    id = 1056;
	}

	for(new i; i < MAX_PLAYERS; ++i)
 	{
  		if(!IsPlayerConnected(i)) continue;
    	if(DDArac[i] != INVALID_VEHICLE_ID)
		{
  			PlayerPlaySound(i, id, 0.0, 0.0, 0.0);
			GameTextForPlayer(i, string, (sure > 0) ? 1000 : 3000, 4);
			if(sure < 1) TogglePlayerControllable(i, 1);
		}
  	}

  	if(sure > 0) SetTimerEx("DDSayim", 1000, false, "i", sure);
	return 1;
}

public DDKontrol()
{
	new Float: z;
	for(new i; i < MAX_PLAYERS; ++i)
	{
	    if(!IsPlayerConnected(i)) continue;
	    if(DDArac[i] == INVALID_VEHICLE_ID) continue;
	    if(DDBasladi == false) continue;
	    GetPlayerPos(i, z, z, z);
	    if(z < 10.5) DDCikar(i, 2);
	    if(GetPlayerFPS(i) < 20 && GetPlayerFPS(i) != 0 && GetPlayerFPS(i) != 1) DDCikar(i, 8);
	}

	return 1;
}

stock strreplace(trg[],newstr[],src[]) {
    new f=0;
    new s1[500];
    new tmp[500];
    format(s1,sizeof(s1),"%s",src);
    f = strfind(s1,trg);
    tmp[0]=0;
    while (f>=0) {
        strcat(tmp,ret_memcpy(s1, 0, f));
        strcat(tmp,newstr);
        format(s1,sizeof(s1),"%s",ret_memcpy(s1, f+strlen(trg), strlen(s1)-f));
        f = strfind(s1,trg);
    }
    strcat(tmp,s1);
    return tmp;
}

ret_memcpy(source[],index=0,numbytes) {
	new tmp[500];
	new i=0;
	tmp[0]=0;
	if (index>=strlen(source)) return tmp;
	if (numbytes+index>=strlen(source)) numbytes=strlen(source)-index;
	if (numbytes<=0) return tmp;
	for (i=index;i<numbytes+index;i++) {
		tmp[i-index]=source[i];
		if (source[i]==0) return tmp;
	}
	tmp[numbytes]=0;
	return tmp;
}

stock PlayerName(playerid) {
    new name[24];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}

forward AntiSpam(playerid);
public AntiSpam(playerid) {
    RecentlyShot[playerid] = 0;
    return 1;
}
stock HeadshotCheck(playerid, &Float:x, &Float:y, &Float:z)
{
	#emit LOAD.S.alt playerid
/*    new Float:fx,Float:fy,Float:fz;
    GetPlayerCameraFrontVector(playerid, fx, fy, fz);

    new Float:cx,Float:cy,Float:cz;
    GetPlayerCameraPos(playerid, cx, cy, cz);

    for(new Float:i = 0.0; i < 50; i = i + 0.5)
    {
        x = fx * i + cx;
        y = fy * i + cy;
        z = fz * i + cz;

        #if defined SHOWPATH
        CreatePickup(1239, 4, x, y, z, -1);
        #endif

        for(new player = 0; player < SERVER_MAX_PLAYERS; player ++)
        {
            if(IsPlayerConnected(playerid))
            {
                if(player != playerid)
                {
                    if(GetPlayerSpecialAction(player) == SPECIAL_ACTION_DUCK)
                    {
                        if(IsPlayerInRangeOfPoint(player, 0.3, x, y, z))
                        {
                            GameTextForPlayer(playerid, "~w~~h~~h~~h~TAM KAFADAN !!!", 2000, 2);
							PlayerPlaySound(playerid,17802,0.0,0.0,0.0);


                            SetPlayerHealth(player, 0.0);
                            CallRemoteFunction("OnPlayerDeath", "ddd", player, playerid, 34);
                        }
                    }
                    else
                    {
                        if(IsPlayerInRangeOfPoint(player, 0.3, x, y, z - 0.7))
                        {
   	 	                    GameTextForPlayer(playerid, "~w~~h~~h~~h~TAM KAFADAN !!!", 2000, 2);
							PlayerPlaySound(playerid,17802,0.0,0.0,0.0);

                            SetPlayerHealth(player, 0.0);
                            CallRemoteFunction("OnPlayerDeath", "ddd", player, playerid, 34);
                        }
                    }
                }
            }
        }
    }
*/    return 1;
}

public OnPlayerAirbreak(playerid)
{
    if(GetPVarInt(playerid, "Uyari") == 0 || GetPVarInt(playerid, "Uyari") == 1 || GetPVarInt(playerid, "Uyari") == 2)
	{
		SetPVarInt(playerid, "Uyari", GetPVarInt(playerid, "Uyari")+1);
		if(GetPVarInt(playerid, "suphe") == 5) SetPVarInt(playerid, "suphe", 6);
		else SetPVarInt(playerid, "suphe", 4);
	}
	else if(GetPVarInt(playerid, "Uyari") == 3) Kickle(playerid, "Airbreak");
	return 1;
}

stock TimeConvert(time){
new Float:vaar = floatdiv(time, 60);
new as = floatround(vaar, floatround_tozero);
new ass = floatround(floatmul(vaar - as, 60), floatround_tozero);
new a[128];
if(as == 0){
format(a,128,"{E24234}%d saniye",ass);
}else if(ass == 0){
format(a,128,"{E24234}%d dakika",as);
}else{
format(a,128,"{E24234}%d dakika {E24234}%d saniye",as,ass);
}
return a;
}
stock GetPlayerFPS(playerid)
{
	SetPVarInt(playerid, "DrunkL", GetPlayerDrunkLevel(playerid));
 	if(GetPVarInt(playerid, "DrunkL") < 100) SetPlayerDrunkLevel(playerid, 2000);
 		else{
   			if(GetPVarInt(playerid, "LDrunkL") != GetPVarInt(playerid, "DrunkL"))
      		{
       			SetPVarInt(playerid, "FPS", (GetPVarInt(playerid, "LDrunkL") - GetPVarInt(playerid, "DrunkL")));
          		SetPVarInt(playerid, "LDrunkL", GetPVarInt(playerid, "DrunkL"));
            	if((GetPVarInt(playerid, "FPS") > 0) && (GetPVarInt(playerid, "FPS") < 256))
             	{
              		return GetPVarInt(playerid, "FPS") - 1;
                }
			}
		}
  	return GetPVarInt(playerid, "FPS") - 1;
}

stock spamProtect(playerid, const szSpam[], iTime) {
	new
		s_szPVar[32],
		s_iPVar
	;
	format(s_szPVar, sizeof(s_szPVar), "pv_iSpam_%s", szSpam);

	s_iPVar = GetPVarInt(playerid, s_szPVar);

	if((GetTickCount() - s_iPVar) < iTime * 1000) {
		return 0;
	} else {
		SetPVarInt(playerid, s_szPVar, GetTickCount());
	}
	return 1;
}
stock spamProtects(const szSpam[], iTime) {
	new
		s_szPVar[32],
		s_iPVar
	;
	format(s_szPVar, sizeof(s_szPVar), "pv_iSpam_%s", szSpam);

	s_iPVar = GetGVarInt(s_szPVar);

	if((GetTickCount() - s_iPVar) < iTime * 1000) {
		return 0;
	} else {
		SetGVarInt(s_szPVar, GetTickCount());
	}
	return 1;
}
function lottoBaslat()
{
	if(lotoBasladi == 0)
	{
		lotoPara = random(500000);
		foreach(new a : Player)
		{
		    new estring[256];
			if(GetPVarInt(a, "Language__") == TURKISH) format(estring, sizeof(estring), "{C3C3C3}« Lotto »{FFFFFF} Bir loto basladi! Sayiyi bilenin banka hesabina {E24234}%d${FFFFFF} yüklenecektir!", lotoPara);
			if(GetPVarInt(a, "Language__") == ENGLISH) format(estring, sizeof(estring), "{C3C3C3}« Lotto »{FFFFFF} A lotto started! Reward; {E24234}%d${FFFFFF}", lotoPara);
			SendClientMessage(a, -1, estring);
			if(GetPVarInt(a, "Language__") == TURKISH)SendClientMessage(a, -1, "{C3C3C3}« Lotto »{FFFFFF} Katilmak icin {E24234}' /loto [sayi] '{FFFFFF} komutunu yazin.");
			if(GetPVarInt(a, "Language__") == ENGLISH)SendClientMessage(a, -1, "{C3C3C3}« Lotto »{FFFFFF} Lotto command; {E24234}' /lotto [number] '");
			lotoBasladi = 1;
			lotoSayi = random(99);
			SetTimer("lotoBitir", 30000, false);
		}
	}
	return 1;
}
new timerlotoa, kullanilabiliyore;
function lotoBitir()
{
	if(kullanilabiliyore == 0)
	{
	    new kazananid = -1, kazanancikti;
	    foreach(new i : Player)
	    {
	        if(GetPVarInt(i, "Lotto_Sayi") == lotoSayi)
	        {
	            kazananid = i;
				kazanancikti = 1;
	        }
			SetPVarInt(i, "Lotto", 0);
	    }
	    foreach(new a : Player)
	    {
		    if(kazanancikti == 1)
		    {
		        new estring[256];
				if(GetPVarInt(a, "Language__") == TURKISH)format(estring, sizeof(estring), "{C3C3C3}« Lotto »{FFFFFF} Loto yine kazandýrýyor! Bugün ki talihlimiz {E24234}%s{FFFFFF}'dir tebrik ederiz. Ödül: {E24234}' %d$ '", oIsim(kazananid), lotoPara);
				if(GetPVarInt(a, "Language__") == ENGLISH)format(estring, sizeof(estring), "{C3C3C3}« Lotto »{FFFFFF} Player {E24234}%s{FFFFFF}'s has won the lotto! Rewards; {E24234}' %d$ '.", oIsim(kazananid), lotoSayi);
				SendClientMessage(a, -1, estring);
				PlayerInfo[kazananid][Ikramiye] += lotoPara;
				Bilgimesaj(kazananid, "Lotoyu siz kazandýnýz! Ýkramiye (Prim) hesabýnýza paranýz yüklenmiþtir.", "Loto wonner is you! Good.");
			}
		    else
		    {
		        new estring[256];
				if(GetPVarInt(a, "Language__") == TURKISH)format(estring, sizeof(estring), "{C3C3C3}« Lotto »{FFFFFF} Lotoyu kimse kazanamadi, talihli sayi {E24234}' %d '{FFFFFF} idi, kaçýranlar için üzgünüz.", lotoSayi);
				if(GetPVarInt(a, "Language__") == ENGLISH)format(estring, sizeof(estring), "{C3C3C3}« Lotto »{FFFFFF} Loto is no wonned! Loto number: {E24234}' %d '", lotoSayi);
				SendClientMessage(a, -1, estring);
			}
		}
		lotoSayi = -1;
		lotoBasladi = 0;
		lotoPara = 0;
		kullanilabiliyore = 1;
		KillTimer(timerlotoa);
		timerlotoa = SetTimer("Kullanilabiliyore", 2000, false);
	}
	return 1;
}

function Kullanilabiliyore()
	return kullanilabiliyore = 0;

function soruTest()
{
	new
	    soruID = random(sizeof(sorular)),
	    sorulacakSoru[128],
	    szString[256]
	;
	format(sorulacakSoru, sizeof(sorulacakSoru), "%s",  sorular[soruID][Soru]);
	format(szString, sizeof(szString), "« Quiz »{FFFFFF} ' {E24234}%s{FFFFFF} ' sorusunu ilk bilen {E24234}10000${FFFFFF} - {E24234}5 {FFFFFF}score kazanir!", sorulacakSoru);
	print(szString);
	printf("%d", sizeof(szString));
	aktifSoruID = soruID;
	SendClientMessageToAll(0xC3C3C3C3, szString);
	SetTimer("SoruBitir", 20000, false);
	soruBasladi = 1;
	return 1;
}
stock Radar_GetVehicleSpeed(vehicleid)
{
	new Float:Pos[3],Float:ARRAY ;
	GetVehicleVelocity(vehicleid, Pos[0], Pos[1], Pos[2]);
	ARRAY = floatsqroot(Pos[0]*Pos[0] + Pos[1]*Pos[1] + Pos[2]*Pos[2])*200;
	return floatround(ARRAY,floatround_round);
}
/*[][] = // Not made by me
{
    	"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
        "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
        "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    	"Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
        "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
        "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
        "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
        "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
        "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
        "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
        "Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
        "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
        "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
        "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
        "Blista Compact", "Police Maverick", "Boxvillde", "Benson", "Mesa", "RC Goblin",
        "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
        "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
        "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
        "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
        "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
        "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
		"Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
        "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
        "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
        "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    	"Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
        "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
        "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
        "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car",
        "Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
        "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
        "Tiller", "Utility Trailer"
};*/
/*( vehicleid )
{
	// Function: GetVehicleSpeed( vehicleid )

	new
	    Float:x,
	    Float:y,
	    Float:z,
		vel;

	GetVehicleVelocity( vehicleid, x, y, z );

	vel = floatround( floatsqroot( x*x + y*y + z*z ) * 180 );			// KM/H
//	vel = floatround( floatsqroot( x*x + y*y + z*z ) * 180 / MPH_KMH ); // MPH

	return vel;
}
*/stock strcount(const string[], const sub[], bool:ignorecase = false, bool:count_overlapped = false) {
	new
		increment = count_overlapped ? 1 : strlen(sub),
		pos = -increment,
		count = 0
	;
	while (-1 != (pos = strfind(string, sub, ignorecase, pos + increment)))
		count++;
	return count;
}
/*stock GetOrjinalPara(playerid)
{
	return GetPlayerMoney(playerid);
}

stock GetMoney(playerid)
{
	return GetPVarInt(playerid, "Para___");
}
#define GetPlayerMoney GetMoney

stock ResetSMoney(playerid)
{
	ResetPlayerMoney(playerid);
	return 1;
}

stock ResetMoney(playerid)
{
	SetPVarInt(playerid, "Para___", 0);
	ResetPlayerMoney(playerid);
	return 1;
}
#define ResetPlayerMoney ResetMoney
*/
//|----------movement----------|
stock ShowTeles1()
{
	new Teles1[512];
	//--------------------------------------------------------------------------

	strcat(Teles1, "{E24234}»{FFFFFF} Stunts        {E24234}\t[/stunts]\n");
	strcat(Teles1, "{E24234}»{FFFFFF} Jumplar       {E24234}\t[/jumps]\n");
	strcat(Teles1, "{E24234}»{FFFFFF} DeathMatch    {E24234}[/DM]\n");
	strcat(Teles1, "{E24234}»{FFFFFF} Drift/Drag    {E24234}\t[/DD]\n");
	strcat(Teles1, "{E24234}»{FFFFFF} Races         {E24234}\t[/races]\n");
	strcat(Teles1, "{E24234}»{FFFFFF} Fun Zones     {E24234}\t[/fz]\n");
	strcat(Teles1, "{E24234}»{FFFFFF} Parkour       {E24234}\t[/parkours]\n");
	strcat(Teles1, "{E24234}»{FFFFFF} Other Teles   {E24234}\t[/others]\n");
	return Teles1;
}
//------------------------------------------------------------------------------
stock ShowTeles2()
{
	new Teles2[1024];
	//--------------------------------------------------------------------------
	strcat(Teles2, "{E24234}» {ffffff}/aa         {E24234}\tAbandoned Airport\n");
	strcat(Teles2, "{E24234}» {ffffff}/lsair      {E24234}\tLos Santos Airport\n");
	strcat(Teles2, "{E24234}» {ffffff}/lvair      {E24234}\tLas Venturas Airport\n");
	strcat(Teles2, "{E24234}» {ffffff}/sfair      {E24234}\tSan Fierro Airport\n");
	strcat(Teles2, "{E24234}» {ffffff}/chilliad   {E24234}\tMount Chilliad\n");
	strcat(Teles2, "{E24234}» {ffffff}/tube2      {E24234}\tTube2\n");
	strcat(Teles2, "{E24234}» {ffffff}/tube3      {E24234}\tTube3\n");
	strcat(Teles2, "{E24234}» {ffffff}/superstunt {E24234}\tSuper Stunt\n");
	strcat(Teles2, "{E24234}» {ffffff}/golf       {E24234}\tGolf Course\n");
	strcat(Teles2, "{E24234}» {ffffff}/stuntdam   {E24234}\tStunt Dam\n");
	strcat(Teles2, "{E24234}» {ffffff}/si         {E24234}\tSkilled Inf\n");
	strcat(Teles2, "{E24234}» {ffffff}/sfstunt    {E24234}\tSan Fierro Stunt\n");
	strcat(Teles2, "{E24234}» {ffffff}/cstunt     {E24234}\tCool Stunt\n");
	strcat(Teles2, "{E24234}» {ffffff}/s000       {E24234}\tStunt 000\n");
	strcat(Teles2, "{E24234}» {ffffff}/sss        {E24234}\tSimple StuntS\n");
	//--------------------------------------------------------------------------
	return Teles2;
}
//------------------------------------------------------------------------------
stock ShowTeles3()
{
	new Teles3[1024];
	//--------------------------------------------------------------------------
	strcat(Teles3, "{E24234}» {ffffff}/basejump  {E24234}\tBaseJump\n");
	strcat(Teles3, "{E24234}» {ffffff}/jump1     {E24234}\tJump1\n");
	strcat(Teles3, "{E24234}» {ffffff}/jump2     {E24234}\tJump2\n");
	strcat(Teles3, "{E24234}» {ffffff}/jump3     {E24234}\tJump3\n");
	strcat(Teles3, "{E24234}» {ffffff}/wjump     {E24234}\tWater Jump\n");
	strcat(Teles3, "{E24234}» {ffffff}/bcar      {E24234}\tBasket Car\n");
	strcat(Teles3, "{E24234}» {ffffff}/ljump     {E24234}\tLong Jump\n");
	strcat(Teles3, "{E24234}» {ffffff}/rjump     {E24234}\tRev Jump\n");
	strcat(Teles3, "{E24234}» {ffffff}/dunejump  {E24234}\tDune Jump\n");
	strcat(Teles3, "{E24234}» {ffffff}/tjump     {E24234}\tTunel Jump\n");
	strcat(Teles3, "{E24234}» {ffffff}/nrgjump   {E24234}\tNRG Jump\n");
	strcat(Teles3, "{E24234}» {ffffff}/placejump {E24234}\tPlace Jump\n");
	//--------------------------------------------------------------------------
	return Teles3;
}
//------------------------------------------------------------------------------
stock ShowTeles4()
{
	new Teles4[1024];
	//--------------------------------------------------------------------------
	strcat(Teles4, "{E24234}» {FFFFFF}/mg1      {E24234}\tMinigun\n");
	strcat(Teles4, "{E24234}» {FFFFFF}/mg2      {E24234}\tMinigun\n");
	strcat(Teles4, "{E24234}» {FFFFFF}/rocket   {E24234}\tRocket");
	//--------------------------------------------------------------------------
	return Teles4;
}
//------------------------------------------------------------------------------
stock ShowTeles5()
{
	new Teles5[1024];
	//--------------------------------------------------------------------------
	strcat(Teles5, "{E24234}» {FFFFFF}/drag1   {E24234}\tDrag1\n");
	strcat(Teles5, "{E24234}» {FFFFFF}/drag2   {E24234}\tDrag2\n");
	strcat(Teles5, "{E24234}» {FFFFFF}/drag3   {E24234}\tDrag3\n");
	strcat(Teles5, "{E24234}» {FFFFFF}/canyon  {E24234}\tCanyon\n");
	strcat(Teles5, "{E24234}» {FFFFFF}/drift   {E24234}\tDrift\n");
	strcat(Teles5, "{E24234}» {FFFFFF}/drift2  {E24234}\tDrift2\n");
	strcat(Teles5, "{E24234}» {FFFFFF}/drift3  {E24234}\tDrift3\n");
	strcat(Teles5, "{E24234}» {FFFFFF}/sdrift  {E24234}\tShort Drift\n");
	//--------------------------------------------------------------------------
    return Teles5;
}
//------------------------------------------------------------------------------
stock ShowTeles6()
{
	new Teles6[912];
	//--------------------------------------------------------------------------
	strcat(Teles6, "{E24234}» {FFFFFF}/race 1  {E24234}\tStrip Race\n");
	strcat(Teles6, "{E24234}» {FFFFFF}/race 2  {E24234}\tLS to SF Race\n");
	strcat(Teles6, "{E24234}» {FFFFFF}/race 3  {E24234}\tBeach Race\n");
	strcat(Teles6, "{E24234}» {FFFFFF}/race 4  {E24234}\tLS to LV Race\n");
	strcat(Teles6, "{E24234}» {FFFFFF}/race 5  {E24234}\tLV to SF Race\n");
	strcat(Teles6, "{E24234}» {FFFFFF}/race 6  {E24234}\tPort Race\n");
	strcat(Teles6, "{E24234}» {FFFFFF}/race 7  {E24234}\tTravel Race\n");
	strcat(Teles6, "{E24234}» {FFFFFF}/race 8  {E24234}\tBanditos Race\n");
	strcat(Teles6, "{E24234}» {FFFFFF}/race 9  {E24234}\tForest Race\n");
	strcat(Teles6, "{E24234}» {FFFFFF}/race 10 {E24234}\tAroundSF Race\n");
	strcat(Teles6, "{E24234}» {FFFFFF}/race 11 {E24234}\tRestricted Race\n");
	strcat(Teles6, "{E24234}» {FFFFFF}/race 12 {E24234}\tGrove Race\n");
	strcat(Teles6, "{E24234}» {FFFFFF}/race 13 {E24234}\tNRG Races\n");
	strcat(Teles6, "{E24234}» {FFFFFF}/race 14 {E24234}\tFortune Races\n");
	//--------------------------------------------------------------------------
	return Teles6;
}
//------------------------------------------------------------------------------
stock ShowTeles7()
{
	new Teles7[512];
	//--------------------------------------------------------------------------
	strcat(Teles7, "{E24234}» {FFFFFF}/eiffel  {E24234}\tEiffel Tower\n");
	strcat(Teles7, "{E24234}» {FFFFFF}/mpk1    {E24234}\tMonster Pk 1\n");
	strcat(Teles7, "{E24234}» {FFFFFF}/mpk2    {E24234}\tMonster Pk 2\n");
	strcat(Teles7, "{E24234}» {FFFFFF}/icerink {E24234}\tIce Rink\n");
	strcat(Teles7, "{E24234}» {FFFFFF}/beach   {E24234}\tBeach\n");
	strcat(Teles7, "{E24234}» {FFFFFF}/maze    {E24234}\tMaze\n");
	//--------------------------------------------------------------------------
	return Teles7;
}
//------------------------------------------------------------------------------
stock ShowTeles9()
{
	new Teles9[1024];
	//--------------------------------------------------------------------------
	strcat(Teles9, "{E24234}» {FFFFFF}/easypk    {E24234}\tEasy Parkour\n");
	strcat(Teles9, "{E24234}» {FFFFFF}/funnypk   {E24234}\tFunny Parkour\n");
	strcat(Teles9, "{E24234}» {FFFFFF}/upperpk   {E24234}\tUpper Parkour\n");
	strcat(Teles9, "{E24234}» {FFFFFF}/extremepk {E24234}\tExtreme Parkour\n");
	strcat(Teles9, "{E24234}» {FFFFFF}/hardpk    {E24234}\tHard Parkour\n");
	strcat(Teles9, "{E24234}» {FFFFFF}/bigpk     {E24234}\tBig Parkour\n");
	strcat(Teles9, "{E24234}» {FFFFFF}/oceanicpk {E24234}\tOceanic Parkour\n");
	strcat(Teles9, "{E24234}» {FFFFFF}/monsterpk {E24234}\tMonster Parkour\n");
	strcat(Teles9, "{E24234}» {FFFFFF}/lospk     {E24234}\tLos Parkouros\n");
	//--------------------------------------------------------------------------
	return Teles9;
}
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
stock ShowTeles8()
{
	new Teles8[1024];
	//--------------------------------------------------------------------------
	strcat(Teles8, "{E24234}» {FFFFFF}/ls         {E24234}\t\tLos Santos\n");
	strcat(Teles8, "{E24234}» {FFFFFF}/lv         {E24234}\t\tLas Venturas\n");
	strcat(Teles8, "{E24234}» {FFFFFF}/sf         {E24234}\t\tSan Fierro\n");
	strcat(Teles8, "{E24234}» {FFFFFF}/island     {E24234}\tIsland\n");
	strcat(Teles8, "{E24234}» {FFFFFF}/party1     {E24234}\tParty1\n");
	strcat(Teles8, "{E24234}» {FFFFFF}/party2     {E24234}\tParty2\n");
	strcat(Teles8, "{E24234}» {FFFFFF}/party3     {E24234}\tParty3\n");
	strcat(Teles8, "{E24234}» {FFFFFF}/party4     {E24234}\tParty4\n");
	strcat(Teles8, "{E24234}» {FFFFFF}/party5     {E24234}\tParty5\n");
	strcat(Teles8, "{E24234}» {FFFFFF}/grov       {E24234}\tGrove Street\n");
	strcat(Teles8, "{E24234}» {FFFFFF}/spool      {E24234}\tSwimming\n");
	strcat(Teles8, "{E24234}» {FFFFFF}/nrgrainbow {E24234}\tNRG Rainbow\n");
	strcat(Teles8, "{E24234}» {FFFFFF}/btbs       {E24234}\tBeach Tubes\n");
	strcat(Teles8, "{E24234}» {FFFFFF}/fplace     {E24234}\tFunky Place\n");
	strcat(Teles8, "{E24234}» {FFFFFF}/pimps      {E24234}\tPimps\n");
	//--------------------------------------------------------------------------
	return Teles8;
}
stock strdelm(string[], badWord[])
{
   new
      i
   ;
   while((i = strfind(string, badWord, true)) != -1)
   {
       for(new x = (i + strlen(badWord)); i != x; ++i)
       {
           strdel(string, i, i+1);
       }
   }
   return 1;
}
stock codex(nickname[]) {
  new tmp[555];
  set(tmp,nickname);
  tmp=strreplace("~w~~h~~h~~h~","~w~~h~~h~~h~",tmp);
  return tmp;
}
stock codexx(nickname[]) {
  new tmp[555];
  set(tmp,nickname);
  tmp=strreplace("-","{E24234}-{FFFFFF}",tmp);
  return tmp;
}
forward TextMesaj(const text1[],const text2[]);
public TextMesaj(const text1[],const text2[])
{
	new textt[1024];
	format(textt, sizeof(textt), "%s", text1);
	codex(textt);
	code(textt);
    new sZ[512];
	format(sZ,512,"%s",textt);
	strdelm(sZ," ");
	if((strcount(sZ, "~")%2) != 0) return printf("Error:TextMesaji string = %s",textt);
    for(new i=0;i<2;i++){
    for(new line; line < 4; line++)
    {
    	MessageStr[i][line] = MessageStr[i][line+1];
    	TextDrawSetString(eMessage[i][line], MessageStr[i][line]);
    }
    }
    format(MessageStr[0][4], 1024, "%s",textt);
    format(MessageStr[1][4], 1024, "%s",textt);
    TextDrawSetString(eMessage[0][4], MessageStr[0][4]);
    TextDrawSetString(eMessage[1][4], MessageStr[1][4]);
    foreach(new as:Player)
    {
    PlayerPlaySound(as,5205,0.0,0.0,0.0);
 }
    for(new i;i<5;i++){
	if(EVT[i] !=-1){
	KillTimer(EVT[i]);
    EVT[i] = -1;
    }
    }
    EVT[0] = SetTimer("emessagedele0",3500,false);
    return 1;
}
forward emessagedele0();
public emessagedele0()
{
for(new i=0;i<2;i++){
format(MessageStr[i][1], 128, "");
TextDrawSetString(eMessage[i][0],"");
}
EVT[1] = SetTimer("emessagedele1",3700,false);
return 1;
}
forward emessagedele1();
public emessagedele1()
{
for(new i= 0;i<2;i++){
format(MessageStr[i][2], 128, "");
TextDrawSetString(eMessage[i][1],"");
}
EVT[2] = SetTimer("emessagedele2",3900,false);
return 1;
}
forward emessagedele2();
public emessagedele2()
{
for(new i= 0;i<2;i++){
format(MessageStr[i][3], 128, "");
TextDrawSetString(eMessage[i][2],"");
}
EVT[3] = SetTimer("emessagedele3",4100,false);
return 1;
}
forward emessagedele3();
public emessagedele3()
{
for(new i= 0;i<2;i++){
format(MessageStr[i][4], 128, "");
TextDrawSetString(eMessage[i][3],"");
}
EVT[4] = SetTimer("emessagedele4",4500,false);
return 1;
}
forward emessagedele4();
public emessagedele4()
{
for(new i= 0;i<2;i++){
format(MessageStr[i][0], 128, "");
TextDrawSetString(eMessage[i][4],"");
}
return 1;
}
new Text:Badana0;
new Text:Badana1;
new Text:Badana2;
new Text:Badana3;
new Text:Badana4;
new Text:Badana5;
new Text:Badana6[MAX_PLAYERS];
new Text:Badana7;
new Text:Badana8;
new Text:Badana9;
new Text:Badana10;

stock eksikSksor(playerid, miktar)
{
	new
	    yazi[256],
	    dogalDeger = ((GetPlayerScore(playerid)-miktar)-(GetPlayerScore(playerid)-miktar)-(GetPlayerScore(playerid)-miktar))
	;
	format(yazi, sizeof(yazi), "{E24234}<(Bilgi)>{FFFFFF} Toplam {E24234}' %d '{FFFFFF} kadar skorunuz yok - Eksik olan miktar {E24234}' %d '", miktar, dogalDeger);
	return SendClientMessage(playerid, -1, yazi), PlayerPlaySound(playerid, 1085, 0, 0, 0);}

stock eksikSkor(playerid, miktar)
{
	komut_yetenekler(playerid, " ");
	new
	    yazi[256],
	    dogalDeger = ((GetPlayerScore(playerid)-miktar)-(GetPlayerScore(playerid)-miktar)-(GetPlayerScore(playerid)-miktar))
	;
	format(yazi, sizeof(yazi), "{E24234}<(Bilgi)>{FFFFFF} Toplam {E24234}' %d '{FFFFFF} kadar skorunuz yok - Eksik olan miktar {E24234}' %d '", miktar, dogalDeger);
	return SendClientMessage(playerid, -1, yazi), PlayerPlaySound(playerid, 1085, 0, 0, 0);}
stock LoadServerTextDraws()
{
	for(new playerid=0;playerid<4;playerid++)
	{
    eMessagepm[playerid][0] = TextDrawCreate(3.000000, 160.000000, MessageStrpm[playerid][0]);
    eMessagepm[playerid][1] = TextDrawCreate(3.000000, 170.000000, MessageStrpm[playerid][0]);
    eMessagepm[playerid][2] = TextDrawCreate(3.000000, 180.000000, MessageStrpm[playerid][0]);
    eMessagepm[playerid][3] = TextDrawCreate(3.000000, 190.000000, MessageStrpm[playerid][0]);
    eMessagepm[playerid][4] = TextDrawCreate(3.000000, 200.000000, MessageStrpm[playerid][0]);
    eMessagepm[playerid][5] = TextDrawCreate(3.000000, 210.000000, MessageStrpm[playerid][0]);
    eMessagepm[playerid][6] = TextDrawCreate(3.000000, 220.000000, MessageStrpm[playerid][0]);
    eMessagepm[playerid][7] = TextDrawCreate(3.000000, 230.000000, MessageStrpm[playerid][0]);
    eMessagepm[playerid][8] = TextDrawCreate(3.000000, 240.000000, MessageStrpm[playerid][0]);
    eMessagepm[playerid][9] = TextDrawCreate(3.000000, 250.000000, MessageStrpm[playerid][0]);
	}
    for(new eline; eline<10; eline++)
	{
	for(new playerid=0;playerid<4;playerid++)
	{
    	TextDrawLetterSize(eMessagepm[playerid][eline], 0.210099, 0.910199);
    	TextDrawSetShadow(eMessagepm[playerid][eline], 1);
		TextDrawAlignment(eMessagepm[playerid][eline], 1);
    	TextDrawTextSize(eMessagepm[playerid][eline], 640, 480);
    	TextDrawFont(eMessagepm[playerid][eline], 1);
    	TextDrawSetOutline(eMessagepm[playerid][eline], 0);
	}
	}

	Death0 = TextDrawCreate(147.000000, 351.000000, "_");
	TextDrawBackgroundColor(Death0, 255);
	TextDrawFont(Death0, 1);
	TextDrawLetterSize(Death0, 0.500000, 6.000000);
	TextDrawColor(Death0, -1);
	TextDrawSetOutline(Death0, 0);
	TextDrawSetProportional(Death0, 1);
	TextDrawSetShadow(Death0, 1);
	TextDrawUseBox(Death0, 1);
	TextDrawBoxColor(Death0, 111);
	TextDrawTextSize(Death0, 310.000000, 0.000000);
	TextDrawSetSelectable(Death0, 0);

	Death1 = TextDrawCreate(144.000000, 348.000000, "LD_DRV:silfly");
	TextDrawBackgroundColor(Death1, 255);
	TextDrawFont(Death1, 4);
	TextDrawLetterSize(Death1, 0.500000, 1.500000);
	TextDrawColor(Death1, -1);
	TextDrawSetOutline(Death1, 0);
	TextDrawSetProportional(Death1, 1);
	TextDrawSetShadow(Death1, 1);
	TextDrawUseBox(Death1, 1);
	TextDrawBoxColor(Death1, 255);
	TextDrawTextSize(Death1, 60.000000, 59.000000);
	TextDrawSetSelectable(Death1, 0);

	Death2 = TextDrawCreate(206.000000, 360.000000, "Olduren: ~r~-");
	TextDrawBackgroundColor(Death2, 255);
	TextDrawFont(Death2, 1);
	TextDrawLetterSize(Death2, 0.190000, 1.100000);
	TextDrawColor(Death2, -1);
	TextDrawSetOutline(Death2, 1);
	TextDrawSetProportional(Death2, 1);
	TextDrawSetSelectable(Death2, 0);

	Death3 = TextDrawCreate(206.000000, 370.000000, "Silah: ~r~-");
	TextDrawBackgroundColor(Death3, 255);
	TextDrawFont(Death3, 1);
	TextDrawLetterSize(Death3, 0.190000, 1.100000);
	TextDrawColor(Death3, -1);
	TextDrawSetOutline(Death3, 1);
	TextDrawSetProportional(Death3, 1);
	TextDrawSetSelectable(Death3, 0);

	Death4 = TextDrawCreate(206.000000, 381.000000, "Cezaniz: ~r~1.000$~w~~h~~h~~h~ Skor~r~ 1");
	TextDrawBackgroundColor(Death4, 255);
	TextDrawFont(Death4, 1);
	TextDrawLetterSize(Death4, 0.190000, 1.100000);
	TextDrawColor(Death4, -1);
	TextDrawSetOutline(Death4, 1);
	TextDrawSetProportional(Death4, 1);
	TextDrawSetSelectable(Death4, 0);
	// Create the textdraws:
	Badana0 = TextDrawCreate(0.000000, 439.000000, "_");
	TextDrawBackgroundColor(Badana0, 255);
	TextDrawFont(Badana0, 1);
	TextDrawLetterSize(Badana0, 0.500000, 1.000000);
	TextDrawColor(Badana0, -1);
	TextDrawSetOutline(Badana0, 0);
	TextDrawSetProportional(Badana0, 1);
	TextDrawSetShadow(Badana0, 1);
	TextDrawUseBox(Badana0, 1);
	TextDrawBoxColor(Badana0, 2044942356);
	TextDrawTextSize(Badana0, 650.000000, 0.000000);
	TextDrawSetSelectable(Badana0, 0);

	Badana1 = TextDrawCreate(5.000000, 437.000000, "~r~~h~Maestronline");
	TextDrawBackgroundColor(Badana1, 255);
	TextDrawFont(Badana1, 1);
	TextDrawLetterSize(Badana1, 0.220000, 1.000000);
	TextDrawColor(Badana1, -1);
	TextDrawSetOutline(Badana1, 1);
	TextDrawSetProportional(Badana1, 1);
	TextDrawSetSelectable(Badana1, 0);

	Badana2 = TextDrawCreate(79.000000, 437.000000, "~b~/~w~~h~~h~~h~cmds - ~b~/~w~~h~~h~~h~help - ~b~/~w~~h~~h~~h~admins - ~b~/~w~~h~~h~~h~anims - ~b~/~w~~h~~h~~h~report");
	TextDrawBackgroundColor(Badana2, 255);
	TextDrawFont(Badana2, 1);
	TextDrawLetterSize(Badana2, 0.220000, 1.000000);
	TextDrawColor(Badana2, -1);
	TextDrawSetOutline(Badana2, 1);
	TextDrawSetProportional(Badana2, 1);
	TextDrawSetSelectable(Badana2, 0);

	Badana3 = TextDrawCreate(265.000000, 437.000000, "www.maestronline.org");
	TextDrawBackgroundColor(Badana3, 255);
	TextDrawFont(Badana3, 1);
	TextDrawLetterSize(Badana3, 0.220000, 1.000000);
	TextDrawColor(Badana3, -65281);
	TextDrawSetOutline(Badana3, 1);
	TextDrawSetProportional(Badana3, 1);
	TextDrawSetSelectable(Badana3, 0);

	Badana4 = TextDrawCreate(368.000000, 437.000000, "~b~/~w~~h~~h~~h~about - ~b~/~w~~h~~h~~h~mycar - ~b~/~w~~h~~h~~h~shop - ~b~/~w~~h~~h~~h~credits - ~b~/~w~~h~~h~~h~animasyonlar");
	TextDrawBackgroundColor(Badana4, 255);
	TextDrawFont(Badana4, 1);
	TextDrawLetterSize(Badana4, 0.220000, 1.000000);
	TextDrawColor(Badana4, -1);
	TextDrawSetOutline(Badana4, 1);
	TextDrawSetProportional(Badana4, 1);
	TextDrawSetSelectable(Badana4, 0);

	Badana5 = TextDrawCreate(578.000000, 437.000000, "~r~~h~Elite GameMode");
	TextDrawBackgroundColor(Badana5, 255);
	TextDrawFont(Badana5, 1);
	TextDrawLetterSize(Badana5, 0.220000, 1.000000);
	TextDrawColor(Badana5, -1);
	TextDrawSetOutline(Badana5, 1);
	TextDrawSetProportional(Badana5, 1);
	TextDrawSetSelectable(Badana5, 0);

	Badana7 = TextDrawCreate(226.000000, 385.000000, "_");
	TextDrawBackgroundColor(Badana7, 100);
	TextDrawFont(Badana7, 1);
	TextDrawLetterSize(Badana7, 0.170000, 1.000000);
	TextDrawColor(Badana7, -1);
	TextDrawSetOutline(Badana7, 1);
	TextDrawSetProportional(Badana7, 1);
	TextDrawSetSelectable(Badana7, 0);

	Badana8 = TextDrawCreate(226.000000, 395.000000, "_");
	TextDrawBackgroundColor(Badana8, 100);
	TextDrawFont(Badana8, 1);
	TextDrawLetterSize(Badana8, 0.170000, 1.000000);
	TextDrawColor(Badana8, -1);
	TextDrawSetOutline(Badana8, 1);
	TextDrawSetProportional(Badana8, 1);
	TextDrawSetSelectable(Badana8, 0);

	Badana9 = TextDrawCreate(226.000000, 395.000000, "_");
	TextDrawBackgroundColor(Badana9, 100);
	TextDrawFont(Badana9, 1);
	TextDrawLetterSize(Badana9, 0.170000, 1.000000);
	TextDrawColor(Badana9, -1);
	TextDrawSetOutline(Badana9, 1);
	TextDrawSetProportional(Badana9, 1);
	TextDrawSetSelectable(Badana9, 0);

	Badana10 = TextDrawCreate(226.000000, 375.000000, "_");
	TextDrawBackgroundColor(Badana10, 100);
	TextDrawFont(Badana10, 1);
	TextDrawLetterSize(Badana10, 0.170000, 1.000000);
	TextDrawColor(Badana10, -1);
	TextDrawSetOutline(Badana10, 1);
	TextDrawSetProportional(Badana10, 1);
	TextDrawSetSelectable(Badana10, 0);

	for(new i; i < MAX_PLAYERS; i ++)
	{
		if(IsPlayerConnected(i))
		{
			TextDrawShowForPlayer(i, Badana0);
			TextDrawShowForPlayer(i, Badana1);
			TextDrawShowForPlayer(i, Badana2);
			TextDrawShowForPlayer(i, Badana3);
			TextDrawShowForPlayer(i, Badana4);
			TextDrawShowForPlayer(i, Badana5);
			TextDrawShowForPlayer(i, Badana6[i]);
			TextDrawShowForPlayer(i, Badana7);
			TextDrawShowForPlayer(i, Badana8);
			TextDrawShowForPlayer(i, Badana9);
			TextDrawShowForPlayer(i, Badana10);
		}
	}
        print("Lazer Pointer by VenomMancer");
        new p = MAX_PLAYERS;
        for (new i=0; i < p; i++) {
                SetPVarInt(i, "Lazer", 0);
                SetPVarInt(i, "color", 18643);
        }
	UserBox[0] = TextDrawCreate(513.999816, 118.975563, "usebox");
	TextDrawLetterSize(UserBox[0], 0.000000, 23.797899);
	TextDrawTextSize(UserBox[0], 125.111122, 0.000000);
	TextDrawAlignment(UserBox[0], 1);
	TextDrawColor(UserBox[0], 0);
	TextDrawUseBox(UserBox[0], true);
	TextDrawBoxColor(UserBox[0], -2139062142);
	TextDrawSetShadow(UserBox[0], 0);
	TextDrawSetOutline(UserBox[0], 0);
	TextDrawFont(UserBox[0], 0);

	UserBox[1] = TextDrawCreate(508.777557, 124.953330, "usebox");
	TextDrawLetterSize(UserBox[1], 0.000000, 22.420114);
	TextDrawTextSize(UserBox[1], 130.000015, 0.000000);
	TextDrawAlignment(UserBox[1], 1);
	TextDrawColor(UserBox[1], 0);
	TextDrawUseBox(UserBox[1], true);
	TextDrawBoxColor(UserBox[1], 20223);
	TextDrawSetShadow(UserBox[1], 0);
	TextDrawSetOutline(UserBox[1], 0);
	TextDrawFont(UserBox[1], 0);

	UserBox[2] = TextDrawCreate(507.777770, 160.291107, "usebox");
	TextDrawLetterSize(UserBox[2], 0.000000, 18.333211);
	TextDrawTextSize(UserBox[2], 130.888885, 0.000000);
	TextDrawAlignment(UserBox[2], 1);
	TextDrawColor(UserBox[2], 0);
	TextDrawUseBox(UserBox[2], true);
	TextDrawBoxColor(UserBox[2], -1378294167);
	TextDrawSetShadow(UserBox[2], 0);
	TextDrawSetOutline(UserBox[2], 0);
	TextDrawFont(UserBox[2], 0);

	UserBox[3] = TextDrawCreate(276.000030, 297.671142, "Maestronline FreeRoam");
	TextDrawLetterSize(UserBox[3], 0.449999, 1.600000);
	TextDrawAlignment(UserBox[3], 1);
	TextDrawColor(UserBox[3], -1);
	TextDrawSetShadow(UserBox[3], 0);
	TextDrawSetOutline(UserBox[3], 1);
	TextDrawBackgroundColor(UserBox[3], 51);
	TextDrawFont(UserBox[3], 0);
	TextDrawSetProportional(UserBox[3], 1);
	for(new sa=0;sa<2;sa++){
	deMessage[sa][0] = TextDrawCreate(330.000000, 422.000000, "");
	deMessage[sa][1] = TextDrawCreate(330.000000, 430.000000, "");
	deMessage[sa][2] = TextDrawCreate(330.000000, 438.000000, "");
	for(new s=0;s<3;s++){
	TextDrawAlignment(deMessage[sa][s], 2);
	TextDrawBackgroundColor(deMessage[sa][s], 255);
	TextDrawFont(deMessage[sa][s], 1);
	TextDrawLetterSize(deMessage[sa][s], 0.220000, 1.000000);
	TextDrawColor(deMessage[sa][s], -1);
	TextDrawSetOutline(deMessage[sa][s], 0);
	TextDrawSetProportional(deMessage[sa][s], 1);
	TextDrawSetShadow(deMessage[sa][s], 1);
	}
	}
    for(new playerid=0;playerid<2;playerid++)
	{
    eMessage[playerid][0] = TextDrawCreate(226.000000, 425.00000, MessageStr[playerid][0]);
    eMessage[playerid][1] = TextDrawCreate(226.000000, 415.00000, MessageStr[playerid][1]);
    eMessage[playerid][2] = TextDrawCreate(226.000000, 405.00000, MessageStr[playerid][2]);
    eMessage[playerid][3] = TextDrawCreate(226.000000, 395.00000, MessageStr[playerid][3]);
    eMessage[playerid][4] = TextDrawCreate(226.000000, 385.00000, MessageStr[playerid][4]);
    }
    for(new aline; aline<5; aline++)
	{
	for(new playerid=0;playerid<2;playerid++)
	{
		TextDrawBackgroundColor(eMessage[playerid][aline], 145);
		TextDrawFont(eMessage[playerid][aline], 1);
		TextDrawLetterSize(eMessage[playerid][aline], 0.19000, 0.899999);
		TextDrawColor(eMessage[playerid][aline], -1);
		TextDrawSetOutline(eMessage[playerid][aline], 1);
		TextDrawSetProportional(eMessage[playerid][aline], 1);
		TextDrawSetSelectable(eMessage[playerid][aline], 0);
	}
	}
#if defined RACEPASIF
/*	TopRace0 = TextDrawCreate(30.000000, 220.000000, "Map's Records");
	TextDrawBackgroundColor(TopRace0, 255);
	TextDrawFont(TopRace0, 1);
	TextDrawLetterSize(TopRace0, 0.209999, 1.000000);
	TextDrawColor(TopRace0, -1);
	TextDrawSetOutline(TopRace0, 0);
	TextDrawSetProportional(TopRace0, 1);
	TextDrawSetShadow(TopRace0, 0);
	TextDrawUseBox(TopRace0, 1);
	TextDrawBoxColor(TopRace0, -1694460316);
	TextDrawTextSize(TopRace0, 146.000000, 10.000000);
	TextDrawSetSelectable(TopRace0, 0);

	TopRace1 = TextDrawCreate(30.000000, 233.000000, "_");
	TextDrawBackgroundColor(TopRace1, 255);
	TextDrawFont(TopRace1, 1);
	TextDrawLetterSize(TopRace1, 0.209999, 9.199998);
	TextDrawColor(TopRace1, -1);
	TextDrawSetOutline(TopRace1, 0);
	TextDrawSetProportional(TopRace1, 1);
	TextDrawSetShadow(TopRace1, 0);
	TextDrawUseBox(TopRace1, 1);
	TextDrawBoxColor(TopRace1, -939498396);
	TextDrawTextSize(TopRace1, 146.000000, 10.000000);
	TextDrawSetSelectable(TopRace1, 0);

	TopRace2 = TextDrawCreate(30.000000, 233.000000, "1-) ~w~~h~~h~~h~CaLderoN - 00:10");
	TextDrawBackgroundColor(TopRace2, 255);
	TextDrawFont(TopRace2, 1);
	TextDrawLetterSize(TopRace2, 0.220000, 1.100000);
	TextDrawColor(TopRace2, 1994719487);
	TextDrawSetOutline(TopRace2, 0);
	TextDrawSetProportional(TopRace2, 1);
	TextDrawSetShadow(TopRace2, 0);
	TextDrawSetSelectable(TopRace2, 0);

	TopRace3 = TextDrawCreate(30.000000, 244.000000, "2-) ~w~~h~~h~~h~CaLderoN - 00:10");
	TextDrawBackgroundColor(TopRace3, 255);
	TextDrawFont(TopRace3, 1);
	TextDrawLetterSize(TopRace3, 0.220000, 1.100000);
	TextDrawColor(TopRace3, 1994719487);
	TextDrawSetOutline(TopRace3, 0);
	TextDrawSetProportional(TopRace3, 1);
	TextDrawSetShadow(TopRace3, 0);
	TextDrawSetSelectable(TopRace3, 0);

	TopRace4 = TextDrawCreate(30.000000, 255.000000, "3-) ~w~~h~~h~~h~CaLderoN - 00:10");
	TextDrawBackgroundColor(TopRace4, 255);
	TextDrawFont(TopRace4, 1);
	TextDrawLetterSize(TopRace4, 0.220000, 1.100000);
	TextDrawColor(TopRace4, 1994719487);
	TextDrawSetOutline(TopRace4, 0);
	TextDrawSetProportional(TopRace4, 1);
	TextDrawSetShadow(TopRace4, 0);
	TextDrawSetSelectable(TopRace4, 0);

	TopRace5 = TextDrawCreate(30.000000, 266.000000, "4-) ~w~~h~~h~~h~CaLderoN - 00:10");
	TextDrawBackgroundColor(TopRace5, 255);
	TextDrawFont(TopRace5, 1);
	TextDrawLetterSize(TopRace5, 0.220000, 1.100000);
	TextDrawColor(TopRace5, 1994719487);
	TextDrawSetOutline(TopRace5, 0);
	TextDrawSetProportional(TopRace5, 1);
	TextDrawSetShadow(TopRace5, 0);
	TextDrawSetSelectable(TopRace5, 0);

	TopRace6 = TextDrawCreate(30.000000, 277.000000, "5-) ~w~~h~~h~~h~CaLderoN - 00:10");
	TextDrawBackgroundColor(TopRace6, 255);
	TextDrawFont(TopRace6, 1);
	TextDrawLetterSize(TopRace6, 0.220000, 1.100000);
	TextDrawColor(TopRace6, 1994719487);
	TextDrawSetOutline(TopRace6, 0);
	TextDrawSetProportional(TopRace6, 1);
	TextDrawSetShadow(TopRace6, 0);
	TextDrawSetSelectable(TopRace6, 0);

	TopRace7 = TextDrawCreate(30.000000, 307.000000, "Copyright - CaLderoN&rRace");
	TextDrawBackgroundColor(TopRace7, 255);
	TextDrawFont(TopRace7, 1);
	TextDrawLetterSize(TopRace7, 0.220000, 1.100000);
	TextDrawColor(TopRace7, -1);
	TextDrawSetOutline(TopRace7, 0);
	TextDrawSetProportional(TopRace7, 1);
	TextDrawSetShadow(TopRace7, 0);
	TextDrawSetSelectable(TopRace7, 0);
*/
	// Create the textdraws:
	RaceSayac0 = TextDrawCreate(200.000000, 160.000000, "I");
	TextDrawBackgroundColor(RaceSayac0, 255);
	TextDrawFont(RaceSayac0, 1);
	TextDrawLetterSize(RaceSayac0, 1.400000, 16.900003);
	TextDrawColor(RaceSayac0, -1061109505);
	TextDrawSetOutline(RaceSayac0, 0);
	TextDrawSetProportional(RaceSayac0, 1);
	TextDrawSetShadow(RaceSayac0, 1);
	TextDrawSetSelectable(RaceSayac0, 0);

	RaceSayac1 = TextDrawCreate(210.000000, 199.000000, "_");
	TextDrawBackgroundColor(RaceSayac1, 255);
	TextDrawFont(RaceSayac1, 1);
	TextDrawLetterSize(RaceSayac1, 1.400000, 3.900003);
	TextDrawColor(RaceSayac1, -1);
	TextDrawSetOutline(RaceSayac1, 0);
	TextDrawSetProportional(RaceSayac1, 1);
	TextDrawSetShadow(RaceSayac1, 1);
	TextDrawUseBox(RaceSayac1, 1);
	TextDrawBoxColor(RaceSayac1, 255);
	TextDrawTextSize(RaceSayac1, 390.000000, 0.000000);
	TextDrawSetSelectable(RaceSayac1, 0);

	RaceSayac2 = TextDrawCreate(220.000000, 114.000000, "_");
	TextDrawBackgroundColor(RaceSayac2, 255);
	TextDrawFont(RaceSayac2, 1);
	TextDrawLetterSize(RaceSayac2, 4.099998, 15.000000);
	TextDrawColor(RaceSayac2, -1207959297);
	TextDrawSetOutline(RaceSayac2, 0);
	TextDrawSetProportional(RaceSayac2, 1);
	TextDrawSetShadow(RaceSayac2, 1);
	TextDrawSetSelectable(RaceSayac2, 0);

	RaceSayac3 = TextDrawCreate(270.000000, 114.000000, "_");
	TextDrawBackgroundColor(RaceSayac3, 255);
	TextDrawFont(RaceSayac3, 1);
	TextDrawLetterSize(RaceSayac3, 4.099998, 15.000000);
	TextDrawColor(RaceSayac3, -65281);
	TextDrawSetOutline(RaceSayac3, 0);
	TextDrawSetProportional(RaceSayac3, 1);
	TextDrawSetShadow(RaceSayac3, 1);
	TextDrawSetSelectable(RaceSayac3, 0);

	RaceSayac4 = TextDrawCreate(320.000000, 114.000000, "_");
	TextDrawBackgroundColor(RaceSayac4, 255);
	TextDrawFont(RaceSayac4, 1);
	TextDrawLetterSize(RaceSayac4, 4.099998, 15.000000);
	TextDrawColor(RaceSayac4, 16711935);
	TextDrawSetOutline(RaceSayac4, 0);
	TextDrawSetProportional(RaceSayac4, 1);
	TextDrawSetShadow(RaceSayac4, 1);
	TextDrawSetSelectable(RaceSayac4, 0);

	RaceSayac5 = TextDrawCreate(216.000000, 236.000000, "HAZIR!");
	TextDrawBackgroundColor(RaceSayac5, 255);
	TextDrawFont(RaceSayac5, 1);
	TextDrawLetterSize(RaceSayac5, 0.500000, 3.000000);
	TextDrawColor(RaceSayac5, -1);
	TextDrawSetOutline(RaceSayac5, 0);
	TextDrawSetProportional(RaceSayac5, 1);
	TextDrawSetShadow(RaceSayac5, 1);
	TextDrawSetSelectable(RaceSayac5, 0);
	#endif
	return 1;
}
stock eksikMiktarr(playerid, miktar)
{
    new anastr[699];
	strcat(anastr, "Isim\tAna Ton\tFiyat\n\
	{E24234}» {F36E4B}Domates\t{FFFF00}Kirmizi\t1.000$\n\
	{E24234}» {B4155D}Küpe Çiçegi\t{FFFF00}Kirmizi\t1.000$\n\
	{E24234}» {E7D3E2}Kireç Rengi\t{FFFF00}Kirmizi\t1.000$\n\
	{E24234}» {CD392F}Akik Taþi\t{FFFF00}Kirmizi\t1.000$\n");
	strcat(anastr, "{E24234}» {FF007F}Gül Rengi\t{FFFF00}Kirmizi\t1.000$\n\
	{E24234}» {0095B6}Bondi Mavisi\t{336699}Mavi\t1.000$\n\
	{E24234}» {7DF9FF}Elektirik Mavisi\t{336699}Mavi\t1.000$\n\
	{E24234}» {0095B6}Bondi Mavisi\t{336699}Mavi\t1.000$\n\
	{E24234}» {009000}Islam Yeþili\t{00FF00}Yeþil\t1.000$\n\
	{E24234}» {7BA05B}Kuþkonmaz Rengi\t{00FF00}Yeþil\t1.000$");
	ShowPlayerDialog(playerid,7780,DIALOG_STYLE_TABLIST_HEADERS,"{E24234}[M]aestronline -{FFFFFF} Shop Menu {E24234}- {FFFFFF} Nick Renkleri",anastr,"Tamam", "Geri");
	new
	    yazi[256],
	    dogalDeger = ((GetPlayerMoney(playerid)-miktar)-(GetPlayerMoney(playerid)-miktar)-(GetPlayerMoney(playerid)-miktar))
	;
	format(yazi, sizeof(yazi), "{E24234}<(Bilgi)>{FFFFFF} Toplam {E24234}' %s '{FFFFFF} kadar paraniz yok. Eksik olan miktar {E24234}' %s '{FFFFFF}.", Comma(miktar), Comma(dogalDeger));
	return SendClientMessage(playerid, -1, yazi), PlayerPlaySound(playerid, 1085, 0, 0, 0);
}
stock eksikPara(playerid, miktar)
{
	new
	    yazi[256],
	    dogalDeger = ((GetPlayerMoney(playerid)-miktar)-(GetPlayerMoney(playerid)-miktar)-(GetPlayerMoney(playerid)-miktar))
	;
	format(yazi, sizeof(yazi), "{E24234}<(Bilgi)>{FFFFFF} Toplam {E24234}' %s '{FFFFFF} kadar paraniz yok. Eksik olan miktar {E24234}' %s '{FFFFFF}.", Comma(miktar), Comma(dogalDeger));
	return SendClientMessage(playerid, -1, yazi), PlayerPlaySound(playerid, 1085, 0, 0, 0);
}
stock eksikMiktar(playerid, miktar)
{
	new _str[1299];
	strcat(_str,"Isim\tFiyat\tMermi\n\
	{E24234}» {FFFFFF}Bicak\t1.000$\t-\n\
	{E24234}» {FFFFFF}Katana\t5.000$\t-\n\
	{E24234}» {FFFFFF}Beyzbol Sopasi\t5.000$\t-\n\
	{E24234}» {FFFFFF}Kürek\t5.000$\t-\n\
	{E24234}» {FFFFFF}Bilardo Sopasi\t5.000$\t-\n\
	{E24234}» {FFFFFF}Job\t5.000$\t-\n\
	{E24234}» {FFFFFF}Golf Sopasi\t5.000$\t-\n\
	{E24234}» {FFFFFF}Testere\t5.000$\t-\n\
	{E24234}» {FFFFFF}Dildo\t5.000$\t-\n");
	strcat(_str,"\
	{E24234}» {FFFFFF}Baston\t5.000$\t-\n\
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
	{E24234}» {FFFFFF}Kamera\t5.000$\t-\n\
	{E24234}» {FFFFFF}Yangin Tüpü\t5.000$\t-\n\
	{E24234}» {FFFFFF}Termal Gozlük\t5.000$\t-\n\
	{E24234}» {FFFFFF}Gece Gorüþ Gozlügü\t5.000$\t-\n\
	{E24234}» {FFFFFF}Paraþüt\t5.000$\t-\n\
	{E24234}» {FFFFFF}Sprey\t5.000$\t-\n");
    ShowPlayerDialog(playerid, 7779, DIALOG_STYLE_TABLIST_HEADERS, "{E24234}[M]aestronline -{FFFFFF} Shop Menu {E24234}- {FFFFFF} Can§Zirh Eklentileri", _str, "Tamam", "Iptal");
	new
	    yazi[256],
	    dogalDeger = ((GetPlayerMoney(playerid)-miktar)-(GetPlayerMoney(playerid)-miktar)-(GetPlayerMoney(playerid)-miktar))
	;
	format(yazi, sizeof(yazi), "{E24234}<(Bilgi)>{FFFFFF} Toplam {E24234}' %d '{FFFFFF} kadar paraniz yok. Eksik olan miktar {E24234}' %d '{FFFFFF}.", miktar, dogalDeger);
	return SendClientMessage(playerid, -1, yazi), PlayerPlaySound(playerid, 1085, 0, 0, 0);
}

stock eksikMiktarc(playerid, miktar)
{
	CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/czmenu");
	new
	    yazi[256],
	    dogalDeger = ((GetPlayerMoney(playerid)-miktar)-(GetPlayerMoney(playerid)-miktar)-(GetPlayerMoney(playerid)-miktar))
	;
	format(yazi, sizeof(yazi), "{E24234}<(Bilgi)>{FFFFFF} Toplam {E24234}' %d '{FFFFFF} kadar paraniz yok. Eksik olan miktar {E24234}' %d '{FFFFFF}.", miktar, dogalDeger);
	return SendClientMessage(playerid, -1, yazi), PlayerPlaySound(playerid, 1085, 0, 0, 0);}
stock eksikMiktarPara(playerid, miktar)
{
	new
	    yazi[256],
	    dogalDeger = ((GetPlayerMoney(playerid)-miktar)-(GetPlayerMoney(playerid)-miktar)-(GetPlayerMoney(playerid)-miktar))
	;
	format(yazi, sizeof(yazi), "{E24234}<(Bilgi)>{FFFFFF} Toplam {E24234}' %d '{FFFFFF} kadar paraniz yok. Eksik olan miktar {E24234}' %d '{FFFFFF}.", miktar, dogalDeger);
	return SendClientMessage(playerid, -1, yazi), PlayerPlaySound(playerid, 1085, 0, 0, 0);}
 function Hatamesaj(playerid, const a[], const b[])
{
	new
	    szString[256]
	;
	if(GetPVarInt(playerid, "Language__") == TURKISH) format(szString, sizeof(szString), "{E24234}<(Hata)>{FFFFFF} %s", a);
	else format(szString, sizeof(szString), "{E24234}<(Error)>{FFFFFF} %s", b);
	SendClientMessage(playerid, -1, szString);
	PlayerPlaySound(playerid, 1085, 0.0000, 0.0000, 0.0000);
	return 1;
}

function Bilgimesaj(playerid, const a[], const b[])
{
	new
	    szString[256]
	;
	if(GetPVarInt(playerid, "Language__") == TURKISH) format(szString, sizeof(szString), "{E24234}<(Bilgi)>{FFFFFF} %s", a);
	else format(szString, sizeof(szString), "{E24234}<(Bilgi)>{FFFFFF} %s", b);
	SendClientMessage(playerid, -1, szString);
	return 1;
}

function Reklam(playerid, const a[], const b[])
{
	new
	    szString[256]
	;
	if(GetPVarInt(playerid, "Language__") == TURKISH) format(szString, sizeof(szString), "{00FF7F}<(Reklam)>{FFFFFF} %s", a);
	else format(szString, sizeof(szString), "{00FF7F}<(Ads)>{FFFFFF} %s", b);
	SendClientMessage(playerid, -1, szString);
	return 1;
}

function Bilgimesaj_(playerid, const a[])
{
	new
	    szString[256]
	;
	format(szString, sizeof(szString), "{E24234}<(Bilgi)>{FFFFFF} %s", a);
	SendClientMessage(playerid, -1, szString);
	PlayerPlaySound(playerid, 1150, 0.0000, 0.0000, 0.0000);
	return 1;
}
function xReactionProgress()
{
	switch(xTestBusy)
	{
		case true:
		{
			new
				string[128]
    		;
    		for(new x; x < MAX_PLAYERS; x++)
    		{
    		    xTestBusy = false;
				if(GetPVarInt(x, "Language__") == TURKISH) format(string, sizeof(string), "{C3C3C3}« Test »{FFFFFF} Hic kimse kazanamadi, yenisinin baslamasina {E24234}%d{FFFFFF} dakika kaldi.", (TIME/60000));
				else format(string, sizeof(string), "{C3C3C3}« Test »{FFFFFF} No-one won the reaction test. New test starting in {E24234}%d{FFFFFF} minutes.", (TIME/60000));
				SendClientMessage(x, -1, string);
	        }
            xReactionTimer = SetTimer("xReactionTest", TIME, 1);
            print("reaction bitti");
       }
	}
    return 1;
}
stock unIP(const mStr[])
{
	new
		sayi,
		warn,
		i,
		sayiarasi
	;
	while(mStr[i] != EOS)
	{
		if('0' <= mStr[i] <= '9')
		{
			if(warn >= 3)return 1;
			if(sayiarasi > 2 && warn > 1)
			{
				warn--;
			}
			sayiarasi=0;
			sayi++;
			if(sayi == 2 || sayi == 3)
			{
				if(mStr[i+1] == '.' && '0' <= mStr[i+2] <= '9')
				{
					warn++;
					sayi=0;
				}
			}
		}else
		{
			sayiarasi++;
			sayi=0;
		}
		i++;
	}
	return 0;
}

function xReactionTest()
{
        new
                xLength = (random(8) + 2),
                string[128]
        ;
        format(xChars, sizeof(xChars), "");
        Loop(x, xLength) format(xChars, sizeof(xChars), "%s%s", xChars, xCharacters[random(sizeof(xCharacters))][0]);
        if (strlen(xChars) < 6)
        Loop(x, xLength) format(xChars, sizeof(xChars), "%s%s", xChars, xCharacters[random(sizeof(xCharacters))][0]);
        if (strlen(xChars) < 6)
        Loop(x, xLength) format(xChars, sizeof(xChars), "%s%s", xChars, xCharacters[random(sizeof(xCharacters))][0]);
   		for(new x; x < MAX_PLAYERS; x++)
   		{
	        if(GetPVarInt(x, "Language__") == TURKISH) format(string, sizeof(string), "{C3C3C3}« Reaction » {FFFFFF}Ilk olarak \"{E24234}%s{FFFFFF}\" yazan {E24234}15000$ - 5 score {FFFFFF}kazanir!", xChars);
	        else format(string, sizeof(string), "{C3C3C3}« Reaction » {FFFFFF}Who first types \"{E24234}%s{FFFFFF}\" wins {E24234}15000$ - 5 score {FFFFFF}points!", xChars);
			SendClientMessage(x, -1, string);
        }
        KillTimer(xReactionTimer);
        xTestBusy = true;
        SetTimer("xReactionProgress", 30000, 0);
        return 1;
}

stock oIsim(i)
{
	new
	    oad[24]
	;
	GetPlayerName(i, oad, sizeof(oad));
	return oad;
}

function MyCarPress(playerid, key_f)
{
	if(key_f == 0)return 1;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return Hatamesaj(playerid, "Bir aracin soforu olmaniz lazim!", "You are not a car driver.");
	new Float:T[4],
		motor,
		isiklar,
		alarm,
		kapilar,
		kaput,
		bagaj,
		objective,
		vehid = GetPlayerVehicleID(playerid);
	switch(key_f)
	{
		case 1:
		{
			GetVehicleZAngle(vehid, T[3]);
			GetVehicleVelocity(vehid, T[0], T[1], T[2]);
			SetVehicleVelocity(vehid,((floatadd(T[0],floatmul(1.01,floatsin(-T[3],degrees))/3.0))), ((floatadd(T[1],floatmul(1.01,floatcos(-T[3],degrees))/3.0))), T[2]);
		}
		case 2:
		{
			GetVehicleVelocity(vehid, T[0], T[1], T[2]);
			SetVehicleVelocity(vehid, T[0], T[1], (T[2]+0.4));
		}
		case 3:
		{
			GetVehicleZAngle(vehid, T[3]);
			SetVehicleAngularVelocity(vehid, ((floatadd(0,floatmul(1.01,floatcos(T[3],degrees))))*2)/5, ((floatadd(0,floatmul(1.01,floatsin(T[3],degrees))))*2)/5, 0.0);
		}
		case 4:
		{
			GetVehicleZAngle(vehid, T[3]);
			SetVehicleAngularVelocity(vehid, ((floatadd(0,floatmul(1.01,floatsin(-T[3],degrees))))*2)/5, ((floatadd(0,floatmul(1.01,floatcos(-T[3],degrees))))*2)/5, 0.0);
		}
		case 5:
		{
			SetVehicleAngularVelocity(vehid, 0.0, 0.0, 0.3);
		}
		case 6:
		{
			GetVehicleZAngle(vehid,T[3]);
			SetVehicleZAngle(vehid,T[3]);
		}
		case 7:
		{
			ChangeVehicleColor(vehid,random(256),random(256));
		}
		case 8:
		{
			SetVehicleVelocity(vehid, 0, 0, 0);
		}
		case 9:
		{
			GetVehicleParamsEx(vehid,motor,isiklar,alarm,kapilar,kaput,bagaj,objective);
			SetVehicleParamsEx(vehid,motor,isiklar,alarm,kapilar,kaput,(PVG->Int->bagaj[playerid] == 0) ? (VEHICLE_PARAMS_ON) : (VEHICLE_PARAMS_OFF),objective);
			PVS->Int->bagaj[playerid]->!PVG->Int->bagaj[playerid];
		}
		case 10:
		{
			GetVehicleParamsEx(vehid,motor,isiklar,alarm,kapilar,kaput,bagaj,objective);
			SetVehicleParamsEx(vehid,motor,isiklar,alarm,kapilar,(PVG->Int->kaput[playerid] == 0) ? (VEHICLE_PARAMS_ON) : (VEHICLE_PARAMS_OFF),bagaj,objective);
			PVS->Int->kaput[playerid]->!PVG->Int->kaput[playerid];
		}
		case 11:
		{
			GetVehicleParamsEx(vehid,motor,isiklar,alarm,kapilar,kaput,bagaj,objective);
			SetVehicleParamsEx(vehid,motor,isiklar,(PVG->Int->alarm[playerid] == 0) ? (VEHICLE_PARAMS_ON) : (VEHICLE_PARAMS_OFF),kapilar,kaput,bagaj,objective);
			PVS->Int->alarm[playerid]->!PVG->Int->alarm[playerid];
		}
		case 12:
		{
			GetVehicleParamsEx(vehid,motor,isiklar,alarm,kapilar,kaput,bagaj,objective);
			SetVehicleParamsEx(vehid,motor,(PVG->Int->isiklar[playerid] == 0) ? (VEHICLE_PARAMS_ON) : (VEHICLE_PARAMS_OFF),alarm,kapilar,kaput,bagaj,objective);
			PVS->Int->isiklar[playerid]->!PVG->Int->isiklar[playerid];
		}
		case 13:
		{
			GetVehicleParamsEx(vehid,motor,isiklar,alarm,kapilar,kaput,bagaj,objective);
			SetVehicleParamsEx(vehid,(PVG->Int->motor[playerid] == 0) ? (VEHICLE_PARAMS_ON) : (VEHICLE_PARAMS_OFF),isiklar,alarm,kapilar,kaput,bagaj,objective);
			PVS->Int->motor[playerid]->!PVG->Int->motor[playerid];
		}
		case 14:
		{
			komut_kilit(playerid, " ");
		}
	}
	return 1;
}
	FP_GetPlsayerSpeed(playerid)
	{
		new Float: vehiclesVelocity[3];
		GetPlayerVelocity(playerid, vehiclesVelocity[0], vehiclesVelocity[1], vehiclesVelocity[2]);
		return floatround(floatsqroot((vehiclesVelocity[0] * vehiclesVelocity[0] + vehiclesVelocity[1] * vehiclesVelocity[1] + vehiclesVelocity[2] * vehiclesVelocity[2])) * 200.2);
	}
/*CMD:evmenu(playerid, params[])
{
	if (GetHouseID(playerid) == 0)
	{
		HataMesaji(playerid, "Bir evin çevresinde deðilsiniz.");
	}
	else
	{
		HouseMenu(playerid);
	}
	return 1;
}*/
CMD:evyarat(playerid, params[])
{
/*	if (GetHouseID(playerid) == 0)
	{
		for(new house_id; house_id < 200; house_id++)
		{
			if (House[house_id][h_type] == 0)
			{
			    new id = house_id;
				new pickupid;
				new string[256];
				format(House[id][h_name], 24, "Ýsimsiz");
				format(House[id][h_owner], 24, "");
				House[id][h_price] = 1;
				House[id][h_type] = 1;
				House[id][h_lock] = 0;
				House[id][h_cash] = 0;
				House[id][h_x] = a_x;
				House[id][h_y] = a_y;
				House[id][h_z] = a_z;
				House[id][h_weapon1] = 0; House[id][h_ammo1] = 0;
				House[id][h_weapon2] = 0; House[id][h_ammo2] = 0;
				House[id][h_weapon3] = 0; House[id][h_ammo3] = 0;
				if (House[id][h_owned] == 0) pickupid = 19524;
				else format(evDurumu, 9, "Kilitli");
				if (pickupid == 19524)
				{
				    format(string, sizeof(string), "Apartman\n\
					{C3C3C3}Kapý No:{FFFFFF} %d\n\
					%s\n\
					{C3C3C3}Ev Sahibi:{FFFFFF} %s\n\
					{C3C3C3}Ev Durumu:{FFFFFF} %s\n", id, House[id][h_name], House[id][h_owner], evDurumu);
				}
				else
				{
				    format(string, sizeof(string), "Apartman\n\
					{C3C3C3}Kapý No:{FFFFFF} %d\n\
					%s\n\
					{C3C3C3}Ev Fiyatý:{FFFFFF} %d$\n\
					{C3C3C3}Ev Sahibi:{FFFFFF} N/A\n\
					{C3C3C3}Ev Durumu:{FFFFFF} Kilitli\n", id, House[id][h_name], evDurumu);
				}
				House[id][h_label] = Create3DTextLabel(string, 0xFFFFFFFF, House[id][h_x], House[id][h_y], House[id][h_z],10,0);
		    	House[id][h_pickup] = CreatePickup(pickupid, 1, House[id][h_x], House[id][h_y], House[id][h_z]);
			}
		}
	}
	else
	{
		HataMesaji(playerid, "Bu noktaya ev oluþturulamaz.");
	}
*/	return 1;
}
function GetHouseID(playerid)
{
	for(new i;i<200;i++)
	{
		if(IsPlayerInRangeOfPoint(playerid,2.0,House[i][h_x], House[i][h_y], House[i][h_z]))return i;
	}
	return 0;
}
function HouseMenu(playerid)
{
	new
	    string[256]
	;
	if (!strcmp(House[GetHouseID(playerid)][h_owner], getName(playerid)))
	{
		format (string, sizeof (string), "Ev Ismi\n");
		format (string, sizeof (string), "%sEv Para Kasasý", string);
		format (string, sizeof (string), "%s\nEv Silah Kasasý", string);
		format (string, sizeof (string), "%s\nEvi Sat", string);
		ShowPlayerDialog(playerid, 2040, DIALOG_STYLE_LIST, "{FFFFFF}[Z]ero{E24234} - {FFFFFF}Ev Menü", string, "Devam", "Kapat");
	}
	else
	{
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{FFFFFF}[Z]ero{E24234} - {FFFFFF}Ev Menü", "Bu evin sahibi deðilsiniz.", "Devam", "Kapat");
	}
	return 1;
}

stock evleriYukle()
{

/*
	h_id,
	h_name,
	h_weapon1, h_ammo1,
	h_weapon2, h_ammo2,
	h_weapon3, h_ammo3,
	h_cash,
	h_price,
	h_owned,
	h_type,
	h_owner[24]
*/
    new	gelenveri[24],id,pickupid, evTipi[9], evDurumu[9], string[144], count;
	mysql_query("SELECT * FROM `evler`");
	mysql_store_result();
	while (mysql_retrieve_row())
	{
	    count++;
		mysql_fetch_field_row(gelenveri, "ev_id"); id = strval(gelenveri);
		mysql_fetch_field_row(gelenveri, "ev_ismi"); format(House[id][h_name], 24, "%s", gelenveri);
		mysql_fetch_field_row(gelenveri, "ev_sahibi"); format(House[id][h_owner], 24, "%s", gelenveri);
		mysql_fetch_field_row(gelenveri, "ev_fiyat"); House[id][h_price] = strval(gelenveri);
		mysql_fetch_field_row(gelenveri, "ev_tip"); House[id][h_type] = strval(gelenveri);
		mysql_fetch_field_row(gelenveri, "ev_kilit"); House[id][h_lock] = strval(gelenveri);
		mysql_fetch_field_row(gelenveri, "ev_kasa"); House[id][h_cash] = strval(gelenveri);
		mysql_fetch_field_row(gelenveri, "ev_x"); House[id][h_x] = floatstr(gelenveri);
		mysql_fetch_field_row(gelenveri, "ev_y"); House[id][h_y] = floatstr(gelenveri);
		mysql_fetch_field_row(gelenveri, "ev_z"); House[id][h_z] = floatstr(gelenveri);
		mysql_fetch_field_row(gelenveri, "ev_silah1"); House[id][h_weapon1] = strval(gelenveri);mysql_fetch_field_row(gelenveri, "ev_mermi1"); House[id][h_ammo1] = strval(gelenveri);
		mysql_fetch_field_row(gelenveri, "ev_silah2"); House[id][h_weapon2] = strval(gelenveri);mysql_fetch_field_row(gelenveri, "ev_mermi2"); House[id][h_ammo2] = strval(gelenveri);
		mysql_fetch_field_row(gelenveri, "ev_silah3"); House[id][h_weapon3] = strval(gelenveri);mysql_fetch_field_row(gelenveri, "ev_mermi3"); House[id][h_ammo3] = strval(gelenveri);
		if (House[id][h_owned] == 0) pickupid = 19524;
		else pickupid = 19522;
		if (House[id][h_lock] == 0) format(evDurumu, 9, "Açýk");
		else format(evDurumu, 9, "Kilitli");
		if (House[id][h_type] == 0)
		{
		    format(evTipi, 9, "Apartman");
		}
		if (House[id][h_type] == 1)
		{
		    format(evTipi, 9, "Bahçeli Ev");
		}
		if (House[id][h_type] == 2)
		{
		    format(evTipi, 9, "Villa");
		}
		if (pickupid == 19524)
		{
		    format(string, sizeof(string), "%s\n\
			{C3C3C3}Kapý No:{FFFFFF} %d\n\
			%s\n\
			{C3C3C3}Ev Sahibi:{FFFFFF} %s\n\
			{C3C3C3}Ev Durumu:{FFFFFF} %s\n", evTipi, id, House[id][h_name], House[id][h_owner], evDurumu);
		}
		else
		{
		    format(string, sizeof(string), "%s\n\
			{C3C3C3}Kapý No:{FFFFFF} %d\n\
			%s\n\
			{C3C3C3}Ev Fiyatý:{FFFFFF} %d$\n\
			{C3C3C3}Ev Sahibi:{FFFFFF} N/A\n\
			{C3C3C3}Ev Durumu:{FFFFFF} Kilitli\n", evTipi, id, House[id][h_name], evDurumu);
		}
		House[id][h_label] = Create3DTextLabel(string, 0xFFFFFFFF, House[id][h_x], House[id][h_y], House[id][h_z],10,0);
    	House[id][h_pickup] = CreatePickup(pickupid, 1, House[id][h_x], House[id][h_y], House[id][h_z]);
	}
	mysql_free_result();
	printf("Number of houses: %d", count);
	return 1;
}
stock reloadHouse(id)
{
    new pickupid, evTipi[9], evDurumu[9], string[144];
	if (House[id][h_owned] == 0) pickupid = 19524;
	else pickupid = 19522;
	if (House[id][h_lock] == 0) format(evDurumu, 9, "Açýk");
	else format(evDurumu, 9, "Kilitli");
	if (House[id][h_type] == 0)
	{
	    format(evTipi, 9, "Apartman");
	}
	if (House[id][h_type] == 1)
	{
	    format(evTipi, 9, "Bahçeli Ev");
	}
	if (House[id][h_type] == 2)
	{
	    format(evTipi, 9, "Villa");
	}
	if (pickupid == 19524)
	{
	    format(string, sizeof(string), "%s\n\
		{C3C3C3}Kapý No:{FFFFFF} %d\n\
		%s\n\
		{C3C3C3}Ev Sahibi:{FFFFFF} %s\n\
		{C3C3C3}Ev Durumu:{FFFFFF} %s\n", evTipi, id, House[id][h_name], House[id][h_owner], evDurumu);
	}
	else
	{
	    format(string, sizeof(string), "%s\n\
		{C3C3C3}Kapý No:{FFFFFF} %d\n\
		%s\n\
		{C3C3C3}Ev Fiyatý:{FFFFFF} %d$\n\
		{C3C3C3}Ev Sahibi:{FFFFFF} N/A\n\
		{C3C3C3}Ev Durumu:{FFFFFF} Kilitli\n", evTipi, id, House[id][h_name], evDurumu);
	}
	House[id][h_label] = Create3DTextLabel(string, 0xFFFFFFFF, House[id][h_x], House[id][h_y], House[id][h_z],10,0);
  	House[id][h_pickup] = CreatePickup(pickupid, 1, House[id][h_x], House[id][h_y], House[id][h_z]);
}
LoginPlayer(playerid)
{
	mysql_free_result();
    new	Query[1024];
	format(Query, sizeof(Query), "SELECT * FROM `oyuncular` WHERE `kullaniciadi` = '%s'", oIsim(playerid));
	mysql_query(Query);
	mysql_store_result();
	if(mysql_num_rows() > 0){
        if(mysql_fetch_row(Query)){
        sscanf(Query, "p<|>e<ds[24]s[35]ddddddds[30]s[30]dddddddddddds[20]ds[30]fffdddddddds[25]dddddd>", PlayerInfo[playerid]);
		}
	}
	mysql_free_result();

	new savingstring[512];
	format(Query, sizeof(Query), "SELECT * FROM `oyuncular` WHERE `kullaniciadi` = '%s'", oIsim(playerid));
	mysql_query(Query);
	printf(Query);
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
	while(mysql_retrieve_row())
	{
	mysql_fetch_field_row(savingstring, "ceteid");PlayerInfo[playerid][Cete] = strval(savingstring);
	mysql_fetch_field_row(savingstring, "dj");PlayerInfo[playerid][DJ] = strval(savingstring);
	mysql_fetch_field_row(savingstring, "spawnsecim");PlayerInfo[playerid][SpawnAlani] = strval(savingstring);
	mysql_fetch_field_row(savingstring, "ceterutbe");PlayerInfo[playerid][CeteRutbe] = strval(savingstring);
	mysql_fetch_field_row(savingstring, "pinfox");PlayerInfo[playerid][pinfox] = floatstr(savingstring);
	mysql_fetch_field_row(savingstring, "pinfoy");PlayerInfo[playerid][pinfoy] = floatstr(savingstring);
	mysql_fetch_field_row(savingstring, "pinfoz");PlayerInfo[playerid][pinfoz] = floatstr(savingstring);
	mysql_fetch_field_row(savingstring, "pinfointerior");PlayerInfo[playerid][pinfointerior] = strval(savingstring);
	mysql_fetch_field_row(savingstring, "pinfoworld");PlayerInfo[playerid][pinfoworld] = strval(savingstring);
	mysql_fetch_field_row(savingstring, "skinplayer");PlayerInfo[playerid][skinplayer] = strval(savingstring);
	mysql_fetch_field_row(savingstring, "rengim");PlayerInfo[playerid][rengim] = strval(savingstring);
	}
	}
/* TERCÝHLER */

	format(Query, sizeof(Query), "SELECT * FROM `oyuncular` WHERE `kullaniciadi` = '%s'", oIsim(playerid));
	mysql_query(Query);
	printf(Query);
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
	while(mysql_retrieve_row())
	{
	mysql_fetch_field_row(savingstring, "semiprotercih");PlayerInfo[playerid][semiprotercih] = strval(savingstring);
	mysql_fetch_field_row(savingstring, "veterantercih");PlayerInfo[playerid][veterantercih] = strval(savingstring);
	mysql_fetch_field_row(savingstring, "odul");PlayerInfo[playerid][odultercih] = strval(savingstring);
	}
	}
	mysql_free_result();

/* TERCÝHLER BÝTÝÞ */

//	new savingstring[512];
	format(Query, sizeof(Query), "SELECT * FROM `oyuncular` WHERE `kullaniciadi` = '%s'", oIsim(playerid));
	mysql_query(Query);
	printf(Query);
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
	while(mysql_retrieve_row())
	{
	mysql_fetch_field_row(savingstring, "deposit");PlayerInfo[playerid][Deposit] = strval(savingstring);
	mysql_fetch_field_row(savingstring, "Ikramiye");PlayerInfo[playerid][Ikramiye] = strval(savingstring);
	}
	}
	mysql_free_result();

	format(Query, sizeof(Query), "SELECT * FROM `oyuncular` WHERE `kullaniciadi` = '%s'", oIsim(playerid));
	mysql_query(Query);
	printf(Query);
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
	while(mysql_retrieve_row())
	{
	mysql_fetch_field_row(savingstring, "spectime");PlayerInfo[playerid][spectime] = strval(savingstring);
	}
	}
	mysql_free_result();
	format(Query, sizeof(Query), "SELECT * FROM `oyuncular` WHERE `kullaniciadi` = '%s'", oIsim(playerid));
	mysql_query(Query);
	printf(Query);
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
	while(mysql_retrieve_row())
	{
	mysql_fetch_field_row(savingstring, "onlinet");PlayerInfo[playerid][onlinet] = strval(savingstring);
	}
	}
	mysql_free_result();
	//CeteYukle(playerid);
	if(PlayerInfo[playerid][language] == 2)
		SetPVarInt(playerid, "Language__", ENGLISH);
	else
		SetPVarInt(playerid, "Language__", TURKISH);
	onlines[playerid] = GetTickCount();
	PlayerInfo[playerid][TimesOnServer]++;
	new day,year,month,strdate[30];
	getdate(year,month,day);
	format(strdate, sizeof(strdate), "%d.%d.%d",day,month,year);
	strmid(PlayerInfo[playerid][LastOn], strdate, 0, strlen(strdate), 255);
 	PlayerInfo[playerid][Registered] = 1;
 	PlayerInfo[playerid][LoggedIn] = 1;
 	SetPlayerScore(playerid,PlayerInfo[playerid][score]);
 	//cek(playerid);
 	format(Query, sizeof(Query), "UPDATE `oyuncular` SET `LastOn` = '%s', `loggedin` = '1', `TimesOnServer` = '%d' WHERE `kullaniciadi` = '%s'", PlayerInfo[playerid][LastOn], PlayerInfo[playerid][TimesOnServer], oIsim(playerid));
	mysql_query(Query);//
	mysql_free_result();

			new i = playerid;
			if(PlayerInfo[playerid][muted] == 1 && PlayerInfo[playerid][mutedtime] == 0)
			{
				PlayerInfo[playerid][muted] = 0;
				Bilgimesaj(playerid, "Mute cezanizin suresi doldu, iyi oyunlar!", "You unmuted by server, good games!");
			}
			if(PlayerInfo[playerid][mutedtime] == 0) PlayerInfo[playerid][muted] = 0;
			if(PlayerInfo[playerid][Jailed] == 1 && PlayerInfo[playerid][JailTime] == 0)
			{
			    SpawnPlayer(i);
				PlayerInfo[playerid][Jailed] = 0;
				Bilgimesaj(playerid, "Hapisten sureniz doldugu icin cikarildiniz.", "You released, good games!");
			}
			if(PlayerInfo[playerid][JailTime] == 0) PlayerInfo[playerid][Jailed] = 0;
			new Float:Pos[3];
			GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
			if(Pos[2] < 0.08)
			{
			    SetPVarInt(playerid, "DenizSeviyesinde", 0);
			}
			else
			{
			    SetPVarInt(playerid, "DenizSeviyesinde", 0);
			}
			if(PlayerInfo[playerid][Jailed] == 1 && PlayerInfo[playerid][JailTime] > 0)
			{
			    PlayerInfo[playerid][JailTime] --;
			}
			if(PlayerInfo[playerid][muted] == 1 && PlayerInfo[playerid][mutedtime] > 0)
			{
			    PlayerInfo[playerid][mutedtime] --;
			}
			if(PlayerInfo[playerid][Veteran] == 1 || PlayerInfo[playerid][SemiPro] == 1)
			{
			    if(PlayerInfo[playerid][odultercih] == 1) GivePlayerMoney(playerid, 5000);
			    if(PlayerInfo[playerid][odultercih] == 2) SetPlayerScore(playerid, GetPlayerScore(playerid)+2);
			}
	if (PlayerInfo[playerid][Level] > 0)
	{
		new string[256];
		format(string,sizeof(string), "« zr-Admin »{FFFFFF} Sunucuya {E24234}' %d '{FFFFFF} level admin olarak baglandiniz!",PlayerInfo[playerid][Level]);
		SendClientMessage(playerid, 0xC3C3C3C3, string);
	}
	if (PlayerInfo[playerid][Animator] > 0)
	{
		new string[256];
		format(string,sizeof(string), "« zr-Admin »{FFFFFF} Sunucuya {E24234}' %d '{FFFFFF} level animatör olarak baglandiniz!",PlayerInfo[playerid][Animator]);
		SendClientMessage(playerid, 0xC3C3C3C3, string);
	}
}

