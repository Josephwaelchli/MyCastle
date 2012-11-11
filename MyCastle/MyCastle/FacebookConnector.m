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
    AppDelegate* theAppDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    switch (state) {
        case FBSessionStateOpen: {
            
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            [theAppDel.nc popToRootViewControllerAnimated:NO];
            
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
    [FBSession openActiveSessionWithPublishPermissions:[[NSArray alloc] initWithObjects:@"publish_actions", nil] defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:YES completionHandler:^(FBSession *session,
                                                                                                                                                                                    FBSessionState state, NSError *error) {
        [self sessionStateChanged:session state:state error:error];
    }];
    /*[FBSession openActiveSessionWithReadPermissions:[[NSArray alloc] initWithObjects:@"publish_actions", nil]
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
    [FBSettings setLoggingBehavior:[NSSet setWithObjects:FBLoggingBehaviorFBRequests, FBLoggingBehaviorFBURLConnections, nil]];
    [FBRequestConnection
     startWithGraphPath:@"me/feed"
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
}

@end
