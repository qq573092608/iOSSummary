//
//  UILabel+Extension.h
//  DTDigitalCampusStudent_iPad
//
//  Created by 范枚龙 on 2018/9/18.
//  Copyright © 2018年 东田教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
@property (assign,nonatomic)  CGFloat wordSpace;
@property (assign,nonatomic)  CGFloat lineSpace;
-(void)setLineSpace:(CGFloat)lineSpace AndWordSpace:(CGFloat)wordSpace;

+(UILabel*)DTLabelWithTitle:(NSString*)title WithTextColor:(UIColor*)textColor WithFontFloat:(CGFloat)fontFloat;
@end
