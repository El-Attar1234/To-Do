//
//  AddingTaskViewController.m
//  TODO-List
//
//  Created by Mahmoud Elattar on 4/4/21.
//  Copyright © 2021 ITI. All rights reserved.
//

#import "AddingTaskViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "Task.h"

@interface AddingTaskViewController (){
    NSArray *priorityArray;
    UIPickerView *myPicker;
    UIDatePicker *myDatePicker;
    NSInteger currentIndex;
    UNUserNotificationCenter *center;
    NSString*strDate;
}
@property (weak, nonatomic) IBOutlet UITextField *taskNameTF;
@property (weak, nonatomic) IBOutlet UITextField *taskDescriptionTF;
@property (weak, nonatomic) IBOutlet UITextField *taskPriorityTF;
@property (weak, nonatomic) IBOutlet UITextField *reminderDateTF;


@end

@implementation AddingTaskViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    currentIndex=0;
    myPicker=[UIPickerView new];
    myDatePicker=[UIDatePicker new];
    priorityArray=@[@"Low",@"Medium",@"High"];
    [myPicker setDelegate:self];
    [myPicker setDataSource:self];
    
    UIToolbar *toolBar=[UIToolbar new];
    [toolBar sizeToFit];
    
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(closePicker)];
    
    [toolBar setItems:@[doneButton] animated:YES];
    // [toolBar setItems:doneButton];
    _taskPriorityTF.inputView=myPicker;
    _taskPriorityTF.inputAccessoryView=toolBar;
    
    _reminderDateTF.inputView=myDatePicker;
    _reminderDateTF.inputAccessoryView=toolBar;
    
    [myDatePicker addTarget:self action:@selector(dateIsChanged:) forControlEvents:UIControlEventValueChanged];
    
    //  _taskPriorityTF.text=priorityArray[[_priorityPicker selectedRowInComponent:0]];
    // Do any additional setup after loading the view.
}


-(void)createNotification{
    center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge |UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            [self schudleTask];
        }
        else{
            printf("Not allowed");
        }
    }];
    
}

-(void)schudleTask{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:_taskNameTF.text arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:_taskDescriptionTF.text
                                                         arguments:nil];
    
    content.sound = [UNNotificationSound defaultSound];
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:40
                                                  repeats:NO];
    /*NSDate *current=[[NSDate new] dateByAddingTimeInterval:10];
     NSCalendar *calender = [[NSCalendar alloc]
     initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
     
     NSDateComponents *weekdayComponents =
     [calender components:(NS |
     NSWeekdayCalendarUnit) fromDate:current];
     
     [[[NSCalendar.currentCalendar] NSDateComponents] ];
     UNCalendarNotificationTrigger *trigger1=[UNCalendarNotificationTrigger triggerWithDateMatchingComponents:<#(nonnull NSDateComponents *)#> repeats:NO];*/
    
    
    
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"NOTIFICATION"
                                                                          content:content
                                                                          trigger:trigger];
    
    
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            printf("notification success");
        }
    }];
    
}

- (void)dateIsChanged:(id)sender{
    NSDateFormatter *formatter=[NSDateFormatter new];
    formatter.dateFormat = @"EEEE, dd MMM yyyy HH:mm:ss";
    strDate= [formatter stringFromDate:myDatePicker.date];
    _reminderDateTF.text=strDate;
    
}

-(void)closePicker{
    NSDateFormatter *formatter=[NSDateFormatter new];
    formatter.dateStyle=UIFontWeightMedium;
    [formatter 	dateStyle];
    [self.view endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return priorityArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    currentIndex=row;
    return priorityArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _taskPriorityTF.text=priorityArray[row];
}

- (IBAction)saveTask:(id)sender {
    
    [self createNotification];
    NSDateFormatter *formatter=[NSDateFormatter new];
    formatter.dateFormat = @"EEEE, dd MMM yyyy HH:mm:ss";
    NSString *current= [formatter stringFromDate:[NSDate new]];
    Task *task=[[Task alloc] init];
    task.taskName=_taskNameTF.text;
    task.taskDescription=_taskDescriptionTF.text;
    task.priority=priorityArray[currentIndex];
    task.reminderDate=strDate;
    task.createdDate=current;
    task.file=@"file";
    task.status=@"TO DO";
    [_addTaskDelegate updateList:task];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}



@end
