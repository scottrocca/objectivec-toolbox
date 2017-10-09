//
//  ThirdViewController.m
//  ToolBox
//
//  Created by Scott Rocca on 10/4/17.
//  Copyright © 2017 ScottRocca. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if( self != nil){
        self.title = @"Second Tab"; //When tab bar loads up, it loads only the view of the first view controller in its items.
        //Al other view controllers will be initialized, but their views won't be loaded. This means the other view controllers
        //will not call thier viewDidLoad until the user touches the associated tab button. Therefore title needs to be set here so it shows up on in the tab controller.
        self.tabBarItem.image = [UIImage imageNamed:@"MaximumValue"];
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"Third Controller";
    // Do any additional setup after loading the view.
}


@end
