////////////////////////////////////////////////// •
////////// INCLUDES ///////////////////////////// •
#include <a_samp>//                            / •
#include <float>//                            | •
#include <foreach>//                          | •
#include <zcmd>//                             | •
#include <easyDialog>//                       | •
#include <IsPlayerLAdmin>//                   | •
////////// INCLUDES /////////////////////////// •
////////////////////////////////////////////// •
///////////////////////////////////////////// •
////////// LXST //////////////////////////// •
/////////////////////////////////////////// •
////////////////////////////////////////// •





#pragma tabsize 0


#if !defined isnull
    #define isnull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif







// NEWS //
new Float:RandomSpawns[][] =
{
    {1249.7258, -2047.9263, 59.9209, 90.2055},
    {1241.2084, -2057.6521, 60.0190, 94.9352},
    {1241.0105, -2052.6873, 59.9975, 2.8144},
    {718.4906, -1477.3024, 5.4688, 357.9947},
    {722.3772, -1477.2856, 5.4688, 272.3814}
};

new Text: Logo0;
new Text: Logo1;


// MAIN //
main()
{
  print("\n--------------------------------");
  print("LXST Freeroam Started");
  print("--------------------------------\n");
}



// ENUMS //
enum Player
{
  pMAraba,
  pMArabaID,
  Deaths,
  Kills,
  ServerTime,
  Coins,
  Score,
  ScoreBank,
  PMEnabled,
}

enum Server
{
  Event,
  EFirstNum,
  ESecondNum,
  EResult,
  EWinner,
  EEnabled,
}
new ServerInfo[Server];




// ENUM NEW //
new PlayerInfo[MAX_PLAYERS][Player];



// NEW //
new gPlayerUsingLoopingAnim[MAX_PLAYERS];
new ToplamOnlineOyuncu = 0;

new automessages[3][256] = {
  "{F4FF00}[BILGI] {ffffff} yapimci; lost ( lost#3232 )",
  "{F4FF00}[BILGI] {ffffff} komutlara ulasmak icin; /yardim",
  "{F4FF00}[DISCORD] {ffffff} discord https://discord.gg/HDVUfPgmEk"
};






// COLORS //
#define COLOR_GRAD2 0xBFC0C2FF
#define Renk 	0xB60000FF
#define COLOR_ANNOUNCE 0xFFAD00FF
#define beyaz 0x00FFFFFFAA
#define R_PM 		0xFFFF2AFF
#define R_I		0x00983BFF
#define Gri 0xAFAFAFAA
#define Yesil 0x33AA33AA
#define COLOR_RED 0xFF0000AA
#define Kirmizi 0xFF0000AA
#define Sari 0xFFFF00AA
#define Beyaz 0xFFFFAA
#define Mor 0xC2A2DAAA
#define Mavi 0x33AAFFFF
#define Turuncu 0xFF9900AA
#define Pembe 0xFF69B4FF
#define Siyah 0x000000FF
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BRIGHTRED 0xE60000FF
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_PURPLE 0xC2A2DAAA





// ON PLAYER CONNECT //
public OnPlayerConnect(playerid)
{
  // playerinfo
  PlayerInfo[playerid][PMEnabled] = 0; // pm engelleme sistemi kapali
  PlayerInfo[playerid][Deaths] = 0; // olum sayaci
  
  
  
  
  // oyuncu giris mesaji
  new pName[MAX_PLAYER_NAME], pConnectMessage[256];
  GetPlayerName(playerid, pName, sizeof(pName));
  format(pConnectMessage, sizeof(pConnectMessage), "{80FF00} >>> {F9FF00}%s(%d) - Sunucuya Katildi.", pName, playerid);
  
  // log
  SendClientMessageToAll(-1, pConnectMessage);
  SendClientMessage(playerid,-1,"     ");
  SendClientMessage(playerid,-1,"     ");
  SendClientMessage(playerid,-1,"     ");
  SendClientMessage(playerid,-1,"     ");
  SendClientMessage(playerid,-1,"     ");
  SendClientMessage(playerid,-1,"     ");
  SendClientMessage(playerid,-1,"     ");
  SendClientMessage(playerid,-1,"     ");
  SendClientMessage(playerid,-1,"     ");
  SendClientMessage(playerid,-1,"     ");
  SendClientMessage(playerid,-1,"     ");
  SendClientMessage(playerid,-1,"     ");
  SendClientMessage(playerid,-1,"     ");
  SendClientMessage(playerid,-1,"     ");
  SendClientMessage(playerid,-1,"{40E0D0}(( {FFFF00}[{FFFFFF}LXST{FFFF00}] {FFFFFF} Veritabaniyla Baglanti Saglaniyor... {40E0D0}))");
  SendClientMessage(playerid,COLOR_WHITE,"{FFFFFF}>>>{CC0000}LXST {BEBEBE}FR{CC0000} HOSGELDINIZ{FFFFFF} <<<");
  return 1;
}


// ON PLAYER DISCONNECT //
public OnPlayerDisconnect(playerid, reason)
{
  //discord
  ToplamOnlineOyuncu--;
  
  
  // textdraw hide
  TextDrawHideForPlayer(playerid, Logo0);
  TextDrawHideForPlayer(playerid, Logo1);
  
  
  
  // cikis mesaji
  new dcReason[3][] = 
  {
    "Zaman asimi / crash",
    "Kendi istegiyle",
    "Kick / ban"
  };
  
  new pName[MAX_PLAYER_NAME], DCMessage[256];
  GetPlayerName(playerid, pName, sizeof(pName));
  format(DCMessage, sizeof(DCMessage), "{FF4D00} >>> {F9FF00}%s(%d) Sunucudan Ayrildi. ( SEBEP: %s )", pName, playerid, dcReason[reason]);
  
  
  // log
  SendClientMessageToAll(-1, DCMessage);
  
  return 1;
}


// ON PLAYER SPAWN //
public OnPlayerSpawn(playerid)
{
  // textdraw show
  TextDrawShowForPlayer(playerid, Logo0);
  TextDrawShowForPlayer(playerid, Logo1);
  
  
  
  SetPlayerInterior(playerid, 0);
  TogglePlayerClock(playerid, 0);
  SetPlayerFacingAngle(playerid, 0);
  new a = random(sizeof(RandomSpawns[]));

  SetPlayerPos(playerid, RandomSpawns[a][0], RandomSpawns[a][1], RandomSpawns[a][2]);
  return 1;
}


