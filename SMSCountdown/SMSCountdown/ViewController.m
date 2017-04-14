//
//  ViewController.m
//  SMSCountdown
//
//  Created by qhzc-iMac-02 on 2017/4/13.
//  Copyright © 2017年 Yxl. All rights reserved.
//

#import "ViewController.h"
#import "CountDownButton.h"

@interface ViewController ()

@property (nonatomic , strong)  CountDownButton *timerButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self creatCountdownButton];
}

- (void)creatUI {

}

- (void)creatCountdownButton {
    _timerButton = [[CountDownButton alloc] initWithFrame:CGRectMake(100, 100, 80, 32)];
    [_timerButton setEnabled:YES];
    _timerButton.indexStart = 60;
    __weak typeof(self) weakSelf = self;
    _timerButton.tapBlock = ^{
        [weakSelf timerButtonAction];
    };
    
    [self.view addSubview:_timerButton];
}

- (void)timerButtonAction {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_timerButton reStart];
    });
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_timerButton stopTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
