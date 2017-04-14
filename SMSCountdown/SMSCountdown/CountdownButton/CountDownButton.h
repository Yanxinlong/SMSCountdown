//
//  CountDownButton.h
//  SMSCountdown
//
//  Created by qhzc-iMac-02 on 2017/4/13.
//  Copyright © 2017年 Yxl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StartCountBlock)();
typedef void(^CdCompleteBlock)();

@interface CountDownButton : UIButton

@property(nonatomic,strong)NSString     *strCommon;     //按钮可用时的文本

@property(nonatomic,strong)NSString     *strPrefix;     //倒计时前缀

@property(nonatomic,strong)NSString     *strSuffix;     //倒计时后缀

@property(nonatomic,assign)int          indexStart;     //开始从几倒计时

@property(nonatomic,strong)UIColor      *colorDisable;  //按钮不可用时背景颜色

@property(nonatomic,strong)UIColor      *colorNormal;   //按钮可用时的背景颜色

@property(nonatomic,strong)UIColor      *colorDisableTitle;  //按钮不可用时文本颜色

@property(nonatomic,strong)UIColor      *colorNormalTitle;//按钮可用时文本颜色


@property (nonatomic, copy) StartCountBlock tapBlock;

@property (nonatomic, copy) CdCompleteBlock completeBlock;



- (void)startWithTime:(NSInteger)startTime;
- (void)reStart;
- (void)stopTimer;

@end
