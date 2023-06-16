#include <a_samp>
#define FILTERSCRIPT
//******************************************************************************
/*
                           **********************************
						   ** Rabel Arac Hiz Gostergesi    **
                           ** Versiyon                     **
					  	   **********************************
							     
                                 2022/2023 Grg Samp                           */
//******************************************************************************
#define GetVehicleModelName(%1) Vehiclename[%1-400]
#define VehicleSpeed_1       false
#define VehicleSpeed_2       true
#define VehicleSpeed_A       0
#define VehicleSpeed_B       6
#define AUTOR             "Rabel"
#define VERSION            "1.0"
#define TEXTDRAW             "6"
#define COLOR                "2"
#define COLOR_WHITE       0xFFFFFFAA
#define COLOR_RED         0xFF0000FF

new bool:R_Vehicle[MAX_PLAYERS] = false;
new Text:Vehname[MAX_PLAYERS];
new Text:VehicleSpeed[MAX_PLAYERS];
new Text:KMH[MAX_PLAYERS];
new Text:Speedometer_R[MAX_PLAYERS];
new Text:SpeeedBox;
new Text:SpeedName;


enum SpeedInfoDB
{
    bool:SpeedometerR,
}
new SpeedDB[MAX_PLAYERS][SpeedInfoDB];

