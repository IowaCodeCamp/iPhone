//
//  SessionDeserializer.h
//  IowaCodeCamp
//
//  Created by Shelene Billups on 8/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SessionDeserializer : NSObject {
    
}

- (NSArray *)parseJsonAndReturnSessions:(NSString *)html;

@end
