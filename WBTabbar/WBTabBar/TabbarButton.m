//
//  TabbarButton.m
//  TabBarDemo
//
//  Created by 王博 on 2016/11/17.
//  Copyright © 2016年 王博. All rights reserved.
//

#import "TabbarButton.h"
#import "WBBadgeView.h"

@interface TabbarButton()
// remind number
@property (weak , nonatomic)WBBadgeView * badgeView;
@end

@implementation TabbarButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setTitleColor:[WBTabBarConfig shared].textColor forState:UIControlStateNormal];
        [self setTitleColor:[WBTabBarConfig shared].selectedTextColor forState:UIControlStateSelected];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    
    CGFloat height = self.superview.frame.size.height - [[self.superview valueForKeyPath:@"controller.safeBottomInsets"]floatValue];
    if (self.titleLabel.text && ![self.titleLabel.text isEqualToString:@""]) {
        self.titleLabel.frame = CGRectMake(0, height-16, width, 16);
        self.imageView.frame = CGRectMake(0 , 0, width, 35);
    }
    else{
        self.imageView.frame = CGRectMake(0 , 0, width, height);
    }
}

/**
 *  Set red dot item
 */
- (void)setItem:(UITabBarItem *)item {
    self.badgeView.badgeValue = item.badgeValue;
    self.badgeView.badgeColor = item.badgeColor;
}

/**
 *  getter
 */
- (WBBadgeView *)badgeView {
    if (!_badgeView) {
        WBBadgeView * badgeView = [[WBBadgeView alloc] init];
        _badgeView = badgeView;
        [self addSubview:badgeView];
    }
    return _badgeView;
}


- (void)setHighlighted:(BOOL)highlighted{
}

@end
