//
//  MainPage.m
//  MyCastle
//
//  Created by Brandon Salter on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import "MainPage.h"
#import "AppDelegate.h"
#import "DatabaseConnector.h"
#import "FacebookConnector.h"
#import <FacebookSDK/FacebookSDK.h>
#import "TwitterController.h"
#import "ResultsList.h"
#import "SocialConnector.h"

#define YPURL @"http://api2.yp.com/listings/v1/search"
#define YPKEY @"02a7ad20207f46fa29fcbea568939b9e"

@interface MainPage ()

@end

@implementation MainPage
@synthesize theAppDel;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        theAppDel = [[UIApplication sharedApplication] delegate];
    }
    return self;
}

#pragma mark IBActions

-(IBAction)loginFacebookButtonPressed
{
    if(![FacebookConnector isLoggedInToFacebook])
    {
        [FacebookConnector openSession];
    }
}

-(IBAction)twitterButtonPressed:(id)sender
{
    [self.navigationController pushViewController:[[TwitterController alloc] init] animated:YES];
    
    CLLocationCoordinate2D coord;
	coord.longitude = theAppDel.theMap.userLocation.coordinate.longitude;
	coord.latitude = theAppDel.theMap.userLocation.coordinate.latitude;
}

-(IBAction)resultsButtonPressed:(id)sender
{
    [self.navigationController pushViewController:[[ResultsList alloc] init] animated:YES];
}

-(IBAction)facebookLogoutButtonPressed
{
    [FacebookConnector closeSession];
    
}

-(IBAction)testButtonPressed
{
    SocialConnector* sc = [[SocialConnector alloc] initWithUrl:YPURL andMethod:@"GET"];
    [sc asynchronousUrlCall:[[NSDictionary alloc] initWithObjects:@[@"1", YPKEY, @"5", @"distance", @"53097", @"pizza"] forKeys:@[@"phonesearch", @"key", @"radius", @"sort", @"searchloc", @"term"]]];
}

#pragma mark view life-cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if([theAppDel hasInternetConnection])
    {
        DatabaseConnector* dbc = [[DatabaseConnector alloc] init];
        NSString* queryString = [NSString stringWithFormat:@"SELECT * FROM users"];
        NSDictionary* queryDict = [[NSDictionary alloc] initWithObjectsAndKeys:queryString, @"query", nil];
        NSString* userName = [[[[dbc getResultsFromQuery:queryDict] objectAtIndex:0] objectAtIndex:0] objectForKey:@"user_Name"];
        [theAppDel appStoppedLoading];
        
        [theLabel setText:[NSString stringWithFormat:@"%@",userName]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
