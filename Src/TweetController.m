//
//  Tweeter.m
//  dcg
//
//  Created by Christina Moulton on 10-07-18.
//  Copyright 2010 Monolith Interactive. All rights reserved.
//

#import "TweetController.h"
#import "JSON.h"
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>

@implementation TweetController

- (void)showTweetStatus:(NSNumber *)boolNumber; {
  bool tweetSent = [boolNumber boolValue];
  if (tweetSent == true) {
    [[[UIAlertView alloc] initWithTitle:@"Sent Tweet" message:@"Your call for beer has been sent out." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
  } else {
    [[[UIAlertView alloc] initWithTitle:@"Error Sending Tweet" message:@"Your call for beer could not be sent out." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
  }
}

- (void)tweetStore:(StoreInfo *)store; {
  NSLog(@"tweetStore");
  NSMutableString * status = [NSMutableString stringWithFormat:@"Outta beer! Quick, grab Corona at %@ and come get some ribs!", store.title];
  [status replaceOccurrencesOfString:@"&" withString:@"and" options:NSBackwardsSearch range:NSMakeRange(0, [status length])];

  // from http://mobiledevelopertips.com/core-services/ios-5-twitter-framework-part-2.html
  if ([TWTweetComposeViewController canSendTweet]) 
  {
    // Create account store, followed by a twitter account identifier
    // At this point, twitter is the only account type available
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    
    // Request access from the user to access their Twitter account
    [account requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) 
     {
       // Did user allow us access?
       if (granted == YES)
       {
         // Populate array with all available Twitter accounts
         NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
         
         // Sanity check
         if ([arrayOfAccounts count] > 0) 
         {
           // Keep it simple, use the first account available
           ACAccount *acct = [arrayOfAccounts objectAtIndex:0];
           
           // Build a twitter request
           TWRequest *postRequest = [[TWRequest alloc] initWithURL:
                                     [NSURL URLWithString:@"http://api.twitter.com/1/statuses/update.json"] 
                                               parameters:[NSDictionary dictionaryWithObject:status 
                                                   forKey:@"status"] requestMethod:TWRequestMethodPOST];
           
           // Post the request
           [postRequest setAccount:acct];
           
           // Block handler to manage the response
           [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) 
            {
              NSLog(@"Twitter response, HTTP response: %i", [urlResponse statusCode]);
              bool tweetSent = ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300);
              NSNumber * tweetSentObject = [NSNumber numberWithBool:tweetSent];
              [self performSelectorOnMainThread:@selector(showTweetStatus:) withObject:tweetSentObject waitUntilDone:YES];
            }];
         }
       }
     }];
  }
}

@end
