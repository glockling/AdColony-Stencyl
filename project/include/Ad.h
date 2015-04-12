#ifndef Ad
#define Ad

namespace adcolony
{	
    void LoadAd(const char *appID, const char *zoneID);
    void PlayAd(const char *zoneID);
    void Log(const char *text);
    bool adcolonyAvailable(const char *zoneID);
    bool adcolonyStatus(const char *zoneID);
    bool adcolonyShowing(const char *zoneID);
}

#endif
