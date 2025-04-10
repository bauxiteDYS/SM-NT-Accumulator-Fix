#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = {
	name = "NT Damage Accumulator fix",
	description = "Fixes issue with damage accumulator not resetting on spawn",
	author = "bauxite",
	version = "0.1.0",
	url = "https://github.com/bauxiteDYS/SM-NT-Accumulator-Fix"
};

public void OnPluginStart()
{
	if (!HookEventEx("player_spawn", OnPlayerSpawnPost, EventHookMode_Post))
	{
		SetFailState("[NT Accumulator fix] Failed to hook event player_spawn");
	}
}

public void OnPlayerSpawnPost(Event event, const char[] name, bool dontBroadcast)
{
	int userid = event.GetInt("userid");
	RequestFrame(AccumulatorFix, userid);
}

void AccumulatorFix(int userid)
{
	int client = GetClientOfUserId(userid);
	
	if(client <= 0 || client > MaxClients || !IsClientInGame(client))
	{
		return;
	}
	
	SetEntPropFloat(client, Prop_Data, "m_flDamageAccumulator", 0.0);
}
