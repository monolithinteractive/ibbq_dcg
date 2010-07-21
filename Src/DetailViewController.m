//
//  DetailViewController.m
//  dcg
//
//  Created by Christina Moulton on 10-07-16.
//  Copyright Monolith Interactive 2010. All rights reserved.
//

#import "DetailViewController.h"
#import "Tweeter.h"
#import "StoresTableViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize store = _store;

#pragma mark -
#pragma mark Managing the detail item

/*
 When setting the detail item, update the view.
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
}


- (void)configureView {
  // Update the user interface for the detail item.
  @try {
    _titleLabel.text = [_store title];
    twitterButton.hidden = (_store == nil);
    [storesMapView addAnnotation:_store];
    MKCoordinateRegion region;
    region.center = _store.coordinate;
    region.span.latitudeDelta = 0.005;
    region.span.longitudeDelta = 0.005;
    [storesMapView setRegion:region animated:YES];
  }
  @catch (NSException * e) {
    _titleLabel.text = @"";
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

- (CLLocationCoordinate2D)DCGCoordinate; {
  CLLocationCoordinate2D coordinate;
  coordinate.latitude = 43.545586;
  coordinate.longitude = -80.250524;
  return coordinate;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
  NSLog(@"mapView didUpdateUserLocation");
  CLLocationCoordinate2D userCoordinate;
#ifdef TARGET_IPHONE_SIMULATOR
  userCoordinate = [self DCGCoordinate];
#else
  userCoordinate = userLocation.coordinate;
#endif
  
  if ((userCoordinate.latitude < 180.0) && (userCoordinate.longitude < 180.0)) {
    MKCoordinateRegion region;
    region.center = userCoordinate;
    region.span.latitudeDelta = 0.01;
    region.span.longitudeDelta = 0.01;
    [mapView setRegion:region animated:YES];
  }
  storesList.userCoordinate = userCoordinate;
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
  [_store release];
  [_titleLabel release];
  [super dealloc];
}

@end
