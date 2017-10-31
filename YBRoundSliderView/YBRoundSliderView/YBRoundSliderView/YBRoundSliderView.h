//
//  YBRoundSliderView.h
//  Round
//
//  Created by FuYun on 16/7/12.
//  Copyright © 2016年 FuYun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YBRoundSliderView;

#define YBRoundSliderViewDianJiMin 0.4

@protocol YBRoundSliderViewDelegate <NSObject>

- (void)roundSliderView:(YBRoundSliderView *)view selIndex:(NSInteger)index isStop:(BOOL)isStop;

@end

@interface YBRoundSliderView : UIButton

@property(nonatomic, weak) id<YBRoundSliderViewDelegate> ybDelegate;
/// 是否画图
@property(nonatomic, assign) BOOL isDraw;
/// 对应没有排序的索引
@property(nonatomic, assign) unsigned char value;
/// 角度（下面张开的角度）(不能放在viewDidLoad里面这个时候拿到的数据是错误的)
- (void)setOpenJiaoDu:(CGFloat)openJiaoDu withLineNum:(NSInteger)lineNum radius:(CGFloat)radids lineLength:(CGFloat)length;

@end
