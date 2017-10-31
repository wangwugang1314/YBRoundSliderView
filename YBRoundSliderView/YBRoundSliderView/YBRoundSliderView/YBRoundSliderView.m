//
//  YBRoundSliderView.m
//  Round
//
//  Created by FuYun on 16/7/12.
//  Copyright © 2016年 FuYun. All rights reserved.
//

#import "YBRoundSliderView.h"
#import "YBRoundLineModel.h"

#define YBColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
/// 渐变范围胡
#define YBRoundSliderViewJianBianNum 0.2
/// 线条到边上的圆距离
#define YBRoundSliderViewLineToRoundInterval 10
/// 角度相差间隔
#define YBRoundSliderViewJiaoDuCha 10
/// 圆形线条宽度
#define YBRoundSliderViewRoundLineWith 2
/// 线条宽度
#define YBRoundSliderViewLineWidth 2
/// 滑动点线条宽度
#define YBRoundSliderViewSliderLineWidth 4

@interface YBRoundSliderView()

/// 图形数组
@property(nonatomic, strong) NSArray *dataArr;
/// 索引
@property(nonatomic, assign) NSInteger currentIndex;
/// 没有排序的索引
@property(nonatomic, strong) NSArray *dataArr1;
/// openJiaoDu
@property(nonatomic, assign) CGFloat openJiaoDu;
/// 一个的角度
@property(nonatomic, assign) CGFloat oneJiaoDu;
/// 最边边的半径
@property(nonatomic, assign) CGFloat bianLength;


@end

@implementation YBRoundSliderView

#pragma mark - 按钮点击 UIGestureRecognizer
- (void)movePoint:(CGPoint)point{
    CGFloat centerX = self.frame.size.width * 0.5;
    CGFloat centerY = self.frame.size.height * 0.5;
    CGFloat jiaoDu;
    if (point.x > centerX && point.y <= centerY) { // 第一象限
        jiaoDu = [self jiaoDuWithH:centerY - point.y v:point.x - centerX andAddNun:0];
    }else if (point.x <= centerX && point.y < centerY){
        jiaoDu = [self jiaoDuWithH:centerX - point.x v:centerY - point.y andAddNun:90];
    }else if (point.x < centerX && point.y >= centerY){
        jiaoDu = [self jiaoDuWithH:point.y - centerY v:centerX - point.x andAddNun:180];
    }else if (point.x >= centerX && point.y > centerY){
        jiaoDu = [self jiaoDuWithH:point.x - centerX v:point.y - centerY andAddNun:270];
    }
    
    NSLog(@"===== %f", jiaoDu);
    
    // 角度超出直接返回
    if(jiaoDu < 0 || jiaoDu > 360) return;
    if (jiaoDu > 270 - self.openJiaoDu * 0.5 + YBRoundSliderViewJiaoDuCha && jiaoDu < 270 + self.openJiaoDu * 0.5 - YBRoundSliderViewJiaoDuCha) return;
    
    if(jiaoDu > 270 - self.openJiaoDu * 0.5 && jiaoDu < 270){
        if (self.value == 0) return;
        self.value = 0;
    }else if (jiaoDu < 270 + self.openJiaoDu * 0.5 && jiaoDu > 270){
        if (self.value == self.dataArr.count - 1) return;
        self.value  =self.dataArr.count -1;
    }else{
        NSInteger index;
        index = [self indexWithJiaoDu:jiaoDu];
        if(index > self.dataArr.count) return;
        if (self.currentIndex == index) return;
        self.currentIndex = index;
    }
    self.isDraw = YES;
}

/// 查找对应的索引
- (NSInteger)indexWithJiaoDu:(CGFloat)jiaoDu{
    jiaoDu = jiaoDu >= 270 ? jiaoDu - 360 : jiaoDu;
    NSLog(@"jiaoDu = %f", jiaoDu);
    // 获取对象（二分查找法）
    NSInteger qian = 0;
    NSInteger hou = self.dataArr.count - 1;
    NSInteger index;
    CGFloat interval = self.oneJiaoDu * 0.5;
    while (1) {
        YBRoundLineModel *model;
        index = (hou + qian) / 2;
        model = self.dataArr[index];
        if (index == qian) {
            if ((jiaoDu >= model.jiaoDu - interval) && (jiaoDu <= model.jiaoDu + interval)) {
                return qian;
            }
            return 1000;
        }
        if (jiaoDu >= model.jiaoDu) {
            if (jiaoDu <= model.jiaoDu + interval) {
                return index;
            }
            qian = index;
        }else{
            if (jiaoDu >= model.jiaoDu - interval) {
                return index;
            }
            hou = index;
        }
    }
}

/// 计算角度
- (CGFloat)jiaoDuWithH:(CGFloat)h v:(CGFloat)v andAddNun:(CGFloat)addNum{
    CGFloat length = sqrt(h * h + v * v);
    if (length > self.frame.size.width * 0.5 || length < self.frame.size.width * 0.5 * YBRoundSliderViewDianJiMin) {
        return 1000;
    }
    return addNum + atan2(h, v) * 180 / M_PI;
}

