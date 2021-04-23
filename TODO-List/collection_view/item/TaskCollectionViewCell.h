//
//  TaskCollectionViewCell.h
//  TODO-List
//
//  Created by Mahmoud Elattar on 4/4/21.
//  Copyright © 2021 ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *taskName;
-(void)setUpCell:(Task *)task;
@end

NS_ASSUME_NONNULL_END
