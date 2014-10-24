//
//  CustomSegmentControl.m
//  DzhIphone
//
//  Created by Billy on 13-6-18.
//  Copyright (c) 2013年 DZH. All rights reserved.
//

#import "CustomSegmentControl.h"
#import <QuartzCore/QuartzCore.h>

#define CUSTOM_SEGMENT_CONTROL_BUTTON_ZERO_TAG      3000
#define CUSTOM_SEGMENT_CONTROL_BORDERLINE_TAG       3100
#define CUSTOM_SEGMENT_CONTROL_IAMGE_ARROW_TAG      3200
#define CUSTOM_SEGMENT_CONTROL_BOTTOMLINE_TAG       3300

@interface CustomSegmentControl()

@property (nonatomic, strong) NSArray *titleArray;      // 文字
@property (nonatomic, strong) NSArray *fontColors;      // 文字颜色， 2种， 普通，选中
@property (nonatomic, strong) NSArray *itemBGArray;     // 按钮背景， 3对 6个，即头，中间，尾 按钮样式，normal hightlight
@property (nonatomic, assign) CGFloat fontSize;         // 文字大小
@property (nonatomic, strong) UIImage *splitLine;       // 分割线


- (void)segmentControlValueChanged:(id)sender;
- (void)segmentControlDidTouchDown:(id)sender;

- (void)reloadSegmentControlItems;

@end


@implementation CustomSegmentControl

@synthesize itemsCount;
@synthesize selectedSegmentIndex;
@synthesize willSelectedSegmentIndex;

#pragma mark -
#pragma mark init


- (id)initWithFrame:(CGRect)frame
         titleItems:(NSArray *)titleItems       // 按钮文字
    backgroundColor:(UIColor *)backgroundColor  // 控件背景色
        itemBGArray:(NSArray *)itemBGArray      // 按钮背景， 3对 6个，即头，中间，尾 按钮样式，normal hightlight
         fontColors:(NSArray *)fontColors       // 文字颜色， 2种， 普通，选中
           fontSize:(CGFloat)fontSize           // 字体大小
      selectedImage:(UIImage *)selectedImage    // 选中标示
          splitLine:(UIImage *)splitLine        // 分割线
    bottomLineColor:(UIColor *)bottomLineColor  // 下划线颜色
{
    if (self = [super initWithFrame:CGRectIntegral(frame)]) {
		
        @autoreleasepool {
            
            self.titleArray = titleItems;
            self.itemBGArray = itemBGArray;
            self.fontColors = fontColors;
            self.fontSize = fontSize;
            self.splitLine = splitLine;
            
            // 控件背景色
            self.backgroundColor = backgroundColor ? backgroundColor : [UIColor clearColor];
            
            _endTrackTouchEvents = NO;
            
            self.itemsCount = [self.titleArray count];
            self.selectedSegmentIndex = 0;
            willSelectedSegmentIndex = -1;
            
            // 创建 按钮和分割线
            [self createMainControl];
            
            // 设置 选中标示
            CGFloat width = self.frame.size.width / self.itemsCount;
            CGFloat height = self.frame.size.height - 2;
            if (selectedImage && [selectedImage isKindOfClass:[UIImage class]])
            {
                CGImageRef imageRef = [(UIImage *)selectedImage CGImage];
                CGFloat imageScale  = [(UIImage *)selectedImage scale];
                CGFloat selectedImageWidth  = CGImageGetWidth(imageRef)  / imageScale;
                CGFloat selectedImageHeight = CGImageGetHeight(imageRef) / imageScale;
                
                UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake((width - selectedImageWidth) / 2, height - selectedImageHeight, selectedImageWidth, selectedImageHeight)];
                //            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(10, height - selectedImageHeight, width - 20, selectedImageHeight)];
                [arrow setImage:selectedImage];
                arrow.tag = CUSTOM_SEGMENT_CONTROL_IAMGE_ARROW_TAG;
                arrow.hidden = NO;
                [self addSubview:arrow];
            }
            
            if (bottomLineColor)
            {
                // 设置底部 横线
                UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, height, self.frame.size.width, 1)];
                bottomLine.backgroundColor = bottomLineColor;
                bottomLine.tag = CUSTOM_SEGMENT_CONTROL_BOTTOMLINE_TAG;
                [self addSubview:bottomLine];
            }
            [self reloadSegmentControlItems];
        }
	}
    return self;
}


#pragma mark -
#pragma mark Public Method

- (void)setSelectedSegmentIndex:(NSInteger)index withoutCallEvent:(BOOL)notCall {
    
	if (index < 0 || index >= itemsCount) {
		index = 0;
	}
	if (index != selectedSegmentIndex) {
        
		selectedSegmentIndex = index;
        
		[self reloadSegmentControlItems];
		
		if (!notCall) {
			if ([_target respondsToSelector:_action]) {
				[_target performSelector:_action withObject:self];
			}
		}
	}
}


