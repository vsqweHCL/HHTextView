//
//  HHTextView.m
//  自定义TextView
//
//  Created by HCL黄 on 16/11/4.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

#import "HHTextView.h"

@interface HHTextView ()

@property(nonatomic,weak)UILabel *placehoderLabel;
@end

@implementation HHTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    // 添加占位label
    UILabel *placehoderLabel = [[UILabel alloc] init];
    placehoderLabel.numberOfLines = 0;
    placehoderLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:placehoderLabel];
    self.placehoderLabel = placehoderLabel;
    
    //设置默认颜色
    self.placehoderColor = [UIColor lightGrayColor];
    
    // 设置默认字体
    self.font = [UIFont systemFontOfSize:15];
    
    //监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

- (void)textDidChange{
    // text属性：只包括普通的文本字符串
    // attributedText属性
    self.placehoderLabel.hidden = (self.attributedText.length != 0);
}
// 重写setAttributedtext
-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}
-(void)setPlacehoder:(NSString *)placehoder{
    
    _placehoder = [placehoder copy];
    // 设置文字
    self.placehoderLabel.text = placehoder;
    
    // 重新计算子控件
    [self setNeedsLayout];
}
-(void)setPlacehoderColor:(UIColor *)placehoderColor{
    // 强引用复制一下
    _placehoderColor = placehoderColor;
    // 设置颜色
    self.placehoderLabel.textColor = placehoderColor;
}
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placehoderLabel.font = font;
    // 重新计算子控件
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat placehoderX = 5;
    CGFloat placehoderY = 10;
    CGFloat placehoderW = self.frame.size.width - 2 * placehoderX;
    // 根据文字计算label的高度
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIFont systemFontOfSize:15]};
    CGSize maxSize = CGSizeMake(placehoderW, MAXFLOAT);
    ;
    CGFloat placehoderH = [self.placehoder boundingRectWithSize:maxSize
                                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                             attributes:dic
                                                                context:nil].size.height;
    self.placehoderLabel.frame = CGRectMake(placehoderX, placehoderY, placehoderW, placehoderH);
}

@end
