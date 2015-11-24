//
//  RootViewController.m
//  日历
//
//  Created by LiMingjie on 14-11-6.
//  Copyright (c) 2014年 LiMingjie. All rights reserved.
//

#import "RootViewController.h"

#import "LMJCalendarView.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    LMJCalendarView * calendarView = [[LMJCalendarView alloc] initWithFrame:CGRectMake(5, 100, 0, 0)];
    [self.view addSubview:calendarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
