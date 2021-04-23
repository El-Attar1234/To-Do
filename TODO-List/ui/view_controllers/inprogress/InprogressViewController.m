//
//  InprogressViewController.m
//  TODO-List
//
//  Created by Mahmoud Elattar on 4/5/21.
//  Copyright © 2021 ITI. All rights reserved.
//


#import "InprogressViewController.h"
#import "InprogressTableViewCell.h"

@interface InprogressViewController ()
{
    NSMutableArray *filteredProgressTasks,*filteredHighPriorityArray,*filteredMediumPriorityArray,*filteredLowPriorityArray;
    NSMutableArray *myListOfTasks;
    NSString *filePath;
    Boolean filtered;
      UILabel *label;
}
@property (weak, nonatomic) IBOutlet UIButton *sortButton;
@property (weak, nonatomic) IBOutlet UITableView *progressTableView;
@end

@implementation InprogressViewController{
    
}
- (void)viewWillAppear:(BOOL)animated{
    
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
    [_progressTableView setDelegate:self];
    [_progressTableView setDataSource:self];
    filtered=false;
    myListOfTasks=[NSMutableArray new];
    filteredProgressTasks=[NSMutableArray new];
    filteredHighPriorityArray=[NSMutableArray new];
    filteredMediumPriorityArray=[NSMutableArray new];
    filteredLowPriorityArray=[NSMutableArray new];
    _sortButton.layer.cornerRadius = 10;
    _sortButton.clipsToBounds = true;
    
    label=[[UILabel alloc]initWithFrame:CGRectMake(30, 450, 350, 50)];
       [label setBackgroundColor:[UIColor lightGrayColor]];
       [label setText:@"No Inprogress Tasks"];
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
    
}
-(void)filterarray{
    [filteredProgressTasks removeAllObjects];
    for (NSDictionary*dic in myListOfTasks) {
        NSString *savedTaskStatus=[dic objectForKey:@"status"];
        if([savedTaskStatus isEqualToString:@"In progress"]){
            [filteredProgressTasks addObject:dic];
        }
    }
    [_progressTableView reloadData];
    
}
- (IBAction)sortTasks:(id)sender {
    [self filterPriorityOfTasks];
}

-(void)filterPriorityOfTasks{
    if (filtered) {
        filtered=false;
    }else{
        filtered=true;
        
          [filteredHighPriorityArray removeAllObjects];
          [filteredMediumPriorityArray removeAllObjects];
          [filteredLowPriorityArray removeAllObjects];
          
          for (NSDictionary*dic in filteredProgressTasks) {
              NSString *savedTaskStatus=[dic objectForKey:@"priority"];
              if([savedTaskStatus isEqualToString:@"High"]){
                  [filteredHighPriorityArray addObject:dic];
              }
              else if ([savedTaskStatus isEqualToString:@"Medium"]){
                  [filteredMediumPriorityArray addObject:dic];
              }
              else{
                  [filteredLowPriorityArray addObject:dic];
                  
              }
            
              
          }
    }
  
      [_progressTableView reloadData];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (filtered) {
        return 3;
    }else{
        return 1;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger length;
    if (filtered) {
        switch (section) {
            case 0:
                length=filteredHighPriorityArray.count;
                break;
            case 1:
                   length=filteredMediumPriorityArray.count;
                break;
                
            default:
                   length=filteredLowPriorityArray.count;
                break;
        }
    }else{
        length=filteredProgressTasks.count;
        if (length==0) {
               [label setHidden:NO];
                  tableView.alpha=0;
                 
                  
                  
              }else{
                  [label setHidden:YES];
                  tableView.alpha=1;
              }
    }
   
    return length;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *task;
    InprogressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"InprogressTableViewCell" forIndexPath:indexPath];
    
    if (filtered) {
        switch (indexPath.section) {
             case 0:
                 task=[filteredHighPriorityArray objectAtIndex:indexPath.row];
                 break;
             case 1:
                     task=[filteredMediumPriorityArray objectAtIndex:indexPath.row];
                 break;
                 
             default:
                  task=[filteredLowPriorityArray objectAtIndex:indexPath.row];
                 break;
         }
     }else{
          task=[filteredProgressTasks objectAtIndex:indexPath.row];
     }
    cell.taskName.text=[task objectForKey:@"name"];
    cell.taskPriority.text=[task objectForKey:@"priority"];
    cell.taskIndicatorColor.layer.cornerRadius=25/2;
        cell.taskIndicatorColor.layer.borderWidth=3;
        cell.taskIndicatorColor.layer.borderColor=[UIColor orangeColor].CGColor;
        cell.taskIndicatorColor.backgroundColor=[UIColor orangeColor];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *header;
    
    if (filtered) {
           switch (section) {
                case 0:
                   header=@"High Priority";
                    break;
                case 1:
                   header=@"Medium Priority";
                    break;
                    
                default:
                   header=@"Low Priority";
                    break;
            }
        }else{
            header=@"";
        }
    return header;
}



@end
