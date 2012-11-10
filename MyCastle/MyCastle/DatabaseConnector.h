//
//  DatabaseConnector.h
//  Good Club App
//
//  Created by Nick Ashenden on 1/5/12.
//  Copyright (c) 2012 Concordia University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@interface DatabaseConnector : NSObject <NSXMLParserDelegate>

@property(retain, nonatomic)NSMutableArray* singleQueryArrayHolder;
@property(retain, nonatomic)NSMutableArray* currentElementsArrayHolder;
@property(nonatomic)int currArray;

-(NSMutableArray*)getResultsFromQuery:(NSDictionary*)query;
-(int)insertUpdateQuery:(NSDictionary*)query;
-(BOOL)modifyQuery:(NSDictionary*)query;
-(ASIFormDataRequest*)getFormRequestFromDictionary:(NSDictionary*)theDict;
-(void)parseTheRequest:(ASIFormDataRequest*)formDataRequest;
-(void)allocateSpaceAndReset;


@end
