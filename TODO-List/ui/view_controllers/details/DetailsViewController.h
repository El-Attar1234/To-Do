//
//  DetailsViewController.h
//  TODO-List
//
//  Created by Mahmoud Elattar on 4/5/21.
//  Copyright © 2021 ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddingTaskDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property NSDictionary *taskDictionary;
@property NSInteger indexOfCurrentTask;
@property NSString *statusMode;
@property id <AddingTaskDelegate>UpdateTaskDelegate;
@end

NS_ASSUME_NONNULL_END
