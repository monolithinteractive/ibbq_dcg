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

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, MKMapViewDelegate> {
  IBOutlet MKMapView * mapView;
  UIPopoverController * popoverController;
  UIToolbar * toolbar;
  
  
  StoreInfo * _store;
  UILabel * detailDescriptionLabel;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic, retain) StoreInfo * store;

@end