new	Vehiclename[][] = //Arac Isimleri
{
		"Landstalker",
		"Bravura",
		"Buffalo",
		"Linerunner",
		"Pereniel",
		"Sentinel",
		"Dumper",
		"Firetruck",
		"Trashmaster",
		"Stretch",
		"Manana",
		"Infernus",
		"Voodoo",
		"Pony",
		"Mule",
		"Cheetah",
		"Ambulance",
		"Leviathan",
		"Moonbeam",
		"Esperanto",
		"Taxi",
		"Washington",
		"Bobcat",
		"Mr Whoopee",
		"BF Injection",
		"Hunter",
		"Premier",
		"Enforcer",
		"Securicar",
		"Banshee",
		"Predator",
		"Bus",
		"Rhino",
		"Barracks",
		"Hotknife",
		"Trailer",
		"Previon",
		"Coach",
		"Cabbie",
		"Stallion",
		"Rumpo",
		"RC Bandit",
		"Romero",
		"Packer",
		"Monster Truck",
		"Admiral",
		"Squalo",
		"Seasparrow",
		"Pizzaboy",
		"Tram",
		"Trailer",
		"Turismo",
		"Speeder",
		"Reefer",
		"Tropic",
		"Flatbed",
		"Yankee",
		"Caddy",
		"Solair",
		"Berkley's RC Van",
		"Skimmer",
		"PCJ-600",
		"Faggio",
		"Freeway",
		"RC Baron",
		"RC Raider",
		"Glendale",
		"Oceanic",
		"Sanchez",
		"Sparrow",
		"Patriot",
		"Quad",
		"Coastguard",
		"Dinghy",
		"Hermes",
		"Sabre",
		"Rustler",
		"ZR-350",
		"Walton",
		"Regina",
		"Comet",
		"BMX",
		"Burrito",
		"Camper",
		"Marquis",
		"Baggage",
		"Dozer",
		"Maverick",
		"News Chopper",
		"Rancher",
		"FBI Rancher",
		"Virgo",
		"Greenwood",
		"Jetmax",
		"Hotring",
		"Sandking",
		"Blista Compact",
		"Police Maverick",
		"Boxville",
		"Benson",
		"Mesa",
		"RC Goblin",
		"Hotring Racer",
		"Hotring Racer",
		"Bloodring Banger",
		"Rancher",
		"Super GT",
		"Elegant",
		"Journey",
		"Bike",
		"Mountain Bike",
		"Beagle",
		"Cropdust",
		"Stunt",
		"Tanker",
		"RoadTrain",
		"Nebula",
		"Majestic",
		"Buccaneer",
		"Shamal",
		"Hydra",
		"FCR-900",
		"NRG-500",
		"HPV1000",
		"Cement Truck",
		"Tow Truck",
		"Fortune",
		"Cadrona",
		"FBI Truck",
		"Willard",
		"Forklift",
		"Tractor",
		"Combine",
		"Feltzer",
		"Remington",
		"Slamvan",
		"Blade",
		"Freight",
		"Streak",
		"Vortex",
		"Vincent",
		"Bullet",
		"Clover",
		"Sadler",
		"Firetruck",
		"Hustler",
		"Intruder",
		"Primo",
		"Cargobob",
		"Tampa",
		"Sunrise",
		"Merit",
		"Utility",
		"Nevada",
		"Yosemite",
		"Windsor",
		"Monster Truck",
		"Monster Truck",
		"Uranus",
		"Jester",
		"Sultan",
		"Stratum",
		"Elegy",
		"Raindance",
		"RC Tiger",
		"Flash",
		"Tahoma",
		"Savanna",
		"Bandito",
		"Freight",
		"Trailer",
		"Kart",
		"Mower",
		"Duneride",
		"Sweeper",
		"Broadway",
		"Tornado",
		"AT-400",
		"DFT-30",
		"Huntley",
		"Stafford",
		"BF-400",
		"Newsvan",
		"Tug",
		"Trailer",
		"Emperor",
		"Wayfarer",
		"Euros",
		"Hotdog",
		"Club",
		"Trailer",
		"Trailer",
		"Andromada",
		"Dodo",
		"RC Cam",
		"Launch",
		"Police Car (LSPD)",
		"Police Car (SFPD)",
		"Police Car (LVPD)",
		"Police Ranger",
		"Picador",
		"S.W.A.T. Van",
		"Alpha",
		"Phoenix",
		"Glendale",
		"Sadler",
		"Luggage Trailer",
		"Luggage Trailer",
		"Stair Trailer",
		"Boxville",
		"Farm Plow",
		"Utility Trailer"
};
//______________________________________________________________________________
public OnFilterScriptInit()
{
    printf("\n AUTOR     %s  ", AUTOR);
    printf("\n VERSION   %s  ", VERSION);
    printf("\n TEXTDARW  %s  ", TEXTDRAW);
    printf("\n COLOR     %s  ", COLOR);
    print("\n**************************************");
	print("    Arac Göstergesi Yüklendi %100       ");
	print("****************************************\n");
	
	TextDrawUseBox(SpeeedBox,1);
	TextDrawBoxColor(SpeeedBox,0xffffff33);
	TextDrawTextSize(SpeeedBox,616.000000,0.000000);
	TextDrawUseBox(SpeedName,1);
	TextDrawBoxColor(SpeedName,0xffffff33);
	TextDrawTextSize(SpeedName,585.000000,5.000000);
	TextDrawAlignment(SpeeedBox,0);
	TextDrawAlignment(SpeedName,0);
	TextDrawBackgroundColor(SpeeedBox,0x000000ff);
	TextDrawBackgroundColor(SpeedName,0xffffff66);
	TextDrawFont(SpeeedBox,1);
	TextDrawLetterSize(SpeeedBox,1.000000,1.000000);
	TextDrawFont(SpeedName,0);
	TextDrawLetterSize(SpeedName,0.799999,1.900000);
	TextDrawColor(SpeeedBox,0xffffffff);
	TextDrawColor(SpeedName,0x000000ff);
	TextDrawSetOutline(SpeeedBox,1);
	TextDrawSetOutline(SpeedName,1);
	TextDrawSetProportional(SpeeedBox,1);
	TextDrawSetProportional(SpeedName,1);
	TextDrawSetShadow(SpeeedBox,1);
	TextDrawSetShadow(SpeedName,1);
	
	VehicleSpeedTextDraw_R();
	return 1;
}

//______________________________________________________________________________
public OnPlayerDisconnect(playerid, reason)
{
	R_Vehicle[playerid] = VehicleSpeed_1;

    TextDrawHideForPlayer(playerid, SpeeedBox);
    TextDrawHideForPlayer(playerid, SpeedName);
    
    TextDrawHideForPlayer(playerid, KMH[playerid]);
    TextDrawHideForPlayer(playerid, VehicleSpeed[playerid]);
    TextDrawHideForPlayer(playerid, Speedometer_R[playerid]);
    TextDrawHideForPlayer(playerid, Vehname[playerid]);
	return 1;
}
//______________________________________________________________________________
public OnPlayerSpawn(playerid)
{
	R_Vehicle[playerid] = VehicleSpeed_1;
	return 1;
}
//______________________________________________________________________________
public OnPlayerDeath(playerid, killerid, reason)
{
	R_Vehicle[playerid] = VehicleSpeed_1;
	return 1;
}
//______________________________________________________________________________
public OnFilterScriptExit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    TextDrawDestroy(KMH[i]);
	    TextDrawDestroy(VehicleSpeed[i]);
	    TextDrawDestroy(Speedometer_R[i]);
	    TextDrawDestroy(Vehname[i]);
	}
    TextDrawDestroy(SpeeedBox);
    TextDrawDestroy(SpeedName);
	return 1;
}
//______________________________________________________________________________
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new String[64];
	    new	String_R[64];
