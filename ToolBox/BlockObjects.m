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
    NSLog(@"string = %@", string);
}

#pragma mark - Passing as a parameter
//Passing Block Object as parameter
//To tell a method that it has to accept a block object of the same type as the intToString block object, first you typedef the signature of the intoToString block object, which tesll the compiler what parameters the block object should accept
typedef NSString* (^IntToStringConverter)(NSUInteger paramInteger);
//This typedef just tells the compiler that block objects that accept an integer parameter and return a string can simply be represented by an identifier named IntToStringConverter.

//The Method that accepts a block object of type IntToStringConverter
-(NSString *) convertIntToString:(NSUInteger)paramInteger usingBlockObject:(IntToStringConverter)paramBlockObject{
    return paramBlockObject(paramInteger);
}

//Calling the convertIntToString: method with the block object of choice
-(void) doTheConverstion{
    NSString *result = [self convertIntToString:123 usingBlockObject:intToStringBlock];
    NSLog(@"result = %@", result);
}

#pragma mark - Inline
//Inline block Objects

//In the doTheConversion method we passed the intToString block object as the parameter to the convertIntToString:usingBlockObject: method.
//If we didn't have a block object ready to be passed to the method we would use inline block object since block objects are first-class functions and can be converted at runtime

- (void) doTheConverstionInLine{
    IntToStringConverter inlineConverter = ^(NSUInteger paramInteger){
        NSString *result = [NSString stringWithFormat:@"%lu", (unsigned long)paramInteger];
        return result;
    };
    
    NSString *result = [self convertIntToString:123 usingBlockObject:inlineConverter];
    
    NSLog(@"result = %@", result);
    
}

#pragma mark - block object as a parameter
//Passing a block object as a parameter
-(void) doTheConverstionAsParameter{
    NSString *result = [self convertIntToString:123 usingBlockObject:^NSString *(NSUInteger paramInteger){
        NSString *result = [NSString stringWithFormat:@"%lu", (unsigned long)paramInteger];
        
        return result;
    }];
    
    NSLog(@"result = %@", result);
}



@end
