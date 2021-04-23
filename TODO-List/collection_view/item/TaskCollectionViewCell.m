//
//  TaskCollectionViewCell.m
//  TODO-List
//
//  Created by Mahmoud Elattar on 4/4/21.
//  Copyright © 2021 ITI. All rights reserved.
//

#import "TaskCollectionViewCell.h"

@implementation TaskCollectionViewCell
- (void)setUpCell:(Task *)task{
    _taskName.text=task.taskName;
}
@end
