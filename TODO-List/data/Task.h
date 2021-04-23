//
//  Task.h
//  TODO-List
//
//  Created by Mahmoud Elattar on 4/4/21.
//  Copyright © 2021 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject
@property NSString *taskName;
@property NSString *taskDescription;
@property NSString *priority;
@property NSString *createdDate;
@property NSString *reminderDate;
@property NSString *file;
@property NSString *status;
@end

NS_ASSUME_NONNULL_END
