//
//  SecondViewController.m
//  ToolBox
//
//  Created by Scott Rocca on 9/29/17.
//  Copyright © 2017 ScottRocca. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 40.0f)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *image = [UIImage imageNamed:@"Logo"];
    [imageView setImage:image];
    self.navigationItem.titleView = imageView;
    //self.title = @"Second Controller";
    
   
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     [self setRightBarWithCustom];
    [self performSelector:@selector(myGoBack) withObject:nil afterDelay:5.0f]; //5 seconds
}

-(void) switchIsChanged:(UISwitch *)paramSender{
    if([paramSender isOn]){
        NSLog(@"Switch is on");
    }
    else{
        NSLog(@"Switch is off");
    }
}

#pragma mark - Navigation UIBarButtonItems
- (void)performAdd:(id)paramSender{
    NSLog(@"Action method got called.");
}
- (void)setRightBarWithText{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(performAdd:)];
}

- (void)setRightBarWithCustom{
    UISwitch * simpleSwitch = [[UISwitch alloc] init];
    simpleSwitch.on = YES;
    [simpleSwitch addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:simpleSwitch];
    [self.navigationItem setRightBarButtonItem:rightBarButton animated:NO];
}

- (void)setRightBarWithSystemItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(performAdd:)];
}

#pragma mark - Navigation Controller Properties
- (void) goBack{//build into UIViewController
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) myGoBack{
    NSArray *currentControllers = self.navigationController.viewControllers;
    
    NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
    
    [newControllers removeLastObject];
    
    //self.navigationController.viewControllers = newControllers; //no animation
    //Perfrom change with animation
    [self.navigationController setViewControllers:newControllers animated:YES];
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
