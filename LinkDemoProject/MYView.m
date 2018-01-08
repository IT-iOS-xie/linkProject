//
//  MYView.m
//  LinkDemoProject
//
//  Created by xie on 2018/1/8.
//  Copyright © 2018年 abadou. All rights reserved.
//

#import "MYView.h"

@implementation MYView

+(instancetype)initWith:(void (^)(MYView *))BLOCK{
    MYView * view = [[MYView alloc]init];
    
    if (BLOCK) {
        BLOCK(view);
    }
    return view;
    
}
-(MYView *(^)(CGRect))viewFrame{
    return  ^MYView*(CGRect rect){
        
        self.frame = rect;
        return self;
    };
    
    
}
-(MYView *(^)(CGFloat))layerCornerRadious{
    return ^MYView*(CGFloat radious){
        
        self.layer.cornerRadius = radious;
        self.layer.masksToBounds = YES;
        return self;
    };
    
}

-(MYView *(^)(NSString *))ColorString{
    
    return ^MYView* (NSString * colorStr){
        
        self.backgroundColor = [UIColor redColor];
        return self;
    };
    
}

@end
