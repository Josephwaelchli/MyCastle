//
//  AppDelegate.m
//  MyCastle
//
//  Created by Brandon Salter on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import "AppDelegate.h"
#import "MainPage.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation AppDelegate
@synthesize window = _window, nc, loadingImageView, loaderView, internetConnected, internetReachable, theMap;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    nc = [[UINavigationController alloc] initWithRootViewController:[[MainPage alloc] init]];
    [nc setNavigationBarHidden:YES];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    //[self.window addSubview: nc.view];
    [self.window makeKeyAndVisible];

    //set up the loading screen which will be used throughout the app
    [self setUpLoader];
    
    NSLog(@"Testing");
    internetReachable = [Reachability reachabilityForInternetConnection];
	[internetReachable startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    [self checkNetworkStatus:nil];
    
    [self setUpMap];
    
    self.window.rootViewController = self.nc;


    //Set up the map for the "reach us page". It is done in the app delegate to give the app time to find the user's current location before they go to the map. Otherwise bad things happen.

    
    return YES;

}

- (void)setUpMap
{
    //initialize the map. This map is only used on the "ReachUsPage.m", but it must be initialized here because it takes a while to actually get the user's location. We need to make sure it already has the user's location by the time they click the map button in "ReachUsPage.m". Since it's here, it will start getting the users location right when the app starts.
    theMap = [[MKMapView alloc] init];
    
    theMap.showsUserLocation = YES;
}

-(void)appStartedLoading
{
    [loadingImageView startAnimating];
    [self.window addSubview:loaderView];
}

-(void)appStoppedLoading
{
    NSLog(@"here bitches");
    [loaderView removeFromSuperview];
    [loadingImageView stopAnimating];
}

-(void)setUpLoader
{
    loaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 460)];
    loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 227, 227)];
    NSArray* loadingArray=[[NSArray alloc] initWithObjects:
                           [UIImage imageNamed:@"animation1.png"],
                           [UIImage imageNamed:@"animation2.png"],
                           [UIImage imageNamed:@"animation3.png"],
                           [UIImage imageNamed:@"animation4.png"],
                           [UIImage imageNamed:@"animation5.png"],
                           [UIImage imageNamed:@"animation6.png"],
                           [UIImage imageNamed:@"animation7.png"],
                           [UIImage imageNamed:@"animation8.png"],
                           [UIImage imageNamed:@"animation9.png"],
                           [UIImage imageNamed:@"animation10.png"],
                           [UIImage imageNamed:@"animation11.png"],
                           [UIImage imageNamed:@"animation12.png"],
                           [UIImage imageNamed:@"animation13.png"],
                           [UIImage imageNamed:@"animation14.png"],
                           [UIImage imageNamed:@"animation15.png"],
                           [UIImage imageNamed:@"animation16.png"],
                           [UIImage imageNamed:@"animation17.png"],
                           [UIImage imageNamed:@"animation18.png"],
                           [UIImage imageNamed:@"animation19.png"],
                           [UIImage imageNamed:@"animation20.png"],
                           nil];
    loadingImageView.animationImages=loadingArray;
    loadingImageView.animationDuration=1.0;
    [loaderView setBackgroundColor:[UIColor colorWithWhite:0 alpha:.77]];
    loadingImageView.center=CGPointMake(loaderView.bounds.size.width/2, loaderView.bounds.size.height/2);
    [loaderView addSubview:loadingImageView];
}

-(void)checkNetworkStatus:(NSNotification*)notice
{
	NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
	switch (internetStatus)
	{
		case NotReachable:
		{
			self.internetConnected = NO;
			if (![myAlertView window])
			{
                myAlertView = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Please connect to an active internet network." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [myAlertView show];
            }
			break;
		}
		default:
		{
			self.internetConnected = YES;
			break;
			
		}
	}
}

-(BOOL)hasInternetConnection
{
    if(!self.internetConnected)
    {
        if (![myAlertView window])
        {
            myAlertView = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Please connect to an active internet network." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [myAlertView show];
        }
    }
    else
    {
        [NSThread detachNewThreadSelector:@selector(appStartedLoading) toTarget:self withObject:nil];
    }
    return self.internetConnected;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [FBSession.activeSession close];
}

@end
