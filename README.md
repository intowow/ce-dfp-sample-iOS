# ce-dfp-demo-iOS

## Mediate CrystalExpress Ads through DFP

The full integration guide: https://intowow.gitbooks.io/crystalexpress-documentation-v3-x/content/mediation-guidelines/dfp/ios.html

The CrystalExpress DFP Custom Event allows DFP publishers to add CrystalExpress as a Custom Ad Network within the DFP platform.

CrystalExpress provides two ad formats for DFP mediation. The relationship between DFP ad unit and ad format in CrystalExpress is as following:

| DFP ad unit | AD format from CrystalExpress |
| --- | --- |
| Banner | Card AD |
| Interstitial | Splash AD |

Before adding CrystalExpress as Custom network, you have to integrate DFP SDK by following the instructions on the [DFP website](https://developers.google.com/mobile-ads-sdk/docs/dfp/ios/quick-start).


** NOTICE: This porject does not contain CrystalExpress SDK. Please contact your Intowow account manager. We will provide the appropriate version of SDK and Crystal ID to fit your needs.**

The custom event is under folder 'DFPDemo/CrystalExpress_Google_CustomEvent/'


## CHANGELOG

#### Version 1 (2018-03-20)
* Implement DFP Custom Events.