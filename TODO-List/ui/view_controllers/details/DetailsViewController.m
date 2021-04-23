//
//  DetailsViewController.m
//  TODO-List
//
//  Created by Mahmoud Elattar on 4/5/21.
//  Copyright © 2021 ITI. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *taskDescription;
@property (weak, nonatomic) IBOutlet UITextField *taskpriority;
@property (weak, nonatomic) IBOutlet UITextField *taskStatus;
@property (weak, nonatomic) IBOutlet UITextField *taskCreationTime;
@property (weak, nonatomic) IBOutlet UITextField *taskreminder;
@property (weak, nonatomic) IBOutlet UITextField *taskFile;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation DetailsViewController{
    NSArray *statusArray;
    UIPickerView *myPicker;
    UIDatePicker *myDatePicker;
    NSInteger currentIndex;
    NSString*strDate;
}
- (void)viewWillAppear:(BOOL)animated{
   //  statusArray=@[@"In progress",@"Done"];
    [_editButton setHidden:NO];
    NSString *savedTaskStatus=[_taskDictionary objectForKey:@"status"];
       if([savedTaskStatus isEqualToString:@"TO DO"]){
            
          statusArray=@[@"In progress",@"Done"];
          }
          else if([savedTaskStatus isEqualToString:@"In progress"]){
            statusArray=@[@"Done"];
          }
          else{
              [_editButton setHidden:YES];
                [_saveButton setTitle:@"Ok" forState:UIControlStateNormal];
           
             statusArray=@[@""];
          }
       
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeUi];
    
    _editButton.layer.cornerRadius = 10;
       _editButton.clipsToBounds = true;
    _saveButton.layer.cornerRadius = 10;
          _saveButton.clipsToBounds = true;
  
     currentIndex=0;
       myPicker=[UIPickerView new];
       myDatePicker=[UIDatePicker new];
      
       [myPicker setDelegate:self];
       [myPicker setDataSource:self];
    
    UIToolbar *toolBar=[UIToolbar new];
       [toolBar sizeToFit];
       
       UIBarButtonItem *doneButton=[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(closePicker)];
       
       [toolBar setItems:@[doneButton] animated:YES];
    _taskStatus.inputView=myPicker;
    _taskStatus.inputAccessoryView=toolBar;
    
    _taskreminder.inputView=myDatePicker;
    _taskreminder.inputAccessoryView=toolBar;
    [myDatePicker addTarget:self action:@selector(dateIsChanged:) forControlEvents:UIControlEventValueChanged];
       
}

-(void)initializeUi{
  _taskName.text=[_taskDictionary objectForKey:@"name"];
     _taskDescription.text=[_taskDictionary objectForKey:@"description"];
     _taskpriority.text=[_taskDictionary objectForKey:@"priority"];
     _taskCreationTime.text=[_taskDictionary objectForKey:@"date"];
     _taskreminder.text=[_taskDictionary objectForKey:@"reminder"];
     _taskFile.text=[_taskDictionary objectForKey:@"file"];
     _taskStatus.text=[_taskDictionary objectForKey:@"status"];
}
- (void)dateIsChanged:(id)sender{
    NSDateFormatter *formatter=[NSDateFormatter new];
    formatter.dateFormat = @"EEEE, dd MMM yyyy HH:mm:ss";
    strDate= [formatter stringFromDate:myDatePicker.date];
    _taskreminder.text=strDate;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return statusArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    currentIndex=row;
    return statusArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _taskStatus.text=statusArray[row];
}

- (IBAction)editTask:(id)sender {
    
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Do you want to edit that task ??"preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *noAction=[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *yesAction=[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self->_taskName.enabled=YES;
         self->_taskDescription.enabled=YES;
         self->_taskStatus.enabled=YES;
         self->_taskreminder.enabled=YES;
        
    }];
    [alert addAction:noAction];
    [alert addAction:yesAction];
      [self presentViewController:alert animated:YES completion:nil];
   
}

- (IBAction)saveTask:(id)sender {

       Task *task=[[Task alloc] init];
       task.taskName=_taskName.text;
       task.taskDescription=_taskDescription.text;
    task.priority=_taskpriority.text;
    task.reminderDate=_taskreminder.text;
    task.createdDate=_taskCreationTime.text;
    task.file=_taskFile.text;
    task.status=_taskStatus.text;
    [_UpdateTaskDelegate updateEditedTask:task :_indexOfCurrentTask];
       [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)closePicker{
    [self.view endEditing:YES];
}



@end
