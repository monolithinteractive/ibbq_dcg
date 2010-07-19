//
//  Tweeter.m
//  dcg
//
//  Created by Christina Moulton on 10-07-18.
//  Copyright 2010 Monolith Interactive. All rights reserved.
//

#import "Tweeter.h"
#import "JSON.h"

@implementation Tweeter

- (BOOL)login; {
  NSLog(@"login");
  /*  NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL: [NSURL 
   URLWithString: @”http:\\\\iBBQ_DCG:iBBQ_DCG@twitter.com\\statuses\\update.xml”]
   cachePolicy:NSURLRequestUseProtocolCachePolicy
   timeoutInterval: 60. 0] ;
   [theRequest setHTTPMethod: @”POST”] ;
   [theRequest setHTTPBody: [[NSString stringWithFormat: @”status=%@”, 
   themessage] dataUsingEncoding: NSASCIIStringEncoding] ] ;
   NSURLResponse* response;
   NSError* error;
   NSData* result = [NSURLConnection sendSynchronousRequest:theRequest 
   returningResponse: &response error: &error] ;
   NSLog( @”%@”, [[[ NSString alloc] initWithData: result 
   encoding: NSASCIIStringEncoding] autorelease] ) ;  */
  return YES;
}

- (void)tweetStore:(StoreInfo *)store; {
  NSLog(@"tweetStore");
  NSString * username = @"iBBQ_DCG";
  NSString * password = @"Grillem!";
  NSString * status = @"Just grilled up some great peppercorn ribs.";
  NSString *post = [NSString stringWithFormat:@"status=%@", [status stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
  
  NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
  
  NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
  NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@@%@/statuses/update.json", username, password, @"twitter.com"]];
  [request setURL:url];
  [request setHTTPMethod:@"POST"];
  [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
  [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  [request setHTTPBody:postData];
  [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
  [request setTimeoutInterval:30.0];
  
  [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark NSURLConnection Delegate methods  
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {  
  NSLog(@"didReceiveResponse");
//  [_responseData setLength:0];
}  

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {  
  NSLog(@"didReceiveData");
//  [_responseData appendData:data];
}  

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {  
  NSLog(@"didFailWithError");
//  NSLog(@"%@", [NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {  
  NSLog(@"didFinishLoading");
/*  [connection release];
  NSString * responseString = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];  
  [_responseData release];
  
  NSDictionary * results = [responseString JSONValue];
  for (NSString * key in [results allKeys]) {
    NSLog(@"key: %@", key);
  }
  
  _stores = [[results objectForKey:@"result"] retain];
  NSLog(@"store count: %d", [_stores count]);
  for (id storeInfos in _stores) {
    NSLog(@"%@", [storeInfos objectForKey:@"name"]);
  }
  
  NSLog(@"reloadData");
  [self.tableView reloadData];*/
}



@end
