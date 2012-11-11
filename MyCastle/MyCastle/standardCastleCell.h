//
//  standardCastleCell.h
//  MyCastle
//
//  Created by Joseph on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Social/Social.h"

@interface standardCastleCell : UITableViewCell
{
    UIViewController* parentController;
}
@property(nonatomic, strong)NSString* phoneNumber;
@property(nonatomic, strong)IBOutlet UILabel* addressLabel;
@property(nonatomic, strong)IBOutlet UILabel* nameLabel;

-(IBAction)phoneButtonPressed;
-(IBAction)bbbButtonPressed;
-(IBAction)fbButtonPressed;
-(IBAction)twitterButtonPressed;

- (id) traverseResponderChainForUIViewController:(id)responder;
- (UIViewController *) firstAvailableUIViewController;

@end
