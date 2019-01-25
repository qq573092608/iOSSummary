

#import "DTLessonPlanViewController.h"
#import "UIColor+Extension.h"
#import "Masonry.h"
#import "UILabel+Extension.h"

@interface DTLessonPlanViewController ()<UIScrollViewDelegate>

// 1.全局宽、高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@property (strong,nonatomic)  NSArray *dataArr; /** <#属性说明#> */
@property (strong,nonatomic)  UILabel *pageLabel; /** 页面展示label */
@property (assign,nonatomic)  UIDeviceOrientation lastOrientation; /** 屏幕上一次的方向 */
@property (assign,nonatomic)  NSInteger currentItem; /** 当前的页码 */

@property (nonatomic, strong) UIScrollView *imgBrowerScrollView;  // 图片浏览滚动视图
@property (nonatomic, strong) UIPageControl *imgBrowerPageControl; // 图片浏览翻页视图

@end

@implementation DTLessonPlanViewController
{
    float offset;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lastOrientation = [[UIDevice currentDevice] orientation];
    self.title = @"28.2直觉三角形教学设计.docx";
    _dataArr = @[@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1149604226,3297619402&fm=200&gp=0.jpg",
                @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537273084789&di=b73c59b1f2e9d475e2fa896c63a26ad0&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fd53f8794a4c27d1e5b9d31e711d5ad6eddc4385d.jpg",
                @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537273084786&di=523eadc5c1eab7212006c30cb39f743a&imgtype=0&src=http%3A%2F%2Fpic11.nipic.com%2F20101119%2F6239728_231052061272_2.jpg",
                @"http://img5.duitang.com/uploads/item/201411/07/20141107164412_v284V.jpeg",
                @"https://pic4.zhimg.com/v2-59c77a6eee94c9776abaebe03b8e4d88_1200x500.jpg",
                @"http://i.epochtimes.com/assets/uploads/2018/08/VCG111162180243_meitu_1-600x400.jpg",
                @"http://c4.haibao.cn/img/690_1035_100_0/1517830031.2778/f41aa45bf2ec30eba28e54ffa66679ae.jpg",
                @"https://n.sinaimg.cn/ent/transform/775/w630h945/20180717/7Tz_-hfkffam0189172.jpg",
                @"http://vd1.bdstatic.com/mda-hijd25magzig3gju/mda-hijd25magzig3gju.jpg",
                @"https://n.sinaimg.cn/ent/transform/20170210/rkz4-fyamvns4416151.jpg"];
    [self setUpForUI];
    
    self.imgBrowerPageControl.currentPage = 6;
    CGRect visible = CGRectMake(6 * kScreenWidth, 0, kScreenWidth, kScreenHeight);
    [self.imgBrowerScrollView scrollRectToVisible:visible animated:NO];
    
 //   ADDNOTIFICATION(UIDeviceOrientationDidChangeNotification, deviceOrientationDidChange:)
}


-(void)setUpForUI{
    
    [self.view addSubview:self.imgBrowerScrollView];
    
    for (int i = 0 ; i < _dataArr.count; i ++) {
        UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTap setNumberOfTapsRequired:2];
        CGRect childScrollViewFrame = self.imgBrowerScrollView.frame;
        UIScrollView *imgVscroll = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, childScrollViewFrame.size.width, childScrollViewFrame.size.height)];
        // 一定要给scrollView打上下标
        imgVscroll.tag =  i;
        imgVscroll.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                               alpha:1];
        imgVscroll.contentSize = CGSizeMake(childScrollViewFrame.size.width, 0);
        imgVscroll.delegate = self;
        imgVscroll.minimumZoomScale = 1.0;
        imgVscroll.maximumZoomScale = 3.0;
        //        s.tag = i+1;
        [imgVscroll setZoomScale:1.0];
        
        __weak typeof(self) weakSelf = self;
        NSURL *url = [NSURL URLWithString:_dataArr[i]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imgData = [NSData dataWithContentsOfURL:url];
            UIImage *img = [UIImage imageWithData:imgData];
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                float pointY = 0;
                if (img.size.height > childScrollViewFrame.size.height ) {
                    pointY = 0;
                } else {
                    pointY = (childScrollViewFrame.size.height - 64.0f - 44.0f - img.size.height) * 0.5;
                }
                
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, pointY, childScrollViewFrame.size.width, img.size.height)];
                imgView.contentMode = UIViewContentModeScaleAspectFit;
                imgView.userInteractionEnabled = YES;
                imgView.tag = i + 1;
                [imgView addGestureRecognizer:doubleTap];
                imgView.image = img;
                [imgVscroll addSubview:imgView];
                
                [weakSelf.imgBrowerScrollView addSubview:imgVscroll];
            });
        });
    }
    
    [self.view addSubview:self.imgBrowerPageControl];
    [self.imgBrowerPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    // 添加底部视图
    [self setBottomView];
}

