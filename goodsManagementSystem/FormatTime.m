//
//  FormatTime.m
//  ChiHao
//
//  Created by ruiduan ma on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FormatTime.h"

@implementation FormatTime

//格式化当前时间 199001101201
+(NSString *)getCurrentTime
{
    NSDate *_date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateTime = [[format stringFromDate:_date] substringToIndex:12];
    return dateTime;
}

//当前时间转化为格里高利时间
+(CFAbsoluteTime)getAbsoluteTime:(NSString *)dateStr
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd"];
    NSDate *oneDay =[date dateFromString:dateStr];
    
    NSDate *xDay = [date dateFromString:@"2001-01-01"];
        
    NSTimeInterval late=[xDay timeIntervalSince1970]*1;
    
    NSTimeInterval now=[oneDay timeIntervalSince1970]*1;
    
    CFAbsoluteTime cha = now - late;
    return cha;
}

//将格里高利格式化成xxxx-xx-xx格式
+(NSString *)getNSTime:(CFGregorianDate)time
{
    NSString *year = [NSString stringWithFormat:@"%d",time.year];
    NSString *month;
    NSString *day;
    if (time.month>9) {
        month = [NSString stringWithFormat:@"%d",time.month];
    }
    else {
        month = [NSString stringWithFormat:@"0%d",time.month];
    }
    
    if (time.day>9) {
        day = [NSString stringWithFormat:@"%d",time.day];
    }
    else {
        day = [NSString stringWithFormat:@"0%d",time.day];
    }
    
    return [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
}

@end
