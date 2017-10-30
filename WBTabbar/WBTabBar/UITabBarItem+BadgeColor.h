//
//  UITabBarItem+BadgeColor.h
//  TabBarDemo
//
//  Created by 王博 on 7/27/17.
//  Copyright © 2017 王博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UITabBarItem (BadgeColor)
@property (nonatomic, readwrite, copy, nullable) UIColor *badgeColor;
@end