- (void)setBottomView {
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"434E57"];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.mas_equalTo(64);
    }];
    
    NSString *showPageNumStr = [NSString stringWithFormat:@"%d/%lu",6 + 1,(unsigned long)_dataArr.count];
    _pageLabel = [UILabel DTLabelWithTitle:showPageNumStr WithTextColor:[UIColor whiteColor] WithFontFloat:20];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:_pageLabel];
    [_pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
        make.width.mas_equalTo(200);
    }];
    
    UIButton *leftBtn = [[UIButton alloc]init];
    leftBtn.tag = 0;
    [leftBtn addTarget:self action:@selector(leftRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"arrow-left-tap"] forState:0];
    
    [bottomView addSubview:leftBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(64);
        make.centerY.offset(0);
        make.right.equalTo(self.pageLabel.mas_left);
    }];
    
    UIButton *rightBtn = [[UIButton alloc]init];
    rightBtn.tag = 1;
    [rightBtn addTarget:self action:@selector(leftRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"arrow-right-tap"] forState:0];
    [bottomView addSubview:rightBtn];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(64);
        make.centerY.offset(0);
        make.left.equalTo(self.pageLabel.mas_right);
    }];
}

#pragma mark - ScrollView Delegate  // 返回一个放大或者缩小的视图
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}

-(void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer{
    
    NSLog(@"gestureRecognizer....");
    
    if (gestureRecognizer.numberOfTapsRequired == 2) {
        UIScrollView *tempScroll = (UIScrollView*)gestureRecognizer.view.superview;
        if(tempScroll.zoomScale == 1){
            float newScale = [tempScroll zoomScale] *2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
            [tempScroll zoomToRect:zoomRect animated:YES];
        }else{
            float newScale = [tempScroll zoomScale]/2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
            [tempScroll zoomToRect:zoomRect animated:YES];
        }
    }
}


#pragma mark - 缩放大小获取方法
-(CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    //大小
    zoomRect.size.height = [self.imgBrowerScrollView frame].size.height/scale;
    zoomRect.size.width = [self.imgBrowerScrollView frame].size.width/scale;
    //原点
    zoomRect.origin.x = center.x - zoomRect.size.width/2;
    zoomRect.origin.y = center.y - zoomRect.size.height/2;
    return zoomRect;
}

// pageControl绑定的方法，来控制_scrollView的偏移量的
- (void)actionCotrolPage:(id)sender
{
    [self.imgBrowerScrollView setContentOffset:CGPointMake(self.imgBrowerPageControl.currentPage * kScreenWidth, 0) animated:YES];
}

//​UIScrollView的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.imgBrowerPageControl.currentPage = self.imgBrowerScrollView.contentOffset.x / kScreenWidth;
    _pageLabel.text = [NSString stringWithFormat:@"%@/%@",@((long)self.imgBrowerPageControl.currentPage+
                       1),@(self.dataArr.count)];
    
    if (scrollView == self.imgBrowerScrollView){
        CGFloat x = scrollView.contentOffset.x;
        if (x== offset){
            
        } else {
            offset = x;
            for (UIScrollView *s in scrollView.subviews){
                if ([s isKindOfClass:[UIScrollView class]]){
                    [s setZoomScale:1.0];
                }
            }
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    NSLog(@"viewWillTransitionToSize.......");
    NSLog(@"kScreenWidth:%f ===== >kScreenHeight:%f",kScreenWidth,kScreenHeight);
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"after ===>kScreenWidth:%f ===== >kScreenHeight:%f",kScreenWidth,kScreenHeight);
        self.imgBrowerScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        CGSize imgBrowerSize = CGSizeMake(kScreenWidth * weakSelf.dataArr.count, kScreenHeight);
        [self.imgBrowerScrollView setContentSize:imgBrowerSize];
        [self.imgBrowerScrollView setNeedsLayout];
        [self.imgBrowerScrollView layoutIfNeeded];
        
        CGRect visible = CGRectMake(self.imgBrowerPageControl.currentPage * kScreenWidth, 0, kScreenWidth, kScreenHeight);
        [self.imgBrowerScrollView scrollRectToVisible:visible animated:NO];
        
        // 下面注释内容虽然可以解决布局问题 但是会导致内容错乱
        for (int i = 0 ; i < self.imgBrowerScrollView.subviews.count; i++) {
            // 通过下标来定位具体的scrollView
            UIScrollView *scrV = self.imgBrowerScrollView.subviews[i];
            // 一定要加上kScreenWidth * scrV.tag 这个标志要不然滚动位置会出现混乱
            scrV.frame = CGRectMake(kScreenWidth * scrV.tag, 0, kScreenWidth, kScreenHeight);
            UIImageView *imageView = scrV.subviews[0];
            UIImage *img = imageView.image;
            float pointY = 0;
            if (img.size.height > scrV.frame.size.height ) {
                pointY = 0;
            } else {
                pointY = (scrV.frame.size.height - 64.0f - 44.0f - img.size.height) * 0.5;
            }
            
            imageView.frame = CGRectMake(0, pointY, scrV.frame.size.width, img.size.height);
        }
    });
}

