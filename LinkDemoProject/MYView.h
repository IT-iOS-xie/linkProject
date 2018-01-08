//
//  MYView.h
//  LinkDemoProject
//
//  Created by xie on 2018/1/8.
//  Copyright © 2018年 abadou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYView : UIView
+(instancetype)initWith:(void(^)(MYView *view))BLOCK;

@property(nonatomic,readonly,copy)MYView *(^viewFrame)(CGRect  frame);
@property(nonatomic,readonly,copy)MYView * (^layerCornerRadious)(CGFloat radious);
@property(nonatomic,copy,readonly)MYView*(^ColorString)(NSString * colorStr);

@end
