//
//  YSShopCartNumberView.m
//  YaYouShangCheng
//
//  Created by 陈经纬 on 2018/2/6.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "FGShopCartNumberView.h"

#define borderCornerMin 0.0
#define borderCornerMax (self.frame.size.height / 2)
#define borderWidthMin 0.5
#define borderWidthMax 2.0


static NSString *const limitNumberText = @"0123456789";

@interface FGShopCartNumberView()<UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIButton *buttonReduce;
@property (nonatomic, strong) UIButton *buttonAddMore;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation FGShopCartNumberView

@synthesize number = _number;

#pragma mark - 视图

- (void)initializeInfo
{
//    _reduceTitleNormal = @"-";
    _reduceFont = [UIFont systemFontOfSize:12.0];
    _reduceTitleColorNormal = [UIColor blackColor];
    _reduceTitleColorHighlight = [UIColor redColor];
    
//    _addTitleNormal = @"+";
    _addFont = [UIFont systemFontOfSize:12.0];
    _addTitleColorNormal = [UIColor blackColor];
    _addTitleColorHighlight = [UIColor redColor];
    
    _textFont = [UIFont systemFontOfSize:12.0];
    _textColor = [UIColor blackColor];
    
    _multiple = 1;
    self.numberMin = 0;

}

- (void)setupViews
{
    
    
    
    self.buttonReduce = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.buttonReduce];
    self.buttonReduce.backgroundColor = [UIColor clearColor];
    [self.buttonReduce setTitle:_reduceTitleNormal forState:UIControlStateNormal];
    [self.buttonReduce setTitle:_reduceTitleNormal forState:UIControlStateHighlighted];
    [self.buttonReduce setTitleColor:_reduceTitleColorNormal forState:UIControlStateNormal];
    [self.buttonReduce setTitleColor:_reduceTitleColorHighlight forState:UIControlStateHighlighted];
    self.buttonReduce.titleLabel.font = _reduceFont;
    [self.buttonReduce addTarget:self action:@selector(buttonReduceClick) forControlEvents:UIControlEventTouchUpInside];
    UILongPressGestureRecognizer *reduceGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonReduceGesMoreLongPress:)];
    [self.buttonReduce addGestureRecognizer:reduceGes];

    
    
    self.textField = [[UITextField alloc] init];
    [self addSubview:self.textField];
    self.textField.backgroundColor = [UIColor clearColor];
//    self.textField.layer.borderColor = UIColorFromHex(0xdddddd).CGColor;
//    self.textField.layer.borderWidth = 0.8;
    self.textField.font = _textFont;
    self.textField.textColor = _textColor;
    self.textField.text = @"0";
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    self.textField.enabled = NO;
    
    self.buttonAddMore = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.buttonAddMore];
    self.buttonAddMore.backgroundColor = [UIColor clearColor];
    [self.buttonAddMore setTitle:_addTitleNormal forState:UIControlStateNormal];
    [self.buttonAddMore setTitle:_addTitleNormal forState:UIControlStateHighlighted];
    [self.buttonAddMore setTitleColor:_addTitleColorNormal forState:UIControlStateNormal];
    [self.buttonAddMore setTitleColor:_addTitleColorHighlight forState:UIControlStateHighlighted];
    self.buttonAddMore.titleLabel.font = _addFont;
    [self.buttonAddMore addTarget:self action:@selector(buttonAddMoreClick) forControlEvents:UIControlEventTouchDown];
    
    UILongPressGestureRecognizer *addGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAddMoreLongPress:)];
    [self.buttonAddMore addGestureRecognizer:addGes];

    [self initializeInfo];
}

- (void)setupLayout
{
    
    [self.buttonReduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.offset(0);
        make.width.height.mas_equalTo(AdaptedWidth(33));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(self.buttonReduce.mas_right).offset(AdaptedWidth(5));
        make.right.equalTo(self.buttonAddMore.mas_left).offset(AdaptedWidth(-5));
    }];
    
    [self.buttonAddMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.centerY.offset(0);
        make.width.height.mas_equalTo(AdaptedWidth(33));
    }];
    
}

