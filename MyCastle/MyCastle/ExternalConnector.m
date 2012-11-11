//
//  SocialConnector.m
//  MyCastle
//
//  Created by Joseph on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import "ExternalConnector.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation ExternalConnector

-(id)initWithUrl:(NSString*)urlString andMethod:(NSString*)methodString
{
    self = [super init];
    url = urlString;
    method = methodString;
    self.items = [[NSMutableArray alloc] init];
    return self;
}

//execture an asynchronous call to an external 
-(void)asynchronousUrlCall:(NSDictionary*)callDict
{
    ASIFormDataRequest* formDataRequest = [[ASIFormDataRequest alloc] init];
    formDataRequest=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [formDataRequest setRequestMethod:method];
    if([formDataRequest.requestMethod isEqualToString:@"GET"])
    {
        [self setGetParameters:formDataRequest withParameters:callDict];
    }
    else
    {
        
    }
    __block ASIFormDataRequest* request = formDataRequest;
    [formDataRequest setCompletionBlock:^{
        NSLog(@"called.");
        //post notification
        NSData* data = [request responseData];
        NSXMLParser* xmlParse = [[NSXMLParser alloc] initWithData:data];
        xmlParse.delegate = self;
        xmlParse.shouldProcessNamespaces = YES;
        [xmlParse parse];
    }];
    [formDataRequest setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error: %@", error.localizedDescription);
    }];
    [formDataRequest startAsynchronous];
}

-(ASIFormDataRequest*)setGetParameters:(ASIFormDataRequest*)request withParameters:(NSDictionary*)dict
{
    NSString* getVars = @"?";
    for(NSString* key in dict)
    {
        NSString* value = [dict objectForKey:key];
        getVars = [NSString stringWithFormat:@"%@%@=%@&", getVars, key, value];
    }
    getVars = [getVars substringToIndex:[getVars length] - 1];
    request.url =  [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%@",request.url], getVars]];
    return request;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    @try
    {
        currentElement = [elementName copy];
        if ([elementName isEqualToString:@"searchListing"])
        {
            item = [[NSMutableDictionary alloc] init];
            currentPhone = [[NSMutableString alloc] init];
            currentStreet = [[NSMutableString alloc] init];
            currentBusiness = [[NSMutableString alloc] init];
            currentRatingCount = [[NSMutableString alloc] init];
            currentRating = [[NSMutableString alloc] init];
            currentZip = [[NSMutableString alloc] init];
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@", exception.reason);
    }
    @finally
    {
        // NSLog(@"finally");
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    @try
    {
        if ([elementName isEqualToString:@"searchListing"])
        {
            [item setObject:currentPhone forKey:@"phone"];
            [item setObject:currentBusiness forKey:@"name"];
            [item setObject:currentStreet forKey:@"address"];
            [item setObject:currentZip forKey:@"zip"];
            [item setObject:currentRating forKey:@"rating"];
            [item setObject:currentRatingCount forKey:@"numberOfRates"];
            
            [self.items addObject:[item copy]];
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@", exception.reason);
    }
    @finally
    {
        // NSLog(@"finally");
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    @try
    {
        if([currentElement isEqualToString:@"phone"])
        {
            [currentPhone appendString:string];
        }
        else if([currentElement isEqualToString:@"businessName"])
        {
            [currentBusiness appendString:string];
        }
        else if([currentElement isEqualToString:@"street"])
        {
            [currentStreet appendString:string];
        }
        else if([currentElement isEqualToString:@"zip"])
        {
            [currentZip appendString:string];
        }
        else if([currentElement isEqualToString:@"averageRating"])
        {
            [currentRating appendString:string];
        }
        else if([currentElement isEqualToString:@"ratingCount"])
        {
            [currentRatingCount appendString:string];
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@", exception.reason);
    }
    @finally
    {
        // NSLog(@"finally");
    }
}


-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    @try
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"YPSearchParsed" object:self];
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@", exception.reason);
    }
    @finally
    {
        // NSLog(@"parserDidEndDocument: finally\n");
    }

}

@end
