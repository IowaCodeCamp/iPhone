#import <Foundation/Foundation.h>
#import "Speaker.h"

@interface Session : NSObject {
    NSString* time;
    NSString* session;
    NSString* desc;
    Speaker* speaker;
}

@property (nonatomic, retain) NSString* time;
@property (nonatomic, retain) NSString* session;
@property (nonatomic, retain) NSString* desc;
@property (nonatomic, retain) Speaker* speaker;

@end
