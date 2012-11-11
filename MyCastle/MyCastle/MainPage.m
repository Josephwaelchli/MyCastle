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
#import <FacebookSDK/FacebookSDK.h>
#import "TwitterController.h"
#import "ResultsList.h"
#import "ExternalConnector.h"

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
    /*if(![FacebookConnector isLoggedInToFacebook])
    {
        [FacebookConnector openSession];
    }*/
}

-(IBAction)twitterButtonPressed:(id)sender
{
    [self.navigationController pushViewController:[[TwitterController alloc] init] animated:YES];
}

-(IBAction)resultsButtonPressed:(id)sender
{
    [self.navigationController pushViewController:[[ResultsList alloc] init] animated:YES];
}

-(IBAction)facebookLogoutButtonPressed
{
    //[FacebookConnector closeSession];
    
}

-(IBAction)testButtonPressed
{
   
}

-(IBAction)mainButtonPressed:(id)sender
{
    UIButton* button = (UIButton*)sender;
    if([theAppDel hasInternetConnection])
    {
          //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General"]];
    [self.navigationController pushViewController:[[ResultsList alloc] initWithSearchTerm:[searchTermArray objectAtIndex:button.tag] andImage:button.imageView.image] animated:YES];
    }
}

#pragma mark view life-cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
