/**
 *
 * Created By Maxwell Glockling
 * http://www.maxglockling.com 
 *
 * Please note, as of right now my Objective C++ is very limited.
 * Really, my knowledge of code in general is limited. Feel free to change something incase it doesn't work
 *
 **/

#include <Ad.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AdColony/AdColony.h>

extern "C" void adColonyEventChange(const char* status);



@interface AdColonyLib:NSObject <AdColonyDelegate, AdColonyAdDelegate>
{
    
    BOOL videoAvailable;
    BOOL videoFinished;
    BOOL videoShown;
    NSString *adcolonyZoneID;
    
}

@property (nonatomic, assign) BOOL videoAvailable;
@property (nonatomic, assign) BOOL videoFinished;
@property (nonatomic, assign) BOOL videoShown;
@property (nonatomic, copy) NSString *adcolonyZoneID;

@end

@implementation AdColonyLib

 
@synthesize videoAvailable;
@synthesize videoFinished;
@synthesize videoShown;
@synthesize adcolonyZoneID;
/*
 
================
 
 Commented out because I'm not using V4VC currently, and it's not really even implemented anywhere so no need for it.
 
================

#pragma mark -
#pragma mark AdColony V4VC

// Callback activated when a V4VC currency reward succeeds or fails
// This implementation is designed for client-side virtual currency without a server
// It uses NSUserDefaults for persistent client-side storage of the currency balance
// For applications with a server, contact the server to retrieve an updated currency balance
// On success, posts an NSNotification so the rest of the app can update the UI
// On failure, posts an NSNotification so the rest of the app can disable V4VC UI elements
- ( void ) onAdColonyV4VCReward:(BOOL)success currencyName:(NSString*)currencyName currencyAmount:(int)amount inZone:(NSString*)zoneID
{
    onAdColonyV4VCReward( success, [currencyName UTF8String], amount * 1.0f );
}
 
 */

/* ======================
 
    Begin what we do need

   ======================
*/

#pragma mark -
#pragma mark AdColony ad fill

// Is called when an ad for a specific Ad Zone changes availability

- ( void )onAdColonyAdAvailabilityChange:(BOOL)available inZone:(NSString*) zoneID
{

    adcolonyZoneID = zoneID;
    videoAvailable = available;
}

#pragma mark -
#pragma mark AdColonyAdDelegate

// Is called when AdColony has taken control of the device screen and is about to begin showing an ad
// Apps should implement app-specific code such as pausing a game and turning off app music
- ( void ) onAdColonyAdStartedInZone:( NSString * )zoneID
{
    videoShown = YES;
    adcolonyZoneID = zoneID;
}

// Is called when AdColony has finished trying to show an ad, either successfully or unsuccessfully
// If shown == YES, an ad was displayed and apps should implement app-specific code such as unpausing a game and restarting app music
- ( void )onAdColonyAdAttemptFinished:(BOOL)shown inZone:( NSString * )zoneID
{
    videoFinished = shown;
    adcolonyZoneID = zoneID;
}

@end


using namespace adcolony;




namespace adcolony{
    
    
    static AdColonyLib *AdColonyController;
    
    //Load adcolony ad using App ID and Zone Id
    void LoadAd(const char *appID, const char *zoneId){
        
        if(AdColonyController == NULL)
        {
            AdColonyController = [AdColonyLib alloc];
        }
        
        
        //Convert const char to NSString for appid and zoneid
        NSString * appID2 = [[NSString alloc] initWithUTF8String:appID];
        NSString * zoneID2 = [[NSString alloc] initWithUTF8String:zoneId];
        
        //initiate Ad Colony
        [AdColony configureWithAppID:appID2 zoneIDs:@[zoneID2]  delegate:AdColonyController logging:YES];
    }
    
    //Plays ad for zone with zone ID
    void PlayAd(const char *zoneId){
        
        NSString * zoneID2 = [[NSString alloc] initWithUTF8String:zoneId];
        [AdColony playVideoAdForZone:zoneID2 withDelegate:AdColonyController];
    }
    
    void Log(const char *text){
    
        NSString * text2 = [[NSString alloc] initWithUTF8String:text];
        
        NSLog(text2);
    }
    
    // Checks availability for specific zone ID
    bool adcolonyAvailable(const char *zoneID)
    {
        
        NSString * zoneID2 = [[NSString alloc] initWithUTF8String:zoneID];
        NSString * OtherZoneID = AdColonyController.adcolonyZoneID;
        if ([zoneID2 isEqualToString:OtherZoneID]) {
            if (AdColonyController.videoAvailable) {
                AdColonyController.videoAvailable = NO;
                return true;
            }
        }
        return false;
    }
    
    bool adcolonyStatus(const char *zoneID)
    {
        NSString * zoneID2 = [[NSString alloc] initWithUTF8String:zoneID];
        NSString * OtherZoneID = AdColonyController.adcolonyZoneID;
        if ([zoneID2 isEqualToString:OtherZoneID]) {
            
            if (AdColonyController.videoFinished) {
                AdColonyController.videoFinished = NO;
                return true;
            }
            
        }
        return false;
    }
    
    bool adcolonyShowing(const char *zoneID)
    {
        NSString * zoneID2 = [[NSString alloc] initWithUTF8String:zoneID];
        NSString * OtherZoneID = AdColonyController.adcolonyZoneID;
        if ([zoneID2 isEqualToString:OtherZoneID]) {
            
            if (AdColonyController.videoShown) {
                AdColonyController.videoShown = NO;
                return true;
            }
            
        }
        return false;
    }
}
