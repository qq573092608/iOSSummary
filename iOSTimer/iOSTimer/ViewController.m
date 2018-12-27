//
//  ViewController.m
//  iOSTimer
//
//  Created by 黄小刚 on 2018/12/27.
//  Copyright © 2018年 黄小刚. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()



@property (weak, nonatomic) IBOutlet UILabel *nsTimmerLbl;
@property (weak, nonatomic) IBOutlet UILabel *gcdTimerLbl;
@property (weak, nonatomic) IBOutlet UILabel *cdLinkTimerLbl;

@property(nonatomic,strong) NSTimer *downTimer;

@property (nonatomic, strong) CADisplayLink *linkTimer;

@end

static NSInteger  secondsDown = 60;

static NSInteger  displayLinkTimer = 60;


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self loadTimmerLbl];
    
    [self loadGcdLbl];
    
    [self loadCADisplayLink];
}

- (void)loadTimmerLbl
{
    self.downTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(timerDown)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void)timerDown
{
    secondsDown--;
    self.nsTimmerLbl.text=[NSString stringWithFormat:@"即将开始：%ld",(long)secondsDown];
    //当倒计时到0时做需要的操作，比如验证码过期不能提交
    if(secondsDown==0){
        
        [self.downTimer invalidate];
    }
}

- (void)loadGcdLbl
{
    __block NSInteger second = 60;
    // 全剧队列 默认优先级
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 定时器模式 事件源(初始化时间源)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // NSEC_PER_SEC是秒 *1是时间间隔(配置时间源 )
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
    // 绑定时间源指定执行的事件
    // 设置响应dispatch源事件的block，在dispatch源指定的队列上运行
    dispatch_source_set_event_handler(timer, ^{
        if (second >= 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.gcdTimerLbl.text = [NSString stringWithFormat:@"倒计时 %ld秒",(long)second];
            });
            
            second--;
        }
        else
        {
            //这句话必须写否则会出问题
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.gcdTimerLbl.text = [NSString stringWithFormat:@"倒计时完成"];
            });
        }
    });
    // 启动事件源
    dispatch_resume(timer);
}

- (void)loadCADisplayLink
{
    self.linkTimer = [CADisplayLink displayLinkWithTarget:self
                                                          selector:@selector(countTimer)];
    self.linkTimer.preferredFramesPerSecond = 1.0f;
    [self.linkTimer addToRunLoop: [NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)countTimer
{
    displayLinkTimer--;
    self.cdLinkTimerLbl.text = [NSString stringWithFormat:@"倒计时 %ld秒",(long)displayLinkTimer];
    
    if (secondsDown == 0) {
        self.cdLinkTimerLbl.text = [NSString stringWithFormat:@"倒计时完成"];
        [self.linkTimer invalidate];
        self.linkTimer = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
