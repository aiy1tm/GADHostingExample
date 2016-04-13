//
//  GADBannerHandler.m
//
//  Created by Scott Sullivan on 4/10/16.
//  Copyright © 2016 Scott Sullivan. All rights reserved.
//

#warning don't forget your app unit id!
//This one is from Google's banner example project!

#define kAppUnitId @"ca-app-pub-3940256099942544/2934735716";
#import "GADBannerHandler.h"
#import "AdHostingViewController.h"

@interface GADBannerHandler  ()

@end

@implementation GADBannerHandler

#warning implement ad delegate handling and forwarding to current delegate
+(GADBannerHandler *)singleton {
    static dispatch_once_t pred;
    static GADBannerHandler *shared;
    // Will only be run once, the first time this is called
    dispatch_once(&pred, ^{
        shared = [[GADBannerHandler alloc] init];
    });
    return shared;
}

-(id)init {
    if (self = [super init]) {
        
        switch ([[UIApplication sharedApplication] statusBarOrientation])  {
            case UIInterfaceOrientationPortrait:
            case UIInterfaceOrientationPortraitUpsideDown:
            {
                //load the portrait view
                adBanner_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
            }
                
                break;
            case UIInterfaceOrientationLandscapeLeft:
            case UIInterfaceOrientationLandscapeRight:
            {
                //load the landscape view
                adBanner_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerLandscape];
            }
                break;
            case UIInterfaceOrientationUnknown:break;
        }
        // Has an ad request already been made
        isLoaded_ = NO;
        
        
    }
    return self;
}
-(void)resetAdView:(AdHostingViewController *)rootViewController {
    // keep track of currentDelegate for notification forwarding
    currentDelegate_ = rootViewController;
    
    // Ad already requested, simply add it into the view
    if (isLoaded_) {
        [rootViewController.view addSubview:adBanner_];
        [self layoutBannerForRootController:rootViewController];
    } else {
        
        adBanner_.delegate = self;
        adBanner_.rootViewController = rootViewController;
        adBanner_.adUnitID =  kAppUnitId;
        
        GADRequest *request = [GADRequest request];
        request.testDevices = @[ kGADSimulatorID,@"dea989155328229d034e18ec503b16aa",@"0d070d28f44b3347fa14792114cd9100"  ];
        [adBanner_ loadRequest:request];
        
        [rootViewController.view addSubview:adBanner_];
        [self layoutBannerForRootController:rootViewController];

        
        isLoaded_ = YES;
    }
}

-(void) layoutBannerForRootController:(AdHostingViewController*) rootViewController{
    
    NSLayoutAttribute boundary1 = NSLayoutAttributeBottomMargin;
    NSLayoutAttribute boundary2 = NSLayoutAttributeBottom;
    if (rootViewController.showAdsOnTop) {
        boundary1 = NSLayoutAttributeTopMargin;
        boundary2 = NSLayoutAttributeTop;
    }
    
    switch ([[UIApplication sharedApplication] statusBarOrientation])  {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            // make sure the ad is portrait
            if (rootViewController.disallowPortraitAds) {
                [adBanner_ removeFromSuperview];
                shouldShow_=NO;
            }else{
                adBanner_.adSize = kGADAdSizeSmartBannerPortrait;
                isLoaded_ = NO;
                shouldShow_=YES;
            }
            
            
           
        }
            
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            //make sure the ad is landscape
            if (rootViewController.disallowLandscapeAds) {
                [adBanner_ removeFromSuperview];
                shouldShow_=NO;
            }else{
                adBanner_.adSize = kGADAdSizeSmartBannerLandscape;
                isLoaded_ = NO;
                shouldShow_= YES;
                NSLog(@"should be showing landscape ad");
            }
        }
            break;
        case UIInterfaceOrientationUnknown:break;
    }
    // Constrain vertical
    if (shouldShow_) {
        
    [rootViewController.view addConstraint:
     [NSLayoutConstraint constraintWithItem:adBanner_
                                  attribute:boundary2
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:rootViewController.view
                                  attribute:boundary1
                                 multiplier:1.0
                                   constant:0]];
    
    // center the banner
    [rootViewController.view addConstraint:
     [NSLayoutConstraint constraintWithItem:adBanner_
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:rootViewController.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0
                                   constant:0]];
    
   adBanner_.translatesAutoresizingMaskIntoConstraints = NO;
    
    [rootViewController.view updateConstraintsIfNeeded];
    [rootViewController.view layoutSubviews];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
