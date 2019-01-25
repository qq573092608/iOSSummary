

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
//字间距
-(CGFloat)wordSpace{
    return 3;
}

-(void)setWordSpace:(CGFloat)wordSpace{
    NSString *labelText = self.text;
    if (labelText.length == 0) {
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

//行间距
-(CGFloat)lineSpace{
    return 3;
}

-(void)setLineSpace:(CGFloat)lineSpace{
    NSString *labelText = self.text;
    if (labelText.length == 0) {
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}


-(void)setLineSpace:(CGFloat)lineSpace AndWordSpace:(CGFloat)wordSpace{
    NSString *labelText = self.text;
    if (labelText.length == 0) {
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
    
}

#pragma mark --- 快速创建
+(UILabel*)DTLabelWithTitle:(NSString*)title WithTextColor:(UIColor*)textColor WithFontFloat:(CGFloat)fontFloat{
    UILabel *label = [[UILabel alloc]init];
    label.text  = title;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontFloat];
    return label;
}
@end
