//
//  MyCastleCell.h
//  MyCastle
//
//  Created by Joseph on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "SA_OAuthTwitterController.h"
#import "Social/Social.h"

@interface MyCastleCell : UIView <MFMailComposeViewControllerDelegate, SA_OAuthTwitterControllerDelegate, UIAlertViewDelegate>
{
    UIViewController* parentController;
    SA_OAuthTwitterEngine    *_engine;
}

@property(strong, nonatomic)NSString* phoneNumber;
@property(strong, nonatomic)NSString* hashtag;
@property(strong, nonatomic)NSString* twitter;
@property(strong, nonatomic)NSString* bbbLink;
@property(strong, nonatomic)NSString* email;
@property(strong, nonatomic)IBOutlet UILabel* addressLabel;
@property(strong, nonatomic)IBOutlet UILabel* nameLabel;
@property(strong, nonatomic)IBOutlet UIImageView* theImage;

-(IBAction)phoneButtonPressed;
-(IBAction)emailButtonPressed;
-(IBAction)bbbButtonPressed;
-(IBAction)fbButtonPressed;
-(IBAction)twitterButtonPressed;

- (id) traverseResponderChainForUIViewController:(id)responder;
- (UIViewController *) firstAvailableUIViewController;

@end
