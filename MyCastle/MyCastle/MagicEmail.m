//
//  MagicEmail.m
//  iMeeting
//
//  Created by Mike Litman on 1/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MagicEmail.h"


@implementation MagicEmail
-(id)init
{
	self = [super init];
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		isIphoneOS3 = YES;
		self.mailComposeDelegate = self;
	}
	else
	{
		isIphoneOS3 = NO;
	}
	return self;
}

- (void)setMessageBody:(NSString*)body isHTML:(BOOL)isHTML
{
	[super setMessageBody:body isHTML:isHTML];
}
- (void)addAttachmentData:(NSData*)attachment mimeType:(NSString*)mimeType fileName:(NSString*)filename
{
	[super addAttachmentData:attachment mimeType:mimeType fileName:filename];
}
- (void)setBccRecipients:(NSArray*)bccRecipients
{
	[super setBccRecipients:bccRecipients];
}
- (void)setCcRecipients:(NSArray*)ccRecipients
{
	[super setCcRecipients:ccRecipients];
}

- (void)setToRecipients:(NSArray*)toRecipients
{
	[super setToRecipients:toRecipients];
}

-(void)setSubject:(NSString*)subject
{
	[super setSubject:subject];
}

-(BOOL)canDisplayInsideApp
{
	return isIphoneOS3;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	//[self.parentViewController dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeEmail" object:self];
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

-(void)viewWillAppear:(BOOL)animated
{
    //[self shouldAutorotateToInterfaceOrientation:self.interfaceOrientation];
}
// Override to allow orientations other than the default portrait orientation.
/*- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}*/


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


@end
