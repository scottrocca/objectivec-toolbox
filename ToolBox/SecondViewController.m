//
//  SecondViewController.m
//  ToolBox
//
//  Created by Scott Rocca on 9/29/17.
//  Copyright © 2017 ScottRocca. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) UITextField *myTextField;
@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UIImageView *myImageView;
@end

@implementation SecondViewController


- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if( self != nil){
        self.title = @"First Tab"; //Only really needed for tabs that are not the first tab
        self.tabBarItem.image = [UIImage imageNamed:@"Thumb"];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 40.0f)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *image = [UIImage imageNamed:@"Logo"];
    [imageView setImage:image];
    self.navigationItem.titleView = imageView;
    //self.title = @"Second Controller";
    
    [self createLabelView];
    [self createTextField];
    [self createImageButton];
    [self createImageView];
    
    
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setRightBarWithCustom];
    
    //Return back to ViewController after 5 seconds
    //[self performSelector:@selector(myGoBack) withObject:nil afterDelay:5.0f]; //5 seconds
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

#pragma mark - Label View
- (void)createLabelView{
    CGRect labelFrame = CGRectMake(0.0f, 0.0f, 100.0f, 170.0f);
    self.myLabel = [[UILabel alloc] initWithFrame:labelFrame];
    self.myLabel.numberOfLines = 0; //Setting numberOfLines to 0 gives you the max number of lines possible to fill the current width and height. If this parameter is not set you only get 1 line no matter the width and height.
    self.myLabel.text = @"iOS SDK"; //@"The quick brown fox jumped over the lazy dog";
    self.myLabel.adjustsFontSizeToFitWidth = YES;  //Font will adjust itself to fit into the boundaries of the label
    self.myLabel.font = [UIFont boldSystemFontOfSize:70.0f]; //With adjustsFontSizeToFitWidth set this becomes the maximum size it will display if capabile.
    self.myLabel.backgroundColor = [UIColor clearColor];
    self.myLabel.textColor = [UIColor blackColor];
    self.myLabel.shadowColor = [UIColor redColor]; //lightGrayColor If this is set so must shadowOffset
    self.myLabel.shadowOffset = CGSizeMake(2.0f, 2.0f); // (1, 2) = the drop shadow appearing 1 point to the right and 2 points down from the text. (-2, -10) = 2 oints to the left and 10 points above the text.
    self.myLabel.center = CGPointMake(self.view.center.x , 130);
    [self.view addSubview:self.myLabel];
}

#pragma mark - TextField view
- (void)createTextField{
    
    CGRect textFieldFrame = CGRectMake(0.0f, 0.0f, 200.0f, 31.0f);
    self.myTextField = [[UITextField alloc] initWithFrame:textFieldFrame];
    self.myTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.myTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //Top left by default
    self.myTextField.textAlignment = NSTextAlignmentCenter;
    //self.myTextField.text = @"Sir Richard Branson";
    self.myTextField.placeholder = @"Enter text here ...";
    self.myTextField.center = CGPointMake(self.view.center.x , self.view.center.y - 75);
    [self.view addSubview:self.myTextField];
    
    self.myTextField.delegate = self;
}

//Called when user pressses the Return/Enter key on the keyboard.
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Label View
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - ImageButton
- (void) createImageButton{
    UIImage *normalImage = [UIImage imageNamed:@"NormalBlueButton"];
    UIImage *highlightedImage = [UIImage imageNamed:@"HighlightedBlueButton"];
    
    self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imageButton.frame = CGRectMake(110.0f, 200.0f, 100.0f, 44.0f);
    
    //If your the image has text use setImage:forState instead
    [self.imageButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [self.imageButton setTitle:@"Normal" forState:UIControlStateNormal];
    
    [self.imageButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [self.imageButton setTitle:@"Pressed" forState:UIControlStateHighlighted];
    
    self.imageButton.center = CGPointMake(self.view.center.x , self.view.center.y - 125);
    
    [self.view addSubview:self.imageButton];
}

#pragma mark - ImageVeiw
- (void) createImageView{
    UIImage *macBookAir = [UIImage imageNamed:@"MacBookAir"]; //displays the full image on screen. Can be an issue if image is bigger then screen

    //self.myImageView = [[UIImageView alloc] initWithImage:macBookAir];//displays the full image on screen. Can be an issue if image is bigger then screen
    //To constrain the image to a specific area
    self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(110.0f, 200.0f, 100.0f, 44.0f)];
    self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
    /*
    UIViewContentModeScaleToFill - Will scale the image inside the image view to fill the entire boundaries of the image view
     
     UIViewContentModeScaleAspectFit - Will make sure the image inside the image view will have the right aspect ratio and fits inside the image view's boundaries
     
     UIViewContentModeScaleAspectFill - Will make sure the image inside the image view will have the right aspect ratio and fills the entire boundaries of the image view.
                                         For this value to work properly, make sure that you set the clipsToBounds property of the image view to YES.
     
         The clipstToBounds property of UIView denotes whether the subviews of that view should be clipped if they go outside the boundaries of the view. You use this property if you want to be absolutely certain that the subviews of the specific view will not get rendered outside the boundaries of that view ( or that they do get rendered out-side the boundaries, depending on your requirements).
     
     */
    self.myImageView.image = macBookAir;
    self.myImageView.center = CGPointMake(self.view.center.x , self.view.center.y + 75);
    
    [self.view addSubview:self.myImageView];
}

@end
