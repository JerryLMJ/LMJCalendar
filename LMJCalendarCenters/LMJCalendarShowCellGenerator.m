//
//  LMJCalendarShowCellGenerator.m
//  LMJCalendar
//
//  Version:1.0.0
//
//  展示单元生成器
//  主要根据提供的item数据生成不同种类的日期单元
//
//  Created by MajorLi on 14-11-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LMJCalendarShowCellGenerator.h"

#import "LMJCalendarProcessingCenter.h"


#define SystemDate [[LMJCalendarProcessingCenter sharProcessingCenter] systemDate]

@implementation LMJCalendarShowCellGenerator

+(LMJCalendarShowCellGenerator *)sharGenerator{
    static LMJCalendarShowCellGenerator * generator = nil;
    @synchronized(self){
        if (generator == nil) {
            generator = [[LMJCalendarShowCellGenerator alloc] init];
        }
    }
    return generator;
}

-(UIView *)createViewWithCalendarDataItem:(LMJCalendarItemModel *)item{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 30)];

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    if (item.isCurrentMonthsDay) {
        
        [button setBackgroundImage:[UIImage imageNamed:@"btn_grid_cell"] forState:UIControlStateNormal];
        
        if (item.month ==  SystemDate.month && item.year == SystemDate.year && item.day == SystemDate.day) {
            [button setBackgroundImage:[UIImage imageNamed:@"btn_grid_cell_selected"] forState:UIControlStateNormal];
        }
    }
    
    [view addSubview:button];
    
    
    //日期号label
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, view.frame.size.width, 20)];
    label.text = [NSString stringWithFormat:@"%d",item.day];
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    [button addSubview:label];
    
    return view;
}

@end