//******************************************************************************
//Arac Ismi
  		format(String, sizeof(String), "Aracin:");
		TextDrawSetString(Speedometer_R[playerid], String);
		TextDrawShowForPlayer(playerid, Speedometer_R[playerid]);
		
		format(String, sizeof(String), "~r~~p~%s", GetVehicleModelName(GetVehicleModel(GetPlayerVehicleID(playerid))));
		TextDrawSetString(Vehname[playerid], String);
		TextDrawShowForPlayer(playerid, Vehname[playerid]);
//******************************************************************************
// Arac Hizi
		format(String_R, sizeof(String_R), "KM/H", GetPlayerSpeed(playerid));
		TextDrawSetString(VehicleSpeed[playerid], String);
		TextDrawShowForPlayer(playerid, KMH[playerid]);

		format(String, sizeof(String), "~r~~p~%d", GetPlayerSpeed(playerid));
		TextDrawSetString(VehicleSpeed[playerid], String);
		TextDrawShowForPlayer(playerid, VehicleSpeed[playerid]);
//******************************************************************************
        TextDrawShowForPlayer(playerid, SpeeedBox);
        TextDrawShowForPlayer(playerid, SpeedName);
		R_Vehicle[playerid] = VehicleSpeed_2;
	}
	else if(newstate == PLAYER_STATE_ONFOOT)
	{
		R_Vehicle[playerid] = VehicleSpeed_1;
		TextDrawHideForPlayer(playerid, Speedometer_R[playerid]);
		TextDrawHideForPlayer(playerid, VehicleSpeed[playerid]);
		TextDrawHideForPlayer(playerid, KMH[playerid]);
		TextDrawHideForPlayer(playerid, Vehname[playerid]);
		TextDrawHideForPlayer(playerid, SpeeedBox);
		TextDrawHideForPlayer(playerid, SpeedName);
	}
	return 1;
}
//______________________________________________________________________________
public OnPlayerExitVehicle(playerid, vehicleid)
{
	R_Vehicle[playerid] = VehicleSpeed_1;
	TextDrawHideForPlayer(playerid, Speedometer_R[playerid]);
	TextDrawHideForPlayer(playerid, VehicleSpeed[playerid]);
	TextDrawHideForPlayer(playerid, KMH[playerid]);
	TextDrawHideForPlayer(playerid, Vehname[playerid]);
	TextDrawHideForPlayer(playerid, SpeeedBox);
	TextDrawHideForPlayer(playerid, SpeedName);
	return 1;
}
//______________________________________________________________________________
public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/speed", cmdtext, true) == 0)
	{
		if(SpeedDB[playerid][SpeedometerR] == false)
		{
            SpeedDB[playerid][SpeedometerR] = true;
    		TextDrawHideForPlayer(playerid, Speedometer_R[playerid]);
			TextDrawHideForPlayer(playerid, VehicleSpeed[playerid]);
			TextDrawHideForPlayer(playerid, KMH[playerid]);
			TextDrawHideForPlayer(playerid, Vehname[playerid]);
			TextDrawHideForPlayer(playerid, SpeeedBox);
			TextDrawHideForPlayer(playerid, SpeedName);
			SendClientMessage(playerid, 0xFF000096,"Speedometer off");
		}
		else
		{
            SpeedDB[playerid][SpeedometerR] = false;
		    TextDrawShowForPlayer(playerid, SpeeedBox);
	        TextDrawShowForPlayer(playerid, SpeedName);
	       	TextDrawShowForPlayer(playerid, Speedometer_R[playerid]);
		    TextDrawShowForPlayer(playerid, VehicleSpeed[playerid]);
			TextDrawShowForPlayer(playerid, KMH[playerid]);
			TextDrawShowForPlayer(playerid, Vehname[playerid]);
			SendClientMessage(playerid, 0xFF000096,"Speedometer on");
		}
		return 1;
	}
	return 0;
}
//______________________________________________________________________________
public OnPlayerUpdate(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		if(bool:R_Vehicle[playerid] == VehicleSpeed_2)
		{
			static UpdateSpeed_R[MAX_PLAYERS];
			if(UpdateSpeed_R[playerid] >= VehicleSpeed_B)
			{
//******************************************************************************
//Vehicle Name
				new string[64];
				format(string, sizeof(string), "Aracin:");
				TextDrawSetString(Speedometer_R[playerid], string);
				
				format(string, sizeof(string), "~r~~p~%s", GetVehicleModelName(GetVehicleModel(GetPlayerVehicleID(playerid))));
				TextDrawSetString(Vehname[playerid], string);

//******************************************************************************
// Vehicle Speed
				format(string, sizeof(string), "KM/H:");
				TextDrawSetString(Text:KMH[playerid], string);

				format(string, sizeof(string), "~r~~p~%d", GetPlayerSpeed(playerid));
				TextDrawSetString(VehicleSpeed[playerid], string);
				UpdateSpeed_R[playerid] = VehicleSpeed_A;
//******************************************************************************
   	            return 1;
            }
			else UpdateSpeed_R[playerid] ++;
		}
	}
	return 1;
}
//______________________________________________________________________________
VehicleSpeedTextDraw_R()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
//Vehicle Name
		Speedometer_R[i] = TextDrawCreate(150.000000,410.000000,"");
		TextDrawAlignment(Speedometer_R[i],0);
		TextDrawBackgroundColor(Speedometer_R[i],0x000000ff);
		TextDrawFont(Speedometer_R[i],1);
		TextDrawLetterSize(Speedometer_R[i],0.299999,1.300000);
		TextDrawColor(Speedometer_R[i],0xffffffff);
		TextDrawSetOutline(Speedometer_R[i],1);
		TextDrawSetProportional(Speedometer_R[i],1);
		TextDrawSetShadow(Speedometer_R[i],1);