// ON GAME MODE INIT //
public OnGameModeInit()
{
  // run log
  new year,month,day;	getdate(year, month, day);
  new hour,minute,second; gettime(hour,minute,second);
  
  print(" ");
  print("\n|======================================|");
  print("| ");
  print("| LXST GAMEMODE STARTED.");
  print("| coded by lost - discord: lost#3232");
  printf("| Date: %d/%d/%d -- Time: %d:%d:%d", day, month, year, hour, minute, second);
  print("| ");
  print("|======================================|\n");
  print(" ");
  
  
  
  
  
  
  
    // textdraws
    Logo0 = TextDrawCreate(532.000, 423.000, "https://discord.gg/HDVUfPgmEk");
	TextDrawLetterSize(Logo0, 0.171000, 0.712100);
	TextDrawTextSize(Logo0, 1280.000000, 1280.000000);
	TextDrawAlignment(Logo0, 1);
	TextDrawColor(Logo0, 0xC0C0C0FF);
	TextDrawUseBox(Logo0, 0);
	TextDrawBoxColor(Logo0, 0x80808080);
	TextDrawSetShadow(Logo0, 0);
	TextDrawSetOutline(Logo0, 255);
	TextDrawBackgroundColor(Logo0, 0x00000013);
	TextDrawFont(Logo0, 1);
	TextDrawSetProportional(Logo0, 1);
	TextDrawSetSelectable(Logo0, 0);

    Logo1 = TextDrawCreate(584.000, 411.000, "LXST FREEROAM");
	TextDrawLetterSize(Logo1, 0.171000, 0.712100);
	TextDrawTextSize(Logo1, 1280.000000, 1280.000000);
	TextDrawAlignment(Logo1, 1);
	TextDrawColor(Logo1, 0xC0C0C0FF);
	TextDrawUseBox(Logo1, 0);
	TextDrawBoxColor(Logo1, 0x80808080);
	TextDrawSetShadow(Logo1, 0);
	TextDrawSetOutline(Logo1, 255);
	TextDrawBackgroundColor(Logo1, 0x00000013);
	TextDrawFont(Logo1, 1);
	TextDrawSetProportional(Logo1, 1);
	TextDrawSetSelectable(Logo1, 0);
    
    
    
    
    
    
    
    
    
    
    SetGameModeText("LXST");
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
	ShowNameTags(1);
	UsePlayerPedAnims();
	SetNameTagDrawDistance(40.0);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	SetWeather(2);
	
	
	
	
	
	
	
	// TIMERS
	SetTimer("RandomMSG", 60000, true); // 1000ms = 1second
	SetTimer("RandomEvent", 300000, true); // game command: /cevap [cevap]
	
	
	
	
	
	
    
//LimitGlobalChatRadius(300.0);

	// Player Class
	AddPlayerClass(1,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(2,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(269,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(270,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(271,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(272,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(47,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(48,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(49,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(50,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(51,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(52,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(53,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(54,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(55,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(56,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(57,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(58,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
    AddPlayerClass(68,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(69,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(70,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(71,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(72,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(73,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(75,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(76,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(78,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(79,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(80,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(81,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(82,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(83,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(84,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(85,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(87,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(88,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(89,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(91,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(92,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(93,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(95,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(96,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(97,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(98,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(99,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(294,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(284,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(293,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(115,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(116,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(24,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	AddPlayerClass(25,1759.0189,-1898.1260,13.5622,266.4503,-1,-1,-1,-1,-1,-1);
	
	
	

  
  
  return 1;
}

/* ESKI
public OnPlayerRequestClass(playerid, classid)
{
  SetPlayerFacingAngle(playerid, 187.0440);
  SetPlayerPos(playerid,1125.355957,-2036.871093,69.888450);
  SetPlayerCameraPos(playerid,1127.820556,-2036.951293,70.331192);
  SetPlayerCameraLookAt(playerid,1125.355957,-2036.871093,69.888450);
  return 1;
}*/

//YENI
public OnPlayerRequestClass(playerid, classid)
{
  SetPlayerPos(playerid,1125.355957,-2036.871093,69.888450);
  SetPlayerCameraPos(playerid,1127.820556,-2036.951293,70.331192);
  SetPlayerCameraLookAt(playerid,1125.355957,-2036.871093,69.888450);
  return 1;
}


public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
  if(!success)
  {
    SendClientMessage(playerid, COLOR_RED, "[HATA] yazdiginiz komut bulunamadi.");
  }
  return 1;
}




public OnPlayerDeath(playerid)
{
  // OLUM SAYACI //
  new old = PlayerInfo[playerid][Deaths];
  PlayerInfo[playerid][Deaths] = old + 1;
  // OLUM SAYACI //
  
  
  return 1;
}







///////////////////////////////////////////////////////////////////////////








//// KOMUTLAR ////


CMD:yardim(playerid)
{
  Dialog_Show(playerid, YardimMenusu, DIALOG_STYLE_LIST, "[LXST] - Yardim", "Komut Listesi\nYapimcilar", "Sec", "Kapat");
  return 1;
}
Dialog:YardimMenusu(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      Dialog_Show(playerid, YardimMKomutListesi, DIALOG_STYLE_LIST, "Komut Listesi", "{5CFFC5}[OYUNCU]{FFFFFF} Komutlari\n{D5D800}[VIP]{FFFFFF} Komutlari\n{FF73E0}[MODERATOR]{FFFFFF} Komutlari\n{A50A00}[GUARDIAN]{FFFFFF} Komutlari\n{FF5926}[ADMIN] {FFFFFF}Komutlari\n{801CFF}[DEV]{FFFFFF} Komutlari\n{FFAA00}[FOUNDER]{FFFFFF} Komutlari", "Sec", "Kapat");
    }
    
    if(listitem == 1)
    {
      Dialog_Show(playerid, YardimMYapimcilar, DIALOG_STYLE_MSGBOX, "Yapimcilar", "- lost ( DISCORD: lost#3232 )", "Tamam", "Kapat");
    }
    
  }
  return 1;
}

Dialog:YardimMKomutListesi(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(listitem == 0)
		{
			Dialog_Show(playerid, YardimMOyuncuK, DIALOG_STYLE_MSGBOX, "{5CFFC5}[OYUNCU]{FFFFFF} Komutlari", "{FFFA39}/yardim {ffffff}[yardim menusu]\n{FFFA39}/hp{ffffff} [can ve zirh yeniler]\n{FFFA39}/lv {ffffff}[las veuntras a isinlar]\n{FFFA39}/sf {ffffff}[san fierro ya isinlar]\n{FFFA39}/ls {ffffff}[los santos a isinlar]\n{FFFA39}/silah {ffffff}[silah alma menusu]\n{FFFA39}/v {ffffff}[arac alma menusu]\n{FFFA39}/arac {ffffff}[arac yapilandirma menusu]\n{FFFA39}/tp{ffffff} [isinlanma menusu]\n{FFFA39}/scoremarket {ffffff}[kill score market menusu]\n{FFFA39}/ayarlar {ffffff}[hesap - oyun ayarlar menusu]\n{FFFA39}/pm {ffffff}[oyuncuya ozel mesaj gonderirsiniz]\n{FFFA39}/pinfo {ffffff}[oyuncu id si girerek oyuncu bilgilerine bakarsiniz.(id girmezseniz kendi bilgilerinizi gorursunuz.)]\n{FFFA39}/anim {ffffff}[animasyon menusu]\n{FFFA39}/radyo {ffffff}[aracta radyo acarsiniz]\n{FFFA39}/duyur {ffffff}[1200$ karsiliginda duyuru mesaji gonderirsiniz]", "Tamam", "Kapat");
		}
		if(listitem == 1)
		{
			Dialog_Show(playerid, YardimMVipK, DIALOG_STYLE_MSGBOX, "{D5D800}[VIP]{FFFFFF} Komutlari [20TL]", "{FFFA39}/extrahp {ffffff}[350 can alirsiniz]\n{FFFA39}/extraar {ffffff}[350 armor alirsiniz]\n{FFFA39}/vduyur {ffffff}[vip duyurusu]", "Tamam", "Kapat");
		}
		if(listitem == 2)
		{
			Dialog_Show(playerid, YardimMModeratorK, DIALOG_STYLE_MSGBOX, "{FF73E0}[MODERATOR]{FFFFFF} Komutlari [35TL]", "{FFFA39}/ban {ffffff}[oyuncu yasaklarsiniz]", "Tamam", "Kapat");
		}
		if(listitem == 3)
		{
			Dialog_Show(playerid, YardimMGuardianK, DIALOG_STYLE_MSGBOX, "{A50A00}[GUARDIAN]{FFFFFF} Komutlari [45TL]", "{FFFA39}/clearchat {ffffff}[sohbeti temizlersiniz]", "Tamam", "Kapat");
		}
		if(listitem == 4)
		{
			Dialog_Show(playerid, YardimMAdminK, DIALOG_STYLE_MSGBOX, "{FF5926}[ADMIN] {FFFFFF}Komutlari [65TL]", "YAKINDA", "Tamam", "Kapat");
		}
		if(listitem == 5)
		{
			Dialog_Show(playerid, YardimMDevK, DIALOG_STYLE_MSGBOX, "{801CFF}[DEV]{FFFFFF} Komutlari [80TL]", "YAKINDA", "Tamam", "Kapat");
		}
		if(listitem == 6)
		{
			Dialog_Show(playerid, YardimMFounderK, DIALOG_STYLE_MSGBOX, "{FFAA00}[FOUNDER]{FFFFFF} Komutlari [135TL]", "YAKINDA", "Tamam", "Kapat");
		}
	}
	return 1;
}



CMD:hp(playerid)
{
  SetPlayerHealth(playerid, 100);
  SetPlayerArmour(playerid, 100);
  SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] Can ve zirh yenilendi.");
  return 1;
}



CMD:lv(playerid)
    {
    SetPlayerPos(playerid,2078.5781,753.5182,10.6719);
    SendClientMessage(playerid,COLOR_YELLOW,"[SUNUCU] Las Veuntras'a isinlandiniz.");
    return 1;
    }
    CMD:sf(playerid)
    {
    SetPlayerPos(playerid,-1984.1687,291.0298,34.8218);
    SendClientMessage(playerid,COLOR_YELLOW,"[SUNUCU] San Fierro'ya isinlandiniz. ");
    return 1;
	}
	CMD:ls(playerid)
    {
    SetPlayerPos(playerid,2486.8835,-1663.7539,13);
    SendClientMessage(playerid,COLOR_YELLOW,"[SUNUCU] Los Santos'a isinlandiniz.");
    return 1;
    }
    


CMD:silah(playerid)
{
  Dialog_Show(playerid, SilahMenusu, DIALOG_STYLE_LIST, "Silah Menusu", "Tabancalar\nTaramalilar\nKeskin Nisanci\nYakin Dovus", "Sec", "Kapat");
  return 1;
}
Dialog:SilahMenusu(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      Dialog_Show(playerid, SilahMTabanca, DIALOG_STYLE_LIST, "Tabancalar", "9mm\nsilenced 9mm\ndesert eagle\ntec nine", "Sec", "Kapat");
    }
    
    if(listitem == 1)
    {
      Dialog_Show(playerid, SilahMTaramali, DIALOG_STYLE_LIST, "Taramalilar", "AK-47\nM4\nMP5\nUzi", "Sec", "Kapat");
    }
    
    if(listitem == 2)
    {
      Dialog_Show(playerid, SilahMKeskin, DIALOG_STYLE_LIST, "Keskin Nisanci", "Sniper Rifle", "Sec", "Kapat");
    }
    
    if(listitem == 3)
    {
      Dialog_Show(playerid, SilahMYakin, DIALOG_STYLE_LIST, "Yakin Dovus", "Golf Club\nNightstick\nKnife\nBaseball bat\nShovel\nKatana\nDildo", "Sec", "Kapat");
    }
  }
  return 1;
}
Dialog:SilahMTabanca(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      GivePlayerWeapon(playerid, 22, 100);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] 9mm aldiniz.");
    }
    
    if(listitem == 1)
    {
      GivePlayerWeapon(playerid, 23, 100);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] silenced 9mm aldiniz.");
    }
    
    if(listitem == 2)
    {
      GivePlayerWeapon(playerid, 24, 100);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] desert eagle (deagle) aldiniz.");
    }
    
    if(listitem == 3)
    {
      GivePlayerWeapon(playerid, 32, 100);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] tec-9 aldiniz.");
    }
  }
  return 1;
}
Dialog:SilahMTaramali(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      GivePlayerWeapon(playerid, 30, 300);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] AK-47 aldiniz.");
    }
    
    if(listitem == 1)
    {
      GivePlayerWeapon(playerid, 31, 300);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] M4 aldiniz.");
    }
    
    if(listitem == 2)
    {
      GivePlayerWeapon(playerid, 29, 300);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] MP5 aldiniz.");
    }
    
    if(listitem == 3)
    {
      GivePlayerWeapon(playerid, 28, 300);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] Uzi aldiniz.");
    }
  }
  return 1;
}
Dialog:SilahMKeskin(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      GivePlayerWeapon(playerid, 34, 100);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] Sniper Rifle aldiniz.");
    }
  }
  return 1;
}
Dialog:SilahMYakin(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      GivePlayerWeapon(playerid, 2, 1);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] Golf club aldiniz.");
    }
    
    if(listitem == 1)
    {
      GivePlayerWeapon(playerid, 3, 1);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] Nightstick aldiniz.");
    }
    
    if(listitem == 2)
    {
      GivePlayerWeapon(playerid, 4, 1);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] Knife aldiniz.");
    }
    
    if(listitem == 3)
    {
      GivePlayerWeapon(playerid, 5, 1);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] Baseball bat aldiniz.");
    }
    
    if(listitem == 4)
    {
      GivePlayerWeapon(playerid, 6, 1);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] Shovel aldiniz.");
    }
    
    if(listitem == 5)
    {
      GivePlayerWeapon(playerid, 8, 1);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] Katana aldiniz.");
    }
    
    if(listitem == 6)
    {
      GivePlayerWeapon(playerid, 10, 1);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] Dildo aldiniz.");
    }
  }
  return 1;
}
//// SILAH KOMUT SONU ////



CMD:v(playerid)
{
  Dialog_Show(playerid, AracMenu, DIALOG_STYLE_LIST, "Arac Menusu", "Spor Arabalar\nMotorlar\nKamyonlar\nDag Araclari\nKamu Hizmeti Araclari", "Sec", "Kapat");
  return 1;
}
//ARAC MENU 2. DIALOG
Dialog:AracMenu(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      Dialog_Show(playerid, AracMSpor, DIALOG_STYLE_LIST, "Spor Arabalar", "Buffalo\nCheetah\nBanshee\nStallion\nTurismo\nZR-350\nSabre\nComet\nBlista Compact\nHotring Racer\nSuper GT", "Sec", "Kapat");
    }
    
    if(listitem == 1)
    {
      Dialog_Show(playerid, AracMMotor, DIALOG_STYLE_LIST, "Motorlar", "PCJ-600\nSanchez\nFCR-900\nNRG-500\nBF-400\nMountain Bike\nBMX", "Sec", "Kapat");
    }
    
    if(listitem == 2)
    {
      Dialog_Show(playerid, AracMKamyon, DIALOG_STYLE_LIST, "Kamyonlar", "Linerunner\nFlatbed\nYankee\nTanker\nTrashmaster", "Sec", "Kapat");
    }
    
    if(listitem == 3)
    {
      Dialog_Show(playerid, AracMDag, DIALOG_STYLE_LIST, "Dag Araclari (Offroad)", "Landstalker\nBF Injection\nPatriot\nRancher\nSandking\nMesa", "Sec", "Kapat");
    }
    
    if(listitem == 4)
    {
      Dialog_Show(playerid, AracMKamu, DIALOG_STYLE_LIST, "Kamu Hizmeti Araclari", "Firetruck\nAmbulance\nTaxi\nEnforcer\nBus\nBarracks\nCoach\nCabbie\nFBI Rancher\nHPV1000\nFBI Truck\nPolice Car\nPolice Rancher", "Sec", "Kapat");
    }
  }
  return 1;
}

//SPOR ARACLAR
Dialog:AracMSpor(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(402,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 1)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(415,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 2)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(429,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 3)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(439,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 4)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(451,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 5)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(477,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 6)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(475,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 7)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(480,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 8)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(496,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 9)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(494,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 10)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(506,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
  }
  return 1;
}

//MOTORLAR
Dialog:AracMMotor(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(461,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 1)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(468,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 2)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(521,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 3)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(522,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 4)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(581,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 5)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(510,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 6)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(481,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
  }
  return 1;
}

//KAMYONLAR
Dialog:AracMKamyon(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(403,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 1)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(455,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 2)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(456,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 3)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(514,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 4)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(408,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
  }
  return 1;
}

//DAG(OFFROAD)
Dialog:AracMDag(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(400,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 1)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(424,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 2)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(470,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 3)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(489,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 4)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(495,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 5)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(500,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
  }
  return 1;
}

// KAMU HIZMET ARAC
Dialog:AracMKamu(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(407,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 1)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(416,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 2)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(420,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 3)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(427,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 4)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(431,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 5)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(433,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 6)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(437,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 7)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(438,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 8)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(490,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 9)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(523,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 10)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(528,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 11)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(596,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
    if(listitem == 12)
    {
      new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(599,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
    }
    
  }
  return 1;
}



// ARAC SISTEMI //
CMD:arac(playerid)
{
  if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED, "[HATA] Arac menusunu acabilmek icin aracta olmaniz gerekli.");
  if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return SendClientMessage(playerid, COLOR_RED, "[HATA] Arac menusunu acabilmek icin aracta olmaniz gerekli.");
  Dialog_Show(playerid, AracYapilandirma, DIALOG_STYLE_LIST, "Aracini Yapilandir", "Renk Menusu\nJant Menusu\nTamir et\nAracini Kilitle\nAracinin Kilidini Ac", "Sec", "Kapat");
  return 1;
}
Dialog:AracYapilandirma(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      Dialog_Show(playerid, AracYRenk, DIALOG_STYLE_LIST, "Arac Renk Menusu", "Siyah\nBeyaz\nMavi\nKirmizi\nSari\nTuruncu\nPembe\nKahverengi\nYesil\nAcik Mavi\nMor", "Sec", "Kapat");
    }
    
    if(listitem == 1)
    {
      Dialog_Show(playerid, AracYJant, DIALOG_STYLE_LIST, "Arac Jant Menusu", "Jant 1\nJant 2\nJant 3\nJant 4", "Sec", "Kapat");
    }
    
    if(listitem == 2)
    {
      if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED, "[HATA] Tamir Icin Aracta Olman Gerekli.");
      if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return SendClientMessage(playerid, COLOR_RED, "[HATA] Tamir Icin Aracta Olman Gerekli.");
      SetVehicleHealth(GetPlayerVehicleID(playerid), 1000);
      RepairVehicle(GetPlayerVehicleID(playerid));
      RepairVehicle(playerid);
      PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] Araciniz Tamir Edildi");
    }
    
    if(listitem == 3)
    {
      if(IsPlayerInAnyVehicle(playerid))
	 {
		new State=GetPlayerState(playerid);
		if(State!=PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid,COLOR_RED, "[HATA] Araci sadece sofor kitleyebilir.");
			return 1;
		}
		new i;
		for(i=0;i<MAX_PLAYERS;i++)
		{
			if(i != playerid)
			{
				SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
			}
		}
		SendClientMessage(playerid, COLOR_RED, "[SUNUCU] Arac kitlendi.");
		new Float:pX, Float:pY, Float:pZ;
		GetPlayerPos(playerid,pX,pY,pZ);
		PlayerPlaySound(playerid,1056,pX,pY,pZ);
	 }
	 else
	 {
	 SendClientMessage(playerid,COLOR_RED, "[HATA] Aracta degilsiniz..");
	 }
    }
    
    if(listitem == 4)
    {
      if(IsPlayerInAnyVehicle(playerid))
	  {
		new State=GetPlayerState(playerid);
		if(State!=PLAYER_STATE_DRIVER)
		{
			SendClientMessage(playerid, COLOR_RED, "[HATA] Aracin kilidini sadece sofor kaldirabilir.");
			return 1;
		}
		new i;
		for(i=0;i<MAX_PLAYERS;i++)
		{
			SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
		}
		SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] Kilit acildi.");
		new Float:pX, Float:pY, Float:pZ;
		GetPlayerPos(playerid,pX,pY,pZ);
		PlayerPlaySound(playerid,1057,pX,pY,pZ);
	  }
	  else
	  {
	  SendClientMessage(playerid, COLOR_RED, "[HATA] Arabada degilsiniz.");
	  }
    }
    
    
  }
  return 1;
}
Dialog:AracYRenk(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      new pvid = GetPlayerVehicleID(playerid);
      ChangeVehicleColor(pvid, 0, 0);
    }
    
    if(listitem == 1)
    {
      new pvid = GetPlayerVehicleID(playerid);
      ChangeVehicleColor(pvid, 1, 1);
    }
    
    if(listitem == 2)
    {
      new pvid = GetPlayerVehicleID(playerid);
      ChangeVehicleColor(pvid, 7, 7);
    }
    
    if(listitem == 3)
    {
      new pvid = GetPlayerVehicleID(playerid);
      ChangeVehicleColor(pvid, 17, 17);
    }
    
    if(listitem == 4)
    {
      new pvid = GetPlayerVehicleID(playerid);
      ChangeVehicleColor(pvid, 6, 6);
    }
    
    if(listitem == 5)
    {
      new pvid = GetPlayerVehicleID(playerid);
      ChangeVehicleColor(pvid, 0, 0);
    }
    
    if(listitem == 6)
    {
      new pvid = GetPlayerVehicleID(playerid);
      ChangeVehicleColor(pvid, 219, 219);
    }
    
    if(listitem == 7)
    {
      new pvid = GetPlayerVehicleID(playerid);
      ChangeVehicleColor(pvid, 220, 220);
    }
    
    if(listitem == 8)
    {
      new pvid = GetPlayerVehicleID(playerid);
      ChangeVehicleColor(pvid, 174, 174);
    }
    
    if(listitem == 9)
    {
      new pvid = GetPlayerVehicleID(playerid);
      ChangeVehicleColor(pvid, 191, 191);
    }
    
    if(listitem == 10)
    {
      new pvid = GetPlayerVehicleID(playerid);
      ChangeVehicleColor(pvid, 155, 155);
    }
    
    if(listitem == 11)
    {
      new pvid = GetPlayerVehicleID(playerid);
      ChangeVehicleColor(pvid, 171, 171);
    }
  }
  return 1;
}
Dialog:AracYJant(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      new pvid = GetPlayerVehicleID(playerid);
      AddVehicleComponent(pvid, 1073);
    }
    
    if(listitem == 1)
    {
      new pvid = GetPlayerVehicleID(playerid);
      AddVehicleComponent(pvid, 1074);
    }
    
    if(listitem == 2)
    {
      new pvid = GetPlayerVehicleID(playerid);
      AddVehicleComponent(pvid, 1075);
    }
    
    if(listitem == 3)
    {
      new pvid = GetPlayerVehicleID(playerid);
      AddVehicleComponent(pvid, 1076);
    }
  }
  return 1;
}





CMD:tp(playerid)
{
  Dialog_Show(playerid, TeleMenu, DIALOG_STYLE_LIST, "Isinlanma Menusu", "Drift 1\nDrift 2\nKaykay Park\nSahil\nHava Alani 1\nHava Alani 2\nPolis 1\nPolis 2\nDag\nBenzinlik\nDirekler\nSanayi", "Isinlan", "Kapat");
  return 1;
}
Dialog:TeleMenu(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {//drift1
      SetPlayerPos(playerid, -1838.1803, 2121.5552, 8.2);
      GameTextForPlayer(playerid, "Isinlandiniz - Drift 1", 4000, 3);
    }
    if(listitem == 1)
    {//drift2
      SetPlayerPos(playerid,-2248.8662, -1601.1885, 482.1);
      GameTextForPlayer(playerid, "Isinlandiniz - Drift 2", 4000, 3);
    }
    if(listitem == 2)
    {//kaykaypark
      SetPlayerPos(playerid, 1880.9452,-1394.7611,13.1246);
      GameTextForPlayer(playerid, "Isinlandiniz - Kaykay park", 4000, 3);
    }
    if(listitem == 3)
    {//sahil
      SetPlayerPos(playerid,304.2043,-1898.9293,1.7956);
      GameTextForPlayer(playerid, "Isinlandiniz - Sahil", 4000, 3);
    }
    if(listitem == 4)
    {//havaalani1
      SetPlayerPos(playerid,1686.7,-2450.2,13.6);
      GameTextForPlayer(playerid, "Isinlandiniz - Hava alani 1", 4000, 3);
    }
    if(listitem == 5)
    {//havaalani2
      SetPlayerPos(playerid,-1345.0, -229.8,14.1);
      GameTextForPlayer(playerid, "Isinlandiniz - Hava alani 2", 4000, 3);
    }
    if(listitem == 6)
    {//polis1
      SetPlayerPos(playerid,1543.9,-1675.5,   13.6);
      GameTextForPlayer(playerid, "Isinlandiniz - Polis 1", 4000, 3);
    }
    if(listitem == 7)
    {//polis2
      SetPlayerPos(playerid,-1604.7,  718.7,   11.8);
      GameTextForPlayer(playerid, "Isinlandiniz - Polis 2", 4000, 3);
    }
    if(listitem == 8)
    {//dag
      SetPlayerPos(playerid,-2392.8999023438,-2206.6999511719,33.299999237061);
      GameTextForPlayer(playerid, "Isinlandiniz - Dag", 4000, 3);
    }
    if(listitem == 9)
    {//benzinlik
      SetPlayerPos(playerid,485.29998779297,1643.9000244141,14.699999809265);
      GameTextForPlayer(playerid, "Isinlandiniz - Benzinlik", 4000, 3);
    }
    if(listitem == 10)
    {//direkler
      GameTextForPlayer(playerid, "Isinlandiniz - Direkler", 4000, 3);
      SetPlayerPos(playerid,892.29998779297,2631.8999023438,11.5);
    }
    if(listitem == 11)
    {//sanayi
      GameTextForPlayer(playerid, "Isinlandiniz - Sanayi", 4000, 3);
      SetPlayerPos(playerid,-2037.5, 1317.1, 7.1999);
    }
  }
  return 1;
}



CMD:scoremarket(playerid)
{
  Dialog_Show(playerid, ScoreMarket, DIALOG_STYLE_TABLIST, "Score Market", "2000$\t{80FF00}2 Kill Score\t{ADADAD}#1\n4000$\t{80FF00}4 Kill Score\t{ADADAD}#2\n10000$\t{80FF00}10 Kill Score\t{ADADAD}#3\nRPG\t{80FF00}35 Kill Score\t{ADADAD}#4\nHS Rocket\t{80FF00}45 Kill Score\t{ADADAD}#5\nGrenade(5Adet)\t{80FF00}50 Kill Score\t{ADADAD}#6\nHydra(UCAK)\t{80FF00}65 Kill Score\t{ADADAD}#7\nHunter(HELIKOPTER)\t{80FF00}75 Kill Score\t{ADADAD}#8\nMinigun\t{80FF00}85 Kill Score\t{ADADAD}#9\nJetpack\t{80FF00}100 Kill Score\t{ADADAD}#10", "Satin Al", "Kapat");
  return 1;
}
Dialog:ScoreMarket(playerid, response, listitem, inputtext[])
{
  if(response)
  {
  
    if(listitem == 0)
    {
      if(GetPlayerScore(playerid) >= 2)
      {
        new score = GetPlayerScore(playerid) - 2;
        SetPlayerScore(playerid, score);
        GivePlayerMoney(playerid, 2000);
        SendClientMessage(playerid, COLOR_GREEN, "[SUNUCU] 2000$ Aldiniz. ( 2 score karsiliginda )");
      } else {
        SendClientMessage(playerid, COLOR_RED, "[HATA] Score yetersiz.");
      }
    }
    
    if(listitem == 1)
    {
      if(GetPlayerScore(playerid) >= 4)
      {
        new score = GetPlayerScore(playerid) - 4;
        SetPlayerScore(playerid, score);
        GivePlayerMoney(playerid, 4000);
        SendClientMessage(playerid, COLOR_GREEN, "[SUNUCU] 4000$ Aldiniz. ( 4 score karsiliginda )");
      } else {
        SendClientMessage(playerid, COLOR_RED, "[HATA] Score yetersiz.");
      }
    }
    
    if(listitem == 2)
    {
      if(GetPlayerScore(playerid) >= 10)
      {
        new score = GetPlayerScore(playerid) - 10;
        SetPlayerScore(playerid, score);
        GivePlayerMoney(playerid, 10000);
        SendClientMessage(playerid, COLOR_GREEN, "[SUNUCU] 10000$ Aldiniz. ( 10 score karsiliginda )");
      } else {
        SendClientMessage(playerid, COLOR_RED, "[HATA] Score yetersiz.");
      }
    }
    
    if(listitem == 3)
    {
      if(GetPlayerScore(playerid) >= 35)
      {
        new score = GetPlayerScore(playerid) - 35;
        SetPlayerScore(playerid, score);
        GivePlayerWeapon(playerid, 35, 50);
        SendClientMessage(playerid, COLOR_GREEN, "[SUNUCU] RPG Aldiniz.. ( 35 score karsiliginda )");
      } else {
        SendClientMessage(playerid, COLOR_RED, "[HATA] Score yetersiz.");
      }
    }
    
    if(listitem == 4)
    {
      if(GetPlayerScore(playerid) >= 45)
      {
        new score = GetPlayerScore(playerid) - 45;
        SetPlayerScore(playerid, score);
        GivePlayerWeapon(playerid, 36, 50);
        SendClientMessage(playerid, COLOR_GREEN, "[SUNUCU] HS Rocket Aldiniz. ( 45 score karsiliginda )");
      } else {
        SendClientMessage(playerid, COLOR_RED, "[HATA] Score yetersiz.");
      }
    }
    
    if(listitem == 5)
    {
      if(GetPlayerScore(playerid) >= 50)
      {
        new score = GetPlayerScore(playerid) - 50;
        SetPlayerScore(playerid, score);
        GivePlayerWeapon(playerid, 16, 5);
        SendClientMessage(playerid, COLOR_GREEN, "[SUNUCU] Grenade Aldiniz. ( 50 score karsiliginda )");
      } else {
        SendClientMessage(playerid, COLOR_RED, "[HATA] Score yetersiz.");
      }
    }
    
    if(listitem == 6)
    {
      if(GetPlayerScore(playerid) >= 65)
      {
        new score = GetPlayerScore(playerid) - 65;
        SetPlayerScore(playerid, score);
        new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(520,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
        SendClientMessage(playerid, COLOR_GREEN, "[SUNUCU] Hydra Aldiniz. ( 65 score karsiliginda )");
      } else {
        SendClientMessage(playerid, COLOR_RED, "[HATA] Score yetersiz.");
      }
    }
    
    if(listitem == 7)
    {
      if(GetPlayerScore(playerid) >= 75)
      {
        new score = GetPlayerScore(playerid) - 75;
        SetPlayerScore(playerid, score);
        
        new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid,Angle);
      LVehicleIDt = CreateVehicle(425,X,Y-5,Z,0,1,-1,-1);
      if(PlayerInfo[playerid][pMAraba]!=0) DestroyVehicle(PlayerInfo[playerid][pMArabaID]);
      PlayerInfo[playerid][pMArabaID]=LVehicleIDt;
      PlayerInfo[playerid][pMAraba]=1;
      
        SendClientMessage(playerid, COLOR_GREEN, "[SUNUCU] Hunter Aldiniz. ( 75 score karsiliginda )");
      } else {
        SendClientMessage(playerid, COLOR_RED, "[HATA] Score yetersiz.");
      }
    }
    
    if(listitem == 8)
    {
      if(GetPlayerScore(playerid) >= 85)
      {
        new score = GetPlayerScore(playerid) - 85;
        SetPlayerScore(playerid, score);
        GivePlayerWeapon(playerid, 38, 300);
        SendClientMessage(playerid, COLOR_GREEN, "[SUNUCU] Minigun Aldiniz. ( 85 score karsiliginda )");
      } else {
        SendClientMessage(playerid, COLOR_RED, "[HATA] Score yetersiz.");
      }
    }
    
    if(listitem == 9)
    {
      if(GetPlayerScore(playerid) >= 100)
      {
        new score = GetPlayerScore(playerid) - 100;
        SetPlayerScore(playerid, score);
        SetPlayerSpecialAction(playerid, 2);
        SendClientMessage(playerid, COLOR_GREEN, "[SUNUCU] Jetpack Aldiniz. ( 100 score karsiliginda )");
      } else {
        SendClientMessage(playerid, COLOR_RED, "[HATA] Score yetersiz.");
      }
    }
    
    
    
  }
  return 1;
}



CMD:ayarlar(playerid)
{
  Dialog_Show(playerid, AyarlarMenusu, DIALOG_STYLE_LIST, "Hesap - Oyun Ayarlari", "Hava durumunu ayarla\nSaati ayarla\nKendini oldur\nIsim rengini degistir\nPM ayarlari", "Sec", "Kapat");
  return 1;
}
Dialog:AyarlarMenusu(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      Dialog_Show(playerid, AyarlarMHava, DIALOG_STYLE_LIST, "Hava Durumunu Ayarla", "Normal\nSisli\nYagmurlu", "Ayarla", "Kapat");
    }
    
    if(listitem == 1)
    {
      Dialog_Show(playerid, AyarlarMSaat, DIALOG_STYLE_LIST, "Saati Ayarla", "Gun dogumu\nSabah\nOglen\nGun dogumu\nGece", "Ayarla", "Kapat");
    }
    
    if(listitem == 2)
    {
      SetPlayerHealth(playerid, 0);
      GameTextForPlayer(playerid, "Kendinizi Oldurdunuz", 4000, 2);
    }
    
    if(listitem == 3)
    {
      Dialog_Show(playerid, AyarlarMIsimRenk, DIALOG_STYLE_LIST, "Isim Renk Menusu", "Mavi\nSiyah\nKirmizi\nSari\nTuruncu", "Ayarla", "Kapat");
    }
    
    if(listitem == 4)
    {
      Dialog_Show(playerid, AyarlarMPM, DIALOG_STYLE_LIST, "PM Ayarlari", "Gelen PM'leri Engelle\nGelen PM'lerin engelini kaldir", "Ayarla", "Kapat");
    }
  }
  return 1;
}
Dialog:AyarlarMHava(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      SetPlayerWeather ( playerid, 2 ) ;
    }
    
    if(listitem == 1)
    {
      SetPlayerWeather ( playerid, 9 ) ;
    }
    
    if(listitem == 2)
    {
      SetPlayerWeather ( playerid, 8 ) ;
    }
  }
  return 1;
}
Dialog:AyarlarMSaat(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      SetPlayerTime(playerid, 6, 0);
    }
    
    if(listitem == 1)
    {
      SetPlayerTime(playerid, 9, 0);
    }
    
    if(listitem == 2)
    {
      SetPlayerTime(playerid, 12, 0);
    }
    
    if(listitem == 3)
    {
      SetPlayerTime(playerid, 18, 0);
    }
    
    if(listitem == 4)
    {
      SetPlayerTime(playerid, 0, 0);
    }
  }
  return 1;
}
Dialog:AyarlarMIsimRenk(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      SetPlayerColor(playerid, Mavi);
    }
    
    if(listitem == 1)
    {
      SetPlayerColor(playerid, Siyah);
    }
    
    if(listitem == 2)
    {
      SetPlayerColor(playerid, Mavi);
    }
    
    if(listitem == 3)
    {
      SetPlayerColor(playerid, COLOR_RED);
    }
    
    if(listitem == 4)
    {
      SetPlayerColor(playerid, COLOR_YELLOW);
    }
    
    if(listitem == 5)
    {
      SetPlayerColor(playerid, Turuncu);
    }
  }
  return 1;
}
Dialog:AyarlarMPM(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      PlayerInfo[playerid][PMEnabled] = 1;
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] artik size kimse PM atamayacak.");
    }
    
    if(listitem == 1)
    {
      PlayerInfo[playerid][PMEnabled] = 0;
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] artik size gelen PM leri alabileceksiniz.");
    }
  }
  return 1;
}



