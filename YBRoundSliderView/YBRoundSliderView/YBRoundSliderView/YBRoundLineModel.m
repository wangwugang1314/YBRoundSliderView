//
//  YBRoundLineModel.m
//  Round
//
//  Created by FuYun on 16/7/12.
//  Copyright © 2016年 FuYun. All rights reserved.
//

#import "YBRoundLineModel.h"

#define RoundLineModelBigLength 3

@implementation YBRoundLineModel

#pragma mark - setter
- (void)setJiaoDu:(CGFloat)jiaoDu{
    _jiaoDu = jiaoDu < 0 ? jiaoDu + 360.0 : jiaoDu;
}

+ (instancetype)roundLineModelWithJiaoDu:(CGFloat)jiaoDu radius:(CGFloat)radids lineLength:(CGFloat)length center:(CGPoint)center{
    YBRoundLineModel *model = [YBRoundLineModel new];
    model.jiaoDu = jiaoDu;
    
    CGFloat countJiaoDu;
    if (jiaoDu > 0 && jiaoDu <= 90) {
        
        countJiaoDu = model.jiaoDu;
        model.star_x = center.x + radids * cos(countJiaoDu / 180 * M_PI);
        model.star_y = center.y - radids * sin(countJiaoDu / 180 * M_PI);
        model.stop_x = center.x + (radids + length) * cos(countJiaoDu / 180 * M_PI);
        model.stop_y = center.y - (radids + length) * sin(countJiaoDu / 180 * M_PI);
        
        model.star1_x = center.x + (radids - RoundLineModelBigLength) * cos(countJiaoDu / 180 * M_PI);
        model.star1_y = center.y - (radids - RoundLineModelBigLength) * sin(countJiaoDu / 180 * M_PI);
        model.stop1_x = center.x + (radids + RoundLineModelBigLength + length) * cos(countJiaoDu / 180 * M_PI);
        model.stop1_y = center.y - (radids + RoundLineModelBigLength + length) * sin(countJiaoDu / 180 * M_PI);
    }else if (jiaoDu > 90 && jiaoDu <= 180){
        
        countJiaoDu = model.jiaoDu - 90;
        model.star_x = center.x - radids * sin(countJiaoDu / 180 * M_PI);
        model.star_y = center.y - radids * cos(countJiaoDu / 180 * M_PI);
        model.stop_x = center.x - (radids + length) * sin(countJiaoDu / 180 * M_PI);
        model.stop_y = center.y - (radids + length) * cos(countJiaoDu / 180 * M_PI);
        
        model.star1_x = center.x - (radids - RoundLineModelBigLength) * sin(countJiaoDu / 180 * M_PI);
        model.star1_y = center.y - (radids - RoundLineModelBigLength) * cos(countJiaoDu / 180 * M_PI);
        model.stop1_x = center.x - (radids + RoundLineModelBigLength + length) * sin(countJiaoDu / 180 * M_PI);
        model.stop1_y = center.y - (radids + RoundLineModelBigLength + length) * cos(countJiaoDu / 180 * M_PI);
    }else if (jiaoDu > 180 && jiaoDu <= 270){
        
        countJiaoDu = model.jiaoDu - 180;
        model.star_x = center.x - radids * cos(countJiaoDu / 180 * M_PI);
        model.star_y = center.y + radids * sin(countJiaoDu / 180 * M_PI);
        model.stop_x = center.x - (radids + length) * cos(countJiaoDu / 180 * M_PI);
        model.stop_y = center.y + (radids + length) * sin(countJiaoDu / 180 * M_PI);
        
        model.star1_x = center.x - (radids - RoundLineModelBigLength) * cos(countJiaoDu / 180 * M_PI);
        model.star1_y = center.y + (radids - RoundLineModelBigLength) * sin(countJiaoDu / 180 * M_PI);
        model.stop1_x = center.x - (radids + RoundLineModelBigLength + length) * cos(countJiaoDu / 180 * M_PI);
        model.stop1_y = center.y + (radids + RoundLineModelBigLength + length) * sin(countJiaoDu / 180 * M_PI);
    }else{
        countJiaoDu = model.jiaoDu - 270;
        model.star_x = center.x + radids * sin(countJiaoDu / 180 * M_PI);
        model.star_y = center.y + radids * cos(countJiaoDu / 180 * M_PI);
        model.stop_x = center.x + (radids + length) * sin(countJiaoDu / 180 * M_PI);
        model.stop_y = center.y + (radids + length) * cos(countJiaoDu / 180 * M_PI);
        
        model.star1_x = center.x + (radids - RoundLineModelBigLength) * sin(countJiaoDu / 180 * M_PI);
        model.star1_y = center.y + (radids - RoundLineModelBigLength) * cos(countJiaoDu / 180 * M_PI);
        model.stop1_x = center.x + (radids + RoundLineModelBigLength + length) * sin(countJiaoDu / 180 * M_PI);
        model.stop1_y = center.y + (radids + RoundLineModelBigLength + length) * cos(countJiaoDu / 180 * M_PI);
        model.jiaoDu = jiaoDu - 360;
    }
    
    return model;
}

@end
