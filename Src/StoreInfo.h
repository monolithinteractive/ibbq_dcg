//
//  Store.h
//  dcg
//
//  Created by Christina Moulton on 10-07-18.
//  Copyright 2010 Monolith Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface StoreInfo : NSObject <MKAnnotation> {
  NSDictionary * _storeInfo;
  CLLocationCoordinate2D _coordinate;
}

@property (nonatomic, retain) NSDictionary * storeInfo;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (id)initWithStoreDictionary:(NSDictionary *)storeDictionary;

@end
