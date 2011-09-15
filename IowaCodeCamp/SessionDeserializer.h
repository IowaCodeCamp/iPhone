#import <Foundation/Foundation.h>

@interface SessionDeserializer : NSObject {
    
}

- (NSArray *)parseJsonAndReturnSessions:(NSString *)html;

@end
