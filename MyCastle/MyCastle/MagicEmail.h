//
//  MagicEmail.h
//  iMeeting
//
//  Created by Mike Litman on 1/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MagicEmail : MFMailComposeViewController <MFMailComposeViewControllerDelegate,UINavigationControllerDelegate> 
{
	BOOL isIphoneOS3;
}
-(id)init;
-(BOOL)canDisplayInsideApp;
-(void)setSubject:(NSString*)subject;
- (void)setMessageBody:(NSString*)body isHTML:(BOOL)isHTML;
- (void)setToRecipients:(NSArray*)toRecipients;
- (void)setCcRecipients:(NSArray*)ccRecipients;
- (void)setBccRecipients:(NSArray*)bccRecipients;
- (void)addAttachmentData:(NSData*)attachment mimeType:(NSString*)mimeType fileName:(NSString*)filename;
@end
