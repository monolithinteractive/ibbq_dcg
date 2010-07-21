//  LoginInfoController.m

#import "LoginInfoController.h"


@implementation LoginInfoController

@synthesize username = _username;
@synthesize password = _password;

- (id) init {
  self = [super init];
  if (self) {  
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"login" ofType:@"plist"];
    NSString * errorDesc = nil;
    NSPropertyListFormat format;
    NSData * plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary * temp = (NSDictionary * )[NSPropertyListSerialization
                                            propertyListFromData:plistXML
                                            mutabilityOption:NSPropertyListMutableContainersAndLeaves                                     
                                            format:&format
                                            errorDescription:&errorDesc];
    if (!temp) {
      NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    self.username = [temp objectForKey:@"username"];
    self.password = [temp objectForKey:@"password"];
  }
  return self;
}

@end
