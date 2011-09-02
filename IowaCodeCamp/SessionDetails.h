//
//  SessionDetails.h
//  IowaCodeCamp
//
//  Created by Shelene Billups on 8/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Session;

@interface SessionDetails : UIViewController {
    Session* selectedSession;   
}

@property (nonatomic, retain) Session* selectedSession;

@end
