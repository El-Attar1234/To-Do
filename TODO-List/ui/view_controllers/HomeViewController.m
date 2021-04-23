//
//  HomeViewController.m
//  TODO-List
//
//  Created by Mahmoud Elattar on 4/4/21.
//  Copyright © 2021 ITI. All rights reserved.
//

#import "HomeViewController.h"
#import "AddingTaskViewController.h"
#import "TaskTableViewCell.h"
#import "DetailsViewController.h"
@interface HomeViewController (){
    
    NSUserDefaults *defaults;
    NSMutableArray *filteredTasks;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tasksTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchTextField;


@end

@implementation HomeViewController{
    NSMutableArray *myListOfTasks;
    NSString *filePath;
    Boolean isFiltered;
    Boolean isFirst;
    UILabel *label;
    //  NSMutableArray *filteredTodoTasks;
    
}


- (void)viewDidAppear:(BOOL)animated{
    printf("viewDidAppear");
    [myListOfTasks removeAllObjects];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [path objectAtIndex:0];
    filePath = [documentFolder stringByAppendingPathComponent:@"Tasks.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"Tasks" ofType:@"plist"];
    }
    
    myListOfTasks = [NSMutableArray arrayWithContentsOfFile:filePath];
    [self filterarray];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isFirst=true;
    printf("viewDidLoad");
    isFiltered=false;
    myListOfTasks=[NSMutableArray new];
    filteredTasks=[NSMutableArray new];
    
    
    
    label=[[UILabel alloc]initWithFrame:CGRectMake(30, 450, 350, 50)];
    [label setBackgroundColor:[UIColor lightGrayColor]];
    [label setText:@"No tasks , please add new tasks"];
    [label setTextColor:[UIColor blackColor]];
    label.minimumScaleFactor=0.5;
    label.adjustsFontSizeToFitWidth = YES;
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    [label setLineBreakMode:NSLineBreakByCharWrapping];
    [label setNumberOfLines:1];
    [label.layer setCornerRadius:15];
    [label.layer setBorderWidth:1.0f];
    [label setClipsToBounds:YES];
    [label.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.view addSubview:label];
    
    
    //  filteredTodoTasks=[NSMutableArray new];
    
    
    // NSString *path=[[NSBundle mainBundle]pathForResource:@"Tasks" ofType:@"plist"];
    // myListOfTasks=[[NSMutableArray alloc] initWithContentsOfFile:path];
    
    
    
    
    /*
     // myListOfTasks=[NSMutableArray new];
     NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentFolder = [path objectAtIndex:0];
     filePath = [documentFolder stringByAppendingPathComponent:@"Tasks.plist"];
     
     if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
     {
     filePath = [[NSBundle mainBundle] pathForResource:@"Tasks" ofType:@"plist"];
     }
     
     myListOfTasks = [NSMutableArray arrayWithContentsOfFile:filePath];
     [self filterarray];*/
    
    
    // Do any additional setup after loading the view.
}
-(void)filterarray{
    //[filteredTodoTasks removeAllObjects];
    for (NSDictionary*dic in myListOfTasks) {
        NSString *savedTaskStatus=[dic objectForKey:@"status"];
        if([savedTaskStatus isEqualToString:@"TO DO"]){
            //  [filteredTodoTasks addObject:dic];
        }
    }
    [_tasksTableView reloadData];
    
}

- (IBAction)addTask:(id)sender {
    AddingTaskViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"AddingTaskViewController"];
    vc.addTaskDelegate=self;
    isFirst=false;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)updateList:(Task *)task{
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Tasks.plist"];
    
    NSDictionary *dict = @{@"name" :task.taskName, @"description" : task.taskDescription, @"priority":task.priority ,@"date":
                               task.createdDate,@"reminder":task.reminderDate,@"file":task.file,@"status":task.status};
    [myListOfTasks addObject:dict];
    //  [filteredTodoTasks addObject:dict];
    
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:myListOfTasks format:NSPropertyListXMLFormat_v1_0 errorDescription:nil];
    
    if(plistData)
    {
        [plistData writeToFile:plistPath atomically:YES];
        
    }
    
    
    [_tasksTableView reloadData];
}

