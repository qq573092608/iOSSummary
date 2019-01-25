//
//  UIColor+Extension.h
//  DTDigitalCampusStudent_iPad
//
//  Created by 范枚龙 on 2018/9/11.
//  Copyright © 2018年 东田教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


//特殊颜色配置
+(UIColor*)DTBgColor;
+(UIColor*)DTBlackBgColor;
+(UIColor*)DTGrayBgColor;
+(UIColor*)DTGrayTitleColor;
+(UIColor*)DTGrayBlackTitleColor;
+(UIColor*)DTBlueTitleColor;
+(UIColor*)DTGreenTitleColor;
+(UIColor*)DTRedTitleColor;

@end
