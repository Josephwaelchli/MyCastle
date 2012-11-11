//
//  ResultsList.h
//  MyCastle
//
//  Created by Brandon Salter on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SocialConnector;

@interface ResultsList : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    //SocialConnector* externalConnector;
    
    IBOutlet UITableView* theTableView;
    
    NSArray* tableViewArray;
}

-(id)initWithSearchTerm:(NSString*)sTerm;

-(IBAction)backButtonPressed:(id)sender;

-(void)searchParsed:(NSNotification*)notice;

@end
