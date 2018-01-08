//
//  ViewController.m
//  LinkDemoProject
//
//  Created by xie on 2018/1/8.
//  Copyright © 2018年 abadou. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Person+goHome.h"
#import "MYView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person * xiaoming = [Person new];
    [xiaoming play];
    [[xiaoming play]run];
    [xiaoming play].play2(@"222");
    [[xiaoming play]goHome];
    xiaoming.play2(@"33").play3(@"333");
    
     [Person initWithP:^(Person *p) {
          p.play2(@"222").play3(@"3333");
         p.play2(@"222").eat(@"333").play3(@"444");
    }];
    
    
    [self.view addSubview:[MYView initWith:^(MYView *View) {
        
        View.viewFrame(CGRectMake(100, 200, 20, 20)).layerCornerRadious(2).ColorString(@"颜色自己设置");
    }]];
    [self.view addSubview:[MYView initWith:^(MYView *View) {
        
        View.viewFrame(CGRectMake(130, 200, 20, 20)).layerCornerRadious(2).ColorString(@"颜色自己设置");
    }]];
    [self.view addSubview:[MYView initWith:^(MYView *View) {
        
        View.viewFrame(CGRectMake(160, 200, 20, 20)).layerCornerRadious(2).ColorString(@"颜色自己设置");
    }]];
    [self.view addSubview:[MYView initWith:^(MYView *View) {
        
        View.viewFrame(CGRectMake(190, 200, 20, 20)).layerCornerRadious(2).ColorString(@"颜色自己设置");
    }]];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