CMD:pm(playerid, params[])
{
  new tmp[256], tmp2[256], Index;  tmp = strtok(params, Index), tmp2 = strtok(params, Index);
  if(!strlen(params)) return SendClientMessage(playerid, COLOR_RED, "[HATA] dogru kullanim /pm [oyuncuid] [mesaj]");
  if(!strlen(tmp2)) return SendClientMessage(playerid, COLOR_RED, "[HATA] dogru kullanim /pm [oyuncuid] [mesaj]");
  new target, playername[MAX_PLAYER_NAME], author[MAX_PLAYER_NAME], string[128];
  target = strval(tmp);
  
  if(IsPlayerConnected(target) && target != INVALID_PLAYER_ID && target != playerid){
    if(PlayerInfo[target][PMEnabled] == 1){
      SendClientMessage(playerid, COLOR_RED, "[HATA] bu oyuncu PM'leri engellemis.");
    } else {
      GetPlayerName(target, playername, sizeof(playername)); GetPlayerName(playerid, author, sizeof(author));
      format(string, sizeof(string), "{2E81FF}[PM] - GONDEREN: %s(%d): {FFFFFF}%s", author, playerid, params[2]);
      SendClientMessage(target, -1, string);
      SendClientMessage(playerid, COLOR_YELLOW, "[SUNUCU] PM Gonderildi.");
      new Float:pX, Float:pY, Float:pZ;
      GetPlayerPos(target,pX,pY,pZ);
      PlayerPlaySound(target,1057,pX,pY,pZ);
    }
  } else return SendClientMessage(playerid, COLOR_RED, "[HATA] boyle bir kullanici bulunamadi.");
  return 1;
}



