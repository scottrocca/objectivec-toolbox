//
//  ViewController.m
//  ToolBox
//
//  Created by Scott Rocca on 9/18/17.
//  Copyright © 2017 ScottRocca. All rights reserved.
//

#import "ViewController.h"
#import "StringReverserActivity.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ScrollViewViewController.h"
#import "WebViewViewController.h"
#import "ConstraintsViewController.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *myPicker;
@property (nonatomic, strong) UISwitch *mainSwitch;
@property (nonatomic, strong) UIDatePicker *myDatePicker;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UISegmentedControl *mySegmentedControl;
@property (nonatomic, strong) UIButton *displaySecondViewControllerButton; //default height of UIButton is 44.0f in iOS7
@property (nonatomic, strong) UIButton *displayScrollViewButton;
@property (nonatomic, strong) UIActivityViewController *activityViewController;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Setting Title to be displayed on Navigation Controller top
    self.title = @"ToolBox Main";
    
    [self createSwitchView];
    [self createPickerView];
    [self createDatePickerView];
    [self createSliderView];
    [self createSegmentedControler];
    [self createButtonView];

}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
   // [self createAlertView];
    
    //defaults switch to off
    [self.mainSwitch setOn:YES animated:YES]; //to turn on, don't need the animaged argument if you don't want it
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//PRAGMA MARK: Alert View
- (void)createAlertView{
    //Adding an allert
    
    //Old way
    /*
     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"You've been delivered an alert" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
     
     [alertView show];
     */
    //New way
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                                   message:@"This is an alert."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {NSLog(@"OK was pressed");
                                                              if (alert.textFields.count > 0) {
                                                                  
                                                                  NSArray * textfields = alert.textFields;
                                                                  UITextField * namefield = textfields[0];
                                                                  UITextField * passwordfiled = textfields[1];
                                                                  NSLog(@"%@:%@",namefield.text,passwordfiled.text);
                                                                  
                                                              }
                                                          }];
    UIAlertAction* anotherAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * action) {NSLog(@"Cancle was pressed");}];
    
    //the order in which you add  actions determines their order in the resulting alert or action sheet.
    [alert addAction:defaultAction];
    [alert addAction:anotherAction];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"name";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"password";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.secureTextEntry = YES;
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

//PRAGMA MARK: Switch View
- (void)createSwitchView{
    // Creating a switch by code
    self.mainSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 100, 0, 0)]; //(x, y, width, height)
    
    
    [self.view addSubview:self.mainSwitch];
    
    self.mainSwitch.tintColor = [UIColor redColor]; //off-mode color
    self.mainSwitch.onTintColor = [UIColor brownColor]; //on color
    self.mainSwitch.thumbTintColor = [UIColor greenColor]; //knob' color
    
    //To call a selector method when switch is toggled
    [self.mainSwitch addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void) switchIsChanged:(UISwitch*)paramSender{
    if([self.mainSwitch isOn]){
        NSLog(@"the switch is on");
        //Presenting Sharing options with UIActivityViewController
        [self launchActivityWithString:@"Hello"];
    }
    else{
        //Set up This apps StringReverserActivity  to include in the opstions of the ActivityViewController
        NSArray *itemsToShare = @[@"Item 1", @"Item 2", @"Item 3"];
        
        UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:@[[StringReverserActivity new]]];
        
        [self presentViewController:activity animated:YES completion:nil];
    }
    
    NSLog(@"The slected Row is %li", (long)[self.myPicker selectedRowInComponent:0] + 1);
}

