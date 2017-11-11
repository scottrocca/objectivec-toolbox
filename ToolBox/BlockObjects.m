//
//  BlockObjects.m
//  ToolBox
//
//  Created by Scott Rocca on 11/1/17.
//  Copyright © 2017 ScottRocca. All rights reserved.
//

#import "BlockObjects.h"

@implementation BlockObjects
/*
 A block object can be defined inline or treated as a separate block of code. When created inline, the scope of variables accessible to block objects is considerably different from when a block object is implemented as a separate block.
 */

//Separate Blocks:
//The following Objective-C method
- (NSInteger) subtract:(NSInteger)paramValue from:(NSInteger)paramFrom{
    return paramFrom - paramValue;
}

//Gets coded as a block object :
NSInteger (^subtractBlock)(NSInteger, NSInteger) = ^(NSInteger paramValue, NSInteger paramFrom){
    return paramFrom - paramValue;
};

//The following Objective-C method
NSString *intToString(NSUInteger paramInteger){
    return [NSString stringWithFormat:@"%lu", (unsigned long)paramInteger];
}

//Gets coded as a block object :
NSString* (^intToStringBlock)(NSUInteger) = ^(NSUInteger paramInteger){
    return [NSString stringWithFormat:@"%lu", (unsigned long)paramInteger];
};

//Simplist from of an independent block would be a block object that returns void and does not take in any parameters
void (^simpleBlock)(void) = ^{
    //Implementation
    };

//Calling a block
- (void) callIntToString{
    __unused NSString *string = intToStringBlock(10);
}

//Passing Block Object as parameter

@end
