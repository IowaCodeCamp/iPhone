#import <Foundation/Foundation.h>

@interface AddModalDialog : NSObject {
    
}

+ (void)buildModalDialogWithTextForView:(NSString *)text:(UIViewController *)controller;
+ (void)removeModalDialogForView:(UIViewController *)controller;

@end
