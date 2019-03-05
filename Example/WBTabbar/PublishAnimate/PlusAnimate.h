//
//  PublishAnimate.h
//  WBTabBar
//
//  Created by 王博 on 16/8/17.
//  Copyright © 2016年 王博. All rights reserved.
//

#import <UIKit/UIKit.h>
//通知点击按钮协议
@protocol PublishAnimateDelegate <NSObject>
- (void)didSelectBtnWithBtnTag:(NSInteger)tag;
@end


@interface PlusAnimate : UIView
//通知点击按钮代理人
@property(weak,nonatomic) id<PublishAnimateDelegate> delegate;
//弹出动画view
+(PlusAnimate *)standardPublishAnimateWithView:(UIView *)view;

@end