- (void)setSelectedSegmentIndex:(NSInteger)index {
	[self setSelectedSegmentIndex:index withoutCallEvent:NO];
}


- (void)addTarget:(id)target action:(SEL)action {
	_target = target;
	_action = action;
}


- (void)addTarget:(id)target willTappedAction:(SEL)action {
    _willTappedTarget = target;
    _willTappedAction = action;
}


- (void)endTrackAllTouchEvents:(BOOL)endTrack {
    _endTrackTouchEvents = NO;//endTrack;
}

- (id)resetFrame:(CGRect)frame
      titleItems:(NSArray *)titleItems
{
    self.frame = CGRectIntegral(frame);
    self.titleArray = titleItems;
		
    // 删除旧的
    for (NSUInteger i = 0; i < self.itemsCount; i++) {
		UIButton *aButton = (UIButton *)[self viewWithTag:(CUSTOM_SEGMENT_CONTROL_BUTTON_ZERO_TAG + i)];
		if (aButton != nil) {
            
            [aButton removeFromSuperview];
            
            if (i != self.itemsCount - 1)
            {
                // 中间分线
                UIImageView *spLine = (UIImageView *)[self viewWithTag:CUSTOM_SEGMENT_CONTROL_BORDERLINE_TAG + i];
                [spLine removeFromSuperview];
            }
		}
	}
    
    @autoreleasepool {
        _endTrackTouchEvents = NO;
        
        itemsCount = [self.titleArray count];
        selectedSegmentIndex = 0;
        willSelectedSegmentIndex = -1;
        
        // 创建 按钮和分割线
        [self createMainControl];
        
        [self reloadSegmentControlItems];

    }
    
    return self;
}


#pragma mark -
#pragma mark Private Method

