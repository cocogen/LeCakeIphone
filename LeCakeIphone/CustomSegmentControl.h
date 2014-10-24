//
//  CustomSegmentControl.h
//  DzhIphone
//
//  Created by Billy on 13-6-18.
//  Copyright (c) 2013年 DZH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefine.h"

@interface CustomSegmentControl : UIView {
    
@private
    
	id      _target;
	SEL     _action;
    
    id      _willTappedTarget;
    SEL     _willTappedAction;
    
    BOOL    _endTrackTouchEvents;
	
}

@property (nonatomic, assign) NSInteger itemsCount;
@property (nonatomic, assign) NSInteger selectedSegmentIndex;
@property (nonatomic, assign) NSInteger willSelectedSegmentIndex;

- (id)initWithFrame:(CGRect)frame
         titleItems:(NSArray *)titleItems       // 按钮文字
    backgroundColor:(UIColor *)backgroundColor  // 控件背景色
        itemBGArray:(NSArray *)itemBGArray      // 按钮背景， 3对 6个，即头，中间，尾 按钮样式，normal hightlight
         fontColors:(NSArray *)fontColors       // 文字颜色， 2种， 普通，选中
           fontSize:(CGFloat)fontSize           // 字体大小
      selectedImage:(UIImage *)selectedImage    // 选中标示
          splitLine:(UIImage *)splitLine        // 分割线
    bottomLineColor:(UIColor *)bottomLineColor; // 下划线颜色

// 改变title个数后， 更新控件
- (id)resetFrame:(CGRect)frame
      titleItems:(NSArray *)titleItems;

- (void)addTarget:(id)target action:(SEL)action;
- (void)addTarget:(id)target willTappedAction:(SEL)action;

- (void)setSelectedSegmentIndex:(NSInteger)index;
- (void)setSelectedSegmentIndex:(NSInteger)index withoutCallEvent:(BOOL)notCall;

- (void)endTrackAllTouchEvents:(BOOL)endTrack;
//- (void)setHaveBorderStyle:(BOOL)flag;
- (void)setHaveBorderStyle:(UIColor *)color borderWidth:(CGFloat)borderWidth;
- (void)resetItemsName:(NSArray *)items;

- (void)selectNone;

//根据索引获取对应的button
-(UIButton *)getButtonWithIndex:(int)index;
@end
