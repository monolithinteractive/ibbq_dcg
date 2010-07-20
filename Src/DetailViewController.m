//
//  DetailViewController.m
//  dcg
//
//  Created by Christina Moulton on 10-07-16.
//  Copyright Monolith Interactive 2010. All rights reserved.
//

#import "DetailViewController.h"
#import "Tweeter.h"

@interface DetailViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@end



@implementation DetailViewController

@synthesize toolbar, popoverController, detailDescriptionLabel;
@synthesize store = _store;

#pragma mark -
#pragma mark Managing the detail item

/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setStore:(id)newStore {
  NSLog(@"setStore");
  if (_store != newStore) {
    if (_store != nil) {
      [storesMapView removeAnnotation:_store];
    }
    [_store release];
    _store = [newStore retain];
    
    // Update the view.
    [self configureView];
  }
  
  if (popoverController != nil) {
    [popoverController dismissPopoverAnimated:YES];
  }
}


- (void)configureView {
  // Update the user interface for the detail item.
  @try {
    detailDescriptionLabel.text = [_store title];
    twitterButton.hidden = (_store == nil);
    [storesMapView addAnnotation:_store];
    MKCoordinateRegion region;
    region.center = _store.coordinate;
    region.span.latitudeDelta = 0.005;
    region.span.longitudeDelta = 0.005;
    [storesMapView setRegion:region animated:YES];
  }
  @catch (NSException * e) {
    detailDescriptionLabel.text = @"";
  }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
  NSLog(@"didSelectAnnotationView");
  NSLog(@"class: %@", [view.annotation class]);
}

- (IBAction)tweet; {
  NSLog(@"tweet");
  Tweeter * tweeter = [[Tweeter alloc] init];
  [tweeter tweetStore:_store];
  [tweeter release];
}

#pragma mark -
#pragma mark Split view support

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
  
  barButtonItem.title = @"LCBO Stores";
  NSMutableArray *items = [[toolbar items] mutableCopy];
  [items insertObject:barButtonItem atIndex:0];
  [toolbar setItems:items animated:YES];
  [items release];
  self.popoverController = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
  
  NSMutableArray *items = [[toolbar items] mutableCopy];
  [items removeObjectAtIndex:0];
  [toolbar setItems:items animated:YES];
  [items release];
  self.popoverController = nil;
}


#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return ((interfaceOrientation == UIInterfaceOrientationLandscapeRight) || (interfaceOrientation == UIInterfaceOrientationLandscapeLeft));
}


#pragma mark -
#pragma mark View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  twitterButton.hidden = (_store == nil);
  storesMapView.delegate = self;
  storesMapView.showsUserLocation = YES;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
  NSLog(@"mapView didUpdateUserLocation");
  if ((userLocation.coordinate.latitude < 180.0) && (userLocation.coordinate.longitude < 180.0)) {
    MKCoordinateRegion region;
    region.center = userLocation.coordinate;
    region.span.latitudeDelta = 0.01;
    region.span.longitudeDelta = 0.01;
    [mapView setRegion:region animated:YES];
  }
}

- (void)viewDidUnload {
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
  self.popoverController = nil;
}


#pragma mark -
#pragma mark Memory management

/*
 - (void)didReceiveMemoryWarning {
 // Releases the view if it doesn't have a superview.
 [super didReceiveMemoryWarning];
 
 // Release any cached data, images, etc that aren't in use.
 }
 */

- (void)dealloc {
  [popoverController release];
  [toolbar release];
  
  [_store release];
  [detailDescriptionLabel release];
  [super dealloc];
}

@end