//Vehicle Name_1
		Vehname[i] = TextDrawCreate(198.000000,411.000000,"_");
		TextDrawAlignment(Vehname[i],0);
		TextDrawFont(Vehname[i],1);
		TextDrawLetterSize(Vehname[i],0.399999,1.000000);
		TextDrawColor(Vehname[i],0xffffffff);
		TextDrawSetOutline(Vehname[i],1);
		TextDrawSetProportional(Vehname[i],1);
		TextDrawSetShadow(Vehname[i],1);
//Vehicle K/MH
		KMH[i] = TextDrawCreate(150.000000,420.000000,"K/MH:");
		TextDrawAlignment(KMH[i],0);
		TextDrawBackgroundColor(KMH[i],0x000000ff);
		TextDrawFont(KMH[i],1);
		TextDrawLetterSize(KMH[i],0.599999,2.599999);
		TextDrawColor(KMH[i],0xffffffff);
		TextDrawSetOutline(KMH[i],1);
		TextDrawSetProportional(KMH[i],1);
		TextDrawSetShadow(KMH[i],1);
//Vehicle K/MH_2
		VehicleSpeed[i] = TextDrawCreate(220.000000,425.000000,"_");
		TextDrawAlignment(VehicleSpeed[i],0);
		TextDrawFont(VehicleSpeed[i],2);
		TextDrawLetterSize(VehicleSpeed[i],1.000000,1.400000);
		TextDrawColor(VehicleSpeed[i],0xffffffff);
		TextDrawSetOutline(VehicleSpeed[i],1);
		TextDrawSetProportional(VehicleSpeed[i],1);
		TextDrawSetShadow(VehicleSpeed[i],1);
	}
	return 1;
}
//______________________________________________________________________________
stock GetPlayerSpeed(playerid)
{
    new Float:ST[4];
    if(IsPlayerInAnyVehicle(playerid))
	GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
	else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 80.3;
    return floatround(ST[3]);
}
//______________________________________________________________________________
