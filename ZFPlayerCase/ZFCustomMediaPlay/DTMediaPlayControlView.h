//
//  DTMediaPlayControl.h
//  ZFPlayerCase
//
//  Created by 黄小刚 on 2018/12/29.
//  Copyright © 2018年 黄小刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZFPlayer/ZFPlayer.h>

/**
 视频播放控制层主要实现<ZFPlayerMediaControl>协议(涉及视频状态相关、视频进度、屏幕旋转、手势、scrollView上的播放器视图方法)
 */
@interface DTMediaPlayControlView : UIView<ZFPlayerMediaControl>


@end
