# WBTabbar
自定义TabBar，【闲鱼、微博、微信】快速完成主流App框架搭建
基于系统UITabBarController
特点：
1	低耦合，易删除
2 即使加号按钮超出了tabbar的区域，超出部分依然能响应点击事件
3 支持自定义动画
4 支持角标小红点 badgeValue
使用简单：

/**
 * 添加子控制器
 * @param Controller          需管理的子控制器
 * @param title               底部文字
 * @param imageName           未选中的图片名
 * @param selectedImageName   选中的图片名
 */
- (void)addChildController:(id)Controller
                        title:(NSString *)title
                    imageName:(NSString *)imageName
            selectedImageName:(NSString *)selectedImageName;

/**
 * 设置中间按钮
 * @param Controller          需管理的子控制器
 * @param title               底部文字
 * @param imageName           未选中的图片名
 * @param selectedImageName   选中的图片名
 */
- (void)addCenterController:(id)Controller
                      bulge:(BOOL)bulge
                     title:(NSString *)title
                 imageName:(NSString *)imageName
         selectedImageName:(NSString *)selectedImageName;

/**
 * 隐藏tabbar
 * @param hidden            是否隐藏
 * @param animated          是否执行动画
 */
- (void)setWBTabBarHidden:(BOOL)hidden animated:(BOOL)animated;
