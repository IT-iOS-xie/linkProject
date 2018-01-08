//
//  Person.h
//  LinkDemoProject
//
//  Created by xie on 2018/1/8.
//  Copyright © 2018年 abadou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
-(Person *)play;

-(void)run;

-(Person *(^)(NSString * str))play2;
-(void(^)(NSString * str))play3;
@property(nonatomic,readonly,copy)Person *(^eat)(NSString * str);
+(instancetype)initWithP:(void(^)(Person * p))Block;

@end
