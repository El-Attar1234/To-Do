

#import "HorizontalViewController.h"
#import "HorizontalItemCollectionViewCell.h"
#import "Task.h"
@interface HorizontalViewController (){
    NSMutableArray *tasks;
    NSTimer *timer;
    NSInteger currentIndex;
}
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *myPageController;

@end

@implementation HorizontalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    currentIndex=0;
    tasks=[[NSMutableArray alloc] init];
    [_myCollectionView setDataSource:self];
    [_myCollectionView setDelegate:self];
    
    UIImage *img=[UIImage imageNamed:@"flag"];
    [tasks addObject:img];
     [tasks addObject:img];
     [tasks addObject:img];
    [tasks addObject:img];
    [tasks addObject:img];
    [tasks addObject:img];
    [tasks addObject:img];
    [tasks addObject:img];
    _myPageController.numberOfPages=tasks.count;
    [self startTimer];
}
-(void)startTimer{
    timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(slideItem) userInfo:nil repeats:YES];
    
}
-(void)slideItem{
    if (currentIndex < tasks.count-1) {
    
        currentIndex=currentIndex+1;
    }
    else{
        currentIndex=0;
    }
    NSIndexPath *index=[NSIndexPath indexPathForItem:currentIndex inSection:0];
    [_myCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    _myPageController.currentPage=currentIndex;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return tasks.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    printf("dequeu\n");
    HorizontalItemCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"HorizontalItemCollectionViewCell" forIndexPath:indexPath];
    cell.priorityImage.image=[tasks objectAtIndex:indexPath.row];
  //  [cell setUpCell:[tasks objectAtIndex:indexPath.item]];
    //[cell setBackgroundColor:UIColor.orangeColor];
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
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
