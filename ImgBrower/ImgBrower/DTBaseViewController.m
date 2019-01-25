

#import "DTBaseViewController.h"

@interface DTBaseViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView *backGoundImageView;

@end

@implementation DTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //基类控制界面颜色、图片等
//    self.view.backgroundColor = EBOOK_BACKGROUND_COLOR;
    // [self addBackGroundImageView];
    
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
}
//添加图片背景
- (void)addBackGroundImageView{
    [self.view addSubview:self.backGoundImageView];
}



- (UIImageView *)backGoundImageView{
    if (!_backGoundImageView) {
        _backGoundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//        _backGoundImageView.backgroundColor = EBOOK_BACKGROUND_COLOR;
        
    }
    return _backGoundImageView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = _navHidden;
}

#pragma mark --- 旋转控制
-(BOOL)shouldAutorotate
{
    return YES;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
//设置特殊的界面支持方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return  UIInterfaceOrientationMaskAll;   
}
//方法过期???
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}
//vc初始显示的方向    返回现在正在显示的用户界面方向???

//** preferredInterfaceOrientationForPresentation 使用说明： **此方法也仅有在当前viewController是rootViewController或者是modal模式时才生效.
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
        return UIInterfaceOrientationPortrait;     //  UIInterfaceOrientationMaskAll;    //
}

@end
