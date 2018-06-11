//
//  MyCollectionViewCell.m
//  ToolBox
//
//  Created by Scott Rocca on 6/10/18.
//  Copyright © 2018 ScottRocca. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageViewBackgroundImage.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.backgroundColor = [UIColor blueColor];
}

@end
