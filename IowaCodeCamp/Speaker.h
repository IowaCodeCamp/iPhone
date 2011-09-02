#import <Foundation/Foundation.h>

@interface Speaker : NSObject {
    NSString* name;
    NSString* title;
    NSString* bio;
    NSString* img;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* bio;
@property (nonatomic, retain) NSString* img;

@end
