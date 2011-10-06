#import <Foundation/Foundation.h>

@interface Speaker : NSObject {
    NSString* name;
    NSString* bio;
    NSString* img;
    NSString* web;
    NSString* location;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* bio;
@property (nonatomic, retain) NSString* img;
@property (nonatomic, retain) NSString* web;
@property (nonatomic, retain) NSString* location;

@end
