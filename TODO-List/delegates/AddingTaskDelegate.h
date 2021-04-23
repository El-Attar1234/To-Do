//
//  AddingTaskDelegate.h
//  TODO-List
//
//  Created by Mahmoud Elattar on 4/5/21.
//  Copyright © 2021 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AddingTaskDelegate <NSObject>
-(void)updateList:(Task *)task;
-(void)updateEditedTask:(Task *)task :(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
