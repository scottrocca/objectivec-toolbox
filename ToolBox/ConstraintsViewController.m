//
//  ConstraintsViewController.m
//  ToolBox
//
//  Created by Scott Rocca on 11/15/17.
//  Copyright © 2017 ScottRocca. All rights reserved.
//

#import "ConstraintsViewController.h"

@interface ConstraintsViewController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation ConstraintsViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if( self != nil){
        self.title = @"Constraints";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.button setTitle:@"Centered with Constraint Button" forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    
    UIView *superView = self.button.superview;
    
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    
        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
    
     [superView addConstraints:@[centerXConstraint, centerYConstraint]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
