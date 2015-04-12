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

void log_adcolony(value text)
{
    Log(val_string(text));
}
DEFINE_PRIM(log_adcolony, 1);

static value available_adcolony(value zoneid)
{
    if (adcolony::adcolonyAvailable(val_string(zoneid)))
    return val_true;
    return val_false;
}
DEFINE_PRIM(available_adcolony, 1);

static value status_adcolony(value zoneid)
{
    if (adcolony::adcolonyStatus(val_string(zoneid)))
    return val_true;
    return val_false;
}
DEFINE_PRIM(status_adcolony, 1);

static value showing_adcolony(value zoneid)
{
    if (adcolony::adcolonyShowing(val_string(zoneid)))
        return val_true;
    return val_false;
}
DEFINE_PRIM(showing_adcolony, 1);
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
