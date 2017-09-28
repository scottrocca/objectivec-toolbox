//
//  StringReverserActivity.m
//  ToolBox
//
//  Created by Scott Rocca on 9/27/17.
//  Copyright © 2017 ScottRocca. All rights reserved.
//

#import "StringReverserActivity.h"

@interface StringReverserActivity()
@property (nonatomic, strong) NSArray *activityItems;
@property (strong, nonatomic) UIWindow *window;
@end

@implementation StringReverserActivity

-(NSString *) activityType{
    return [[NSBundle mainBundle].bundleIdentifier stringByAppendingFormat:@".%@", NSStringFromClass([self class])];
}

//Title to display in UIActivityViewController
-(NSString *) activityTitle{
    return @"Reverse String";
}

//Image to display in UIActivityVeiwController
-(UIImage *) activityImage{
    //iPad Retina image 110X110 iPHone Retina 86x86  iPad nonRet 55x55 iPhone nonRet 43x43
    return [UIImage imageNamed:@"Reverse"];
}

//Determine if you can handle all or one of the object types being sent to you
- (BOOL) canPerformWithActivityItems:(NSArray *)activityItems{
    for(id object in activityItems){
        if([object isKindOfClass:[NSString class]]){
            return YES;
        }
    }
    return NO;
}

//Called if YES is returned from canPerformWithActivityItems
//Retain the objects needed for later user
-(void) prepareWithActivityItems:(NSArray *)activityItems{
    NSMutableArray *stringObjects = [[NSMutableArray alloc] init];
    for(id object in activityItems){
        if([object isKindOfClass:[NSString class]]){
            [stringObjects addObject:object];
        }
    }
    
    self.activityItems = [stringObjects copy];
}

- (NSString *) reverseOfString:(NSString *)paramString{
    NSMutableString* reveresed = [[NSMutableString alloc] initWithCapacity:paramString.length];
    
    for (NSInteger counter = paramString.length -1; counter >= 0; counter--){
        [reveresed appendFormat:@"%c", [paramString characterAtIndex:counter]];
    }
    
    return [reveresed copy];
}

/*
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion NS_AVAILABLE_IOS(5_0){
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = viewControllerToPresent;
    [self.window makeKeyAndVisible];
}
 */

-(void) performActivity{
    NSMutableString *reversedStrings = [[NSMutableString alloc] init];
    
    for( NSString *string in self.activityItems){
        [reversedStrings appendString:[self reverseOfString:string]];
        [reversedStrings appendString:@"\n"];
    }
    /*
   //Need to figure out how to display an allert view in a UIActivity
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Reversed"
                                                                   message:reversedStrings
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {NSLog(@"OK was pressed");
                                                              [self activityDidFinish:YES];
                                                          }];

    
    //the order in which you add  actions determines their order in the resulting alert or action sheet.
    [alert addAction:defaultAction];
    //[self presentViewController:alert animated:YES completion:nil];
    */
    NSLog(@"%@", reversedStrings);

}

@end
