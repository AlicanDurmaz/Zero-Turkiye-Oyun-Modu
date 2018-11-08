#define PVS->%0->%1[%2]->%3; SetPVar%0(%2,#%1,%3);
#define PVG->%0->%1[%2] GetPVar%0(%2,#%1)
#include <YSI\y_hooks>

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(GetPVarInt(playerid,"AntiFloodRSpawnMagNeteC") > GetTickCount())
	{
		if(GetPVarInt(playerid,"flood_rspawn") > 5)
		{
			Kickle(playerid,"Car Hack");
			return 0;
		}
		SetPVarInt(playerid,"flood_rspawn",GetPVarInt(playerid,"flood_rspawn")+1);
	}else
	{
		SetPVarInt(playerid,"flood_rspawn",0);
		SetPVarInt(playerid, "AntiFloodRSpawnMagNeteC", GetTickCount()+300);
	}
	return 1;
}
hook OnPlayerRequestSpawn(playerid)
{
	if(GetPVarInt(playerid,"AntiFloodRSpawnMagNeteC") > GetTickCount())
	{
		if(GetPVarInt(playerid,"flood_rspawn") > 3)
		{
			Kickle(playerid,"Hack");
			return 0;
		}
		SetPVarInt(playerid,"flood_rspawn",GetPVarInt(playerid,"flood_rspawn")+1);
	}else
	{
		SetPVarInt(playerid,"flood_rspawn",0);
		SetPVarInt(playerid, "AntiFloodRSpawnMagNeteC", GetTickCount()+300);
	}
	return 1;
}
hook OnPlayerCommandText(playerid, cmdtext[])
{
	if(GetPVarInt(playerid,"AntiFloodCommandMagNeteC") > GetTickCount())
	{
		if(GetPVarInt(playerid,"flood_cmd") > 3)
		{
			Kickle(playerid,"Coomand Flood");
			return 0;
		}
		SetPVarInt(playerid,"flood_cmd",GetPVarInt(playerid,"flood_cmd")+1);
	}else
	{
		SetPVarInt(playerid,"flood_cmd",0);
		SetPVarInt(playerid, "AntiFloodCommandMagNeteC", GetTickCount()+300);
	}
	return 0;
}
hook OnPlayerText(playerid, text[])
{
	if(GetPVarInt(playerid,"AntiFloodTextMagNeteC") > GetTickCount())
	{
		if(GetPVarInt(playerid,"flood_text") > 3)
		{
			Kickle(playerid,"Text Flood");
			return 0;
		}
		SetPVarInt(playerid,"flood_text",GetPVarInt(playerid,"flood_text")+1);
	}else
	{
		SetPVarInt(playerid,"flood_text",0);
		SetPVarInt(playerid, "AntiFloodTextMagNeteC", GetTickCount()+300);
	}
	return 0;
}
hook OnPlayerSpawn(playerid)
{
	if(GetPVarInt(playerid,"AntiFloodSpawnMagNeteC") > GetTickCount())
	{
		if(GetPVarInt(playerid,"flood_spawn") > 3)
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
	return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid != INVALID_PLAYER_ID && playerid == killerid)return SendClientMessage(playerid, -1, "{E24234}<(Bilgi)>{FFFFFF} Hile yaptýðýnýz için {E24234}' 500 '{FFFFFF} skorunuz kesilmistir."),SetPlayerScore(playerid, GetPlayerScore(playerid)-500), Kickle(playerid,"Death Hack");
	if(GetPVarInt(playerid,"AntiFloodKillMagNeteC") > GetTickCount())
	{
		if(GetPVarInt(playerid,"flood_kill") > 3)
		{
			Kickle(playerid,"Fake Kill");
			return 1;
		}
		SetPVarInt(playerid,"flood_kill",GetPVarInt(playerid,"flood_kill")+1);
	}else
	{
		SetPVarInt(playerid,"flood_kill",0);
		SetPVarInt(playerid, "AntiFloodKillMagNeteC", GetTickCount()+300);
	}
	return 1;
}