CMD:pinfo(playerid, params[])
{
  new tmp[256], Index; tmp = strtok(params, Index);
  if(!strlen(tmp) || !strlen(params)) return SendClientMessage(playerid, COLOR_RED, "[HATA] dogru kullanim /pinfo [oyuncuid]");
  new target, targetname[MAX_PLAYER_NAME];
  target = strval(tmp);
  GetPlayerName(target, targetname, sizeof(targetname));
  if(IsPlayerConnected(target) && target != INVALID_PLAYER_ID){
    new infotext[502];
    new PMStatus = PlayerInfo[target][PMEnabled];
    new PMSReplace[2][] = 
    {
      "Engellememis",
      "Engellemis"
    };
    
    new Float:x, Float:y, Float:z;
    GetPlayerPos(target, x, y, z);
    format(infotext, sizeof(infotext), "{FFFA39}Oyuncu Ismi:{FFFFFF}%s\n{FFFA39}Oyuncu ID'si:{ffffff}%d\n{FFFA39}Oyuncu Parasi:{ffffff}%d\n{FFFA39}Oyuncu Kill Skoru:{ffffff}%d\n{FFFA39}Oyuncu Olum Sayisi:{ffffff}%d\n{FFFA39}Oyuncunun Bulundugu Koordinatlar:{ffffff}X:%d, Y:%d, Z:%d\n{FFFA39}PM Durumu:{ffffff}%s", targetname, target, GetPlayerMoney(target), GetPlayerScore(target), PlayerInfo[target][Deaths], x, y, z, PMSReplace[PMStatus]);
    Dialog_Show(playerid, PlayerInfo, DIALOG_STYLE_MSGBOX, "Oyuncu Bilgileri", infotext, "Kapat", "");
  } else return SendClientMessage(playerid, COLOR_RED, "[HATA] oyuncu bulunamadi.");
  
  
  
  return 1;
}



