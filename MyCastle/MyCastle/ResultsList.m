//
//  ResultsList.m
//  MyCastle
//
//  Created by Brandon Salter on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import "ResultsList.h"

@interface ResultsList ()

@end

@implementation ResultsList

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"RecordingsCell";
    RecordingsCell* cell = (RecordingsCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RecordingsCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[RecordingsCell class]])
            {
                cell = (RecordingsCell*)currentObject;
                break;
            }
        }
    }
    
    [cell.recordingNameLabel setText:[[theXmlData objectAtIndex:indexPath.row] objectForKey:@"date"]];
    [cell.colorLabel setText:[[theXmlData objectAtIndex:indexPath.row] objectForKey:@"color"]];
    
    if([cell.colorLabel.text isEqualToString:@"green"])
    {
        cell.colorLabel.textColor = [UIColor greenColor];
    }
    else
    {
        cell.colorLabel.textColor = [UIColor redColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(theAppDelegate.hasInternetConnection)
    {
        NSString* theUrlString = [NSString stringWithFormat:@"https://www.afibalert.com/db/applink.php?username=%@&password=%@&strip=%@",userName,password,[[theXmlData objectAtIndex:indexPath.row] objectForKey:@"strip"]];
        //NSLog(@"%@",theUrlString);
        //NSString* theUrlString = @"http://www.irs.gov/pub/irs-pdf/fw4.pdf";
        
        NSURL *url = [NSURL URLWithString:theUrlString];
        
        [self.navigationController pushViewController:[[PdfViewer alloc] initWithPdf:url] animated:YES];
    }
}*/


-(IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
