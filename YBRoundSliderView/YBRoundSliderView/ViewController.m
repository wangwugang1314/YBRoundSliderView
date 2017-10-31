//
//  ViewController.m
//  YBRoundSliderView
//
//  Created by 王亚彬 on 2017/10/31.
//  Copyright © 2017年 王亚彬. All rights reserved.
//

#import "ViewController.h"
#import "YBRoundSliderView.h"

@interface ViewController () <YBRoundSliderViewDelegate>

@property (nonatomic,weak) UILabel *numLable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = [UIScreen mainScreen].bounds.size.width * 0.9;
    YBRoundSliderView *sliderView = [YBRoundSliderView new];
    sliderView.bounds = CGRectMake(0, 0, width, width);
    sliderView.center = self.view.center;
    [self.view addSubview:sliderView];
    
    [sliderView setOpenJiaoDu:60 withLineNum:100 radius:100 lineLength:50];
    sliderView.ybDelegate = self;
    sliderView.value = 50;
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 30);
    [self.view addSubview:label];
    self.numLable = label;
}


- (void)roundSliderView:(YBRoundSliderView *)view selIndex:(NSInteger)index isStop:(BOOL)isStop {
    self.numLable.text = [NSString stringWithFormat:@"%ld", index];
}



@end
