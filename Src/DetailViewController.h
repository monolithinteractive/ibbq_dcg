//
//  DetailViewController.h
//  dcg
//
//  Created by Christina Moulton on 10-07-16.
//  Copyright Monolith Interactive 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "StoreInfo.h";
@class StoresTableViewController;

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, MKMapViewDelegate> {
  IBOutlet MKMapView * storesMapView;
  IBOutlet StoresTableViewController * storesList;
  
  StoreInfo * _store;
  IBOutlet UILabel * _titleLabel;
  
  IBOutlet UIButton * twitterButton;
}

@property (nonatomic, retain) StoreInfo * store;

- (IBAction)tweet;

@end
