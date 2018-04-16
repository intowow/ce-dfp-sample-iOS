//
//  ViewController.m
//  DFPDemo
//
//  Created by WayneShiau on 2017/12/12.
//  Copyright © 2017年 Intowow. All rights reserved.
//

#import "ViewController.h"
@import GoogleMobileAds;

@interface ViewController () <GADBannerViewDelegate, GADInterstitialDelegate>

@property(nonatomic, strong) DFPBannerView *bannerView;
@property(nonatomic, strong) DFPInterstitial *interstitial;
@property(nonatomic, strong) GADAdLoader *adLoader;
@property(nonatomic, strong) GADNativeContentAdView *contentAdView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)addBannerViewToView:(UIView *)bannerView {
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bannerView];
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.adMediaCoverView
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1
                                                              constant:0]
                                ]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearView
{
    [self.bannerView removeFromSuperview];
    [self.contentAdView removeFromSuperview];
}

- (IBAction)loadInterstitialBtnClicked:(id)sender {
    [self clearView];
    self.interstitial = [[DFPInterstitial alloc] initWithAdUnitID:@"/57931037/test_intowow_ios_splash"];

    self.interstitial.delegate = self;
    DFPRequest *request = [DFPRequest request];
    [self.interstitial loadRequest:request];
}

- (IBAction)loadBannerBtnClicked:(id)sender {
    [self clearView];
    // In this case, we instantiate the banner with desired ad size.
    self.bannerView = [[DFPBannerView alloc]
                       initWithAdSize:kGADAdSizeMediumRectangle];

    [self addBannerViewToView:self.bannerView];
    self.bannerView.adUnitID = @"/57931037/test_intowow_ios_card";

    self.bannerView.rootViewController = self;
    self.bannerView.delegate = self;
    DFPRequest *request = [DFPRequest request];
    [self.bannerView loadRequest:request];
}

#pragma mark - GADBannerViewDelegate
/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");

}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that a full-screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

/// Tells the delegate that the full-screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full-screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}

#pragma mark - GADInterstitialDelegate
/// Tells the delegate an ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"interstitialDidReceiveAd");
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    } else {
        NSLog(@"Ad wasn't ready");
    }
}

/// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that an interstitial will be presented.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillPresentScreen");
}

/// Tells the delegate the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillDismissScreen");
}

/// Tells the delegate the interstitial had been animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialDidDismissScreen");
}

/// Tells the delegate that a user click will open another app
/// (such as the App Store), backgrounding the current app.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"interstitialWillLeaveApplication");
}

@end
