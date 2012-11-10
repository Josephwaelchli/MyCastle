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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(theAppDel.hasInternetConnection)
    {
        DatabaseConnector* dbc = [[DatabaseConnector alloc] init];
        NSString* queryString = [NSString stringWithFormat:@"SELECT * FROM users"];
        NSDictionary* queryDict = [[NSDictionary alloc] initWithObjectsAndKeys:queryString, @"query", nil];
        NSString* userName = [[[[dbc getResultsFromQuery:queryDict] objectAtIndex:0] objectAtIndex:0] objectForKey:@"user_Name"];
        [theAppDel appStoppedLoading];
        
        [theLabel setText:[NSString stringWithFormat:@"%@",userName]];
    }
}

-(IBAction)loginFacebookButtonPressed
{
    if(![FacebookConnector isLoggedInToFacebook])
    {
        [FacebookConnector openSession];
    }
    else
    {
        NSLog(@"already logged in");
    }
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
    [FacebookConnector closeSession];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
