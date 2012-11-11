//
//  FBPosterView.m
//  MyCastle
//
//  Created by Joseph on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import "FBPosterView.h"
#import "FacebookConnector.h"

@interface FBPosterView ()

@end

@implementation FBPosterView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init
{
    self = [super init];
    /*@"https://developers.facebook.com/ios", @"link",
     @"https://developers.facebook.com/attachment/iossdk_logo.png", @"picture",*/
    self.postParams =
    [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"Facebook SDK for iOS", @"name",
     @"Build great social apps and get more installs.", @"caption",
     @"The Facebook SDK for iOS makes it easier and faster to develop Facebook integrated iOS apps.", @"description",
     nil];
    FacebookConnector* fb = [[FacebookConnector alloc] init];
    [fb openSession];
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark textview delegation

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // Clear the message text when the user starts editing
    if ([textView.text isEqualToString:@"Share to facebook..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    // Reset to placeholder text if the user is done
    // editing and no message has been entered.
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Share to facebook...";
    }
}

#pragma mark IBActions

-(IBAction)fbShareButtonPressed
{
    [[[FacebookConnector alloc] init] publishStory:self.postParams];
}

#pragma mark view life-cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
