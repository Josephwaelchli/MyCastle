//
//  ResultsList.h
//  MyCastle
//
//  Created by Brandon Salter on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ExternalConnector;
#import "AppDelegate.h"

@interface ResultsList : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    //SocialConnector* externalConnector;
    
    IBOutlet UITableView* theTableView;
    NSString* zipCode;
    bool databaseFinished;
    bool yellowPagesFinished;
    NSArray* tableViewArray;
    NSDictionary* goldDict;
}

@property (nonatomic,retain) AppDelegate* theAppDel;

-(id)initWithSearchTerm:(NSString*)sTerm;

-(IBAction)backButtonPressed:(id)sender;

-(void)handleError:(NSException*)exception;

-(void)searchParsed:(NSNotification*)notice;
- (void)getGoldCompany;

@end
