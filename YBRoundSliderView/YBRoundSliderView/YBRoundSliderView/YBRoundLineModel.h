//
//  YBRoundLineModel.h
//  Round
//
//  Created by FuYun on 16/7/12.
//  Copyright © 2016年 FuYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBRoundLineModel : UIView

@property(nonatomic, assign) CGFloat star_x;
@property(nonatomic, assign) CGFloat star_y;
@property(nonatomic, assign) CGFloat stop_x;
@property(nonatomic, assign) CGFloat stop_y;

@property(nonatomic, assign) CGFloat star1_x;
@property(nonatomic, assign) CGFloat star1_y;
@property(nonatomic, assign) CGFloat stop1_x;
@property(nonatomic, assign) CGFloat stop1_y;

/// 角度
@property(nonatomic, assign) CGFloat jiaoDu;

+ (instancetype)roundLineModelWithJiaoDu:(CGFloat)jiaoDu radius:(CGFloat)radids lineLength:(CGFloat)length center:(CGPoint)center;

@end
