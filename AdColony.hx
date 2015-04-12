package;


import openfl.Lib;

#if cpp
import cpp.Lib;
#end

class AdColony
{
    
    //Called from Blocks.xml this loads Ad Colony with a specific Zone ID
    public static function load(appid:String, zoneid:String):Void{
        
       
       // adColonyEvent(setEventListeners);
        LoadAd(appid, zoneid);
    
    }
    
    //Called from Blocks.xml this plays Ad Colony Ad with a specific Zone ID
    public static function play(zoneID:String):Void{
        
        PlayAd(zoneID);
        
    }
    
    //Called from Blocks.xml this checks if ad with zone id is loaded
    
    public static function available(zoneid:String):Bool{
    
        return Available(zoneid);
    
    }
    
    //Called from Blocks.xml this updates the status of zone ID "Closed"
    
    public static function status(zoneid:String):Bool{
    
        return Status(zoneid);
    }
    
    // Called from Blocks.xml this updates the status of Zone ID "Showing"
    
    public static function showing(zoneid:String):Bool{
        
        return Showing(zoneid);
    }
    
     
	#if ios
	private static var LoadAd = Lib.load("adcolony","init_adcolony", 2);
    private static var PlayAd = Lib.load("adcolony","play_adcolony", 1);
    private static var Available = Lib.load("adcolony","available_adcolony", 1);
    private static var Status = Lib.load("adcolony","status_adcolony", 1);
    private static var Showing = Lib.load("adcolony","showing_adcolony",1);
	#end
}
