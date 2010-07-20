//
//  StoresTableViewController.m
//  dcg
//
//  Created by Christina Moulton on 10-07-18.
//  Copyright 2010 Monolith Interactive. All rights reserved.
//

#import "StoresTableViewController.h"
#import "JSON.h"
#import "StoreInfo.h"

@implementation StoresTableViewController

@synthesize stores = _stores;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.clearsSelectionOnViewWillAppear = NO;
  self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
  [self fetchStores];
}

- (void)fetchStores; {
  NSLog(@"fetch stores");
  _responseData = [[NSMutableData data] retain];
  _stores = [[NSArray array] retain];
  // TODO: get current location:
  NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://lcboapi.com/stores/near/N1H2T1"]];
  [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark NSURLConnection Delegate methods  
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {  
  NSLog(@"didReceiveResponse");
  [_responseData setLength:0];
}  

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {  
  NSLog(@"didReceiveData");
  [_responseData appendData:data];
}  

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {  
  NSLog(@"didFailWithError");
  NSLog(@"%@", [NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {  
  NSLog(@"didFinishLoading");
  [connection release];
  NSString * responseString = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];  
  [_responseData release];
  
  NSDictionary * results = [responseString JSONValue];
  for (NSString * key in [results allKeys]) {
    NSLog(@"key: %@", key);
  }
  
  _stores = [[results objectForKey:@"result"] retain];
  NSLog(@"store count: %d", [_stores count]);
  for (id storeInfos in _stores) {
    NSLog(@"%@", [storeInfos objectForKey:@"name"]);
  }
  
  NSLog(@"reloadData");
  [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Override to allow orientations other than the default portrait orientation.
  return ((interfaceOrientation == UIInterfaceOrientationLandscapeRight) || (interfaceOrientation == UIInterfaceOrientationLandscapeLeft));
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  NSLog(@"numberOfSections");
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSLog(@"numberOfRows");
  if (_stores != nil) {
    return [_stores count]; 
  }
  return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  //  NSLog(@"cellForRow");
  static NSString * CellIdentifier = @"Cell";
  
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
  if ((_stores != nil) && ([_stores count] > 0)) {
    id storeData = [_stores objectAtIndex:indexPath.row];
    if ([storeData isKindOfClass:[NSDictionary class]]) {
      NSDictionary * storeDictionary = (NSDictionary *)storeData;
      cell.textLabel.text = [storeDictionary objectForKey:@"name"];
    }    
  }
  return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ((_stores != nil) && ([_stores count] > 0)) {
    id storeData = [_stores objectAtIndex:indexPath.row];
    if ([storeData isKindOfClass:[NSDictionary class]]) {
      StoreInfo * store = [[StoreInfo alloc] initWithStoreDictionary:(NSDictionary *)storeData];
      detailViewController.store = store;
    }    
  }
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
  // For example: self.myOutlet = nil;
}


- (void)dealloc {
  if (_stores != nil) {
    [_stores release];
  }
  if (_responseData != nil) {
    [_responseData release];
  }
  [super dealloc];
}

@end

