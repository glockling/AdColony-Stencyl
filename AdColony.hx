package;


import openfl.Lib;

#if cpp
import cpp.Lib;
#end

class AdColony
{
    
    //Called from Blocks.xml this loads Ad Colony with a specific Zone ID
    public static function load(appid:String, zoneid:String){
        
       
        adColonyEvent(setEventListeners);
        LoadAd(appid, zoneid);
    
    }
    
    //Called from Blocks.xml this plays Ad Colony Ad with a specific Zone ID
    public static function play(zoneID:String){
        
        PlayAd(zoneID);
        
    }
    
    //Adding event listeners
    
    public static function addEventListener(status:String, callbackFn:Void->Void):Void{
    
        #if ios
            
            if(status == "available"){
            
                availableCall == callbackFn;
            
            }

            else if(status == "shown"){
                
                shownCall = callbackFn;
                
            }
        #end
    
    }
    
    
    //Removing event listeners
    
    public static function removeEventListener(status:String):Void{
    
        #if ios
            
            if(status == "available"){
                
                availableCall == null;
                
            }

            else if(status == "shown"){
                
                shownCall = null;
                
            }
            
        #end
    }
    
    public static function setEventListeners(inEvent:Dynamic){
    
        #if ios
        
            var status:String = Std.string(Reflect.field(inEvent, "status"));
        
        if(status == "available" && availableCall != null)
        {
            availableCall();
        }
        
        if(status == "shown" && shownCall != null)
        {
            shownCall();
        }
        #end
    }
    
    public function new()
    {
        
    }
    
    private static var availableCall:Void->Void;
    private static var shownCall:Void->Void;
    
	#if ios
	private static var LoadAd = Lib.load("adcolony","init_adcolony", 2);
    private static var PlayAd = Lib.load("adcolony","play_adcolony", 1);
    private static var adColonyEvent = Lib.load("adcolony","adcolony_event",1);
	#end
}
