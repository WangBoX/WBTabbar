//
//  MineViewController.m
//  WBTabbar
//
//  Created by 王博Bling on 2017/10/30.
//  Copyright © 2017年 WBO. All rights reserved.
//

#import "MineViewController.h"
#import "WBTabBar.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarItem.badgeColor = [UIColor orangeColor];
    self.tabBarItem.badgeValue = @"1234";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

