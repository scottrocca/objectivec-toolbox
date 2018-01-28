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
//Above we removed the initial code that provided the block object's signature, which consisted of a name and argument: ^intToStringBlock)(NSUInteger).
//It is now an anonymous object. To refer to the block object we assign it using an equals sign to a type and name: IntToStringConverter inlineConverter.
//Now I can use the data type to enforce proper use in methods and use the name to actuall pass the block object.

#pragma mark - block object as a parameter
//Passing a block object as a parameter
-(void) doTheConverstionAsParameter{
    NSString *result = [self convertIntToString:123 usingBlockObject:^NSString *(NSUInteger paramInteger){
        NSString *result = [NSString stringWithFormat:@"%lu", (unsigned long)paramInteger];
        
        return result;
    }];
    
    NSLog(@"result = %@", result);
}

/*The difference betwee accessing variable sin Objective-C methods and accessing those variables in block objects:

    * Local variables in block objects work exactly the same as in Objective-C methods.
    * For inline block objects, local variables constitute not only variables defined wihthin the block, but also the variables that have been defined in the method that implements that block.
    * You cannot refer to self in independet block objects implemented in an Objective-C class. If you need to access self, you must pass that object to the block object as a parameter.
    * You can ffefer to self in an inline block object only if self is present in the lexical scope inside which the blok object is created.
    * For inline block objects, local variables that are defined inside the blcok object's implementation can be read from and written to. In other words, the block object has rea/write access to variables defined inside the block object's body.
    * Suppose you have an object of type NSObject and inside that object's implementationyou are using a block object in conjunction with GCD. Inside this block object,  you will have read/write access to declared properties of that NSObject inside which  you block is implemented.
    * You can access declared properties of your NSObject inside indepenent block objects only if you use the setter and getter methods of these properties. You cannot access declared properties of an object using dot notation inside an independent block object.
*/

//Variables that are local to the implemntation of an independent block object:
void (^independentBlockObject)(void) = ^(void) {
    NSInteger localInteger = 10;
    NSLog(@"Local integer =  %ld", (long)localInteger);
    localInteger = 20;
    NSLog(@"Local integer = %ld", (long)localInteger);
    
};
/*
 Invoking this block object we get:
Local integer = 10
Local integer = 20
 */


//Variables that are local to the implemntation of an inline block object:
- (void)simpleMethod {
    NSUInteger outsideVariable = 10;
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"obj1", @"obj2", nil];
    
    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSUInteger insideVariable = 20;
        
        NSLog(@"Outside variable = %lu", (unsigned long)outsideVariable);
        NSLog(@"Inside variable = %lu", (unsigned long)insideVariable);
        
        return NSOrderedSame;
    }];
}
//Above the block object can read and write to the local variable: insideVariable. However, the block object only has read-only access tot he outside variable: outsideVariable by default. In order to allow the block object to write to outsideVariable, you must prefix it with the __block storage type.
@end
