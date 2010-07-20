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

- (void)tweetStore:(StoreInfo *)store; {
  NSLog(@"tweetStore");
  NSString * username = @"iBBQ_DCG";
  NSString * password = @"Grillem!";
  NSMutableString * status = [NSMutableString stringWithFormat:@"Outta beer! Quick, grab Corona at %@ and come get some ribs!", store.title];
  [status replaceOccurrencesOfString:@"&" withString:@"and" options:NSBackwardsSearch range:NSMakeRange(0, [status length])];
  NSLog(@"status: %@", status);
  NSString * post = [NSString stringWithFormat:@"status=%@", [status stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  NSData * postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
  
  NSString * postLength = [NSString stringWithFormat:@"%d", [postData length]];
  NSLog(@"postLength: %@", postLength);
  // TODO: check/warn on post length
  NSMutableURLRequest * request = [[[NSMutableURLRequest alloc] init] autorelease];
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
}  

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {  
  NSLog(@"didReceiveData");
}  

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {  
  NSLog(@"didFailWithError: %@", [NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {  
  NSLog(@"didFinishLoading");
}



@end
