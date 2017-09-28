//
//  ch1.m
//  ToolBox
//
//  Created by Scott Rocca on 9/18/17.
//  Copyright © 2017 ScottRocca. All rights reserved.
//

#import "ch1.h"

@implementation ch1

+ (void) ThisIsAClassMethod;{

    //Arrays
    //immutable
    NSArray<NSString *> *stringArray = @[ @"String 1", @"String 2", @"String 3"];
    
    __unused NSString *firstString = stringArray[0];  //__unused tells the compiler not to complain
    __unused NSString *firstString2 = [stringArray objectAtIndex:0]; //old way of accessing
    
    //mutable
    NSMutableArray<NSString *> *mutableArray = [[NSMutableArray alloc] initWithArray:stringArray];
    
    [mutableArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
    [mutableArray removeObjectAtIndex:1];
    [mutableArray setObject:@"Hello" atIndexedSubscript:0];
    [mutableArray addObject:@"another string"];
    __unused NSArray<NSString *> *dupString = [mutableArray copy];
    
    //print contents of arrays
    NSLog(@"Contents of Array: %@", mutableArray);
    
    //Dictionarys
    NSDictionary<NSString *, NSString *> *personInformation = @{ @"firstName" : @"Scott", @"lastName" : @"Rocca", @"age":@30, @"sex":@"M"};
    
    NSString *age = personInformation[@"age"];
    __unused NSNumber *age2 = personInformation[@"age"]; //warning because of <NSString *, NSString *>
    NSLog(@"Age = %@", age);
    
    //Creating and using keys to access Dictionary values
    NSString *const kFirstNameKey = @"firstName";
    NSString *const kLastNameKey = @"lastName";
    
    NSDictionary *name = @{kFirstNameKey: @"Scott", kLastNameKey: @"Rocca"};
    __unused NSString *fn = name[kFirstNameKey];
    __unused NSString *oldway = [name objectForKey:kLastNameKey]; //The old way
    
    //Mutable Dictionary
    NSMutableDictionary *mutablePersonInfo = [[NSMutableDictionary alloc] initWithDictionary:personInformation];
    
    mutablePersonInfo[@"age"] = @25;
    
    
    //Sets like arrays but keep a unique set of objects. They do not keep the order in shich objects were added to them
    NSSet *shoppingList = [[NSSet alloc] initWithObjects: @"Milk", @"Bananas", @"Bread", @"Milk", nil];
    NSLog(@"shopping list: %@", shoppingList); //Milk will only show once
    
    
    //MutableSet
    NSMutableSet *mutableSet = [NSMutableSet setWithSet:shoppingList];
    [mutableSet addObject:@"Yogurt"];
    [mutableSet removeObject:@"Bread"];
    
    //NsOrderedSet - An immutable set that keeps the order in which objects were added
    //NSMutableOrderedSet - The mutable version
    NSMutableOrderedSet *setOfNumbers = [NSMutableOrderedSet orderedSetWithArray:@[@3, @4, @1, @5, @10]];
    [setOfNumbers removeObject:@5];
    [setOfNumbers addObject:@0];
    [setOfNumbers exchangeObjectAtIndex:1 withObjectAtIndex:2];
    NSLog(@"Set of numbers = %@", setOfNumbers);
    
    //NSCountedSet Objects still appear only once, but the set keeps a count of how many times the object was added to the set and will decrement that counter each time you remove an instance of the object. It is always mutable even tho it does not have mutable in the name
    NSCountedSet *countedSet = [NSCountedSet setWithObjects:@10, @20, @10, @10, @30, nil];
    [countedSet addObject:@20];
    [countedSet removeObject:@10];
    
    NSLog(@"Count for object @10 = %lu", (unsigned long)[countedSet countForObject:@10]);
    NSLog(@"Count for object @20 = %lu", (unsigned long)[countedSet countForObject:@20]);
    
    //Checking if a propety is a specifc class type
    if([firstString isKindOfClass:[NSString class]])
    {
        NSLog(@"This is a string class property");
    }
    
    //String comparison
    if([firstString isEqualToString:age]){
        //The two strings are equal
    }

}

- (void) ThisIsAInstanceMethod{}



@end
