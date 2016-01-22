//
//  LMJCalendarProcessingCenter.m
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

#import "LMJCalendarProcessingCenter.h"

@implementation LMJCalendarProcessingCenter

+(LMJCalendarProcessingCenter *)sharProcessingCenter{
    static LMJCalendarProcessingCenter * center = nil;
    @synchronized(self){
        if (center == nil) {
            center = [[LMJCalendarProcessingCenter alloc] init];
        }
    }
    return center;
}

-(LMJCalendarDateDayModel *)systemDate{
    NSDate * date=[NSDate date];
    
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString * dateString=[dateFormatter stringFromDate:date];
    
    NSArray * valueArr = [dateString componentsSeparatedByString:@"-"];
    
    LMJCalendarDateDayModel * theDate = [[LMJCalendarDateDayModel alloc] init];
    theDate.year = [[valueArr objectAtIndex:0] integerValue];
    theDate.month = [[valueArr objectAtIndex:1] integerValue];
    theDate.day = [[valueArr objectAtIndex:2] integerValue];
    
    return theDate;
}
//上一个月
-(LMJCalendarDateMonthModel *)previousMonthOfCurrentMonth:(LMJCalendarDateMonthModel *)month{
    
    LMJCalendarDateMonthModel * monthDate = [[LMJCalendarDateMonthModel alloc] init];
    
    if (month.month -1 <1) {
        monthDate.month = 12;
        monthDate.year = month.year -1;
    }else{
        monthDate.month = month.month -1;
        monthDate.year = month.year;
    }
    
    return monthDate;
}
//下一个月
-(LMJCalendarDateMonthModel *)nextMonthOfCurrentMonth:(LMJCalendarDateMonthModel *)month{
    
    LMJCalendarDateMonthModel * monthDate = [[LMJCalendarDateMonthModel alloc] init];
    
    if (month.month +1 >12) {
        monthDate.month = 1;
        monthDate.year = month.year +1;
    }else{
        monthDate.month = month.month +1;
        monthDate.year = month.year;
    }
    
    return monthDate;
}
//某月需展示的数据
-(NSArray *)dataArrayToShowOfTheMonth:(LMJCalendarDateMonthModel *)month{
    NSMutableArray * dataArray = [[NSMutableArray alloc] init];
    
    LMJCalendarDateMonthModel * previousMonth = [self previousMonthOfCurrentMonth:month]; //上个月
    LMJCalendarDateMonthModel * nextMonth     = [self nextMonthOfCurrentMonth:month];     //下个月
    
    NSInteger numberDaysOfPreviousMonth       = [self daysOfTheMonth:previousMonth];      //上个月天数
    NSInteger numberDaysOfCurrentMonth        = [self daysOfTheMonth:month];              //当前月天数
//    NSInteger numberDaysOfNextMonth           = [self daysOfTheMonth:nextMonth];          //下个月天数
    
    LMJCalendarDateDayModel * dayModel = [[LMJCalendarDateDayModel alloc] init];
    dayModel.year  = month.year;
    dayModel.month = month.month;
    dayModel.day   = 1;
    //当前月1号是周几
    NSInteger weekdayNumber = [self weekdayOfSomeday:dayModel];//周日是“1”，周一是“2”。。。。
    
    //上个月的展示数据
    for (NSInteger n = numberDaysOfPreviousMonth -(weekdayNumber -1) +1; n <= numberDaysOfPreviousMonth; n++) {
        
        LMJCalendarItemModel * item = [[LMJCalendarItemModel alloc] init];
        item.year                 =    previousMonth.year;
        item.month                =    previousMonth.month;
        item.day                  =    n;
        item.isSelected           =    NO;
        item.isOperational        =    NO;
        item.isCurrentMonthsDay   =    NO;
        
        [dataArray addObject:item];
    }
    //当前月的展示数据
    for (NSInteger n = 1; n <= numberDaysOfCurrentMonth; n++) {
        
        LMJCalendarItemModel * item = [[LMJCalendarItemModel alloc] init];
        item.year                 =    month.year;
        item.month                =    month.month;
        item.day                  =    n;
        item.isSelected           =    NO;
        item.isCurrentMonthsDay   =    YES;
        if (n == self.systemDate.day) {
            item.isOperational    =    YES;
        }else{
            item.isOperational    =    NO;
        }
        
        [dataArray addObject:item];
    }
    
    //下个月的展示数据
    NSInteger count = 0;
    if ((numberDaysOfCurrentMonth - (8 -weekdayNumber))%7 == 0) {
        count = 0;
    }else{
        count = 7 -((numberDaysOfCurrentMonth - (8 -weekdayNumber))%7);
    }
    
    for (NSInteger n = 1; n <= count; n++) {
        LMJCalendarItemModel * item = [[LMJCalendarItemModel alloc] init];
        item.year                 =    nextMonth.year;
        item.month                =    nextMonth.month;
        item.day                  =    n;
        item.isSelected           =    NO;
        item.isOperational        =    NO;
        item.isCurrentMonthsDay   =    NO;
        
        [dataArray addObject:item];
    }
    
    return dataArray;
}

//某一天是周几
-(NSInteger)weekdayOfSomeday:(LMJCalendarDateDayModel *)day{//周日是“1”，周一是“2”。。。。
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString * dateString = [NSString stringWithFormat:@"%d-%d-%d",day.year,day.month,day.day];
    NSDate * date = [dateFormatter dateFromString:dateString];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit) fromDate:date];
    
    return [comps weekday]; //今年的第几周
}

//是否是闰年
-(BOOL)isLeapYearWithYear:(LMJCalendarDateYearModel *)year{
    if (year.year%4 == 0 && year.year%100 != 0) {
        return YES;
    }
    if (year.year%400 == 0) {
        return YES;
    }
    
    return NO;
}

//判定某年的某月有多少天
-(NSInteger)daysOfTheMonth:(LMJCalendarDateMonthModel *)month{
    
    if (month.month == 1 || month.month == 3 || month.month == 5 || month.month == 7 || month.month == 8 || month.month == 10 || month.month == 12) {
        return 31;
    }
    if (month.month == 4 || month.month == 6 || month.month == 9 || month.month == 11) {
        return 30;
    }
    if (month.month == 2) {
        if ([self isLeapYearWithYear:month]) {
            return 29;
        }else{
            return 28;
        }
    }
    
    return 0;
}

@end
