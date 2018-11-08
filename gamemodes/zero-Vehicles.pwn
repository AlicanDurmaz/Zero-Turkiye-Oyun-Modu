#include <a_samp>
#include zcmd
#include <YSI\y_hooks>
new vehahaames[212][] = {
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
};
#define tott_itemaS        	 	204
#define selectioaN_itemaS 		12
#define itemaS_PER_LINE   		2
#define DIALOG_bambase_X   		250.0
#define DIALOG_bambase_Y       	55.0
#define SPRdasadsDIM_X    		50.0
#define SPRdasadsDIM_Y    		40.0
new gTotalitemas = tott_itemaS;
new PlayerText:gselectioanitemas[MAX_PLAYERS][selectioaN_itemaS];
new PlayerText:gselectioanitemasName[MAX_PLAYERS][selectioaN_itemaS];
new gselectioanitemasTag[MAX_PLAYERS][selectioaN_itemaS];
new gitemaAt[MAX_PLAYERS];
new gitemaList[tott_itemaS] = {
602, 429, 536, 402, 541, 415, 480, 411, 603, 506, 451, 477, 565, 562, 559, 534, 567, 535, 561, 560, 566, 576, 558, 412,
581, 509, 481, 462, 521, 463, 510, 522, 461, 448, 471, 468, 568, 424, 573, 579, 400, 500, 444, 556, 557, 470, 489, 495,
592, 577, 511, 512, 512, 593, 553, 476, 519, 460, 513, 539, 548, 548, 417, 487, 497, 563, 563, 469, 406, 524, 486, 531,
472, 473, 493, 595, 484, 430, 453, 452, 446, 454, 588, 423, 485, 457, 483, 532, 530, 434, 572, 428, 409, 574, 525, 583,
445, 504, 401, 518, 527, 466, 546, 418, 404, 550, 491, 529, 416, 431, 438, 437, 427, 407, 455, 582, 582, 608, 608, 552,
578, 587, 498, 610, 494, 502, 503, 443, 413, 515, 555, 456, 435, 450, 591, 606, 607, 499, 571, 414, 516, 514, 540, 554,
458, 564, 441, 441, 501, 465, 594, 601, 496, 533, 405, 421, 580, 439, 586, 475, 547, 426, 507, 474, 482, 542, 492, 467,
479, 600, 436, 545, 584, 599, 611, 596, 597, 598, 575, 408, 403, 410, 419, 422, 433, 440, 442, 459, 478, 488, 490, 505,
508, 517, 523, 526, 528, 543, 544, 549, 551, 585, 589, 604
};
PlayerText:CreateModelasdasdTextDraw(playerid, modelindex, Float:Xpos, Float:Ypos, Float:width, Float:height)
{
    new PlayerText:txtPlayerSprite = CreatePlayerTextDraw(playerid, Xpos, Ypos, ""); // it has to be set with SetText later
    PlayerTextDrawFont(playerid, txtPlayerSprite, 5);
    PlayerTextDrawColor(playerid, txtPlayerSprite, 0xFFFFFFFF);
    PlayerTextDrawBackgroundColor(playerid, txtPlayerSprite, 0x00000000);
    PlayerTextDrawTextSize(playerid, txtPlayerSprite, width, height); // Text size is the Width:Height
    PlayerTextDrawSetPreviewModel(playerid, txtPlayerSprite, modelindex);
    PlayerTextDrawSetPreviewRot(playerid,txtPlayerSprite, -16.0, 0.0, -55.0);
    PlayerTextDrawSetSelectable(playerid, txtPlayerSprite, 1);
    return txtPlayerSprite;
}
PlayerText:CreateModelNameTextDraw(playerid, Float:Xpos, Float:Ypos)
{
    new PlayerText:txtPlayerSprite = CreatePlayerTextDraw(playerid, Xpos+10, Ypos+40, ""); // it has to be set with SetText later
    PlayerTextDrawColor(playerid, txtPlayerSprite, 0xFFFFFFFF);
    PlayerTextDrawBackgroundColor(playerid, txtPlayerSprite, 0x00000000);
    PlayerTextDrawFont(playerid,txtPlayerSprite, 1);
    PlayerTextDrawLetterSize(playerid, txtPlayerSprite, 0.190000, 0.909999);
	return txtPlayerSprite;
}
//------------------------------------------------
HidePlayerModelasdasds(playerid)
{
	new x=0;
	while(x != selectioaN_itemaS) {
	    if(gselectioanitemas[playerid][x] != PlayerText:INVALID_TEXT_DRAW) {
			PlayerTextDrawHide(playerid, gselectioanitemas[playerid][x]);
			PlayerTextDrawHide(playerid, gselectioanitemasName[playerid][x]);
		}
		x++;
	}
}
ShowPlayerModelasdasds(playerid)
{
    new x=0;
	new itemaat = GetPVarInt(playerid, "vspawner_page") * selectioaN_itemaS;

	// Destroy any previous ones created
	HidePlayerModelasdasds(playerid);
	while(x != selectioaN_itemaS && itemaat < gTotalitemas) {
  		PlayerTextDrawSetPreviewModel(playerid, gselectioanitemas[playerid][x], gitemaList[itemaat]);
		PlayerTextDrawShow(playerid, gselectioanitemas[playerid][x]);
		new str[30];
		format(str,30,"~w~~h~~h~~h~%s",vehahaames[gitemaList[itemaat]-400]);
		PlayerTextDrawSetString(playerid,gselectioanitemasName[playerid][x],str);
		PlayerTextDrawShow(playerid, gselectioanitemasName[playerid][x]);
		gselectioanitemasTag[playerid][x] = gitemaList[itemaat];
		itemaat++;
		x++;
	}
}
selectioanMenu(playerid)
{
	ShowPlayerModelasdasds(playerid);
}
CloseselectioanMenu(playerid)
{
	HidePlayerModelasdasds(playerid);
	return 1;
}
CreateselectioanMenu(playerid)
{
	new x=0;
	new Float:bambaseX = DIALOG_bambase_X;
	new Float:bambaseY = DIALOG_bambase_Y - (SPRdasadsDIM_Y * -0.33); // down a bit
	new linetracker = 0;
	new itemaat = GetPVarInt(playerid, "vspawner_page") * selectioaN_itemaS;
	while(x != selectioaN_itemaS && itemaat < gTotalitemas) {
	    if(linetracker == 0) {
	        bambaseX = DIALOG_bambase_X + 20.0; // in a bit from the box
	        bambaseY += SPRdasadsDIM_Y; // move on the Y for the next line
		}
  		gselectioanitemas[playerid][x] = CreateModelasdasdTextDraw(playerid, gitemaList[itemaat], bambaseX, bambaseY, SPRdasadsDIM_X, SPRdasadsDIM_Y);
        gselectioanitemasName[playerid][x] = CreateModelNameTextDraw(playerid, bambaseX, bambaseY);
		gselectioanitemasTag[playerid][x] = gitemaList[itemaat];
		bambaseX += SPRdasadsDIM_X;
		linetracker++;
		if(linetracker == itemaS_PER_LINE) linetracker = 0;
		itemaat++;
		x++;
	}
	gitemaAt[playerid] = 0;
}
//ayer(playerid, vehiclemodel)
//{//
	//return CreatePlayerVehicle(playerid, vehiclemodel);
