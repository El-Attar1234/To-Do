//
//  CollectionViewController.m
//  TODO-List
//
//  Created by Mahmoud Elattar on 4/4/21.
//  Copyright © 2021 ITI. All rights reserved.
//

#import "CollectionViewController.h"
#import "TaskCollectionViewCell.h"
#import "Task.h"
@interface CollectionViewController (){
    NSMutableArray *tasks;
}
@property (weak, nonatomic) IBOutlet UICollectionView *myColectionView;


@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tasks=[[NSMutableArray alloc] init];
    [_myColectionView setDelegate:self];
    [_myColectionView setDataSource:self];
    
     Task *task=[Task new];
    task.taskName=@"study1";
    [tasks addObject:task];
    Task *task1=[Task new];
     task1.taskName=@"study2";
    [tasks addObject:task1];
      [tasks addObject:task1];
      [tasks addObject:task1];
      [tasks addObject:task1];
      [tasks addObject:task1];
      [tasks addObject:task1];
      [tasks addObject:task1];
      [tasks addObject:task1];
      [tasks addObject:task1];
      [tasks addObject:task1];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return tasks.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TaskCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"TaskCollectionViewCell" forIndexPath:indexPath];
    [cell setUpCell:[tasks objectAtIndex:indexPath.item]];
    [cell setBackgroundColor:UIColor.orangeColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width*0.32, self.view.frame.size.height*0.3);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 3, 1, 3);
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
