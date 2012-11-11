//
//  MyCastleCell.h
//  MyCastle
//
//  Created by Joseph on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface MyCastleCell : UIView <MFMailComposeViewControllerDelegate>
{
    UIViewController* parentController;
}

@property(strong, nonatomic)NSString* phoneNumber;
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
