//
//  FormatTime.h
//  ChiHao
//
//  Created by ruiduan ma on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormatTime : NSObject
+(NSString *)getCurrentTime;
+(CFAbsoluteTime)getAbsoluteTime:(NSString *)dateStr;
+(NSString *)getNSTime:(CFGregorianDate)time;
@end