CMD:duyur(playerid, params[])
{
  if(GetPlayerMoney(playerid) >= 1200)
  {
    if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[HATA] dogru kullanim /duyur [duyuru mesaji]");
    new pName[MAX_PLAYER_NAME], str[256];
    GetPlayerName(playerid, pName, sizeof(pName));
    format(str, sizeof(str), "{62FFFD}[OYUNCU-DUYURUSU] {D0D0D0}( {ffffff}%s(%d){D0D0D0} ) {62FFFD}(MESAJI): {FFFFFF}%s", pName, playerid, params);
    SendClientMessageToAll(-1, str);
    new Float:pX, Float:pY, Float:pZ;
    GetPlayerPos(playerid,pX,pY,pZ);
    PlayerPlaySound(playerid,1057,pX,pY,pZ);
    GivePlayerMoney(playerid, -1200);
  } else return SendClientMessage(playerid, COLOR_RED, "[HATA] duyuru yapabilmek icin $1.200 ihtiyaciniz var.");
  return 1;
}



CMD:anim(playerid)
{
  if(!IsAblePedAnimation(playerid)) return 1;
  Dialog_Show(playerid, OyuncuAnim, DIALOG_STYLE_LIST, "Animasyonlar", "ANIMASYON KAPAT\nDans 1\nDans 2\nSarhos\nKorunma\nKriz Gecirme\nUyumak\nOturmak\nEsnemek\nSigara 1\nSigara 2\nDur-Dur\nBay Bay\nOturmak\nYaslanmak\nKoltuga Oturmak\n31 Cekme\nHAYIRDIR AMK\nKasinti\nKung-Fu", "Sec", "Kapat");
  return 1;
}
Dialog:OyuncuAnim(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
			 ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
            }
            if(listitem == 1)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             ApplyAnimation(playerid, "DANCING", "DAN_Down_A", 4.0, 1, 0, 0, 0, 0, 1);
            }
            if(listitem == 2)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "DANCING", "DAN_Left_A", 4.0, 1, 0, 0, 0, 0, 1);
            }
            if(listitem == 3)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "PED", "WALK_DRUNK", 4.0, 1, 1, 1, 1, 1, 1);
            }
            if(listitem == 4)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0, 1);
            }
            if(listitem == 5)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0, 1);
            }
            if(listitem == 6)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "CRACK", "crckdeth4", 4.0, 0, 1, 1, 1, 0, 1);
            }
            if(listitem == 7)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "CRACK", "crckidle1", 4.0, 0, 1, 1, 1, 0, 1);
            }
            if(listitem == 8)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "PLAYIDLES", "stretch", 4.1, 1, 1, 1, 1, 1, 1);
            }
            if(listitem == 9)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "SMOKING", "M_smk_in", 4.0, 0, 0, 0, 0, 0, 1);
            }
            if(listitem == 10)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0, 1);
            }
            if(listitem == 11)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "POLICE", "CopTraf_Stop", 4.0, 1, 0, 0, 0, 0, 1);
            }
            if(listitem == 12)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "PED", "endchat_03", 4.0, 1, 0, 0, 0, 0, 1);
            }
            if(listitem == 13)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "BEACH", "SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0, 1);
            }
            if(listitem == 14)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "GANGS", "leanIDLE", 4.0, 0, 0, 0, 1, 0, 1);
            }
            if(listitem == 15)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "ped", "SEAT_down", 4.0, 0, 0, 0, 1, 1, 1);
            }
            if(listitem == 16)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "PAULNMAC", "wank_loop", 4.0, 1, 0, 0, 0, 0, 1);
            }
            if(listitem == 17)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "ON_LOOKERS", "Pointup_loop", 4.0, 1, 0, 0, 0, 0, 1);
            }
            if(listitem == 18)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "MISC", "Scratchballs_01", 4.0, 1, 0, 0, 0, 0, 1);
            }
            if(listitem == 19)
			{
			 if(!IsAblePedAnimation(playerid)) return 1;
             PlayAnimEx(playerid, "PARK", "Tai_Chi_Loop", 4.0, 1, 0, 0, 0, 0, 1);
            }
  }
  return 1;
}



