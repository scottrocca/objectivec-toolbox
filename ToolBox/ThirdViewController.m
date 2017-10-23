//
//  ThirdViewController.m
//  ToolBox
//
//  Created by Scott Rocca on 10/4/17.
//  Copyright © 2017 ScottRocca. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
@property (nonatomic, strong) UITextView *myTextView;
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
    
    self.myTextView = [[UITextView alloc] initWithFrame:self.view.bounds];
    self.myTextView.text = @"Some Text here";
    self.myTextView.contentInset = UIEdgeInsetsMake(10.0f, 0.0f, 0.0f, 0.0f);
    self.myTextView.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:self.myTextView];
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//If you intend to change your UI structure when the keyboard gets displayed and dismissed, you should only rely on keyboard notifications. This is becuse the user might be using a bluetooth keyboard and no soft keyboard will be displayed.
- (void) handleKeyboardDidShow:(NSNotification *)paramNotification{
    //Get the frame of the keyboard
    NSValue *keyboardRectAsObject = [[paramNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    //Place it in a CGRect
    CGRect keyboardRect = CGRectZero;
    
    [keyboardRectAsObject getValue:&keyboardRect];
    
    //Give a bottom margin to our text view that makes if reach to the top of the keyboard
    self.myTextView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, keyboardRect.size.height, 0.0f);
}


- (void) handleKeyboardWillHide:(NSNotification *)paramNotification{
    //Make the textview as big as the whole view again
    self.myTextView.contentInset = UIEdgeInsetsZero;
}


@end
