//  LoginInfoController.h

#import <Foundation/Foundation.h>


@interface LoginInfoController : NSObject {
  NSString * _username;
  NSString * _password;
}

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;

@end
