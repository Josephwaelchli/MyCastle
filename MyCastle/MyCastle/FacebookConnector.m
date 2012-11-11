//
//  FacebookConnector.m
//  MyCastle
//
//  Created by Joseph on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import "FacebookConnector.h"
#import "AppDelegate.h"

@implementation FacebookConnector

-(id)init
{
    self = [super init];
    return self;
}

-(BOOL)isLoggedInToFacebook
{
    NSLog(@"%u, %u", FBSession.activeSession.state, FBSessionStateCreatedTokenLoaded);
    //return FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded;
    if(FBSession.activeSession.isOpen)
    {
        NSLog(@"test");
    }
    else{
        NSLog(@"bad");
    }
    return FBSession.activeSession.isOpen;
}

//weird facebook methods taken from their examples lol. 
-(void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    NSLog(@"yay");
    //AppDelegate* theAppDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    switch (state) {
        case FBSessionStateOpen: {
            //[[FBSession activeSession] state] = FBSessionStateOpen;
            NSLog(@"yay");
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            ///[theAppDel.nc popToRootViewControllerAnimated:NO];
            NSLog(@"bad");
            [FBSession.activeSession closeAndClearTokenInformation];
            
            //[self showLoginView];
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

//also helps log into facebook.
-(void)openSession
{
    NSArray *permissions =
    [NSArray arrayWithObjects:@"email", nil];
    
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                      /* handle success + failure in block */
                                      [self sessionStateChanged:session state:status error:error];
                                  }];
    /*[FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                      [self sessionStateChanged:session state:state error:error];
                                  }];
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                      [self sessionStateChanged:session state:state error:error];
                                  }];
    
    [FBSession openActiveSessionWithPublishPermissions:[[NSArray alloc] initWithObjects:@"publish_actions", nil] defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:YES completionHandler:^(FBSession *session,
                                                                                                                                                                                    FBSessionState state, NSError *error) {
        [self sessionStateChanged:session state:state error:error];
    }];
    [FBSession openActiveSessionWithReadPermissions:[[NSArray alloc] initWithObjects:@"publish_actions", nil]
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];*/
}

//this pretty much logs into facebook.
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

//used for logging out.
-(void) closeSession
{
    [FBSession.activeSession closeAndClearTokenInformation];
}

-(void)publishStory:(NSDictionary*)post
{
    if(FBSession.activeSession.isOpen)
    {
        NSLog(@"test");
    }
    else{
        NSLog(@"bad");
    }
    
    NSArray* permissions = [NSArray arrayWithObjects:@"publish_actions", nil];
     
     [[FBSession activeSession] reauthorizeWithPublishPermissions:permissions
                                                  defaultAudience:FBSessionDefaultAudienceFriends
                                                completionHandler:^(FBSession *session, NSError *error) {
                                                    /* handle success + failure in block */
            }];
    
    BOOL displayedNativeDialog = [FBNativeDialogs
     presentShareDialogModallyFrom:self.vc
     initialText:@""
     image:nil
     url:nil
     handler:^(FBNativeDialogResult result, NSError *error) {
         if (error) {
             /* handle failure */
         } else {
             if (result == FBNativeDialogResultSucceeded) {
                 /* handle success */
             } else {
                 /* handle user cancel */
             }
         }
     }];
    if (!displayedNativeDialog) {
        /* handle fallback to native dialog  */
    }
     
   /*[FBSettings setLoggingBehavior:[NSSet setWithObjects:FBLoggingBehaviorFBRequests, FBLoggingBehaviorFBURLConnections, nil]];
    [FBRequestConnection
     startWithGraphPath:@"me/MyCastle"
     parameters:post
     HTTPMethod:@"POST"
     completionHandler:^(FBRequestConnection *connection,
                         id result,
                         NSError *error) {
         NSString *alertText;
         if (error) {
             alertText = [NSString stringWithFormat:
                          @"error: domain = %@, code = %d",
                          error.domain, error.code];
         } else {
             alertText = [NSString stringWithFormat:
                          @"Posted action, id: %@",
                          [result objectForKey:@"id"]];
         }
         // Show the result in an alert
         [[[UIAlertView alloc] initWithTitle:@"Result"
                                     message:alertText
                                    delegate:self
                           cancelButtonTitle:@"OK!"
                           otherButtonTitles:nil]
          show];
     }];
    
    [FBRequestConnection startForPostWithGraphPath:@"me/fb_sample_scrumps:eat"
                                       graphObject:id<FBGraphObject>
                                 completionHandler:^(FBRequestConnection *connection,
                                                     id result,
                                                     NSError *error) {
                                     if (!error) {
                                         [[[UIAlertView alloc] initWithTitle:@"Result"
                                                                     message:[NSString stringWithFormat:@"Posted Open Graph action, id: %@",
                                                                              [result objectForKey:@"id"]]
                                                                    delegate:nil
                                                           cancelButtonTitle:@"Thanks!"
                                                           otherButtonTitles:nil]
                                          show];
                                         
                                         // start over
                                         self.selectedMeal = nil;
                                         self.selectedPlace = nil;
                                         self.selectedFriends = nil;
                                         [self updateSelections];
                                     } else {
                                         // do we lack permissions here? If so, the application's policy is to reask for the permissions, and if
                                         // granted, we will recall this method in order to post the action
                                         if ([[error userInfo][FBErrorParsedJSONResponseKey][@"body"][@"error"][@"code"] compare:@200] == NSOrderedSame) {
                                             [FBSession.activeSession reauthorizeWithPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
                                                                                        defaultAudience:FBSessionDefaultAudienceFriends
                                                                                      completionHandler:^(FBSession *session, NSError *innerError) {
                                                                                          if (!innerError) {
                                                                                              // re-call assuming we now have the permission
                                                                                              [self postOpenGraphAction];
                                                                                          }
                                                                                          else{
                                                                                              // If we are here, this means the user has disallowed posting after a retry
                                                                                              // which means iOS 6.0 will have turned the app's slider to "off" in the
                                                                                              // device settings->Facebook.
                                                                                              // You may want to customize the message for your application, since this
                                                                                              // string is specifically for iOS 6.0.
                                                                                              [[[UIAlertView alloc] initWithTitle:@"Permission To Post Disallowed"
                                                                                                                          message:@"Use device settings->Facebook to re-enable permission to post."
                                                                                                                         delegate:nil
                                                                                                                cancelButtonTitle:@"Thanks!"
                                                                                                                otherButtonTitles:nil]
                                                                                               show];
                                                                                          }
                                                                                      }];
                                         } else {
                                             [[[UIAlertView alloc] initWithTitle:@"Result"
                                                                         message:[NSString stringWithFormat:@"error: domain = %@, code = %@(%d)",
                                                                                  error.domain,
                                                                                  [SCAppDelegate FBErrorCodeDescription:error.code],
                                                                                  error.code]
                                                                        delegate:nil
                                                               cancelButtonTitle:@"Thanks!"
                                                               otherButtonTitles:nil]
                                              show];
                                         }
                                     }
                                 }];*/

}

@end