CMD:radyo(playerid)
{
  if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED, "[HATA] Radyo acabilmek icin aracta olmaniz gerekli.");
  if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return SendClientMessage(playerid, COLOR_RED, "[HATA] Radyo acabilmek icin aracta olmaniz gerekli.");
  Dialog_Show(playerid, AracRadyo, DIALOG_STYLE_LIST, "Radyo", "Radyo Seymen\nKralPOP\nPowerFM\nShow Radyo\nRadyoyu Kapat", "Sec", "Kapat");
  return 1;
}
Dialog:AracRadyo(playerid, response, listitem, inputtext[])
{
  if(response)
  {
    if(listitem == 0)
    {
      PlayAudioStreamForPlayer(playerid, "http://yayin.radyoseymen.com.tr:1070/;stream.mp3");
    }
    
    if(listitem == 1)
    {
      PlayAudioStreamForPlayer(playerid, "http://kralpopwmp.radyotvonline.com/;%20KRAL%20POP%20=");
    }
    
    if(listitem == 2)
    {
      PlayAudioStreamForPlayer(playerid, "http://powerfm.listenpowerapp.com/powerfm/mpeg/icecast.audio");
    }
    
    if(listitem == 3)
    {
      PlayAudioStreamForPlayer(playerid, "http://windows.showradyo.com.tr/");
    }
    
    if(listitem == 4)
    {
      StopAudioStreamForPlayer(playerid);
    }
  }
  return 1;
}


















