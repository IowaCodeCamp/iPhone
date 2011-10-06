#import "SessionDateTransformer.h"

@implementation SessionDateTransformer

- (NSDate *) transformSessionTimeToDate:(NSString *)time {
    NSRange textRange;
    textRange =[[time lowercaseString] rangeOfString:[@":" lowercaseString]];
    
    if(textRange.location != NSNotFound)
    {
        NSRange range = NSMakeRange(0, textRange.location + 6);
        NSString* initTimeValue = [time substringWithRange: range];
        
        NSString* dateWithSessionStartTime = [NSString stringWithFormat:@"2011-01-01 %@", initTimeValue];
        
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd h:mm a"];
        
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:dateWithSessionStartTime];
        return dateFromString;
    }
    
    return nil;
}

@end
