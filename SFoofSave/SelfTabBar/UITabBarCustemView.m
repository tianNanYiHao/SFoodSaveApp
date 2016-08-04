//
//  UITabBarCustemView.m
//  SFoofSave
//
//  Created by Lff on 16/8/3.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import "UITabBarCustemView.h"

#define ScrenHeight self.frame.size.height
#define ScrenWidth self.frame.size.width
@implementation UITabBarCustemView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self.frame = frame;
        self.backgroundColor = [UIColor blueColor];
        [self layoutView];
    }return self;
    
}

- (void)layoutView{
    _tabBarBaseView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"底部标签栏"]];
    _tabBarBaseView.frame = CGRectMake(0,0,ScrenWidth, ScrenHeight);
    [self addSubview:_tabBarBaseView];
    
    
    
}





@end
