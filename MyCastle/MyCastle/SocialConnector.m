//
//  SocialConnector.m
//  MyCastle
//
//  Created by Joseph on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import "SocialConnector.h"

@implementation SocialConnector

-(id)init
{
    self = [super init];
    return self;
}

//execture an asynchronous call to an external 
-(void)asynchronousUrlCall:(NSDictionary*)callDict
{
    ASIFormDataRequest* formDataRequest = [[ASIFormDataRequest alloc] init];
    formDataRequest=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[callDict objectForKey:@"url"]]];
    [formDataRequest setRequestMethod:[callDict objectForKey:@"method"]];
    
}

-(ASIFormDataRequest*)setParameters:(ASIFormDataRequest*)request withParameters:(NSDictionary*)dict
{
    NSString* getStart = @"?";
    for(NSString* key in dict)
    {
        NSString* value = [dict objectForKey:key];
        getStart = [NSString stringWithFormat:@"%@%@=%@", getStart, key, value];
    }
    
}

@end
