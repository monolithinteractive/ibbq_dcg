//
//  dcgAppDelegate.m
//  dcg
//
//  Created by Christina Moulton on 10-07-16.
//  Copyright Monolith Interactive 2010. All rights reserved.
//

#import "dcgAppDelegate.h"

@implementation dcgAppDelegate

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  
  // Override point for customization after app launch.
  
  // Add the split view controller's view to the window and display.
  [window addSubview:splitViewController.view];
  [window makeKeyAndVisible];
  
  return YES;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  [splitViewController release];
  [window release];
  [super dealloc];
}


@end

