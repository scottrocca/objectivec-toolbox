//
//  ScrollViewViewController.m
//  ToolBox
//
//  Created by Scott Rocca on 10/21/17.
//  Copyright © 2017 ScottRocca. All rights reserved.
//

#import "ScrollViewViewController.h"

@interface ScrollViewViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UIImageView *myImageView;
@end

@implementation ScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIImage *macBook = [UIImage imageNamed:@"MacBookAir"];
    UIImage *iPhone = [UIImage imageNamed:@"iPhone"];
    UIImage *iPad = [UIImage imageNamed:@"iPadFull"];
    
    //self.myImageView = [[UIImageView alloc] initWithImage:imageToLoad];
    
    self.myScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.myScrollView addSubview:self.myImageView];
    //self.myScrollView.contentSize = self.myImageView.bounds.size;
    
    CGRect scrollViewRect = self.view.bounds;
    self.myScrollView.contentSize = CGSizeMake(scrollViewRect.size.width * 3, scrollViewRect.size.height);
    
    UIImageView *iPhoneImageView = [self newImageViewWithImage:iPhone frame:scrollViewRect];
    [self.myScrollView addSubview:iPhoneImageView];
    
    scrollViewRect.origin.x += scrollViewRect.size.width;
    UIImageView *iPadImageView = [self newImageViewWithImage:iPad frame:scrollViewRect];
    [self.myScrollView addSubview:iPadImageView];
    
    scrollViewRect.origin.x += scrollViewRect.size.width;
    UIImageView *macImageView = [self newImageViewWithImage:macBook frame:scrollViewRect];
    [self.myScrollView addSubview:macImageView];
    
    self.myScrollView.delegate = self;
    self.myScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    self.myScrollView.pagingEnabled = YES;
    [self.view addSubview:self.myScrollView];
}

- (UIImageView *)newImageViewWithImage:(UIImage *)paramImage frame:(CGRect)paramFrame{
    UIImageView *result = [[UIImageView alloc] initWithFrame:paramFrame];
    result.contentMode = UIViewContentModeScaleAspectFit;
    result.image = paramImage;
    
    return result;
}

//PRAGMA MARK: - Scroll View Delegates

//Gets called when user scrolls or drags
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.myScrollView.alpha = 0.50f;
}

//Gets called only after scrolling
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.myScrollView.alpha = 1.0f;
}

//Gets called when the user finishes dragging the contents of the scroll view
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.myScrollView.alpha = 1.0f;
}


@end
