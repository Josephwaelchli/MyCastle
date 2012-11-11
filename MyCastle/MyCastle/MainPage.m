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
        searchTermArray = @[@"Electric", @"Heating/Cooling", @"Roofing", @"Insulation", @"Garages", @"Doors/Windows", @"Appliances", @"Plumbing", @"Handyman"];
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
    //[self.navigationController pushViewController:[[TwitterController alloc] init] animated:YES];
    
    //CLLocation* theLocation = [[CLLocation alloc] initWithLatitude:theAppDel.theMap.userLocation.coordinate.latitude longitude:theAppDel.theMap.userLocation.coordinate.latitude];
    CLLocation* theLocation = [[CLLocation alloc] initWithLatitude:43.038349 longitude:-87.927528];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:theLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSLog(@"Reverse geocoding finished");
        
        NSLog(@"%@",[[placemarks objectAtIndex:0] postalCode]);
        
    }];
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
   
}

-(IBAction)mainButtonPressed:(id)sender
{
    UIButton* button = (UIButton*)sender;
    [self.navigationController pushViewController:[[ResultsList alloc] initWithSearchTerm:[searchTermArray objectAtIndex:button.tag]] animated:YES];
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
