//
//  Car.h
//  ToolBox
//
//  Created by Scott Rocca on 9/18/17.
//  Copyright © 2017 ScottRocca. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
    Called an interface in Java
 */
@protocol Car <NSObject>
//The defaule qualifier is @required so you only need to specifiy @optional
@property (nonatomic, copy) NSArray *wheels;
@property (nonatomic, strong) UIColor *bodyColor;
@property (nonatomic, copy) NSArray * doors;

@end

@interface Jaguar : NSObject <Car>

@property (nonatomic, copy) NSArray *wheels;
@property (nonatomic, strong) UIColor *bodyColor;
@property (nonatomic, copy) NSArray * doors;

@end
