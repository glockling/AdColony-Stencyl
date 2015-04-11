#ifndef Ad
#define Ad

namespace adcolony
{	
    void LoadAd(const char *appID, const char *zoneID);
    void PlayAd(const char *zoneID);
    bool AdColonyAvailable();
    bool AdColonyDidFinishAd();
}

#endif