//PRAGMA MARK: Button View
- (void)createButtonView{
    //Buttons must always be assigned a type
    //If a button renders an image it must be of type UIButtonTypeCustom
    self.displaySecondViewControllerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.displaySecondViewControllerButton setTitle:@"Launch Tab Bar Controller" forState:UIControlStateNormal];
    [self.displaySecondViewControllerButton setTitle:@"I'm Pressed" forState:UIControlStateHighlighted];
    [self.displaySecondViewControllerButton sizeToFit];
    
    self.displaySecondViewControllerButton.center = CGPointMake(275 , 90);
    
    [self.displaySecondViewControllerButton addTarget:self action:@selector(perfromDisplaySecondViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.displaySecondViewControllerButton];
    
    self.displayScrollViewButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.displayScrollViewButton setTitle:@"Launch scroll view" forState:UIControlStateNormal];

    [self.displayScrollViewButton sizeToFit];
    
    self.displayScrollViewButton.center = CGPointMake(275 , 140);
    
    [self.displayScrollViewButton addTarget:self action:@selector(perfromDisplayScrollView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.displayScrollViewButton];
}

//PRAGMA MARK: Slider View
- (void)createSliderView{
    //Setting the Slider
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 23.0f)];
    self.slider.center = CGPointMake(self.view.center.x , self.view.center.y - 175);
    self.slider.minimumValue = 0.0f;
    self.slider.maximumValue = 100.0f;
    // .value is  read write
    self.slider.value = self.slider.maximumValue / 2.0;  // could also use [self.slider setValue:self.slider.maximumValue / 2.0 animated:YES];
    [self.view addSubview:self.slider];
    
    //Customize color
    self.slider.minimumTrackTintColor = [UIColor redColor];
    self.slider.maximumTrackTintColor = [UIColor greenColor];
    self.slider.thumbTintColor = [UIColor blackColor];
    //using images
    [self.slider setMinimumValueImage:[UIImage imageNamed:@"MinimumValue"]]; //displayed outerleft 23x23 or 46x46 for Retina
    [self.slider setMaximumValueImage:[UIImage imageNamed:@"MaximumValue"]]; //displayed outerleft 23x23 or 46x46 for Retina
    
    
    self.slider.continuous = NO; // Only notify when thumb is removed from slider
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}

//PRAGMA MARK: Picker View
- (void)createPickerView{
    //Create a Picker by code
    self.myPicker = [[UIPickerView alloc] init];
    self.myPicker.dataSource = self;
    self.myPicker.delegate = self;
    self.myPicker.showsSelectionIndicator = YES;
    self.myPicker.center = CGPointMake(self.view.center.x , self.view.center.y -100);
    [self.view addSubview:self.myPicker];
}
// returns the number of 'columns'/components to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    if([pickerView isEqual:self.myPicker]){
        return 1;
    }
    
    return 0;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if([pickerView isEqual:self.myPicker]){
        return 10;
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
        if([pickerView isEqual:self.myPicker]){
            return [NSString stringWithFormat:@"Row %ld", (long)row + 1];
        }
    
    return nil;
}