//}/

HandlePlayeritemaselectioan(playerid, selecteditema)
{
    SpawnVehicle_InfrontOfPlayer(playerid, gselectioanitemasTag[playerid][selecteditema]);
}
CMD:v1(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v1, "V1");
	return 1;
}CMD:v2(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v2, "V2");
	return 1;
}CMD:v3(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v3, "V3");
	return 1;
}CMD:v4(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v4, "V4");
	return 1;
}CMD:v5(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v5, "V5");
	return 1;
}CMD:v6(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v6, "V6");
	return 1;
}CMD:v7	(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v7, "V7");
	return 1;
}CMD:v8	(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v8, "V8");
	return 1;
}CMD:v9	(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v9, "V9");
	return 1;
}CMD:v10	(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v10, "V10");
	return 1;
}CMD:v11	(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v11, "V11");
	return 1;
}CMD:v12	(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v12, "V12");
	return 1;
}CMD:v13	(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v13, "V13");
	return 1;
}CMD:v14	(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v14, "V14");
	return 1;
}CMD:v15	(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v15, "V15");
	return 1;
}CMD:v16	(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v16, "V16");
	return 1;
}CMD:v17	(playerid,params[])
{
	ShowModelSelectionMenu(playerid, v17, "V17");
	return 1;
} /*
CMD:v2(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 1);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}
CMD:v3(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 2);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}
CMD:v4(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 3);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}
CMD:v5(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 4);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}
CMD:v6(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 5);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}
CMD:v7(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 6);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}
CMD:v8(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 7);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}
CMD:v9(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 8);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}
CMD:v10(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 9);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}
CMD:v11(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 10);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}
CMD:v12(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 11);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}
CMD:v13(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 12);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}
CMD:v14(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 13);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}
CMD:v15(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 14);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}
CMD:v16(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 15);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}
CMD:v17(playerid,params[])
{

	CloseselectioanMenu(playerid);
	SetPVarInt(playerid, "vspawner_active", 1);
	SetPVarInt(playerid, "vspawner_page", 16);
	selectioanMenu(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}*/

stock getName(playerid)
{
	static pName[25];
	pName[0] = EOS;
	GetPlayerName(playerid,pName,25);
	return pName;
}
hook OnPlayerConnect(playerid)
{
    CreateselectioanMenu(playerid);
	return 1;
}
