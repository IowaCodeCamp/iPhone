#import <Foundation/Foundation.h>

@class SessionWebService;
@class SessionDeserializer;

@interface SessionService : NSObject {
    UIViewController* viewController;
    SessionWebService* service;
    SessionDeserializer* deserializer;
}

@property (nonatomic, retain) UIViewController* viewController;
@property (nonatomic, retain) SessionWebService* service;
@property (nonatomic, retain) SessionDeserializer* deserializer;

- (id) initWithViewController:(UIViewController *)viewController;

- (void) getListOfSessions;
- (void) callbackWithListOfSessions:(NSString *)json;

@end
