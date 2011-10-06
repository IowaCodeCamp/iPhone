#import <Foundation/Foundation.h>

@class IowaCodeCampAppDelegate;

@interface ConnectivityWebService : NSObject {
    NSMutableData* responseData;
    IowaCodeCampAppDelegate* appDelegate;
}

@property (nonatomic, retain) IowaCodeCampAppDelegate* appDelegate;
@property (nonatomic, retain) NSMutableData* responseData;

- (id) initWithAppDelegate:(IowaCodeCampAppDelegate *)apDelegate;
- (void) verifyConnectivity;

@end
