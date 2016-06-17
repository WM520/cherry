//
//  WMCustomTabBar.m
//  DHCar
//
//  Created by David on 16/5/30.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "WMCustomTabBar.h"
#import "WMTarButton.h"
#import "WMPublishViewController.h"


@interface WMCustomTabBar()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) WMTarButton *selectedButton;
@property (nonatomic, weak) UIButton *publishButton;

@end


@implementation WMCustomTabBar

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *publishButton = [[UIButton alloc] init];
        [publishButton setBackgroundImage:[[UIImage imageNamed:@"tabBar_publish_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[[UIImage imageNamed:@"tabBar_publish_click_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)publishClick
{
    WMPublishViewController *publishVC = [[WMPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:YES completion:^{
        
    }];
}

- (void)addTabBarItem:(UITabBarItem *)item
{
    WMTarButton *button = [[WMTarButton alloc] init];
    [self addSubview:button];
    [self.dataArray addObject:button];
    
    button.item = item;
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    if (self.dataArray.count == 1) {
        [self onClick:button];
    }
}

- (void)onClick:(WMTarButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:btn.tag];
    }
    self.selectedButton.selected = NO;
    btn.selected = YES;
    self.selectedButton = btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h =  self.bounds.size.height;
    
    
    // 设置发布按钮的frame
    self.publishButton.center = CGPointMake(w * 0.5, h * 0.5);
    NSLog(@"%@", NSStringFromCGRect(self.publishButton.frame));
    
    
    CGFloat btnY = 0;
    CGFloat btnW = w/self.subviews.count;
    CGFloat btnH =  h;
    
    for (NSInteger i = 0; i < _dataArray.count; i++) {
        
        WMTarButton *btn = _dataArray[i];
        // 2.设置按钮的frame
        CGFloat btnX =  btnW * ((i > 1)? i + 1 : i);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag = i;
//        NSLog(@"%@", NSStringFromCGRect(btn.frame));
    }
}


@end
