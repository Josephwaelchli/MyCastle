//
//  AppDelegate.h
//  MyCastle
//
//  Created by Brandon Salter on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <MapKit/MapKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIAlertView *myAlertView;
}

//loading screens
@property(nonatomic) UIImageView* loadingImageView;
@property(nonatomic) UIView* loaderView;

-(void)appStartedLoading;
-(void)appStoppedLoading;
-(void)setUpLoader;

@property BOOL internetConnected;
@property(retain, nonatomic) Reachability* internetReachable;
-(void)checkNetworkStatus:(NSNotification*)notice;
-(BOOL)hasInternetConnection;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property(retain, nonatomic)UINavigationController* nc;

@property(retain, nonatomic)MKMapView* theMap;

@end
