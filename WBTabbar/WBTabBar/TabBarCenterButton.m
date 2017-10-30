//
//  TabBarCenterButton.m
//  TabBarDemo
//
//  Created by 王博 on 2016/11/17.
//  Copyright © 2016年 王博. All rights reserved.
//

#import "TabBarCenterButton.h"

@implementation TabBarCenterButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
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
    if (CGRectEqualToRect(self.frame, CGRectZero)) {
        return;
    }
    
    /**
     *  button is bulge
     */
    if (self.is_bulge){
        self.imageView.frame = self.bounds;
        if (self.titleLabel.text.length) {
            self.titleLabel.frame = CGRectMake(0 , self.frame.size.height +(BULGEH-16),
                                               self.frame.size.width , 16);
        }else{
            CGRect rect = self.imageView.frame;
            rect.size.height += 8;
            self.imageView.frame = rect;
        }
        return;
    }
    /**
     *  button is normal and no text
     */
    if (!self.titleLabel.text.length) {
        self.imageView.frame = self.bounds;
        return;
    }
    /**
     *  button is normal and contain text
     */
    CGFloat width = self.frame.size.width;
    CGFloat height = self.superview.frame.size.height;
    self.titleLabel.frame = CGRectMake(0, height-BULGEH , width, BULGEH);
    self.imageView.frame = CGRectMake(0 , 0, width, 35);
}


- (void)setHighlighted:(BOOL)highlighted{
}


@end
