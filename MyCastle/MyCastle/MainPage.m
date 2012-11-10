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
#import "TwitterController.h"

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
        
        //set the phoneNumberTextView to the phone number string. The textview on the nib automatically detects phone numbers, so if you click the number, it will give you the option to call that number.
        [theLabel setText:[NSString stringWithFormat:@"%@",userName]];
    }
}

-(IBAction)twitterButtonPressed:(id)sender
{
    [self.navigationController pushViewController:[[TwitterController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