#pragma mark - 响应

- (void)buttonReduceClick
{
    if ([self.textField isFirstResponder])
    {
        [self.textField resignFirstResponder];
    }
    
    NSString *numberText = self.textField.text;
    CGFloat number = numberText.floatValue;
    if (number > self.numberMin)
    {
        number -= _multiple;
        
        if ([@(_multiple).stringValue rangeOfString:@"."].length > 0) {
            numberText = [NSString stringWithFormat:@"%.1f", number];
        }else{
            numberText = [NSString stringWithFormat:@"%.0f", number];
        }
    }
//    else
//    {
//        numberText = @"0";
//    }
    self.textField.text = numberText;
    
    if (self.numberEdit)
    {
        self.numberEdit(number);
    }

}


/**
 长按减少
 */
- (void)buttonReduceGesMoreLongPress:(UIGestureRecognizer *)ges{
    
    if ([self.textField.text isEqualToString:@"0"]) {
        if (self.timer) {
            dispatch_source_cancel(self.timer);
            self.timer = nil;
        }
        return;
    }
    
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:{
            DLog(@"开始执行")
            
            [self startTimeWithIsAddType:NO];
            
        }
            
            break;
        case UIGestureRecognizerStateEnded:{
            DLog(@"结束执行")
            dispatch_source_cancel(self.timer);
            self.timer = nil;
        }
            
            break;
        default:
            break;
    }
}


/**
 点击增加
 */
- (void)buttonAddMoreClick
{
    
    if ([self.textField isFirstResponder])
    {
        [self.textField resignFirstResponder];
    }
    
    NSString *numberText = self.textField.text;
    CGFloat number = numberText.floatValue;
    number += _multiple;
    
    if (number  > self.numberMax && 0 < self.numberMax) {
        
        return;
    }
    
    if (number >= self.numberMax && 0 < self.numberMax)
    {
        number = self.numberMax;
    }
    if ([@(_multiple).stringValue rangeOfString:@"."].length > 0) {
        numberText = [NSString stringWithFormat:@"%.1f", number];
    }else{
        numberText = [NSString stringWithFormat:@"%.0f", number];
    }
    
    self.textField.text = numberText;
    
    if (self.numberEdit)
    {
        self.numberEdit(number);
    }
    
 
}


/**
 长按增加
 */
- (void)buttonAddMoreLongPress:(UIGestureRecognizer *)ges{
    

    NSString *numberText = self.textField.text;
    NSInteger number = numberText.integerValue;
    if (number  >= self.numberMax && 0 < self.numberMax) {
        if (self.timer) {
            dispatch_source_cancel(self.timer);
            self.timer = nil;
        }
        return;
    }
    
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:{
            DLog(@"开始执行")
            
            [self startTimeWithIsAddType:YES];
            
        }
            
            break;
            case UIGestureRecognizerStateEnded:{
                DLog(@"结束执行")

                dispatch_source_cancel(self.timer);
                self.timer = nil;
            }
            
            break;
        default:
            break;
    }
    
}


