//
//  WBTabBar
//  TabBarDemo
//
//  Created by 王博 on 2016/11/17.
//  Copyright © 2016年 王博. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TabBarCenterButton.h"
@class TabbarButton;
@class WBTabBar;

@protocol WBTabBarDelegate <NSObject>
@optional
// 中间按钮点击会通过这个代理通知你通知。
- (void)tabbar:(WBTabBar *)tabbar clickForCenterButton:(TabBarCenterButton *)centerButton;
// 默认返回YES，允许所有的切换，不过你通过TabBarController来直接设置SelectIndex来切换的是不会收到通知的。
- (BOOL)tabBar:(WBTabBar *)tabBar willSelectIndex:(NSInteger)index;
// 通知已经选择的控制器下标。
- (void)tabBar:(WBTabBar *)tabBar didSelectIndex:(NSInteger)index;
@end

@interface WBTabBar : UIView
@property (copy, nonatomic) NSArray<UITabBarItem *> *items;  // tabbar按钮显示信息
@property (strong , nonatomic) NSMutableArray <TabbarButton*>*btnArr;   // 其他按钮
@property (strong , nonatomic) TabBarCenterButton *centerBtn;   // 中间按钮
@property (weak , nonatomic) id<WBTabBarDelegate>delegate;   // tabBar通知委托

@end
