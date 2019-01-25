
#import "UIColor+Extension.h"

@implementation UIColor (Extension)
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}


#pragma mark --- 常用颜色
+(UIColor*)DTBgColor{
    return [UIColor colorWithHexString:@"F5FCFF"];
}

+(UIColor*)DTBlackBgColor{
    return  [UIColor colorWithHexString:@"252A2E"];
}

+(UIColor*)DTGrayBgColor{
    return [UIColor colorWithHexString:@"E9F2F6"];
}

+(UIColor*)DTGrayTitleColor{
     return [UIColor colorWithHexString:@"9DACBB"];
}

+(UIColor*)DTGrayBlackTitleColor{
       return [UIColor colorWithHexString:@"415366"];
}

+(UIColor*)DTBlueTitleColor{
    return  [UIColor colorWithHexString:@"4FC1FE"];
}

+(UIColor*)DTGreenTitleColor{
    return  [UIColor colorWithHexString:@"91D841"];
}

+(UIColor*)DTRedTitleColor{
      return  [UIColor colorWithHexString:@"FF5876"];
}

@end