- (void)updateEditedTask:(Task *)task :(NSInteger)index{
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Tasks.plist"];
    
    NSDictionary *dict = @{@"name" :task.taskName, @"description" : task.taskDescription, @"priority":task.priority ,@"date":
                               task.createdDate,@"reminder":task.reminderDate,@"file":task.file,@"status":task.status};
    [myListOfTasks removeObjectAtIndex:index];
    [myListOfTasks addObject:dict];
    //   [filteredTodoTasks removeObjectAtIndex:index];
    //  [filteredTodoTasks addObject:dict];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:myListOfTasks format:NSPropertyListXMLFormat_v1_0 errorDescription:nil];
    
    if(plistData)
    {
        [plistData writeToFile:plistPath atomically:YES];
        
    }
    
    
    [_tasksTableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger length=0;
    
    
    if (isFiltered) {
        length=filteredTasks.count;
    }else{
        length=myListOfTasks.count;
    }
    if (length==0) {
        [label setHidden:NO];
        tableView.alpha=0;
        
        
        
    }else{
        [label setHidden:YES];
        tableView.alpha=1;
    }
    return length;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger length=0;
    if (isFiltered) {
        length=filteredTasks.count;
    }else{
        length=myListOfTasks.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *task;
    TaskTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TaskTableViewCell" forIndexPath:indexPath];
    if (isFiltered) {
        task=[filteredTasks objectAtIndex:indexPath.section];
    }else{
        task=[myListOfTasks objectAtIndex:indexPath.section];
    }
    
    
    cell.taskNameLabel.text=[task objectForKey:@"name"];
    cell.taskPriority.text=[task objectForKey:@"priority"];
    cell.taskIndicatorColor.layer.cornerRadius=25/2;
    cell.taskIndicatorColor.layer.borderWidth=3;
    NSString *savedTaskStatus=[task objectForKey:@"status"];
    if([savedTaskStatus isEqualToString:@"TO DO"]){
        cell.taskIndicatorColor.layer.borderColor=[UIColor redColor].CGColor;
        cell.taskIndicatorColor.backgroundColor=[UIColor redColor];
        
    }
    else if([savedTaskStatus isEqualToString:@"In progress"]){
        cell.taskIndicatorColor.layer.borderColor=[UIColor orangeColor].CGColor;
        cell.taskIndicatorColor.backgroundColor=[UIColor orangeColor];
    }
    else{
        cell.taskIndicatorColor.layer.borderColor=[UIColor greenColor].CGColor;
        cell.taskIndicatorColor.backgroundColor=[UIColor greenColor];
    }
    
    
    
    
    
    
    //  cell.taskImage.image=[UIImage imageNamed:@"todo"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    NSInteger row=indexPath.section;
    printf("roooow%ld",(long)row);
    NSDictionary *task=[myListOfTasks objectAtIndex:row];
    vc.taskDictionary=task;
    vc.UpdateTaskDelegate=self;
    vc.indexOfCurrentTask=indexPath.section;
     NSString *savedTaskStatus=[task objectForKey:@"status"];
    if([savedTaskStatus isEqualToString:@"TO DO"]){
         
        vc.statusMode=@"TO DO";
       }
       else if([savedTaskStatus isEqualToString:@"In progress"]){
          vc.statusMode=@"In progress";
       }
       else{
          vc.statusMode=@"Done";
       }
    
    
    
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [filteredTasks removeAllObjects];
    if ([searchText isEqualToString:@""]) {
        isFiltered=false;
    }
    else{
        for (NSDictionary*dic in myListOfTasks) {
            isFiltered=true;
            NSString *savedTaskName=[dic objectForKey:@"name"];
            if([savedTaskName localizedCaseInsensitiveContainsString:searchText]){
                
                [filteredTasks addObject:dic];
            }
        }
    }
    [_tasksTableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle ==UITableViewCellEditingStyleDelete){
        
        
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Do you want to delete that task ??"preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *noAction=[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *yesAction=[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self->myListOfTasks removeObjectAtIndex:indexPath.section];
            //   [self->  filteredTodoTasks removeObjectAtIndex:indexPath.row];
            
            
            [self->_tasksTableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                                 withRowAnimation:UITableViewRowAnimationFade];
            
            /*  [self->_tasksTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];*/
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsPath = [paths objectAtIndex:0];
            NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Tasks.plist"];
            NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:myListOfTasks format:NSPropertyListXMLFormat_v1_0 errorDescription:nil];
            
            if(plistData)
            {
                [plistData writeToFile:plistPath atomically:YES];
                
            }
        }];
        [alert addAction:noAction];
        [alert addAction:yesAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}


@end
