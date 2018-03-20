//  Minimum support Intowow SDK 3.20.0
//
//  CECustomEventInterstitial.m
//
//  Copyright © 2017 intowow. All rights reserved.
//

#import "CECustomEventInterstitial.h"
#import "CESplash2AD.h"

#define LoadAdTimeout 10

/// Constant for CrystalExpress Ad Network custom event error domain.
static NSString *const customEventErrorDomain = @"com.intowow.CrystalExpress";

@interface CECustomEventInterstitial () <CESplash2ADDelegate>

@property (nonatomic, strong) CESplash2AD *ceSplashAD;

@end


@implementation CECustomEventInterstitial

@synthesize delegate;

- (void)requestInterstitialAdWithParameter:(NSString *)serverParameter
                                     label:(NSString *)serverLabel
                                   request:(GADCustomEventRequest *)request
{
    NSString *placement = serverParameter;
    if (placement == nil || [placement isEqualToString:@""]) {
        NSError *error = [NSError errorWithDomain:customEventErrorDomain code:kGADErrorInvalidArgument userInfo:nil];
        [self.delegate customEventInterstitial:self didFailAd:error];
        return;
    }

    self.ceSplashAD = [[CESplash2AD alloc] initWithPlacement:placement];
    self.ceSplashAD.delegate = self;
    [self.ceSplashAD loadAdWithTimeout:LoadAdTimeout];
}

- (void)presentFromRootViewController:(nonnull UIViewController *)rootViewController {
    if (self.ceSplashAD) {
        [self.ceSplashAD showFromViewController:rootViewController animated:YES];
    }
}

#pragma mark - CESplash2ADDelegate
- (void)splash2ADDidLoaded:(CESplash2AD *)splash2AD
{
    [self.delegate customEventInterstitialDidReceiveAd:self];
}

- (void)splash2ADDidFail:(CESplash2AD *)splash2AD withError:(NSError *)error
{
    [self.delegate customEventInterstitial:self didFailAd:error];
}

- (void)splash2ADWillDisplay:(CESplash2AD *)splash2AD
{
    [self.delegate customEventInterstitialWillPresent:self];
}

- (void)splash2ADWillDismiss:(CESplash2AD *)splash2AD
{
    [self.delegate customEventInterstitialWillDismiss:self];
}

- (void)splash2ADDidDismiss:(CESplash2AD *)splash2AD
{
    [self.delegate customEventInterstitialDidDismiss:self];
}

- (void)splash2ADDidClick:(CESplash2AD *)splash2AD
{
    [self.delegate customEventInterstitialWasClicked:self];
}

@end
