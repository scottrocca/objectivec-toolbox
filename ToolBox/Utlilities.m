//
//  Utlilities.m
//  ToolBox
//
//  Created by Scott Rocca on 11/9/17.
//  Copyright © 2017 ScottRocca. All rights reserved.
//

#import "Utlilities.h"
#import <UIKit/UIKit.h>
#import <mach/mach_time.h> // for mach_absolute_time

@implementation Utlilities
//uint64_t start = [Utilities MachAbsoluteTime]; uint64_t end = [Utilities MachAbsoluteTime];
//[Utilities MachTimeToMs:( end - start)];
+(uint64_t) MachAbsoluteTime
{
    return mach_absolute_time();
}
+(double) MachTimeToSecs:(uint64_t) time
{
    mach_timebase_info_data_t timebase;
    mach_timebase_info(&timebase);
    return (double)time * (double)timebase.numer /
    (double)timebase.denom / 1e9;
}

+(double) MachTimeToMs:(uint64_t) time
{
    mach_timebase_info_data_t timebase;
    mach_timebase_info(&timebase);
    return (double)time * (double)timebase.numer / (double)timebase.denom / 1e6;
}

+ (NSString *)getDocumentDirectory
{
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = arrayPaths[0];
    return docDirectory;
}

+ (float) maxFontSizeThatFitsForString:(NSString*)text inRect:(CGRect)rectangle withFont:(NSString *)fontName {
    
    float lowFontSize = 8.0f;
    float highFontSize = 80.0f;
    
    while (true) {
        if (fabs( highFontSize - lowFontSize) < 1.0f)
            break;
        float midFontSize = (lowFontSize + highFontSize) / 2;
        NSDictionary *attrs = @ { NSFontAttributeName:[UIFont fontWithName:fontName size:midFontSize] };
        CGSize textsize = [text sizeWithAttributes:attrs];
        //      if (textsize.width > rectangle.size.width || textsize.height > rectangle.size.height)
        if (textsize.height > rectangle.size.height)
            highFontSize = midFontSize;
        else
            lowFontSize = midFontSize;
    }
    
    return highFontSize;
}

@end
