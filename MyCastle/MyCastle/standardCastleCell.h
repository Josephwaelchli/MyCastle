//
//  standardCastleCell.h
//  MyCastle
//
//  Created by Joseph on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface standardCastleCell : UITableViewCell
{
    
}
@property(nonatomic, strong)NSString* phoneNumber;
@property(nonatomic, strong)IBOutlet UILabel* addressLabel;
@property(nonatomic, strong)IBOutlet UILabel* nameLabel;

-(IBAction)phoneButtonPressed;

@end
