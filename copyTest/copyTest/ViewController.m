//
//  ViewController.m
//  copyTest
//
//  Created by 代上 on 2019/6/25.
//  Copyright © 2019 代上. All rights reserved.
//

#import "ViewController.h"
//#import "AMap.h"
//#import "XiaoliaoSDK_iOS/XianliaoApiObject.h"
//#import "XiaoliaoSDK_iOS/XianliaoApiManager.h"
//#import "WeChat/WXApi.h"
//#import "GVoice/include/GVoice.h"

@interface ViewController ()<UITextViewDelegate>

//@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, strong) NSTimer *pollTimer;

@property (strong, nonatomic) NSString *fileID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(50, 50, 100, 50)];
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:textView];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 200, 60, 30);
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(150, 200, 60, 30);
    startBtn.backgroundColor = [UIColor greenColor];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];

    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stopBtn.frame = CGRectMake(150, 250, 60, 30);
    stopBtn.backgroundColor = [UIColor greenColor];
    [stopBtn setTitle:@"停止" forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(stopBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];

    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.frame = CGRectMake(150, 300, 60, 30);
    playBtn.backgroundColor = [UIColor greenColor];
    [playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    

    NSLog(@"test123123");

//    [XianliaoApiManager registerApp:@"yapSYw221SGViW7N"];
    
//    [WXApi registerApp:@"wx237da1b77a172eeb"];
    
//    // Step1:设置基本业务信息
//    [[GVGCloudVoice sharedInstance] setAppInfo:"1651703699" withKey:"d412269e64da844842bba3c2ec561e56" andOpenID:"001"];
//
//    // Step2:初始化引擎
//    [[GVGCloudVoice sharedInstance] initEngine];
//
//    // Step3:设置回调
//    [GVGCloudVoice sharedInstance].delegate = self;
//
//    [[GVGCloudVoice sharedInstance] setMode:Messages];
//
//    // Step4:定时调用Poll函数，驱动引擎回调
//    _pollTimer = [NSTimer scheduledTimerWithTimeInterval:1.000/15 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [[GVGCloudVoice sharedInstance] poll];
//    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}

//- (void)startBtnClick
//{
//    [[GVGCloudVoice sharedInstance] applyMessageKey:10000];
//
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *_filePath = [NSString stringWithFormat:@"%@/%s", docPath, "voice.dat"];
//    [[GVGCloudVoice sharedInstance] startRecording:[_filePath cStringUsingEncoding:NSUTF8StringEncoding]];
//}
//
//- (void)stopBtnClick
//{
//    [[GVGCloudVoice sharedInstance] stopRecording];
//
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *_filePath = [NSString stringWithFormat:@"%@/%s", docPath, "voice.dat"];
//    [[GVGCloudVoice sharedInstance] uploadRecordedFile:[_filePath cStringUsingEncoding:NSUTF8StringEncoding] timeout:18000];
//}
//
//- (void)playBtnClick
//{
////    NSString *_fileID = [NSString stringWithFormat:@"%s", _fileID];//从上传完成回调接口中获取fileID
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *_downFilePath = [NSString stringWithFormat:@"%@/%s", docPath, "voice_downlad.dat"];
//    [[GVGCloudVoice sharedInstance] downloadRecordedFile:[_fileID cStringUsingEncoding:NSUTF8StringEncoding] filePath:[_downFilePath cStringUsingEncoding:NSUTF8StringEncoding] timeout:18000];
//}

- (void)btnClick
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
//
//    UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
//    NSString *copyStr = [copyFW copyAndCleanPasteboard];
//    NSLog(@"copyStr:%@ ---- clean:%@",copyStr,pasteboard.string);
//    //写入
//    BOOL copy = [copyFW writePasteboard:@"测试内容"];
//    if (copy)
//    {
//        NSLog(@"成功");
//    }else
//    {
//        NSLog(@"失败");
//    }
//
//    NSLog(@"write:%@",pasteboard.string);
//
//    //清空
//    [copyFW cleanPasteboard];
//    NSLog(@"clean:%@",pasteboard.string);
    
//    [AMap registKey:@"be271609c7280b69f6f2d087c816b84f"];
//    NSString *loactionStr = [AMap getLocation:0];
//    NSLog(@"位置：%@",loactionStr);
//    [AMap test];
//    [AMap getLocation];
    
//    [[AMapServices sharedServices] setEnableHTTPS:YES];
//    [AMapServices sharedServices].apiKey = @"be271609c7280b69f6f2d087c816b84f";
//
//    self.locationManager = [[AMapLocationManager alloc] init];
//
//    // 带逆地理信息的一次定位（返回坐标和地址信息）
//    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
//    //   定位超时时间，最低2s，此处设置为10s
//    self.locationManager.locationTimeout = 10;
//    //   逆地理请求超时时间，最低2s，此处设置为10s
//    self.locationManager.reGeocodeTimeout = 10;
//
//    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
//    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
//
//        if (error)
//        {
//            NSLog(@"error:%@",error);
//        }else
//        {
//            NSLog(@"位置：%f",location.coordinate.latitude);
//        }
//
//    }];
    
//    [self getLocation];
//    [self xianliaoShare];
//    [self xianliaoLogin];
//    [self weixinLogin];
//    [self weixinShare];
    
}

//- (void)xianliaoLogin
//{
//    [XianliaoApiManager loginState:@"sugram_login_state" fininshBlock:^(XianliaoLoginCallBackType callBackType, NSString *code, NSString *state) {
//        NSString *loginString = [NSString stringWithFormat:@"callBackType:%lu, code:%@, state:%@", (unsigned long)callBackType, code, state];
////        self.textView.text = loginString;
//        NSLog(@"callBackType:%lu, code:%@, state:%@", (unsigned long)callBackType, code, state);
//        NSLog(@"登录信息%@",loginString);
//    }];
//}
//
//- (void)xianliaoShare
//{
//    if ([XianliaoApiManager isInstallXianliao]) {
//        XianliaoShareTextObject *textObject = [[XianliaoShareTextObject alloc] init];
//        textObject.text = @"分享的内容";
//        [XianliaoApiManager share:textObject fininshBlock:^(XianliaoShareCallBackType callBackType) {
//            NSLog(@"callBackType:%ld", (long)callBackType);
//        }];
//    }else{
//        NSLog(@"未安装");
//    }
//}


//- (void)weixinLogin
//{
//    //构造SendAuthReq结构体
//    SendAuthReq* req = [[SendAuthReq alloc] init];
//    req.scope = @"snsapi_userinfo";
//    req.state = @"123";
//    //第三方向微信终端发送一个SendAuthReq消息结构
//    [WXApi sendReq:req];
//}


//- (NSString *)getLocatin
//{
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//
//    __block NSString *locationStr = @"";
//    dispatch_async(queue, ^{
//
//        // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
//        [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
//
//            if (error)
//            {
//                locationStr = @"获取失败";
//            }else
//            {
//                locationStr = [NSString stringWithFormat:@"%@,%@",@(location.coordinate.latitude),@(location.coordinate.longitude)];
//
//                NSLog(@"经纬度：%@",locationStr);
//            }
//            dispatch_semaphore_signal(semaphore);
//        }];
//
//        //信号量减1，如果>0，则向下执行，否则等待
//
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//
//        NSLog(@"位置：%@",locationStr);
//    });
//
//    return nil;
//}
//
//
//- (NSString *)getLocation
//{
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    __block NSString *locationStr = @"";
//    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
//    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
//
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            if (error)
//            {
//                locationStr = @"获取失败";
//            }else
//            {
//                locationStr = [NSString stringWithFormat:@"%@,%@",@(location.coordinate.latitude),@(location.coordinate.longitude)];
//
//                NSLog(@"经纬度：%@",locationStr);
//            }
//            dispatch_semaphore_signal(semaphore);
//        });
//
//    }];
//
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//
//    NSLog(@"位置：%@",locationStr);
//    return locationStr;
//}

//#pragma mark - 语音代理
//- (void) onUploadFile: (enum GCloudVoiceCompleteCode) code withFilePath: (const char * _Nullable)filePath andFileID:(const char * _Nullable)fileID  {
//    _fileID = [NSString stringWithFormat:@"%s", fileID];
//
//}
//
//- (void) onDownloadFile: (enum GCloudVoiceCompleteCode) code  withFilePath: (const char * _Nullable)filePath andFileID:(const char * _Nullable)fileID {
//    NSString *msg;
//    msg = @"Download File Success";
//
//    [[GVGCloudVoice sharedInstance] playRecordedFile:filePath];
//
//}
//
//- (void) onPlayRecordedFile:(enum GCloudVoiceCompleteCode) code withFilePath: (const char * _Nullable)filePath {
//
//    NSString *msg;
//    msg = @"Finish Play File";
//
//}
//
//- (void) onApplyMessageKey:(enum GCloudVoiceCompleteCode) code {
//    NSString *msg;
//    msg = @"Apply AuthKey Success";
//
//}


@end
