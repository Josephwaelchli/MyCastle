//
//  MyCastleCell.m
//  MyCastle
//
//  Created by Joseph on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import "MyCastleCell.h"
#import "SA_OAuthTwitterEngine.h"

#define kOAuthConsumerKey        @"E38T2ButLdxRunj7RftYXw"
#define kOAuthConsumerSecret    @"fu6bZzefjaWJnZrXI5suBWyXqlOAwqfVH3dnuDn28"

@implementation MyCastleCell
@synthesize bbbLink, email;

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"MyCastleCell" owner:self options:nil] objectAtIndex:0];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark IBActions

-(IBAction)phoneButtonPressed
{
    NSString* string = [@"tel://" stringByAppendingString:self.phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

-(IBAction)emailButtonPressed
{
    //searchTermArray = @[@"Electric", @"Heating/Cooling", @"Roofing", @"Insulation", @"Garages", @"Doors/Windows", @"Appliances", @"Plumbing", @"Handyman"];
    
    NSString* newString = @"";
    
    if([self.whichSearch isEqualToString:@"Electric"])
    {
        newString = @"an electrical";
    }
    else if([self.whichSearch isEqualToString:@"Heating/Cooling"])
    {
        newString = @"a heating/cooling";
    }
    else if([self.whichSearch isEqualToString:@"Roofing"])
    {
        newString = @"a roofing";
    }
    else if([self.whichSearch isEqualToString:@"Insulation"])
    {
        newString = @"an insulation";
    }
    else if([self.whichSearch isEqualToString:@"Garages"])
    {
        newString = @"a garage";
    }
    else if([self.whichSearch isEqualToString:@"Doors/Windows"])
    {
        newString = @"a doors/windows";
    }
    else if([self.whichSearch isEqualToString:@"Appliances"])
    {
        newString = @"an appliances";
    }
    else if([self.whichSearch isEqualToString:@"Plumbing"])
    {
        newString = @"a plumbing";
    }
    else if([self.whichSearch isEqualToString:@"Handyman"])
    {
        newString = @"a handyman";
    }
    
    
    parentController = [self firstAvailableUIViewController];

    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"I found you on MyCastle!"];
        NSArray *toRecipients = [NSArray arrayWithObjects:email, nil];
        [mailer setToRecipients:toRecipients];
        //UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
        //NSData *imageData = UIImagePNGRepresentation(myImage);
        //[mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
        NSString *emailBody = [NSString stringWithFormat:@"I have %@ problem at my home. Please contact me as soon as possible.",newString];
        [mailer setMessageBody:emailBody isHTML:NO];
    
        //[parentController presentModalViewController:mailer animated:YES];
        [parentController presentViewController:mailer animated:YES completion:nil];

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (id) traverseResponderChainForUIViewController:(id)responder {
    if ([responder isKindOfClass:[UIViewController class]]) {
        return responder;
    } else if ([responder isKindOfClass:[UIView class]]) {
        return [self traverseResponderChainForUIViewController:[responder nextResponder]];
    } else if ([responder isKindOfClass:[UITableView class]]) {
        return [self traverseResponderChainForUIViewController:[responder nextResponder]];
    } else {
        return nil;
    }
}

- (UIViewController *) firstAvailableUIViewController {
    // convenience function for casting and to "mask" the recursive function
    return (UIViewController *)[self traverseResponderChainForUIViewController:[self nextResponder]];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    //[parentController dismissModalViewControllerAnimated:YES];
    [parentController dismissViewControllerAnimated:NO completion:nil];

}

-(IBAction)bbbButtonPressed
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:bbbLink]];
}

-(IBAction)fbButtonPressed
{
    parentController = [self firstAvailableUIViewController];
    
    SLComposeViewController* facebookController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
            
            [facebookController dismissViewControllerAnimated:YES completion:nil];
            
            switch(result){
                case SLComposeViewControllerResultCancelled:
                default:
                {
                    NSLog(@"Cancelled.....");
                    
                }
                    break;
                case SLComposeViewControllerResultDone:
                {
                    NSLog(@"Posted....");
                }
                    break;
            }};
        
        //[twitterController addImage:[UIImage imageNamed:@"1.jpg"]];
        [facebookController setInitialText:[NSString stringWithFormat:@"I found %@ (%@) on @MyCastleMKE, and they rock!", self.nameLabel.text,self.twitter]];
        //[twitterController addURL:[NSURL URLWithString:@"http://soulwithmobiletechnology.blogspot.com/"]];
        [facebookController setCompletionHandler:completionHandler];
        [parentController presentViewController:facebookController animated:YES completion:nil];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"No Facebook Account" message:@"You must be logged into Facebook to do that! Please go to your device settings and sign into Facebook." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    
}

-(IBAction)twitterButtonPressed
{
    parentController = [self firstAvailableUIViewController];

    /*if(![_engine isAuthorized])
    {
    if(!_engine){
        _engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
        _engine.consumerKey    = kOAuthConsumerKey;
        _engine.consumerSecret = kOAuthConsumerSecret;
    }
    UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:_engine delegate:self];
    if (controller){
        //[self presentModalViewController: controller animated: YES];
        [parentController presentViewController:controller animated:YES completion:nil];
    }
    }
    else
    {
        _engine 
        [_engine sendUpdate:[NSString stringWithFormat:@"I found %@ on @MyCastleMKE, and they rock!", self.nameLabel.text]];
    }*/
    SLComposeViewController *twitterController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
            
            [twitterController dismissViewControllerAnimated:YES completion:nil];
            
            switch(result){
                case SLComposeViewControllerResultCancelled:
                default:
                {
                    NSLog(@"Cancelled.....");
                    
                }
                    break;
                case SLComposeViewControllerResultDone:
                {
                    NSLog(@"Posted....");
                }
                    break;
            }};
        
        //[twitterController addImage:[UIImage imageNamed:@"1.jpg"]];
        [twitterController setInitialText:[NSString stringWithFormat:@"I found %@ (%@) on @MyCastleMKE, and they rock! %@", self.nameLabel.text,self.twitter, self.hashtag]];
        //[twitterController addURL:[NSURL URLWithString:@"http://soulwithmobiletechnology.blogspot.com/"]];
        [twitterController setCompletionHandler:completionHandler];
        [parentController presentViewController:twitterController animated:YES completion:nil];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"No Twitter Account" message:@"You must be logged into Twitter to do that! Please go to your device settings and sign into Twitter." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}


@end
