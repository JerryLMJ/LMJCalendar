//
//  LMJCalendarShowCellGenerator.h
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

#import <Foundation/Foundation.h>

#import "LMJCalendarItemModel.h"

@interface LMJCalendarShowCellGenerator : NSObject

+(LMJCalendarShowCellGenerator *)sharGenerator;


-(UIView *)createViewWithCalendarDataItem:(LMJCalendarItemModel *)item;

@end
