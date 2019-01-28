//
//  TableZoomVC.m
//  ImgBrower
//
//  Created by 黄小刚 on 2019/1/27.
//  Copyright © 2019年 黄小刚. All rights reserved.
//

#import "TableZoomVC.h"
#import "ZoomFooterView.h"

// 1.全局宽、高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface TableZoomVC ()<UITableViewDelegate,UITableViewDataSource>

/**
   缩放的表格
 */
@property (nonatomic, strong) UITableView *zoomTable;


@property (nonatomic, strong) UIView *footerView; /* 底部视图 */

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation TableZoomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"点击表格缩放";

    [self.view addSubview:self.zoomTable];
    
    self.dataSource = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
}


#pragma mark - ####### UITableViewDelegate、UITableViewDataSource #######

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.dataSource.count > 3) {
        return 3;
    }
    
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (UITableView *)zoomTable {
    if (!_zoomTable) {
        CGRect rect = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _zoomTable = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _zoomTable.delegate = self;
        _zoomTable.dataSource = self;
        _zoomTable.tableFooterView = self.footerView;
        [_zoomTable dequeueReusableCellWithIdentifier:@"id"];
    }
    return _zoomTable;
}

- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [[ZoomFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60.0f)];
        _footerView.backgroundColor = [UIColor lightGrayColor];
    }
    return _footerView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
