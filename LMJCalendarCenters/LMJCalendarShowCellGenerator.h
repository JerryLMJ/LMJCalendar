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
//  Copyright (c) 2014年 iOS开发者公会. All rights reserved.
//
//  iOS开发者公会-技术1群 QQ群号：87440292
//  iOS开发者公会-技术2群 QQ群号：232702419
//  iOS开发者公会-议事区  QQ群号：413102158
//

#import <Foundation/Foundation.h>

#import "LMJCalendarItemModel.h"

@interface LMJCalendarShowCellGenerator : NSObject

+(LMJCalendarShowCellGenerator *)sharGenerator;


-(UIView *)createViewWithCalendarDataItem:(LMJCalendarItemModel *)item;

@end
