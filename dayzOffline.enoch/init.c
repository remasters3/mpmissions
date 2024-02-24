static Object SpawnObject(string type, vector position, vector orientation, float scale = 1.0)
{
    Object obj = GetGame().CreateObjectEx(type, position, ECE_SETUP | ECE_UPDATEPATHGRAPH | ECE_CREATEPHYSICS);
    if (!obj) {
        Error("Failed to create object " + type);
        return null;
    }

    obj.SetPosition(position);
    obj.SetOrientation(orientation);
    obj.SetOrientation(obj.GetOrientation());
    obj.SetScale(scale);
    obj.Update();
	obj.SetAffectPathgraph(true, false);
	if (obj.CanAffectPathgraph()) {
        GetGame().GetCallQueue(CALL_CATEGORY_SYSTEM).CallLater(GetGame().UpdatePathgraphRegionByObject, 100, false, obj);
    } 

    return obj;
}

void main()
{
	//INIT ECONOMY--------------------------------------
	Hive ce = CreateHive();
	if ( ce )
		ce.InitOffline();

	//DATE RESET AFTER ECONOMY INIT-------------------------
	int year, month, day, hour, minute;
	int reset_month = 8, reset_day = 10;
	GetGame().GetWorld().GetDate(year, month, day, hour, minute);

	if ((month == reset_month) && (day < reset_day))
	{
		GetGame().GetWorld().SetDate(year, reset_month, reset_day, hour, minute);
	}
	else
	{
		if ((month == reset_month + 1) && (day > reset_day))
		{
			GetGame().GetWorld().SetDate(year, reset_month, reset_day, hour, minute);
		}
		else
		{
			if ((month < reset_month) || (month > reset_month + 1))
			{
				GetGame().GetWorld().SetDate(year, reset_month, reset_day, hour, minute);
			}
		}
	}
    SpawnObject("Land_Misc_Well_Pump_Yellow", "573.500549 351.346832 2742.822998", "-64.702881 0.000000 -0.000000", 0.999998);
    SpawnObject("Land_Castle_Wall1_20", "603.335999 359.103851 2736.898438", "131.865509 -0.570536 2.188924", 0.999734);
    SpawnObject("Land_Castle_Bastion", "618.598083 359.315857 2753.238770", "93.282326 0.000000 -0.000000", 0.999998);
    SpawnObject("Land_Castle_Bastion", "586.700073 358.681519 2720.966797", "177.150284 0.000000 0.000000", 0.999998);
    SpawnObject("Land_Castle_Bastion", "592.132935 358.982086 2781.154785", "-0.354077 0.000000 -0.000000", 0.999993);
    SpawnObject("Land_Castle_Bastion", "560.495728 359.055176 2746.491455", "-87.383583 0.000000 -0.000000", 0.999995);
    SpawnObject("Land_Castle_Bergfrit", "574.157776 364.090363 2735.145020", "126.000206 0.000000 -0.000000", 1);
    SpawnObject("Land_Castle_Bergfrit", "603.290771 364.608795 2765.886719", "-47.950634 0.000000 -0.000000", 0.999997);
    SpawnObject("Land_Castle_Stairs", "593.317444 354.760895 2765.894043", "44.999992 -0.000000 -0.000000", 1);
    SpawnObject("Land_Castle_Stairs", "584.028992 354.253204 2736.413330", "-142.818466 -0.000000 -0.000000", 1);
    SpawnObject("Land_Castle_Gate", "572.914307 354.272919 2767.389404", "-50.172634 0.000000 0.000000", 0.999994);
    SpawnObject("Land_FuelStation_Feed_Enoch", "575.137756 351.337250 2741.212646", "32.041954 0.000000 -0.000000", 0.999997);
    SpawnObject("Land_House_1W10_Brown", "598.162964 352.500214 2741.896484", "-47.153172 0.000000 0.000000", 0.999991);
}

class CustomMission: MissionServer
{
	void SetRandomHealth(EntityAI itemEnt)
	{
		if ( itemEnt )
		{
			float rndHlt = Math.RandomFloat( 0.45, 0.65 );
			itemEnt.SetHealth01( "", "", rndHlt );
		}
	}

	override PlayerBase CreateCharacter(PlayerIdentity identity, vector pos, ParamsReadContext ctx, string characterName)
	{
		Entity playerEnt;
		playerEnt = GetGame().CreatePlayer( identity, characterName, pos, 0, "NONE" );
		Class.CastTo( m_player, playerEnt );

		GetGame().SelectPlayer( identity, m_player );

		return m_player;
	}

	override void StartingEquipSetup(PlayerBase player, bool clothesChosen)
	{
		EntityAI itemClothing;
		EntityAI itemEnt;
		ItemBase itemBs;
		float rand;

		itemClothing = player.FindAttachmentBySlotName( "Body" );
		if ( itemClothing )
		{
			SetRandomHealth( itemClothing );
			
			itemEnt = itemClothing.GetInventory().CreateInInventory( "BandageDressing" );
			player.SetQuickBarEntityShortcut(itemEnt, 2);

			string chemlightArray[] = { "Chemlight_White", "Chemlight_Yellow", "Chemlight_Green", "Chemlight_Red" };
			int rndIndex = Math.RandomInt( 0, 4 );
			itemEnt = itemClothing.GetInventory().CreateInInventory( chemlightArray[rndIndex] );
			player.SetQuickBarEntityShortcut(itemEnt, 1);
			SetRandomHealth( itemEnt );
		}
		
		itemClothing = player.FindAttachmentBySlotName( "Legs" );
		if ( itemClothing )
			SetRandomHealth( itemClothing );
		
		itemClothing = player.FindAttachmentBySlotName( "Feet" );
	}
};

Mission CreateCustomMission(string path)
{
	return new CustomMission();
}
