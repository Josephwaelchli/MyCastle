//
//  MyCastleCell.m
//  MyCastle
//
//  Created by Joseph on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import "MyCastleCell.h"
#import "FacebookConnector.h"

@implementation MyCastleCell

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

#pragma mark IBActions

-(IBAction)phoneButtonPressed
{
    NSString* string = [@"tel://" stringByAppendingString:self.phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

-(IBAction)emailButtonPressed
{
    //open e-mail client?
    
}

-(IBAction)bbbButtonPressed
{
    //open webview?
    
}

-(IBAction)fbButtonPressed
{
    //post to facebook.
    /*if([FacebookConnector isLoggedInToFacebook])
    {
        
    }*/
}

-(IBAction)twitterButtonPressed
{
    //tweet
    
}

@end
