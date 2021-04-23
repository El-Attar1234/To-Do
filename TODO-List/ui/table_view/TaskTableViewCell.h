//
//  TaskTableViewCell.h
//  TODO-List
//
//  Created by Mahmoud Elattar on 4/5/21.
//  Copyright © 2021 ITI. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet UIView *taskIndicatorColor;

@property (weak, nonatomic) IBOutlet UILabel *taskPriority;
@property (weak, nonatomic) IBOutlet UIImageView *taskImage;

@end

NS_ASSUME_NONNULL_END
