#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TabbarButton.h"
#import "TabBarCenterButton.h"
#import "UITabBarItem+BadgeColor.h"
#import "WBBadgeView.h"
#import "WBTabBar.h"
#import "WBTabBarConfig.h"
#import "WBTabBarController.h"

FOUNDATION_EXPORT double WBTabbarVersionNumber;
FOUNDATION_EXPORT const unsigned char WBTabbarVersionString[];

