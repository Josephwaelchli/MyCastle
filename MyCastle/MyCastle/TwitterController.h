//
//  TwitterController.h
//  MyCastle
//
//  Created by Brandon Salter on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterController.h"
@class SA_OAuthTwitterEngine;

@interface TwitterController : UIViewController <UITextFieldDelegate, SA_OAuthTwitterControllerDelegate>
{
    SA_OAuthTwitterEngine    *_engine;
}
@property(nonatomic, retain) IBOutlet UITextField *tweetTextField;
-(IBAction)updateTwitter:(id)sender;
@end
