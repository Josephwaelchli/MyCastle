//
//  FacebookConnector.h
//  MyCastle
//
//  Created by Joseph on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
@class AppDelegate;

@interface FacebookConnector : NSObject <FBLoginViewDelegate>
{

}

+ (BOOL)isLoggedInToFacebook;
+(void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
+(void)openSession;
+(void)closeSession;
+(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

@end