//PRAGMA MARK: Date Picker View
- (void)createDatePickerView{
    //Create a Date Picker
    self.myDatePicker = [[UIDatePicker alloc] init];
    self.myDatePicker.center = CGPointMake(self.view.center.x , self.view.center.y + 100);
    self.myDatePicker.datePickerMode = UIDatePickerModeDate;//
    [self.view addSubview:self.myDatePicker];
    [self.myDatePicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
    
    NSTimeInterval oneYerTime = 365 * 24 * 60 * 60;
    NSDate *todayDate = [NSDate date];
    
    NSDate *oneYearFromToday = [todayDate dateByAddingTimeInterval:oneYerTime];
    NSDate *twoYearsFromToday = [todayDate dateByAddingTimeInterval:2 * oneYerTime];
    
    //Set the min and max the date picker can display
    self.myDatePicker.minimumDate = oneYearFromToday;
    self.myDatePicker.maximumDate = twoYearsFromToday;
    
    //If using UIDatePickerModeCountDownTimer to set the defaule starting coutdown time:
    NSTimeInterval twoMinutes = 2 * 60;
    [self.myDatePicker setCountDownDuration: twoMinutes];
}

- (void)datePickerDateChanged:(UIDatePicker *) paramDatePicker{
    
    if([paramDatePicker isEqual:self.myDatePicker]){
        NSLog(@"Selected date = %@", paramDatePicker.date);
    }
}

//PRAGMA MARK: Slider View
-(void) sliderValueChanged:(UISlider *)paramSender{
    if([paramSender isEqual:self.slider]){
        NSLog(@"New value of slider = %f", paramSender.value);
    }
}

//PRAGMA MARK: Segmented Control
- (void)createSegmentedControler{
    //Segmented Controler
    NSArray<NSString *> *segments = @[ @"iPhone", [UIImage imageNamed:@"MaximumValue"], @"iPad", @"iPod", @"iMac"];
    self.mySegmentedControl = [[UISegmentedControl alloc] initWithItems:segments];
    CGRect segmentedFrame = self.mySegmentedControl.frame;
    segmentedFrame.size.height = 75.0f;
    segmentedFrame.size.width = 300.0f;
    self.mySegmentedControl.frame = segmentedFrame;
    self.mySegmentedControl.center = CGPointMake(self.view.center.x , self.view.center.y + 250);
    [self.view addSubview:self.mySegmentedControl];
    [self.mySegmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.mySegmentedControl.momentary = YES; //Prevents selected portion from staying highlighted.
}
-(void) segmentChanged:(UISegmentedControl *)paramSender{
    if([paramSender isEqual:self.mySegmentedControl]){
        NSInteger selectedSegmentIndex = [paramSender selectedSegmentIndex];
        
        NSString *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        
        NSLog(@"Segment %ld with %@ text is selected", (long)selectedSegmentIndex, selectedSegmentText);
        
        if(selectedSegmentIndex == 1){
            SecondViewController *secondVC = [[SecondViewController alloc] initWithNibName:nil bundle:NULL];
            UINavigationController *secondNavVC = [[UINavigationController alloc] initWithRootViewController:secondVC];
            [self.navigationController pushViewController:secondVC animated:YES];
        }
    }
}

//PRAGMA MARK: NINE PATCH
-(UIImage *) minimumTrackImage{
    UIImage *result = [UIImage imageNamed:@"MinimumTrack"];
    UIEdgeInsets edgeInsets;
    edgeInsets.left = 4.0f;
    edgeInsets.top = 0.0f;
    edgeInsets.right = 0.0f;
    edgeInsets.bottom = 0.0f;
    result = [result resizableImageWithCapInsets:edgeInsets];
    return result;
}

//PRAGMA MARK: - Sharing with UIActivityViewController
-(void)launchActivityWithString:(NSString *) content{
    self.activityViewController = [[UIActivityViewController alloc]
                                   initWithActivityItems:@[content] applicationActivities:nil];
    [self presentViewController:self.activityViewController animated:YES completion:^{/* Nothing for now**/}];
}

//PRAGMA MARK: UINavigationController
-(void) perfromDisplaySecondViewController:(id)paramSender{

    SecondViewController *secondVC = [[SecondViewController alloc] initWithNibName:nil bundle:NULL];
    UINavigationController *secondNavVC = [[UINavigationController alloc] initWithRootViewController:secondVC];
    
    ThirdViewController *thirdVC = [[ThirdViewController alloc] initWithNibName:nil bundle:NULL];
    UINavigationController *thirdNavVC = [[UINavigationController alloc] initWithRootViewController:thirdVC];
    
    //Nav in Nav is not working

    WebViewViewController *webVC = [[WebViewViewController alloc] initWithNibName:nil bundle:NULL];
    
    ConstraintsViewController *contraintsVC = [[ConstraintsViewController alloc] initWithNibName:nil bundle:NULL];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:@[secondVC, thirdVC, webVC, contraintsVC] animated:YES];

    [self.navigationController pushViewController:tabBarController animated:YES];
}

- (void)perfromDisplayScrollView{
    ScrollViewViewController *scrollVC = [[ScrollViewViewController alloc] initWithNibName:nil bundle:NULL];
    
     [self.navigationController pushViewController:scrollVC animated:YES];
}

@end
