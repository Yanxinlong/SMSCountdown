# SMSCountdown
短信倒计时按钮
=========================

创建倒计时按钮
-------------------------
```javascript
_timerButton = [[CountDownButton alloc] initWithFrame:CGRectMake(100, 100, 80, 32)];
    
[_timerButton setEnabled:YES];//    当需要输完手机号码才能点击发送验证码时可以设置为NO；
_timerButton.indexStart = 60;
__weak typeof(self) weakSelf = self;
_timerButton.tapBlock = ^{
    [weakSelf timerButtonAction];
};

[self.view addSubview:_timerButton];
```
