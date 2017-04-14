//
//  CountDownButton.m
//  SMSCountdown
//
//  Created by qhzc-iMac-02 on 2017/4/13.
//  Copyright © 2017年 Yxl. All rights reserved.
//

#import "CountDownButton.h"

@interface CountDownButton()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation CountDownButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatButton];
    }
    return self;
}

- (void)creatButton {
    self.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    
    self.layer.cornerRadius = 4;
    
    self.clipsToBounds = YES;
    
    [self setTitle:[_strCommon length] > 0 ? _strCommon : @"发送验证码" forState:UIControlStateNormal];
    [self setTitle:[_strCommon length] > 0 ? _strCommon : @"发送验证码" forState:UIControlStateDisabled];
    
    [self setTitleColor:_colorNormalTitle ? _colorNormalTitle : [UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:_colorDisableTitle ? _colorDisableTitle : [UIColor grayColor] forState:UIControlStateDisabled];
    
    [self addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setBackgroundImage:[UIImage imageNamed:@"icon_timeButtonNormal"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"icon_timeButtonEnable"] forState:UIControlStateDisabled];
    
}


#pragma mark - 点击事件
- (void)sendMessage:(UIButton *)button {
    [self startWithTime:_indexStart];
    
    if (self.tapBlock) {
        self.tapBlock();
    }
}

#pragma mark - 启动函数
- (void)startWithTime:(NSInteger)startTime {
    
    __block NSInteger timeLeft = startTime;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    if (_timer == nil) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    }
    
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if (timeLeft <= 0) {
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.completeBlock) {
                    self.completeBlock();
                }
                
                if (_timer) {
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                }
                
                [self setTitle:@"重新发送" forState:UIControlStateNormal];
                [self setTitle:@"重新发送" forState:UIControlStateDisabled];
                
                [self setEnabled:YES];
            });
            
        } else {
            
            NSString* title = [NSString stringWithFormat:@"   %@%ld%@   ",(_strPrefix ? _strPrefix : @"剩余"),timeLeft,(_strSuffix ? _strSuffix : @"秒")];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"剩余%@秒", title] forState:UIControlStateDisabled];
                
                [self setTitle:title forState:UIControlStateDisabled];
                [self setEnabled:NO];
            });
            
            timeLeft--;
            
        }
    });
    
    dispatch_resume(_timer);
}

- (void)reStart {
    dispatch_source_cancel(_timer);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (_timer) {
            dispatch_source_cancel(_timer);
            _timer = nil;
        }
        
        [self setTitle:@"重新发送" forState:UIControlStateNormal];
        [self setEnabled:YES];
    });
}

- (void)stopTimer {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}


@end
