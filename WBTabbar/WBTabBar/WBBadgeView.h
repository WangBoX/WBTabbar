//
//  CYBadgeView.h
//  TabBarDemo
//
//  Created by 王博 on 2016/11/19.
//  Copyright © 2016年 王博. All rights reserved.
//

#import "WBTabBarConfig.h"

@interface WBBadgeView : UIButton
// remind number
@property (copy , nonatomic) NSString *badgeValue;
// remind color
@property (copy , nonatomic) UIColor *badgeColor;
@end