#pragma mark - 画图
- (void)drawRect:(CGRect)rect{
    if (!self.isDraw) return;
    self.isDraw = NO;
    [self delegateFuncWithIsStop:NO];
    // 获取当前图形上下文
    CGContextRef contectRef = UIGraphicsGetCurrentContext();
    // 清空数据
    CGContextClearRect(contectRef, CGRectMake(0, 0, rect.size.width, rect.size.height));
    // 设置背景颜色
//    CGContextSetFillColorWithColor(contectRef, YBColor(44, 48, 62, 1).CGColor);
//    // 实现渲染
//    CGContextFillRect(contectRef, CGRectMake(0, 0, rect.size.width, rect.size.height));
    // 设置线条颜色
    CGContextSetStrokeColorWithColor(contectRef, [UIColor colorWithWhite:1 alpha:self.userInteractionEnabled ? 0.4 : 0.2].CGColor);
    // 设置线条宽度
    CGContextSetLineWidth(contectRef, YBRoundSliderViewRoundLineWith);
    
    CGFloat x = (self.frame.size.width - self.bianLength * 2) / 2 - YBRoundSliderViewLineToRoundInterval;
    CGFloat wid = self.bianLength * 2 + 2 * YBRoundSliderViewLineToRoundInterval;
    // 画一个内切圆
    CGContextAddEllipseInRect(contectRef, CGRectMake(x, x, wid, wid));
    // 空心渲染
    CGContextStrokePath(contectRef);
    
    CGFloat oneAlpha = (1 - YBRoundSliderViewJianBianNum) / (CGFloat)self.value;
    [self.dataArr1 enumerateObjectsUsingBlock:^(YBRoundLineModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 画线 e79d60
        if (idx < self.value) {
            UIColor *color = YBColor(0xe7, 0x9d, 0x60, (YBRoundSliderViewJianBianNum + oneAlpha * idx) * (self.userInteractionEnabled ? 1 : 0.5));
            CGContextSetStrokeColorWithColor(contectRef, color.CGColor);
            CGContextSetLineWidth(contectRef, YBRoundSliderViewLineWidth);
            CGContextMoveToPoint(contectRef, obj.star_x, obj.star_y);
            CGContextAddLineToPoint(contectRef, obj.stop_x, obj.stop_y);
        }else if(idx == self.value){
//            UIColor *color = YBColor(0xe7, 0x9d, 0x60, 1);
            UIColor *color = [UIColor colorWithWhite:1 alpha:self.userInteractionEnabled ? 1 : 0.5];
            CGContextSetStrokeColorWithColor(contectRef, color.CGColor);
            CGContextSetLineWidth(contectRef, YBRoundSliderViewSliderLineWidth);
            CGContextMoveToPoint(contectRef, obj.star1_x, obj.star1_y);
            CGContextAddLineToPoint(contectRef, obj.stop1_x, obj.stop1_y);
        }else{
            CGContextSetLineWidth(contectRef, YBRoundSliderViewLineWidth);
            CGContextSetStrokeColorWithColor(contectRef, [UIColor colorWithWhite:1 alpha:0.4  * (self.userInteractionEnabled ? 1 : 0.5)].CGColor);
            CGContextMoveToPoint(contectRef, obj.star_x, obj.star_y);
            CGContextAddLineToPoint(contectRef, obj.stop_x, obj.stop_y);
        }
        
        CGContextStrokePath(contectRef);
    }];
}

/// 角度（下面张开的角度）
- (void)setOpenJiaoDu:(CGFloat)openJiaoDu withLineNum:(NSInteger)lineNum radius:(CGFloat)radids lineLength:(CGFloat)length{
    self.openJiaoDu = openJiaoDu;
    self.bianLength = radids + length;
    // 计算每个间隔的角度
    self.oneJiaoDu = (360.0 - openJiaoDu) / (lineNum - 1);
    // 计算每个的角度
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSInteger i = 0; i < lineNum; i++) {
        YBRoundLineModel *model = [YBRoundLineModel roundLineModelWithJiaoDu:270.0 - openJiaoDu * 0.5 - (self.oneJiaoDu * i) radius:radids lineLength:length center:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5)];
        [mArr addObject:model];
        
        NSLog(@"%zd, starX = %f, starY = %f, endX = %f, endY = %f, :%f",i, model.star_x, model.star_y, model.stop_x, model.stop_y, model.jiaoDu);
    }
    self.dataArr1 = [mArr copy];
    // 按角度排序
    self.dataArr = [mArr sortedArrayUsingFunction:(sortByID) context:nil];
}

NSInteger sortByID(id obj1, id obj2, void *context){
    YBRoundLineModel *model1 =(YBRoundLineModel *) obj1;
    YBRoundLineModel *model2 =(YBRoundLineModel *) obj2;
    if (model1.jiaoDu > model2.jiaoDu) {
        return NSOrderedDescending;
    }
    return NSOrderedAscending;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.isDraw = YES;
}


#pragma mark - setter
- (void)setIsDraw:(BOOL)isDraw{
    _isDraw = isDraw;
    if (isDraw) {
        [self setNeedsDisplay];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    YBRoundLineModel *model = self.dataArr[currentIndex];
    self.value = [self.dataArr1 indexOfObject:model];
}

- (void)setEnabled:(BOOL)enabled{
    self.userInteractionEnabled = enabled;
    self.isDraw = YES;
}

#pragma mark - 移动
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self movePoint: [touch locationInView:self]];
    return YES;
}
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self movePoint: [touch locationInView:self]];
    return YES;
}
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self delegateFuncWithIsStop:YES];
}

#pragma mark - 代理
- (void)delegateFuncWithIsStop:(BOOL)isStop{
    // 执行代理
    if([self.ybDelegate respondsToSelector:@selector(roundSliderView:selIndex:isStop:)]){
        [self.ybDelegate roundSliderView:self selIndex:self.value isStop:isStop];
    }
}

@end

