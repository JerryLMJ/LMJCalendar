//
//  LMJCalendarProcessingCenter.h
//  LMJCalendar
//
//  Version:1.0.0
//
//  日期处理中心
//  主要对日历中日期相关运算的处理
//
//  Created by MajorLi on 14-11-5.
//  Copyright (c) 2014年 iOS开发者公会. All rights reserved.
//
//  iOS开发者公会-技术1群 QQ群号：87440292
//  iOS开发者公会-技术2群 QQ群号：232702419
//  iOS开发者公会-议事区  QQ群号：413102158
//

#import <Foundation/Foundation.h>

#import "LMJCalendarDateYearModel.h"
#import "LMJCalendarDateMonthModel.h"
#import "LMJCalendarDateDayModel.h"
#import "LMJCalendarItemModel.h"

@interface LMJCalendarProcessingCenter : NSObject

@property (nonatomic,strong) LMJCalendarDateDayModel * systemDate;

@property (nonatomic,strong) LMJCalendarDateMonthModel * currentMonth;


+(LMJCalendarProcessingCenter *)sharProcessingCenter;

-(LMJCalendarDateDayModel *)systemDate;

//某月需展示的数据
-(NSArray *)dataArrayToShowOfTheMonth:(LMJCalendarDateMonthModel *)month;//返回数组元素为LMJCalendarItemModel类型

//上一个月
-(LMJCalendarDateMonthModel *)previousMonthOfCurrentMonth:(LMJCalendarDateMonthModel *)month;
//下一个月
-(LMJCalendarDateMonthModel *)nextMonthOfCurrentMonth:(LMJCalendarDateMonthModel *)month;


//某一天是周几
-(NSInteger)weekdayOfSomeday:(LMJCalendarDateDayModel *)day;
@end
