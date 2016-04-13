//
//  GADBannerHandler.h
//
//
//  Created by Scott Sullivan on 4/10/16.
//  Copyright © 2016 Scott Sullivan. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;

@interface GADBannerHandler : UIViewController <GADBannerViewDelegate> {
    GADBannerView *adBanner_;
    BOOL didCloseWebsiteView_;
    BOOL isLoaded_;
    BOOL shouldShow_;
    id currentDelegate_;
}

+(GADBannerHandler *)singleton;
-(void)resetAdView:(UIViewController *)rootViewController;

@end
