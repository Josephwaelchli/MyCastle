//
//  ResultsList.m
//  MyCastle
//
//  Created by Brandon Salter on 11/10/12.
//  Copyright (c) 2012 Pwn Industries. All rights reserved.
//

#import "ResultsList.h"
#import "ExternalConnector.h"
#import <MapKit/MapKit.h>
#import "standardCastleCell.h"
#import "DatabaseConnector.h"
#import "MyCastleCell.h"


#define YPURL @"http://api2.yp.com/listings/v1/search"
#define YPKEY @"02a7ad20207f46fa29fcbea568939b9e"

@interface ResultsList ()

@end

@implementation ResultsList
@synthesize theAppDel;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        databaseFinished = NO;
        yellowPagesFinished = NO;
    }
    return self;
}

-(id)initWithSearchTerm:(NSString*)sTerm
{
    self = [super init];
    if (self) {
        theAppDel = [[UIApplication sharedApplication] delegate];
        tableViewArray = [[NSArray alloc] init];
        ExternalConnector* sc = [[ExternalConnector alloc] initWithUrl:YPURL andMethod:@"GET"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchParsed:) name:@"YPSearchParsed" object:sc];
        
        CLLocation* theLocation = [[CLLocation alloc] initWithLatitude:43.038349 longitude:-87.927528];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:theLocation completionHandler:^(NSArray *placemarks, NSError *error) {
                zipCode = [[placemarks objectAtIndex:0] postalCode];
                [sc asynchronousUrlCall:[[NSDictionary alloc] initWithObjects:@[@"1", YPKEY, @"50", @"distance", zipCode, sTerm, @"20"] forKeys:@[@"phonesearch", @"key", @"radius", @"sort", @"searchloc", @"term", @"listingcount"]]];
                [self getGoldCompany];
        }];
    
    }
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    theTableView.bounces = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)getGoldCompany
{
        DatabaseConnector* dbc = [[DatabaseConnector alloc] init];
        NSString* queryString = [NSString stringWithFormat:@"SELECT * FROM gold_Business"];

    @try {
        NSDictionary* queryDict = [[NSDictionary alloc] initWithObjectsAndKeys:queryString, @"query", nil];
        
        UIImage *pImage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[[dbc getResultsFromQuery:queryDict] objectAtIndex:0] objectAtIndex:0] objectForKey:@"image"]]]];;
        
        NSArray* tempObjects = [[NSArray alloc] initWithObjects:[[[[dbc getResultsFromQuery:queryDict] objectAtIndex:0] objectAtIndex:0] objectForKey:@"name"],pImage,[[[[dbc getResultsFromQuery:queryDict] objectAtIndex:0] objectAtIndex:0] objectForKey:@"phone"],[[[[dbc getResultsFromQuery:queryDict] objectAtIndex:0] objectAtIndex:0] objectForKey:@"email"],[[[[dbc getResultsFromQuery:queryDict] objectAtIndex:0] objectAtIndex:0] objectForKey:@"address"], [[[[dbc getResultsFromQuery:queryDict] objectAtIndex:0] objectAtIndex:0] objectForKey:@"zips"],[[[[dbc getResultsFromQuery:queryDict] objectAtIndex:0] objectAtIndex:0] objectForKey:@"bbb_Link"],[[[[dbc getResultsFromQuery:queryDict] objectAtIndex:0] objectAtIndex:0] objectForKey:@"twitter"], nil];
        
        NSArray* tempKeys = [[NSArray alloc] initWithObjects:@"name",@"image",@"phone",@"email",@"address",@"zips",@"bbb_Link",@"twitter", nil];
        
        goldDict = [[NSDictionary alloc] initWithObjects:tempObjects forKeys:tempKeys];
    //pushing lol.
    }
    @catch (NSException* exception) {
        [self handleError:exception];
    }
    databaseFinished = YES;
    
    if(databaseFinished == YES && yellowPagesFinished == YES)
    {
        [theAppDel appStoppedLoading];
    }
}

#pragma mark table view delegation

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableViewArray count];
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSIndexPath *)indexPath
{    
    if(goldDict != nil)
    {
        return 120;//your height
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(goldDict != nil)
    {
        
    theTableView.scrollIndicatorInsets = UIEdgeInsetsMake(120, 0, 0, 0);        
    MyCastleCell* cell = [[MyCastleCell alloc] init];
    
    cell.phoneNumber = [goldDict objectForKey:@"phone"];
    cell.email = [goldDict objectForKey:@"email"];
    cell.addressLabel.text = [goldDict objectForKey:@"address"];
    cell.nameLabel.text = [goldDict objectForKey:@"name"];
    cell.theImage.image = [goldDict objectForKey:@"image"];
    cell.bbbLink = [goldDict objectForKey:@"bbb_Link"];
    cell.twitter = [goldDict objectForKey:@"twitter"];
        return cell;
    }
    else
    {
        return nil;
    }    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"standardCell";
    //RecordingsCell* cell = (RecordingsCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    standardCastleCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"standardCell"];
        //cell = [[standardCastleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"standardCell"];
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"standardCastleCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[standardCastleCell class]])
            {
                cell = (standardCastleCell *)currentObject;
                break;
            }
        }
    }
    
    NSDictionary* dict = [tableViewArray objectAtIndex:indexPath.row];
    cell.addressLabel.text = [NSString stringWithFormat:@"%@, %@, %@", [dict objectForKey:@"address"], [dict objectForKey:@"zip"], [dict objectForKey:@"state"]];
    cell.nameLabel.text = [dict objectForKey:@"name"];
    cell.phoneNumber = [dict objectForKey:@"phone"];
    //cell.textLabel.numberOfLines = 0;
    //cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@",[[tableViewArray objectAtIndex:indexPath.row] objectForKey:@"name"],[[tableViewArray objectAtIndex:indexPath.row] objectForKey:@"address"],[[tableViewArray objectAtIndex:indexPath.row] objectForKey:@"rating"]];
    
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

-(void) handleError:(NSException *)exception
{
    [[[UIAlertView alloc]initWithTitle:@"Warning" message:[NSString stringWithFormat:@"Error: %@", @"Failure connecting to database."] delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
    [theAppDel appStoppedLoading];
    [theAppDel.nc popViewControllerAnimated:YES];
}

#pragma mark notifications

-(void)searchParsed:(NSNotification *)notice
{
    ExternalConnector* sc = notice.object;
    tableViewArray = sc.items;
    NSLog(@"%@", tableViewArray);
    yellowPagesFinished = YES;
    [theTableView reloadData];
        
    if(databaseFinished == YES && yellowPagesFinished == YES)
    {
        [theAppDel appStoppedLoading];
    }
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
