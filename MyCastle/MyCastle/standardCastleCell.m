//
//  standardCastleCell.m
//  MyCastle
//
//  Created by Joseph on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//v

#import "standardCastleCell.h"

@implementation standardCastleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

-(IBAction)phoneButtonPressed
{
    NSString* newPhone = [self.phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* string = [@"tel://" stringByAppendingString:newPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

-(IBAction)bbbButtonPressed
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.bbb.org"]];
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
        [facebookController setInitialText:[NSString stringWithFormat:@"I found %@ on @MyCastleMKE, and they rock!", self.nameLabel.text]];
        //[twitterController addURL:[NSURL URLWithString:@"http://soulwithmobiletechnology.blogspot.com/"]];
        [facebookController setCompletionHandler:completionHandler];
        [parentController presentViewController:facebookController animated:YES completion:nil];
    }
}

-(IBAction)twitterButtonPressed
{
    
    parentController = [self firstAvailableUIViewController];

    SLComposeViewController* twitterController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
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
        [twitterController setInitialText:[NSString stringWithFormat:@"I found %@ on @MyCastleMKE, and they rock!", self.nameLabel.text]];
        //[twitterController addURL:[NSURL URLWithString:@"http://soulwithmobiletechnology.blogspot.com/"]];
        [twitterController setCompletionHandler:completionHandler];
        [parentController presentViewController:twitterController animated:YES completion:nil];
    }

}

@end
