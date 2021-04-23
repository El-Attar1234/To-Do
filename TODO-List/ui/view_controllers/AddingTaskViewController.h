//
//  AddingTaskViewController.h
//  TODO-List
//
//  Created by Mahmoud Elattar on 4/4/21.
//  Copyright © 2021 ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddingTaskDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddingTaskViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
@property id <AddingTaskDelegate>addTaskDelegate;
@end

NS_ASSUME_NONNULL_END
