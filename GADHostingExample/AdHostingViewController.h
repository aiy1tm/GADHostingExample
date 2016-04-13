//
//  AdHostingViewController.h
//
//  Created by Scott Sullivan on 4/10/16.
//  Copyright © 2016 Scott Sullivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerHandler.h"

@interface AdHostingViewController : UIViewController

 
@property BOOL shouldShowBannerAds; //set to yes to show ads.
@property BOOL showAdsOnTop; // NO for bottom banner.
@property BOOL disallowLandscapeAds; //by default, banner will re-size and request an ad in new orientation
@property BOOL disallowPortraitAds;

@end