/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






IsAblePedAnimation(playerid)
{
    if(GetPVarInt(playerid, "PlayerCuffed") != 0 || GetPVarInt(playerid, "Injured") == 1 || GetPVarInt(playerid, "IsFrozen") == 1 || GetPVarInt(playerid, "EventAnims") == 1)
	{
   		SendClientMessage(playerid, COLOR_GRAD2, "Bu Animasyonu Yapamazsin");
   		return 0;
	}
    if(IsPlayerInAnyVehicle(playerid) == 1)
    {
		SendClientMessage(playerid, COLOR_GRAD2, "Bu islemi yapmak icin aractan inmelisin.");
		return 0;
	}
    return 1;
}
PlayAnimEx(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync)
{
	if(GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
	gPlayerUsingLoopingAnim[playerid] = 1;
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
	CallRemoteFunction("ShowPlayerAnimTextdraw", "d", playerid);
}



forward RandomMSG();
public RandomMSG()
{
	new string[256];
	new random1 = random(sizeof(automessages));
	
	format(string, sizeof(string), "%s", automessages[random1]);
	SendClientMessageToAll(-1,string);
	return 1;
}

forward RandomEvent();
public RandomEvent()
{
  ServerInfo[EEnabled] = 1;
  new randomGives = random(2);
  new rreplace[2][] = {
    "score",
    "coins"
  };
  new firstnum = random(50), secondnum = random(50);
  new result = firstnum + secondnum;
    
  // log server data
  ServerInfo[EFirstNum] = firstnum;
  ServerInfo[ESecondNum] = secondnum;
  ServerInfo[EResult] = result;
  ServerInfo[Event] = randomGives;
  
  
  
  if(randomGives == 0)
  {
    new event[256];
    format(event, sizeof(event), "{1AFF00}[EVENT] {FFEB8F}Yeni soru! %d+%d=? ( ODUL: 5 score ) - /cevap [cevabiniz]", firstnum, secondnum);
    SendClientMessageToAll(-1, event);
  } else {
    new event[256];
    format(event, sizeof(event), "{1AFF00}[EVENT] {FFEB8F}Yeni soru! %d+%d=? ( ODUL: 2500 coins ) - /cevap [cevabiniz]", firstnum, secondnum);
    SendClientMessageToAll(-1, event);
  }
  
}
// event command
CMD:cevap(playerid, params[])
{
  if(ServerInfo[EEnabled] == 1)
  {
    if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "[HATA] dogru kullanim /cevap [cevabiniz]");
    new sayii = strval(params);
    if(sayii == ServerInfo[EResult])
    {
      
      if(ServerInfo[Event] == 0)
      {
        new KazanmaMesaj[256];
        new pName[MAX_PLAYER_NAME];
        GetPlayerName(playerid, pName, sizeof(pName));
        format(KazanmaMesaj, sizeof(KazanmaMesaj), "{1AFF00}[EVENT] {FFEB8F}%s(%d) Oyuncusu Event'i bildi ve aldigi odul 5 score.Bir sonraki event ( 5 dakika sonra ).", pName, playerid);
        SendClientMessageToAll(-1, KazanmaMesaj);
        
        new old = GetPlayerScore(playerid);
        SetPlayerScore(playerid, old + 5);
        
        new Float:pX, Float:pY, Float:pZ;
        GetPlayerPos(playerid,pX,pY,pZ);
        PlayerPlaySound(playerid,1057,pX,pY,pZ);
        
        ServerInfo[EEnabled] = 0; // disabled event
      } else if(ServerInfo[Event] == 1)
      {
        new KazanmaMesaj[256];
        new pName[MAX_PLAYER_NAME];
        GetPlayerName(playerid, pName, sizeof(pName));
        format(KazanmaMesaj, sizeof(KazanmaMesaj), "{1AFF00}[EVENT] {FFEB8F}%s(%d) Oyuncusu Event'i bildi ve aldigi odul 2500 coins.Bir sonraki event ( 5 dakika sonra ).", pName, playerid);
        SendClientMessageToAll(-1, KazanmaMesaj);
        
        //new old = GetPlayerMoney(playerid);
        GivePlayerMoney(playerid, 2500);
        
        new Float:pX, Float:pY, Float:pZ;
        GetPlayerPos(playerid,pX,pY,pZ);
        PlayerPlaySound(playerid,1057,pX,pY,pZ);
        
        ServerInfo[EEnabled] = 0; // disabled event
      }
    } else {
      SendClientMessage(playerid, COLOR_RED, "[HATA] yanlis cevap verdiniz.Tekrar deneyin.");
    }
    
  } else {
    SendClientMessage(playerid, COLOR_RED, "[HATA] Event'e coktan cevap verilmis.Bir sonraki eventi bekle.");
  }
  
  return 1;
}










/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




////////////////////  - - BITIS - - ////////////////////