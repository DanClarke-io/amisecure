//
//  breachListViewController.m
//  amisecure
//
//  Created by Work on 25/02/2014.
//  Copyright (c) 2014 OverByThere. All rights reserved.
//

#import "breachListViewController.h"

@interface breachListViewController ()

@end

@implementation breachListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(int)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 1;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(ourBreachList) { return [ourBreachList count]; }
    return 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Breaches"];
    [[self view] setBackgroundColor:[UIColor blackColor]];
    [[self tableView] setSeparatorColor:[UIColor colorWithWhite:0.14 alpha:1.000]];
    getList = [[LazyInternet alloc] init];
    [getList startDownload:@"https://haveibeenpwned.com/api/v2/breaches" withDelegate:self withUnique:getList];
    
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBreach)];
    [[self navigationItem] setRightBarButtonItem:searchBtn];
    
	// Do any additional setup after loading the view.
}

-(void)searchBreach {
    NSLog(@"Search breach called");
}

-(UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    NSString *cellID = @"CellID";
    
    cell = [tv dequeueReusableCellWithIdentifier:cellID];
    if(cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        [[cell detailTextLabel] setTextColor:[UIColor colorWithWhite:0.422 alpha:1.000]];
        [[cell textLabel] setTextColor:[UIColor whiteColor]];
        [cell setBackgroundColor:[UIColor blackColor]];
    }
    if(ourBreachList) {
        NSDictionary *ourData = [ourBreachList objectAtIndex:indexPath.row];
        [[cell textLabel] setText:[ourData objectForKey:@"Title"]];
        [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Added %@",[ourData objectForKey:@"AddedDate"]]];
    }
    else { [[cell textLabel] setText:@"Loading..."]; }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(ourBreachList) {
        NSLog(@"%@",[ourBreachList objectAtIndex:indexPath.row]);
    }
}

- (void)lazyInternetDidLoad:(NSData*)data withUnique:(id)unique {
    ourBreachList = [getList dataToArr:data];
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
