//
//  WBTabBar.m
//  TabBarDemo
//
//  Created by 王博 on 2016/11/17.
//  Copyright © 2016年 王博. All rights reserved.
//

#import "WBTabBar.h"
#import "TabbarButton.h"

@interface WBTabBar ()
// selctButton
@property (weak , nonatomic) TabbarButton *selButton;
// center button of place (kvc will setting)
@property(assign , nonatomic) NSInteger centerPlace;
// Whether center button to bulge (kvc will setting)
@property(assign , nonatomic,getter=is_bulge) BOOL bulge;
// tabBarController (kvc will setting)
@property (weak , nonatomic) UITabBarController *controller;
// border
@property (nonatomic,weak) CAShapeLayer *border;
@end

@implementation WBTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.btnArr = [NSMutableArray array];
        if ([WBTabBarConfig shared].haveBorder) {
            self.border.fillColor = [WBTabBarConfig shared].bordergColor.CGColor;
        }
        self.backgroundColor = [WBTabBarConfig shared].backgroundColor;
        
        [[WBTabBarConfig shared]addObserver:self forKeyPath:@"textColor" options:NSKeyValueObservingOptionNew context:nil];
        [[WBTabBarConfig shared]addObserver:self forKeyPath:@"selectedTextColor" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

/**
 *  Set items
 */
- (void)setItems:(NSArray<UITabBarItem *> *)items{
    _items = items;
    for (int i=0; i<items.count; i++)
    {
        UITabBarItem *item = items[i];
        UIButton *btn = nil;
        if (-1 != self.centerPlace && i == self.centerPlace)
        {
            self.centerBtn = [TabBarCenterButton buttonWithType:UIButtonTypeCustom];
            self.centerBtn.adjustsImageWhenHighlighted = NO;
            self.centerBtn.bulge = self.is_bulge;
            btn = self.centerBtn;
            if (item.tag == -1)
            {
                [btn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [btn addTarget:self action:@selector(controlBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        else
        {
            btn = [TabbarButton buttonWithType:UIButtonTypeCustom];
            //Add Observer
            [item addObserver:self forKeyPath:@"badgeValue"
                      options:NSKeyValueObservingOptionNew
                      context:(__bridge void * _Nullable)(btn)];
            [item addObserver:self forKeyPath:@"badgeColor"
                      options:NSKeyValueObservingOptionNew
                      context:(__bridge void * _Nullable)(btn)];
            
            [self.btnArr addObject:(TabbarButton *)btn];
            [btn addTarget:self action:@selector(controlBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        //Set image
        [btn setImage:item.image forState:UIControlStateNormal];
        [btn setImage:item.selectedImage forState:UIControlStateSelected];
        btn.adjustsImageWhenHighlighted = NO;
        
        //Set title
        [btn setTitle:item.title forState:UIControlStateNormal];
        btn.tag = item.tag;
        [self addSubview:btn];
    }
}

/**
 *  getter
 */
- (CAShapeLayer *)border {
    if (!_border) {
        CAShapeLayer *border = [CAShapeLayer layer];
        border.path = [UIBezierPath bezierPathWithRect:
                       CGRectMake(0,0,self.bounds.size.width,[WBTabBarConfig shared].borderHeight)].CGPath;
        [self.layer insertSublayer:border atIndex:0];
        _border = border;
    }
    return _border;
}


/**
 *  layout
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    int count = (int)(self.centerBtn ? self.btnArr.count+1 : self.btnArr.count);
    NSInteger mid = ({
        NSInteger mid = [WBTabBarConfig shared].centerBtnIndex;
        (mid>=0 && mid <count) ? mid : count/2;
    });
    CGRect rect = ({
        CGFloat safeBottom = [[self.controller valueForKeyPath:@"safeBottomInsets"]floatValue];
        CGRectMake(0, 0, self.bounds.size.width/count,self.bounds.size.height-safeBottom);
    });
    
    int j = 0;
    for (int i=0; i<count; i++) {
        if (i == mid && self.centerBtn!= nil) {
            CGFloat h = self.items[self.centerPlace].title ? 10.f : 0;
            self.centerBtn.frame = self.is_bulge
            ? CGRectMake(rect.origin.x,
                         -BULGEH-h ,
                         rect.size.width,
                         rect.size.height+h)
            : rect;
        }
        else{
            self.btnArr[j++].frame = rect;
        }
        rect.origin.x += rect.size.width;
    }
    
    _border.path = [UIBezierPath bezierPathWithRect:CGRectMake(0,0,
                                                                   self.bounds.size.width,
                                                                   [WBTabBarConfig shared].borderHeight)].CGPath;
}

/**
 *  Pass events for center button
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = self.centerBtn.frame;
    if (CGRectContainsPoint(rect, point)) {
        return self.centerBtn;
    }
    return [super hitTest:point withEvent:event];
}


/**
 *  Control button click
 */
- (void)controlBtnClick:(TabbarButton *)button {
    if ([self.delegate respondsToSelector:@selector(tabBar:willSelectIndex:)]) {
        if (![self.delegate tabBar:self willSelectIndex:button.tag]) {
            return;
        }
    }
    self.controller.selectedIndex = button.tag;
}

/**
 *  Updata select button UI (kvc will setting)
 */
- (void)setSelectButtoIndex:(NSUInteger)index {
    if (self.centerBtn && index == self.centerBtn.tag) {
         self.selButton = (TabbarButton *)self.centerBtn;
    }else{
        for (TabbarButton *loop in self.btnArr) {
            if (loop.tag == index){
                self.selButton = loop;
                break;
            }
        }
    }
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectIndex:)]) {
        [self.delegate tabBar:self didSelectIndex:index];
    }
}

/**
 *  Switch select button to highlight
 */
- (void)setSelButton:(TabbarButton *)selButton {
    _selButton.selected = NO;
    _selButton = selButton;
    _selButton.selected = YES;
}


/**
 *  Center button click
 */
- (void)centerBtnClick:(TabBarCenterButton *)button {
    if ([self.delegate respondsToSelector:@selector(tabbar:clickForCenterButton:)]) {
        [self.delegate tabbar:self clickForCenterButton:button];
    }
}


/**
 *  Observe the attribute value change
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"badgeValue"] || [keyPath isEqualToString:@"badgeColor"]) {
        TabbarButton *btn = (__bridge TabbarButton *)(context);
        btn.item = (UITabBarItem*)object;
    }
    else if ([object isEqual:[WBTabBarConfig shared]]){
        if([keyPath isEqualToString:@"textColor"] ||[keyPath isEqualToString:@"selectedTextColor"]) {
            UIColor *color = change[@"new"];
            UIControlState state = [keyPath isEqualToString:@"textColor"]? UIControlStateNormal: UIControlStateSelected;
            for (UIButton *loop in self.btnArr){
                [loop setTitleColor:color forState:state];
            }
        }
    }
}


/**
 *  Remove observer
 */
- (void)dealloc {
    for (int i=0; i<self.btnArr.count; i++) {
        int index = ({
            int n = 0;
            if (-1 != _centerPlace)
                n = _centerPlace > i ? 0 : 1;
            i+n;});
        [self.items[index] removeObserver:self
                               forKeyPath:@"badgeValue"
                                  context:(__bridge void * _Nullable)(self.btnArr[i])];
        [self.items[index] removeObserver:self
                               forKeyPath:@"badgeColor"
                                  context:(__bridge void * _Nullable)(self.btnArr[i])];
    }
    [[WBTabBarConfig shared]removeObserver:self forKeyPath:@"textColor" context:nil];
    [[WBTabBarConfig shared]removeObserver:self forKeyPath:@"selectedTextColor" context:nil];
}

@end
