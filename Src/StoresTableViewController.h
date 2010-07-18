//
//  StoresTableViewController.h
//  dcg
//
//  Created by Christina Moulton on 10-07-18.
//  Copyright 2010 Monolith Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface StoresTableViewController : UITableViewController {
  NSMutableData * _responseData;
  NSArray * _stores;
  
  IBOutlet DetailViewController * detailViewController;
}

@property (nonatomic, retain) NSArray * stores;

@end
