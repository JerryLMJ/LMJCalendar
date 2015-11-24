//
//  LMJCalendarItemModel.h
//  LMJCalendar
//
//  Version:1.0.0
//
//  数据模型 -- 日期元素 （继承于LMJCalendarDateDayModel）
//
//  Created by MajorLi on 14-11-5.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LMJCalendarDateDayModel.h"
//继承于LMJCalendarDateDayModel
@interface LMJCalendarItemModel : LMJCalendarDateDayModel

@property (assign,nonatomic) BOOL isSelected;//是否已经选择

@property (assign,nonatomic) BOOL isOperational;//是否可选

@property (assign,nonatomic) BOOL isCurrentMonthsDay;//是否是当前月的日期

@end
