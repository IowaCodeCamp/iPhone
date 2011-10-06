#import "SpecialSessionIdentifier.h"

@implementation SpecialSessionIdentifier

- (BOOL *) sessionNameRequiresSpecialTreatment:(NSString *)sessionName {
    if ([sessionName isEqualToString:@"Breakfast"]) {
        return YES;
    }
    if ([sessionName isEqualToString:@"Welcome and announcements"]) {
        return YES;
    }
    if ([sessionName isEqualToString:@"Break"]) {
        return YES;
    }
    if ([sessionName isEqualToString:@"Lunch"]) {
        return YES;
    } 
    if ([sessionName isEqualToString:@"Closing and Prizes"]) {
        return YES;
    }
    
    return NO;
}

@end
