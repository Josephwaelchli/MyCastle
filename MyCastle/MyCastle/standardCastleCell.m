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

-(IBAction)phoneButtonPressed
{
    NSString* newPhone = [self.phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* string = [@"tel://" stringByAppendingString:newPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

@end
