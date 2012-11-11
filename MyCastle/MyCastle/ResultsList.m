//
//  ResultsList.m
//  MyCastle
//
//  Created by Brandon Salter on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import "ResultsList.h"
#import "SocialConnector.h"

#define YPURL @"http://api2.yp.com/listings/v1/search"
#define YPKEY @"02a7ad20207f46fa29fcbea568939b9e"

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

-(id)initWithSearchTerm:(NSString*)sTerm
{
    self = [super init];
    if (self) {
        SocialConnector* sc = [[SocialConnector alloc] initWithUrl:YPURL andMethod:@"GET"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchParsed:) name:@"YPSearchParsed" object:sc];
        
        [sc asynchronousUrlCall:[[NSDictionary alloc] initWithObjects:@[@"1", YPKEY, @"5", @"distance", @"53097", sTerm] forKeys:@[@"phonesearch", @"key", @"radius", @"sort", @"searchloc", @"term"]]];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark table view delegation

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"UITableViewCell";
    //RecordingsCell* cell = (RecordingsCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
       /* NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RecordingsCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                //cell = (RecordingsCell*)currentObject;
                break;
            }
        }*/
    }
    
    /*[cell.recordingNameLabel setText:[[theXmlData objectAtIndex:indexPath.row] objectForKey:@"date"]];
    [cell.colorLabel setText:[[theXmlData objectAtIndex:indexPath.row] objectForKey:@"color"]];
    
    if([cell.colorLabel.text isEqualToString:@"green"])
    {
        cell.colorLabel.textColor = [UIColor greenColor];
    }
    else
    {
        cell.colorLabel.textColor = [UIColor redColor];
    }*/
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*if(theAppDelegate.hasInternetConnection)
    {
        NSString* theUrlString = [NSString stringWithFormat:@"https://www.afibalert.com/db/applink.php?username=%@&password=%@&strip=%@",userName,password,[[theXmlData objectAtIndex:indexPath.row] objectForKey:@"strip"]];
        //NSLog(@"%@",theUrlString);
        //NSString* theUrlString = @"http://www.irs.gov/pub/irs-pdf/fw4.pdf";
        
        NSURL *url = [NSURL URLWithString:theUrlString];
        
        [self.navigationController pushViewController:[[PdfViewer alloc] initWithPdf:url] animated:YES];
    }*/
}

#pragma mark notifications

-(void)searchParsed:(NSNotification *)notice
{
    SocialConnector* sc = notice.object;
    tableViewArray = sc.items;
    NSLog(@"%@", tableViewArray);
}

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
