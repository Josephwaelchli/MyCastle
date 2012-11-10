//
//  TwitterController.m
//  MyCastle
//
//  Created by Brandon Salter on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import "TwitterController.h"
#import "SA_OAuthTwitterEngine.h"

@interface TwitterController ()

@end

#define kOAuthConsumerKey        @"E38T2ButLdxRunj7RftYXw"
#define kOAuthConsumerSecret    @"fu6bZzefjaWJnZrXI5suBWyXqlOAwqfVH3dnuDn28"

@implementation TwitterController
@synthesize tweetTextField;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)updateTwitter:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
