static Object SpawnObject(string type, vector position, vector orientation, float scale = 1.0)
{
    Object obj;
    if (type.Contains(".p3d")) {
        obj = GetGame().CreateStaticObjectUsingP3D(type, position, orientation, scale, false);
    } else {        
        obj = GetGame().CreateObjectEx(type, position, ECE_SETUP | ECE_CREATEPHYSICS | ECE_NOLIFETIME | ECE_NOPERSISTENCY_WORLD | ECE_NOPERSISTENCY_CHAR);
    }

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
	// Created Objects
	SpawnObject("Land_FuelStation_Feed_Enoch", "2485.852051 233.807556 4684.231445", "-85.978584 1.061407 0.151142", 0.987693);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2508.685791 237.461456 4663.173340", "-173.561798 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2473.420898 237.353180 4702.729004", "-81.929131 0.000000 0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2477.907715 237.278305 4706.000000", "11.180381 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2486.340576 237.222565 4704.315430", "11.180381 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2516.616699 237.628372 4664.949707", "146.418350 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2520.012207 236.207977 4696.425293", "-151.981720 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2524.420654 237.342682 4685.585938", "67.793213 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2526.500977 237.379272 4677.435059", "82.782547 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Bridge_Stone_25", "6583.569336 329.152008 9300.870117", "18.000000 0.000000 -0.000000", 1);
	SpawnObject("Land_Barn_Wood1", "6573.733398 339.880829 9269.823242", "17.999998 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Bridge_Stone_25", "6591.278809 329.152283 9324.486328", "18.000000 0.000000 -0.000000", 1);
	SpawnObject("Land_Mil_ControlTower_East", "2489.822266 240.578659 4683.584961", "-176.485992 0.000000 -0.000000", 1);
	SpawnObject("Land_Mil_ControlTower", "2512.163818 200.953705 5141.335449", "-96.915771 0.000000 -0.000000", 1);
	SpawnObject("Land_Misc_Well_Pump_Yellow", "2487.504395 233.770966 4691.138184", "100.489296 1.066426 -0.242566", 0.999935);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2488.603271 237.536240 4674.063965", "-155.893616 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2482.457520 237.551376 4676.302734", "14.635978 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2473.693604 237.584625 4689.550781", "-93.659378 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2476.025391 237.632629 4681.243652", "-117.030739 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2494.106445 237.477188 4668.410156", "-113.126976 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2523.650146 237.334915 4670.269043", "138.966782 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2494.766357 237.211945 4702.678223", "11.180381 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2503.529785 236.154282 4700.913574", "11.180381 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2499.907471 237.339462 4664.095215", "-173.561798 0.000000 -0.000000", 1);
	SpawnObject("StaticObj_Wall_IndCnc_10", "2511.841064 236.162521 4699.317383", "11.885277 0.000000 -0.000000", 1);
	SpawnObject("Land_Misc_Greenhouse", "2490.374023 234.243240 4689.471680", "8.283581 0.000000 -0.000000", 1);


	// Uncomment if you want to export loot from newly added buildings
	// Position, Radius (increase if you have a larger map than Chernarus)
	GetCEApi().ExportProxyData(Vector(7500, GetGame().SurfaceY(7500, 7500), 7500), 20000);

    //INIT ECONOMY--------------------------------------
    Hive ce = CreateHive();
    if ( ce )
        ce.InitOffline();

    //DATE RESET AFTER ECONOMY INIT-------------------------
    int year, month, day, hour, minute;
    int reset_month = 9, reset_day = 20;
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

        player.RemoveAllItems();

        int JKIndex = Math.RandomInt( 0, 4 );
        string JacketArray[] = { "GorkaEJacket_Autumn", "GorkaEJacket_Flat", "GorkaEJacket_PautRev", "GorkaEJacket_Summer" };
        itemEnt = player.GetInventory().CreateInInventory( JacketArray[JKIndex] );

        int PTIndex = Math.RandomInt( 0, 4 );
        string PantsArray[] = { "GorkaPants_Autumn", "GorkaPants_Flat", "GorkaPants_PautRev", "GorkaPants_Summer" };
        itemEnt = player.GetInventory().CreateInInventory( PantsArray[PTIndex] );

        int FCIndex = Math.RandomInt( 0, 4 );
        string FaceCoverArray[] = { "BalaclavaMask_Beige", "BalaclavaMask_Black", "BalaclavaMask_Blackskull", "BalaclavaMask_Green" };
        itemEnt = player.GetInventory().CreateInInventory( FaceCoverArray[FCIndex] );

        int BOIndex = Math.RandomInt( 0, 4 );
        string BootsArray[] = { "JungleBoots_Beige", "JungleBoots_Brown", "JungleBoots_Green", "JungleBoots_Olive" };
        itemEnt = player.GetInventory().CreateInInventory( BootsArray[BOIndex] );

        int GLVIndex = Math.RandomInt( 0, 3 );
        string GlovesArray[] = { "TacticalGloves_Beige", "TacticalGloves_Green", "TacticalGloves_Black" };
        itemEnt = player.GetInventory().CreateInInventory( GlovesArray[GLVIndex] );

        int HATIndex = Math.RandomInt( 0, 4 );
        string HatArray[] = { "Mich2001Helmet", "Mich2001Helmet", "Mich2001Helmet", "Mich2001Helmet" };
        itemEnt = player.GetInventory().CreateInInventory( HatArray[HATIndex] );

        int VSTIndex = Math.RandomInt( 0, 4 );
        string VestArray[] = { "PlateCarrierVest", "PlateCarrierVest", "PlateCarrierVest", "PlateCarrierVest" };
        itemEnt = player.GetInventory().CreateInInventory( VestArray[VSTIndex] );

        int BLTIndex = Math.RandomInt( 0, 4 );
        string BeltArray[] = { "MilitaryBelt", "MilitaryBelt", "MilitaryBelt", "MilitaryBelt" };
        itemEnt = player.GetInventory().CreateInInventory( BeltArray[BLTIndex] );


        itemClothing = player.FindAttachmentBySlotName( "Body" );
        if ( itemClothing )
        {


            itemEnt = itemClothing.GetInventory().CreateInInventory( "BandageDressing" );
            if ( Class.CastTo( itemBs, itemEnt ) )
                itemBs.SetQuantity( 2 );

            string chemlightArray[] = { "M18SmokeGrenade_White", "M18SmokeGrenade_Green", "M18SmokeGrenade_Yellow", "M18SmokeGrenade_Red" };
            int rndIndex = Math.RandomInt( 0, 4 );
            itemEnt = itemClothing.GetInventory().CreateInInventory( chemlightArray[rndIndex] );


            rand = Math.RandomFloatInclusive( 0.0, 1.0 );
            if ( rand < 0.35 )
                itemEnt = player.GetInventory().CreateInInventory( "Apple" );
            else if ( rand > 0.65 )
                itemEnt = player.GetInventory().CreateInInventory( "Pear" );
            else
                itemEnt = player.GetInventory().CreateInInventory( "Plum" );

            SetRandomHealth( itemEnt );
        }

        itemClothing = player.FindAttachmentBySlotName( "Legs" );
        itemClothing = player.FindAttachmentBySlotName( "Feet" );

        itemEnt = player.GetInventory().CreateInInventory("UniversalLight");       
        itemEnt = player.GetInventory().CreateInInventory("Battery9V");
        itemEnt = player.GetInventory().CreateInInventory("Battery9V");
        itemEnt = player.GetInventory().CreateInInventory("Machete"); 
        
        itemEnt = player.GetInventory().CreateInInventory("TacticalBaconCan_Opened");
        itemEnt = player.GetInventory().CreateInInventory("BakedBeansCan_Opened");
        itemEnt = player.GetInventory().CreateInInventory("SodaCan_Pipsi");
        itemEnt = player.GetInventory().CreateInInventory("SodaCan_Spite");

        itemEnt = player.GetInventory().CreateInInventory("M67Grenade");
        itemEnt = player.GetInventory().CreateInInventory("FlashGrenade");
        
        array<string> MPFIVEArray = { "MP5K", "Mag_MP5_30Rnd", "Mag_MP5_30Rnd", "AmmoBox_9x19_25rnd", "AmmoBox_9x19_25rnd","AmmoBox_9x19_25rnd","PistolSuppressor","MP5k_StockBttstck","MP5_RailHndgrd","ACOGOptic" };
        array<string> UMPArray = { "UMP45", "Mag_UMP_25Rnd", "Mag_UMP_25Rnd", "AmmoBox_45ACP_25rnd", "AmmoBox_45ACP_25rnd","AmmoBox_45ACP_25rnd","PistolSuppressor","ACOGOptic" };
        array<string> CRSOArray = { "CZ61", "Mag_CZ61_20Rnd", "Mag_CZ61_20Rnd", "Mag_CZ61_20Rnd", "Mag_CZ61_20Rnd","Mag_CZ61_20Rnd","PistolSuppressor" };       
        array<string> FALArray = { "FAL", "Fal_OeBttstck", "Mag_FAL_20Rnd", "Mag_FAL_20Rnd", "Mag_FAL_20Rnd","Mag_FAL_20Rnd","ACOGOptic_6x"};
        array<string> SKSArray = { "SKS", "AmmoBox_762x39_20Rnd", "AmmoBox_762x39_20Rnd", "AmmoBox_762x39_20Rnd", "AmmoBox_762x39_20Rnd","PUScopeOptic" };
        array<string> MFOURArray = { "M4A1", "M4_MPHndgrd", "M4_OEBttstck", "Mag_CMAG_30Rnd", "Mag_CMAG_30Rnd", "Mag_CMAG_30Rnd","Mag_CMAG_30Rnd","ACOGOptic" };
        array<string> AKMArray = { "AKM", "AK_PlasticBttstck", "AK_PlasticHndgrd", "Mag_AKM_30Rnd", "Mag_AKM_30Rnd", "Mag_AKM_30Rnd","Mag_AKM_30Rnd","PSO11Optic" };
        array<string> FAMASArray = { "FAMAS", "Mag_FAMAS_25Rnd", "Mag_FAMAS_25Rnd", "Mag_FAMAS_25Rnd", "Mag_FAMAS_25Rnd", "Mag_FAMAS_25Rnd","ACOGOptic" };
        array<string> VSSArray = { "VSS", "Mag_VAL_20Rnd", "Mag_VAL_20Rnd", "Mag_VAL_20Rnd", "Mag_VAL_20Rnd", "Mag_VAL_20Rnd","PSO1Optic","Mag_VAL_20Rnd" };
        array<string> ASVALArray = { "ASVAL", "Mag_VAL_20Rnd", "Mag_VAL_20Rnd", "Mag_VAL_20Rnd", "Mag_VAL_20Rnd", "Mag_VAL_20Rnd","ACOGOptic_6x","Mag_VAL_20Rnd" };
        array<string> SCOUTArray = { "Scout", "Mag_Scout_5Rnd","Mag_Scout_5Rnd","Mag_Scout_5Rnd","Mag_Scout_5Rnd","Mag_Scout_5Rnd","Mag_Scout_5Rnd", "Mag_Scout_5Rnd", "Mag_Scout_5Rnd", "Mag_Scout_5Rnd", "Mag_Scout_5Rnd","Rangefinder","ACOGOptic_6x" };
        array<string> MOSINArray = { "Mosin9130","Mosin_Compensator","PUScopeOptic","AmmoBox_762x54_20Rnd","AmmoBox_762x54_20Rnd","AmmoBox_762x54_20Rnd", "AmmoBox_762x54_20Rnd","AmmoBox_762x54_20Rnd", "Rangefinder" };
        array<string> TUNDRAArray = { "Winchester70", "AmmoBox_308Win_20Rnd","AmmoBox_308Win_20Rnd","AmmoBox_308Win_20Rnd","AmmoBox_308Win_20Rnd","Rangefinder","HuntingOptic" };
        array<string> SVDArray = { "SVD", "Mag_SVD_10Rnd","Mag_SVD_10Rnd","Mag_SVD_10Rnd","Mag_SVD_10Rnd","Mag_SVD_10Rnd","PSO11Optic" };
		array<string> DMRArray = { "M14", "Mag_M14_20Rnd","Mag_M14_20Rnd","AmmoBox_308Win_20Rnd","AmmoBox_308Win_20Rnd","AmmoBox_308Win_20Rnd","AmmoBox_308Win_20Rnd","AmmoBox_308Win_20Rnd","ACOGOptic_6x" };
        
        
        int gunz = Math.RandomInt( 0, 11 );
        //int gunz = 10;
        if ( gunz == 1 )
        {
            foreach(int i, string j: FALArray)
            {
                itemEnt = player.GetInventory().CreateInInventory( FALArray[i] );
            }
        }
        else if ( gunz == 2 )
        {
            foreach(int k, string l: SKSArray)
            {
                itemEnt = player.GetInventory().CreateInInventory( SKSArray[k] );
            }
        }
        else if ( gunz == 3 )
        {
            foreach(int m, string n: MFOURArray)
            {
                itemEnt = player.GetInventory().CreateInInventory( MFOURArray[m] );
            }
        }
        else if ( gunz == 4 )
        {
            foreach(int o, string p: VSSArray)
            {
                itemEnt = player.GetInventory().CreateInInventory( VSSArray[o] );
            }
        }
        else if ( gunz == 5 )
        {
            foreach(int q, string r: ASVALArray)
            {
                itemEnt = player.GetInventory().CreateInInventory( ASVALArray[q] );
            }
        }
        else if ( gunz == 6 )
        {
            foreach(int s, string t: SCOUTArray)
            {
                itemEnt = player.GetInventory().CreateInInventory( SCOUTArray[s] );
            }
        }
        else if ( gunz == 7 )
        {
            foreach(int u, string v: MOSINArray)
            {
                itemEnt = player.GetInventory().CreateInInventory( MOSINArray[u] );
            }
        }
        else if ( gunz == 8 )
        {
            foreach(int w, string x: TUNDRAArray)
            {
                itemEnt = player.GetInventory().CreateInInventory( TUNDRAArray[w] );
            }
        }
        else if ( gunz == 9 )
        {
            foreach(int y, string z: SVDArray)
            {
                itemEnt = player.GetInventory().CreateInInventory( SVDArray[y] );
            }
        }
        else if ( gunz == 10 )
        {
            foreach(int ya, string za: DMRArray)
            {
                itemEnt = player.GetInventory().CreateInInventory( DMRArray[ya] );
            }
        }
        else 
        {
            foreach(int a, string b: AKMArray)
            {
                itemEnt = player.GetInventory().CreateInInventory( AKMArray[a] );
            }        
        }
        
        array<string> SideArmArray = { "PlateCarrierHolster","MKII", "Mag_MKII_10Rnd","Mag_MKII_10Rnd","AmmoBox_22_50Rnd" };
        foreach(int sai, string san: SideArmArray)
        {
            itemEnt = player.GetInventory().CreateInInventory( SideArmArray[sai] );
        } 

    }
};

Mission CreateCustomMission(string path)
{
    return new CustomMission();
}
