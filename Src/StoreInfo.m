//
//  Store.m
//  dcg
//
//  Created by Christina Moulton on 10-07-18.
//  Copyright 2010 Monolith Interactive. All rights reserved.
//

#import "StoreInfo.h"


@implementation StoreInfo

@synthesize storeInfo = _storeInfo;
@synthesize coordinate = _coordinate;

- (id)initWithStoreDictionary:(NSDictionary *)storeDictionary; {
  if (self == [super init]) {
    _storeInfo = [storeDictionary retain];
    _coordinate.latitude = [[_storeInfo objectForKey:@"latitude"] doubleValue];
    _coordinate.longitude = [[_storeInfo objectForKey:@"longitude"] doubleValue];
  }
  return self;
}

- (NSString *)title; {
  return [_storeInfo objectForKey:@"name"];
}

@end
