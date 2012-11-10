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
    
}

-(void)asynchronousUrlCall:(NSDictionary*)callDict;
-(ASIFormDataRequest*)setParameters:(ASIFormDataRequest*)request withParameters:(NSDictionary*)array;

@end