- (void)startTimeWithIsAddType:(BOOL)isAdd{


    
    if (self.timer) {
        return;
    }
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(0.1 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    // 设置回调
    WeakSelf
    dispatch_source_set_event_handler(self.timer, ^{
        StrongSelf
        NSLog(@"------------%@", [NSThread currentThread]);
        if (isAdd) {
            [self buttonAddMoreClick];
        }else{
            [self buttonReduceClick];
        }
        
        
    });
    // 启动定时器
    dispatch_resume(self.timer);
    

}



#pragma mark - UITextFieldDelegate




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder])
    {
        [textField resignFirstResponder];
    }
    
    NSString *numberText = self.textField.text;
    // 限制输入数字
    for (int i = 0; i < numberText.length; i++)
    {
        NSString *subText = [numberText substringWithRange:NSMakeRange(i, 1)];
        // 首个输入不能为0
        if (0 == i && subText.integerValue == 0)
        {
            numberText = [numberText stringByReplacingOccurrencesOfString:subText withString:@""];
        }
        
        NSRange range = [limitNumberText rangeOfString:subText];
        if (range.location == NSNotFound)
        {
            numberText = [numberText stringByReplacingOccurrencesOfString:subText withString:@""];
        }
    }
    
    // 限制最大值
    NSInteger number = numberText.integerValue;
    if (number >= self.numberMax && 0 < self.numberMax)
    {
        number = self.numberMax;
    }
    numberText = [NSString stringWithFormat:@"%@", @(number)];
    self.textField.text = numberText;
    
    if (self.numberEdit)
    {
        self.numberEdit(number);
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *regex = @"[0-9]";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pre evaluateWithObject:string] || [string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

#pragma mark - getter

//- (UIButton *)reduceButton
//{
//    return self.buttonReduce;
//}
//
//- (UIButton *)addButton
//{
//    return self.buttonAddMore;
//}

#pragma mark - setter
- (void)setCanEditing:(BOOL)canEditing{
    self.textField.enabled = canEditing;
}

- (void)setNumberMax:(CGFloat)numberMax{
    _numberMax = numberMax;
    
    WeakSelf
    [RACObserve(self.textField, text) subscribeNext:^(NSString * _Nullable x) {
        StrongSelf
        CGFloat num = x.floatValue;
        
        if (num >= self.numberMax) {
            self.buttonAddMore.enabled = NO;
        }else{
            self.buttonAddMore.enabled = YES;
        }
        
        if (num <= self.numberMin) {
            self.buttonReduce.enabled = NO;
        }else{
            self.buttonReduce.enabled = YES;
        }
    }];
}

- (void)setNumberMin:(CGFloat)numberMin{
    _numberMin = numberMin;
    WeakSelf
    [RACObserve(self.textField, text) subscribeNext:^(NSString * _Nullable x) {
        StrongSelf
        CGFloat num = x.floatValue;
        
        
        if (num <= self.numberMin) {
            self.buttonReduce.enabled = NO;
        }else{
            self.buttonReduce.enabled = YES;
        }
    }];
}

#pragma mark 减按钮

- (void)setReduceImageNormal:(UIImage *)reduceImageNormal
{
    _reduceImageNormal = reduceImageNormal;
    if (_reduceImageNormal)
    {
        [self.buttonReduce setTitle:nil forState:UIControlStateNormal];
        [self.buttonReduce setImage:_reduceImageNormal forState:UIControlStateNormal];
    }
}

- (void)setReduceImageHighlight:(UIImage *)reduceImageHighlight
{
    _reduceImageHighlight = reduceImageHighlight;
    if (_reduceImageHighlight)
    {
        [self.buttonReduce setTitle:nil forState:UIControlStateHighlighted];
        [self.buttonReduce setImage:_reduceImageHighlight forState:UIControlStateHighlighted];
    }
}

- (void)setReduceTitleNormal:(NSString *)reduceTitleNormal
{
    _reduceTitleNormal = reduceTitleNormal;
    if (_reduceTitleNormal)
    {
        [self.buttonReduce setTitle:_reduceTitleNormal forState:UIControlStateNormal];
        [self.buttonReduce setTitle:(_reduceTitleHighlight ? _reduceTitleHighlight : _reduceTitleNormal) forState:UIControlStateHighlighted];
    }
}

- (void)setReduceTitleHighlight:(NSString *)reduceTitleHighlight
{
    _reduceTitleHighlight = reduceTitleHighlight;
    if (_reduceTitleHighlight)
    {
        [self.buttonReduce setTitle:_reduceTitleHighlight forState:UIControlStateHighlighted];
    }
}

- (void)setReduceImageDisenable:(UIImage *)reduceImageDisenable{
    _reduceImageDisenable = reduceImageDisenable;
    if (_reduceImageDisenable)
    {
        [self.buttonReduce setTitle:nil forState:UIControlStateHighlighted];
        [self.buttonReduce setImage:_reduceImageDisenable forState:UIControlStateDisabled];
    }
}

- (void)setReduceFont:(UIFont *)reduceFont
{
    _reduceFont = reduceFont;
    if (_reduceFont)
    {
        self.buttonReduce.titleLabel.font = _reduceFont;
    }
}

- (void)setReduceTitleColorNormal:(UIColor *)reduceTitleColorNormal
{
    _reduceTitleColorNormal = reduceTitleColorNormal;
    if (_reduceTitleColorNormal)
    {
        [self.buttonReduce setTitleColor:_reduceTitleColorNormal forState:UIControlStateNormal];
    }
}

- (void)setReduceTitleColorHighlight:(UIColor *)reduceTitleColorHighlight
{
    _reduceTitleColorHighlight = reduceTitleColorHighlight;
    if (_reduceTitleColorHighlight)
    {
        [self.buttonReduce setTitleColor:_reduceTitleColorHighlight forState:UIControlStateHighlighted];
    }
}

#pragma mark 加按钮

- (void)setAddImageNormal:(UIImage *)addImageNormal
{
    _addImageNormal = addImageNormal;
    if (_addImageNormal)
    {
        [self.buttonAddMore setTitle:nil forState:UIControlStateNormal];
        [self.buttonAddMore setImage:_addImageNormal forState:UIControlStateNormal];
    }
}

- (void)setAddImageHighlight:(UIImage *)addImageHighlight
{
    _addImageHighlight = addImageHighlight;
    if (_addImageHighlight)
    {
        [self.buttonAddMore setTitle:nil forState:UIControlStateHighlighted];
        [self.buttonAddMore setImage:_addImageHighlight forState:UIControlStateHighlighted];
    }
}

- (void)setAddImageDisenable:(UIImage *)addImageDisenable{
    _addImageDisenable = addImageDisenable;
    if (_addImageDisenable)
    {
        [self.buttonAddMore setTitle:nil forState:UIControlStateHighlighted];
        [self.buttonAddMore setImage:_addImageDisenable forState:UIControlStateDisabled];
    }
}

- (void)setAddTitleNormal:(NSString *)addTitleNormal
{
    _addTitleNormal = addTitleNormal;
    if (_addTitleNormal)
    {
        [self.buttonAddMore setTitle:_addTitleNormal forState:UIControlStateNormal];
        [self.buttonAddMore setTitle:(_addTitleHighlight ? _addTitleHighlight : _addTitleNormal) forState:UIControlStateHighlighted];
    }
}

- (void)setAddTitleHighlight:(NSString *)addTitleHighlight
{
    _addTitleHighlight = addTitleHighlight;
    if (_addTitleHighlight)
    {
        [self.buttonAddMore setTitle:_addTitleHighlight forState:UIControlStateHighlighted];
    }
}

- (void)setAddFont:(UIFont *)addFont
{
    _addFont = addFont;
    if (_addFont)
    {
        self.buttonAddMore.titleLabel.font = _addFont;
    }
}

- (void)setAddTitleColorNormal:(UIColor *)addTitleColorNormal
{
    _addTitleColorNormal = addTitleColorNormal;
    if (_addTitleColorNormal)
    {
        [self.buttonAddMore setTitleColor:_addTitleColorNormal forState:UIControlStateNormal];
    }
}

- (void)setAddTitleColorHighlight:(UIColor *)addTitleColorHighlight
{
    _addTitleColorHighlight = addTitleColorHighlight;
    if (_addTitleColorHighlight)
    {
        [self.buttonAddMore setTitleColor:_addTitleColorHighlight forState:UIControlStateHighlighted];
    }
}

#pragma mark 编辑框

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    if (_textFont)
    {
        self.textField.font = _textFont;
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    if (_textColor)
    {
        self.textField.textColor = _textColor;
    }
}

- (void)setNumber:(CGFloat)number
{
    _number = number;
    
    NSString *numberText = @"0";
    if ([@(_multiple).stringValue rangeOfString:@"."].length > 0) {
        numberText = [NSString stringWithFormat:@"%.1f", number];
    }else{
        numberText = [NSString stringWithFormat:@"%.0f", number];
    }

    self.textField.text = numberText;
}

- (CGFloat)number
{
    return self.textField.text.floatValue;
}

- (void)setMultiple:(CGFloat)multiple{
    _multiple = multiple;
    
}


@end