// 创建 按钮和分割线
- (void)createMainControl
{
    // 按钮 frame 准备
    CGFloat xOffset  = 0.0;
    CGFloat yOffset  = 0.0;
    CGFloat height   = self.frame.size.height - 1;
    
    // 分割线 宽高
    CGFloat splitLineWidth = 0;
    CGFloat splitLineHeight = 0;
    if (self.splitLine && [self.splitLine isKindOfClass:[UIImage class]]) {
        CGImageRef imageRef = [(UIImage *)self.splitLine CGImage];
        CGFloat imageScale  = [(UIImage *)self.splitLine scale];
        splitLineWidth  = CGImageGetWidth(imageRef)  / imageScale;
        splitLineHeight = CGImageGetHeight(imageRef) / imageScale;
    }
    
    CGFloat width = (self.frame.size.width - (self.itemsCount - 1) * splitLineWidth) / self.itemsCount;
    
    // 逐个添加按钮
    for (NSUInteger i = 0; i < self.itemsCount; i++) {
        
        UIButton *aButton = [[UIButton alloc] initWithFrame:CGRectIntegral(CGRectMake(xOffset + (width + splitLineWidth) * i, yOffset, width, height))];
        
        [aButton setBackgroundColor:[UIColor clearColor]];
        [aButton setTitle:(NSString *)[self.titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [aButton.titleLabel setFont:[UIFont systemFontOfSize:self.fontSize]];
        [aButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [aButton.titleLabel setMinimumFontSize:10.0];
        aButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        aButton.titleLabel.textAlignment = UITextAlignmentCenter;
       
        // 设置按钮背景
        if ([self.itemBGArray count] == 6)
        {
            UIImage *normal = nil;
            UIImage *disabled = nil;
            if (i == 0) {
                normal		= [self.itemBGArray objectAtIndex:0];
                disabled	= [self.itemBGArray objectAtIndex:1];
            }
            else if (i == (self.itemsCount - 1)) {
                normal		= [self.itemBGArray objectAtIndex:4];
                disabled	= [self.itemBGArray objectAtIndex:5];
            }
            else {
                normal		= [self.itemBGArray objectAtIndex:2];
                disabled	= [self.itemBGArray objectAtIndex:3];
            }
            
            if (normal && (NSNull *)normal != [NSNull null])
            {
                [aButton setBackgroundImage:normal forState:UIControlStateNormal];
            }
            if (disabled && (NSNull *)disabled != [NSNull null])
            {
                [aButton setBackgroundImage:disabled forState:UIControlStateDisabled];
            }
        }
        
        [aButton setAdjustsImageWhenHighlighted:NO];
        [aButton setAdjustsImageWhenDisabled:NO];
        [aButton setTag:(CUSTOM_SEGMENT_CONTROL_BUTTON_ZERO_TAG + i)];
        [aButton addTarget:self action:@selector(segmentControlValueChanged:) forControlEvents:UIControlEventTouchUpInside];
        [aButton addTarget:self action:@selector(segmentControlDidTouchDown:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:aButton];
        
        if (self.splitLine && i != self.itemsCount - 1)
        {
            // 中间分线
            CGRect imageRect = CGRectIntegral(CGRectMake(round(xOffset + width * (i + 1) + splitLineWidth * i),
                                                         round((height - splitLineHeight) / 2),
                                                         splitLineWidth,
                                                         splitLineHeight));
            UIImageView *spLine = [[UIImageView alloc] initWithFrame:imageRect];
            [spLine setImage:self.splitLine];
            //                [spLine setImage:[CommonDrawFunc retinaImageNamed:@"btnbreakline.png"]];
            spLine.contentMode = UIViewContentModeScaleAspectFit;
            spLine.tag = CUSTOM_SEGMENT_CONTROL_BORDERLINE_TAG + i;
            [self addSubview:spLine];
        }
    }
}

- (void)segmentControlValueChanged:(id)sender {
    if (!_endTrackTouchEvents) {
        UIButton *aButton = (UIButton *)sender;
        if (!aButton.selected) {
            NSInteger buttonIndex = aButton.tag - CUSTOM_SEGMENT_CONTROL_BUTTON_ZERO_TAG;
            if (selectedSegmentIndex != buttonIndex) {
                self.selectedSegmentIndex = buttonIndex;
            }
        }
    }
}


- (void)segmentControlDidTouchDown:(id)sender {
    
    _endTrackTouchEvents     = NO;
    willSelectedSegmentIndex = ((UIButton *)sender).tag - CUSTOM_SEGMENT_CONTROL_BUTTON_ZERO_TAG;
    
    if (_willTappedTarget != nil && _willTappedAction != nil) {
        if ([_willTappedTarget respondsToSelector:_willTappedAction]) {
            [_willTappedTarget performSelector:_willTappedAction withObject:self];
        }
    }
}

- (void)reloadSegmentControlItems {
    
	for (NSUInteger i = 0; i < self.itemsCount; i++) {
        
		UIButton *aButton = (UIButton *)[self viewWithTag:(CUSTOM_SEGMENT_CONTROL_BUTTON_ZERO_TAG + i)];
		if (aButton) {
            if (i == self.selectedSegmentIndex) {
                [aButton setEnabled:NO];

                [aButton setTitleColor:([self.fontColors count] == 2 ? [self.fontColors objectAtIndex:0] : UIColorFromRGB(0xc07402)) forState:UIControlStateNormal];
                
                UIImageView *arrow = (UIImageView *)[self viewWithTag:CUSTOM_SEGMENT_CONTROL_IAMGE_ARROW_TAG];
                arrow.hidden = NO;
                
                CGFloat width = self.frame.size.width / self.itemsCount;
                
                // 上箭头 指示
                CGRect arrowFrame = arrow.frame;
                arrowFrame.origin.x = width * i + (width - arrow.frame.size.width) / 2;
				
                
				[UIView beginAnimations:@"animationID" context:nil];
				[UIView setAnimationDuration:0.3f];
				[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
				[UIView setAnimationRepeatAutoreverses:NO];
				[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:arrow cache:YES];
				[arrow setFrame:arrowFrame];
				[UIView commitAnimations];
				
            }
            else
            {
                [aButton setEnabled:YES];
                [aButton setTitleColor:([self.fontColors count] == 2 ? [self.fontColors objectAtIndex:1] : [UIColor whiteColor]) forState:UIControlStateNormal];
                
            }
		}
	}
}

- (void)selectNone
{
    selectedSegmentIndex = -1;
    
    [self reloadSegmentControlItems];
    
    UIImageView *arrow = (UIImageView *)[self viewWithTag:CUSTOM_SEGMENT_CONTROL_IAMGE_ARROW_TAG];
    if (arrow) {
        arrow.hidden = YES;
    }
    
}
//- (void)setHaveBorderStyle:(BOOL)flag
//{
//	if (flag) {
//		self.layer.borderWidth = 1;
//		self.layer.borderColor = [kCLRBorder CGColor];
//	}else
//	{
//		self.layer.borderWidth = 0;
//		self.layer.borderColor = [[UIColor clearColor] CGColor];
//	}
//}


- (void)setHaveBorderStyle:(UIColor *)color borderWidth:(CGFloat)borderWidth
{
	if (color) {
		self.layer.borderWidth = borderWidth;
		self.layer.borderColor = [color CGColor];
	}
    else
	{
		self.layer.borderWidth = 0;
		self.layer.borderColor = [[UIColor clearColor] CGColor];
	}
}


- (void)resetItemsName:(NSArray *)items
{
    if(self.itemsCount == [items count])
    {
        for(int i = 0; i < self.itemsCount; i++)
        {
            UIButton * btn = (UIButton *)[self viewWithTag:(CUSTOM_SEGMENT_CONTROL_BUTTON_ZERO_TAG + i)];
            [btn setTitle:[items objectAtIndex:i] forState:UIControlStateNormal];
            
            
        }
       
    }
}
-(UIButton *)getButtonWithIndex:(int)index
{
    UIButton *btn = (UIButton *)[self viewWithTag:(CUSTOM_SEGMENT_CONTROL_BUTTON_ZERO_TAG + index)];
    return btn ? btn : nil;
}

@end
