//
//  LMJCalendarView.m
//  LMJCalendar
//
//  Version:1.0.0
//
//  Created by MajorLi on 14-11-5.
//  Copyright (c) 2014年 iOS开发者公会. All rights reserved.
//
//  iOS开发者公会-技术1群 QQ群号：87440292
//  iOS开发者公会-技术2群 QQ群号：232702419
//  iOS开发者公会-议事区  QQ群号：413102158
//

#import "LMJCalendarView.h"

#import "LMJCalendarProcessingCenter.h"
#import "LMJCalendarShowCellGenerator.h"

#define CalendarView_Width     310
#define CalendarView_Height    287

#define ProcessingCenter [LMJCalendarProcessingCenter sharProcessingCenter]

@implementation LMJCalendarView
{
    LMJCalendarDateMonthModel * _currentMonth;
    
    UILabel * _yearAndMonthLabel;
}

-(void)setFrame:(CGRect)frame{
    CGRect rect = CGRectMake(frame.origin.x, frame.origin.y, CalendarView_Width, CalendarView_Height);
    [super setFrame:rect];
}

- (id)initWithFrame:(CGRect)frame
{
    CGRect rect = CGRectMake(frame.origin.x, frame.origin.y, CalendarView_Width, CalendarView_Height);
    self = [super initWithFrame:rect];
    if (self) {
        [self createCalendarView];
        
        [self setCurrentMonth];
    }
    return self;
}



-(void)test{

    
}

-(void)createCalendarView{
    //整个轮廓阴影 ----------------- 背景
    UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CalendarView_Width, CalendarView_Height)];
    [backgroundImageView setImage:[UIImage imageNamed:@"bg_calendar"]];
    backgroundImageView.userInteractionEnabled = YES;
    [self addSubview:backgroundImageView];
    
    
    
    
    //标题年月切换栏 --------------- 背景
    UIImageView * headBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, CalendarView_Width -15, 30)];
    [headBackgroundImageView setImage:[UIImage imageNamed:@"bg_calendar_header"]];
    headBackgroundImageView.userInteractionEnabled = YES;
    [backgroundImageView addSubview:headBackgroundImageView];
    //标题年月切换栏 ---- 左按钮
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(60, 5, 20, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"btn_previous_month"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"btn_previous_month_highlight"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(clickedPreviousOrNextButton:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 101;
    [headBackgroundImageView addSubview:leftBtn];
    //标题年月切换栏 ---- 显示年月label
    _yearAndMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 95, 20)];
    LMJCalendarDateDayModel * model = [ProcessingCenter systemDate];
    _yearAndMonthLabel.text = [NSString stringWithFormat:@"%d年%d月",model.year,model.month];
    _yearAndMonthLabel.textColor = [UIColor whiteColor];
    _yearAndMonthLabel.textAlignment = NSTextAlignmentCenter;
    _yearAndMonthLabel.font = [UIFont systemFontOfSize:16];
    [headBackgroundImageView addSubview:_yearAndMonthLabel];
    //标题年月切换栏 ---- 右按钮
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(215, 5, 20, 20)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"btn_next_month"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"btn_next_month_highlight"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(clickedPreviousOrNextButton:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.tag = 102;
    [headBackgroundImageView addSubview:rightBtn];
    
    
    
    
    //星期栏 ---------------------- 背景
    UIImageView * weekbarBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 38, CalendarView_Width -15, 20)];
    [weekbarBackgroundImageView setImage:[UIImage imageNamed:@"bg_calendar_week_header"]];
    weekbarBackgroundImageView.userInteractionEnabled = YES;
    [self addSubview:weekbarBackgroundImageView];
    //星期栏 ---------- 星期标题
    NSArray * weekTitleArray = [NSArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    for (int i = 0; i <7; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(42 *i, 0, 42, 20)];
        label.text = [weekTitleArray objectAtIndex:i];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        [weekbarBackgroundImageView addSubview:label];
    }
    
}

-(void)setCurrentMonth{
    _currentMonth = [[LMJCalendarDateMonthModel alloc] init];
    LMJCalendarDateDayModel * day = [ProcessingCenter systemDate];
    _currentMonth.year  = day.year;
    _currentMonth.month = day.month;
    
    _yearAndMonthLabel.text = [NSString stringWithFormat:@"%d年%d月",_currentMonth.year,_currentMonth.month];
    
    [self showCalendarWithTheMonth:_currentMonth];
}

-(void)clickedPreviousOrNextButton:(UIButton *)button{
    switch (button.tag) {
        case 101:
        {
            LMJCalendarDateMonthModel * model = [ProcessingCenter previousMonthOfCurrentMonth:_currentMonth];
            _currentMonth.year = model.year;
            _currentMonth.month = model.month;
            
            _yearAndMonthLabel.text = [NSString stringWithFormat:@"%d年%d月",_currentMonth.year,_currentMonth.month];
            
            for (UIView * view in self.subviews) {
                if (view.tag >= 3300) {
                    [view removeFromSuperview];
                }
            }
            
            [self showCalendarWithTheMonth:_currentMonth];
        }
            break;
        case 102:
        {
            LMJCalendarDateMonthModel * model = [ProcessingCenter nextMonthOfCurrentMonth:_currentMonth];
            _currentMonth.year = model.year;
            _currentMonth.month = model.month;
            
            _yearAndMonthLabel.text = [NSString stringWithFormat:@"%d年%d月",_currentMonth.year,_currentMonth.month];
            
            for (UIView * view in self.subviews) {
                if (view.tag >= 3300) {
                    [view removeFromSuperview];
                }
            }

            [self showCalendarWithTheMonth:_currentMonth];
        }
            break;
        default:
            break;
    }
}


-(void)showCalendarWithTheMonth:(LMJCalendarDateMonthModel *)month{
    NSArray * dataArray = [ProcessingCenter dataArrayToShowOfTheMonth:month];

    for (int i = 0; i <dataArray.count ; i++) {
        UIView * cellView = [[LMJCalendarShowCellGenerator sharGenerator] createViewWithCalendarDataItem:[dataArray objectAtIndex:i]];
        [cellView setFrame:CGRectMake(7 +42*(i%7)+2, 63 +35*(i/7), 38, 30)];
        cellView.tag = 3300 + i;
        [self addSubview:cellView];
    }
}



@end
