//
//  SocialConnector.h
//  MyCastle
//
//  Created by Joseph on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface SocialConnector : NSObject
{
    NSString* url;
    NSString* method;
}

-(id)initWithUrl:(NSString*)urlString andMethod:(NSString*)methodString;
-(void)asynchronousUrlCall:(NSDictionary*)callDict;
-(ASIFormDataRequest*)setGetParameters:(ASIFormDataRequest*)request withParameters:(NSDictionary*)array;

@end
