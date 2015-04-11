#ifndef IPHONE
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif

#include <hx/CFFI.h>
#include "Ad.h"
#include <stdio.h>

//--------------------------------------------------
// Change this to match your extension's ID
//--------------------------------------------------

using namespace adcolony;


#ifdef IPHONE

//--------------------------------------------------
// Glues Haxe to native code.
//--------------------------------------------------


// Configure

AutoGCRoot* adColonyEvent = 0;


void adcolony_event(value onEvent)
{
    adColonyEvent = new AutoGCRoot(onEvent);
}
DEFINE_PRIM(adcolony_event, 1);

//Functions

void init_adcolony(value appid, value zoneid)
{
    LoadAd(val_string(appid), val_string(zoneid));
}
DEFINE_PRIM(init_adcolony, 2);

void play_adcolony(value zoneid)
{
    PlayAd(val_string(zoneid));
}
DEFINE_PRIM(play_adcolony, 1);

#endif



//--------------------------------------------------
// IGNORE STUFF BELOW THIS LINE
//--------------------------------------------------

extern "C" void AdColony_main()
{	
}
DEFINE_ENTRY_POINT(AdColony_main);

extern "C" int AdColony_register_prims()
{ 
    return 0; 
}


// Events
extern "C" void adColonyEventChange( const char* status )
{
    value o = alloc_empty_object();
    alloc_field(o, val_id("status"), alloc_string(status));
    val_call1(adColonyEvent->get(), o);
}
/*
 =================
 Commented out because I'm not currently using this.
 =================
extern "C" void onAdColonyV4VCReward( bool success, const char* name, float amount )
{
    val_call3( v4vcRewardHandle->get(), alloc_bool(success), alloc_string(name), alloc_float(amount) );
}
*/