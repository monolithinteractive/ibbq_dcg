//
//  Tweeter.h
//  dcg
//
//  Created by Christina Moulton on 10-07-18.
//  Copyright 2010 Monolith Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreInfo.h"

@interface Tweeter : NSObject {
  
}

- (BOOL)login;
- (void)tweetStore:(StoreInfo *)store;

@end
