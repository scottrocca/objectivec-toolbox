//
//  CollectionViewController.m
//  ToolBox
//
//  Created by Scott Rocca on 6/9/18.
//  Copyright © 2018 ScottRocca. All rights reserved.
//

#import "CollectionViewController.h"
#import "MyCollectionViewCell.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

static NSString * const kCellIdentifier = @"Cell";
const NSTimeInterval kAnimationDuration = 0.20;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    
    // To Register a .xib file with the collection view
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([MyCollectionViewCell class])
                                bundle:[NSBundle mainBundle]];
    //[self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)allSectionColors
{
    static NSArray *allSectionColors = nil;
    
    if (allSectionColors == nil){
        allSectionColors = @[ [UIColor redColor], [UIColor greenColor], [UIColor blueColor] ];
    }
    
    return allSectionColors;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return [self allSectionColors].count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //arc4random_uniform(x_ returns positive integer bwetwen 0 and x
    //Generate a number between 20 and 40
    return 20 + arc4random_uniform(20);  //(1 - 19) gives us 21 - 39
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.backgroundColor = [self allSectionColors][indexPath.section];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];

    //Fade out and fade back in when selected
    [UIView animateWithDuration:kAnimationDuration animations:^{
        selectedCell.alpha = 0.0;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:kAnimationDuration animations:^{
            selectedCell.alpha = 1.0;
        }];
    }];
}

- (void) collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        //cell growing twice as large
        selectedCell.transform = CGAffineTransformMakeScale(2.0, 2.0);
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        //Shrink back to original size
        selectedCell.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
