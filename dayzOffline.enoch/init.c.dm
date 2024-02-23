static Object SpawnObject(string type, vector position, vector orientation)
{
    Object obj = GetGame().CreateObjectEx(type, position, ECE_SETUP | ECE_UPDATEPATHGRAPH | ECE_CREATEPHYSICS);
    if (!obj) {
        Error("Failed to create object " + type);
        return null;
    }

    obj.SetPosition(position);
    obj.SetOrientation(orientation);
    obj.SetOrientation(obj.GetOrientation());
    obj.SetFlags(EntityFlags.STATIC, false);
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
    
    //SpawnObject("Land_Office_Municipal2", "4099.696777 370.635742 10649.987305", "161.270859 -0.000000 -0.000000");
    //SpawnObject("Land_Mil_GuardTower", "4243.538086 344.346069 10995.006836", "-116.736763 0.000000 -0.000000");
    //SpawnObject("Land_Office_Municipal2", "4240.404785 370.739349 10212.217773", "-131.135010 0.000000 -0.000000");
    //SpawnObject("Land_Tower_TC5", "4630.498535 358.456726 9586.584961", "0.000000 -0.000000 -0.000000");
    //SpawnObject("Land_Mil_ControlTower", "4327.233398 346.569031 10875.312500", "50.595417 -0.000000 -0.000000");
    //SpawnObject("Land_Castle_Bergfrit", "3995.628662 358.688171 10380.584961", "-128.621368 0.000000 -0.000000");
    //SpawnObject("Land_Castle_Stairs_nolc", "3998.738770 348.763367 10372.528320", "-40.645191 0.000000 -0.000000");
    //SpawnObject("Land_Sawmill_Illuminanttower", "5145.929199 351.436401 9703.166992", "46.628014 -0.000000 -0.000000");
    //SpawnObject("Land_Misc_Well_Pump_Yellow", "3695.897461 402.507782 6006.879883", "86.164833 -0.000000 -0.000000", 1);
    //SpawnObject("Land_Misc_Well_Pump_Yellow", "2489.085938 233.496170 4687.829590", "86.164833 -0.000000 -0.000000", 1);
    
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
		array<string> AUGArray = { "Aug","Mag_Aug_30Rnd", "Mag_Aug_30Rnd", "Mag_Aug_30Rnd","Mag_Aug_30Rnd","ACOGOptic" };
        
        
        int gunz = Math.RandomInt( 0, 12 );
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
		else if ( gunz == 11 )
        {
            foreach(int yb, string zb: AUGArray)
            {
                itemEnt = player.GetInventory().CreateInInventory( AUGArray[yb] );
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