-(void)leftRightBtnClick:(UIButton*)btn{
    if (btn.tag) {
        self.imgBrowerPageControl.currentPage += 1;
    } else {
        self.imgBrowerPageControl.currentPage -= 1;
    }
    CGRect moveRect = CGRectMake(kScreenWidth * self.imgBrowerPageControl.currentPage, 0, self.imgBrowerScrollView.frame.size.width, self.imgBrowerScrollView.frame.size.height);
    [self.imgBrowerScrollView scrollRectToVisible:moveRect animated:NO];
    [self.imgBrowerPageControl updateCurrentPageDisplay];
    _pageLabel.text = [NSString stringWithFormat:@"%@/%@",@(self.imgBrowerPageControl.currentPage + 1),@(self.dataArr.count)];
}

#pragma mark - ####### Lazy load #######
- (UIScrollView *)imgBrowerScrollView
{
    if (!_imgBrowerScrollView) {
        CGRect scrollViewrect = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _imgBrowerScrollView = [[UIScrollView alloc] initWithFrame:scrollViewrect];
        _imgBrowerScrollView.pagingEnabled = YES;
        _imgBrowerScrollView.delegate = self;
        _imgBrowerScrollView.scrollsToTop = NO;
        
        _imgBrowerScrollView.showsVerticalScrollIndicator = NO;
        _imgBrowerScrollView.showsHorizontalScrollIndicator = NO;
        _imgBrowerScrollView.minimumZoomScale = 1;
        _imgBrowerScrollView.maximumZoomScale = 3;
        
        CGSize imgBrowerSize = CGSizeMake(kScreenWidth * _dataArr.count, kScreenHeight);
        [_imgBrowerScrollView setContentSize:imgBrowerSize];
    }
    return _imgBrowerScrollView;
}

- (UIPageControl *)imgBrowerPageControl
{
    if (!_imgBrowerPageControl) {
        _imgBrowerPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 400, 320, 30)];
        _imgBrowerPageControl.numberOfPages = _dataArr.count;
        _imgBrowerPageControl.currentPage = 0;
        _imgBrowerPageControl.alpha = 0;
        [_imgBrowerPageControl addTarget:self
                                      action:@selector(actionCotrolPage:)
                            forControlEvents:UIControlEventValueChanged];
    }
    return _imgBrowerPageControl;
}

@end
