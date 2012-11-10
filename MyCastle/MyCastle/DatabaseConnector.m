//
//  DatabaseConnector.m
//  Good Club App
//
//  Created by Nick Ashenden on 1/5/12.
//  Copyright (c) 2012 Concordia University. All rights reserved.
//

#import "DatabaseConnector.h"

@implementation DatabaseConnector
@synthesize currentElementsArrayHolder, singleQueryArrayHolder, currArray;

-(NSMutableArray*)getResultsFromQuery:(NSDictionary*)query
{
    [self allocateSpaceAndReset];
    ASIFormDataRequest* newForm=[self getFormRequestFromDictionary:query];
    [newForm startSynchronous];
    [self parseTheRequest:newForm];
    return singleQueryArrayHolder;
}

-(void)allocateSpaceAndReset
{
    singleQueryArrayHolder=[[NSMutableArray alloc] init];
    currentElementsArrayHolder=[[NSMutableArray alloc] init];
    [singleQueryArrayHolder removeAllObjects];
    [currentElementsArrayHolder removeAllObjects];
    currArray=-1;
}

-(void)parseTheRequest:(ASIFormDataRequest*)formDataRequest
{
    NSXMLParser* xmlParser=[[NSXMLParser alloc] initWithData:[formDataRequest responseData]];
    [xmlParser setDelegate:self];
    if([xmlParser parse])
    {
        
    }
    else
    {
        NSLog(@"Parsing error:%@",[xmlParser parserError]);
    }
}

-(ASIFormDataRequest*)getFormRequestFromDictionary:(NSDictionary*)theDict
{
    ASIFormDataRequest* formDataRequest=[[ASIFormDataRequest alloc] init];
    formDataRequest=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:SQL_URL]];
    [formDataRequest setRequestMethod:@"POST"];
    
    for(NSString* theKey in [theDict allKeys])
    {
        [formDataRequest setPostValue:[theDict objectForKey:theKey] forKey:theKey];
    }
    return formDataRequest;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if(![elementName isEqualToString:@"top"])
    {
        [currentElementsArrayHolder addObject:elementName];
        NSMutableArray* saveObjects;
        for(NSString* jumpElements in currentElementsArrayHolder)
        {
            if([jumpElements isEqualToString:[currentElementsArrayHolder objectAtIndex:0]])
            {
                saveObjects=[singleQueryArrayHolder objectAtIndex:currArray];
            }
            else
            {
                saveObjects=[[saveObjects lastObject] objectForKey:jumpElements];
            }
        }
        for(NSString* theKey in [attributeDict allKeys])
        {
            if([[attributeDict objectForKey:theKey] isEqualToString:@"#NULL#"])
            {
                [attributeDict setValue:[[NSMutableArray alloc] init] forKey:theKey];
            }
        }
        [saveObjects addObject:attributeDict];
    }
    else
    {
        currArray++;
        [singleQueryArrayHolder addObject:[[NSMutableArray alloc] init]];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:[currentElementsArrayHolder lastObject]])
    {
        [currentElementsArrayHolder removeLastObject];
    }
}

-(BOOL)modifyQuery:(NSDictionary*)query
{
    ASIFormDataRequest* newForm=[self getFormRequestFromDictionary:query];
    [newForm startSynchronous];
    return ([[newForm responseString] isEqualToString:@"Success"] ? YES : NO);
}

-(int)insertUpdateQuery:(NSDictionary*)query
{
    ASIFormDataRequest* newForm=[self getFormRequestFromDictionary:query];
    [newForm startSynchronous];
    NSNumberFormatter* format = [[NSNumberFormatter alloc] init];
    [format numberFromString: [newForm responseString]];
    if([format numberFromString: [newForm responseString]] != nil )
    {
        return [[format numberFromString: [newForm responseString]] intValue];
    }
    else
    {
        return -1;
    }
}

@end
