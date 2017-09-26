//
//  ch1.h
//  ToolBox
//
//  Created by Scott Rocca on 9/18/17.
//  Copyright © 2017 ScottRocca. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 Propertie qualifiers/attributes
 strong - Properties of this type will be retained by the runtime. These can only be instaces of classes. In other words
 you cannot retain a value into a property of type strong if the value is a primitive. You can retain objects, but not primitives.
 
 copy - The same as strong, but when you assign to properties of this type, the runtime will make a copy of the object on the right side of the assignment. The object on the righthand side of the assignment must conform to the NSCopying or NSMutable Copying prototcol
 
 assign - Objects or primitive values that are set as the value of a property of type assign will not be coppied or retained by that property. For primitive properties, this qualifier will create a memory address where you can put the primitive data. For objects, properties of this type will simply point to the object on the righthand side of the equation.
 
 unsafe_unretained - same as assign qualifier.
 
 weak - The same as the assign qualifier with one big difference. In the case of objects, when the object that is assigned to a property of this type is released from memory, the runtime will automatically set the value of the property to nil
 
 */

@interface ch1 : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, assign) float currentHeight;

+ (void) ThisIsAClassMethod;
- (void) ThisIsAInstanceMethod;

@end
