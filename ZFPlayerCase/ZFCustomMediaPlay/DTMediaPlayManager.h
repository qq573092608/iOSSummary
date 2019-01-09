//
//  DTMediaPlayManager.h
//  ZFPlayerCase
//
//  Created by 黄小刚 on 2018/12/29.
//  Copyright © 2018年 黄小刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ZFPlayer/ZFPlayer.h>

/**
   播放器SDK(播放器的参数配置信息包括音量、亮度、播放的设置)，要求只要实现 <ZFPlayerMediaPlayback>协议即可
 */
@interface DTMediaPlayManager : NSObject<ZFPlayerMediaPlayback>

@end
