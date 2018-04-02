//  Minimum support Intowow SDK 3.27.0
//
//  CECustomEventCard.m
//
//  Copyright © 2017 intowow. All rights reserved.
//

#import "CECustomEventCard.h"
#import "CECardAD.h"
#import "UIView+CELayoutAdditions.h"

#define LoadAdTimeout 1

/// Constant for CrystalExpress Ad Network custom event error domain.
static NSString *const customEventErrorDomain = @"com.intowow.CrystalExpress";

@interface CECustomEventCard () <CECardADDelegate>

@property (nonatomic, strong) CECardAD *ceCardAd;
@property (nonatomic, assign) CGSize adSize;

@end

@implementation CECustomEventCard

@synthesize delegate;

- (void)requestBannerAd:(GADAdSize)adSize
              parameter:(NSString *)serverParameter
                  label:(NSString *)serverLabel
                request:(GADCustomEventRequest *)request
{
    _adSize = CGSizeMake(adSize.size.width, adSize.size.height);
    NSString * placement = serverParameter;

    if (placement == nil || [placement isEqualToString:@""]) {
        NSError *error = [NSError errorWithDomain:customEventErrorDomain code:kGADErrorInvalidArgument userInfo:nil];
        [self.delegate customEventBanner:self didFailAd:error];
        return;
    }

    CERequestInfo *info = [CERequestInfo new];
    info.placement = placement;
    info.timeout = LoadAdTimeout;
    self.ceCardAd = [[CECardAD alloc] initWithVideoViewProfile:CEVideoViewProfileCardDefaultProfile];
    [self.ceCardAd setDelegate:self];

    if (adSize.size.width > 0) {
        info.adWidth = adSize.size.width;
    }

    [self.ceCardAd loadAdWithInfo:info];
}

#pragma mark - CECardADDelegate

- (void)cardADDidLoaded:(CECardAD *)cardAD
{
    UIView * adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.adSize.width, self.adSize.height)];

    adView.backgroundColor = [UIColor blackColor];
    [adView addSubview:cardAD.adUIView];
    [cardAD.adUIView ce_fitSuperview];
    [self.delegate customEventBanner:self didReceiveAd:adView];
}

- (void)cardADDidFail:(CECardAD *)cardAD withError:(NSError *)error
{
    [self.delegate customEventBanner:self didFailAd:error];
}

- (void)cardADDidClick:(CECardAD *)cardAD
{
    [self.delegate customEventBannerWasClicked:self];
}

@end
