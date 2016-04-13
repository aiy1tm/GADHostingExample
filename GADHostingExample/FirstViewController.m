//
//  FirstViewController.m
//  GADHostingExample
//
//  Created by Scott Sullivan on 4/12/16.
//  Copyright © 2016 Scott Sullivan. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.shouldShowBannerAds=YES;
    self.showAdsOnTop = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
