//
//  dcgAppDelegate.h
//  dcg
//
//  Created by Christina Moulton on 10-07-16.
//  Copyright Monolith Interactive 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoresTableViewController.h"

@class DetailViewController;

@interface dcgAppDelegate : NSObject <UIApplicationDelegate> {
  
  IBOutlet UIWindow * window;
  
  IBOutlet UISplitViewController * splitViewController;
  IBOutlet StoresTableViewController * storeTableViewController;
  IBOutlet DetailViewController * detailViewController;
}

@end
