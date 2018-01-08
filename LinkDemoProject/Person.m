//
//  Person.m
//  LinkDemoProject
//
//  Created by xie on 2018/1/8.
//  Copyright © 2018年 abadou. All rights reserved.
//

#import "Person.h"

@implementation Person
//-(void)play{
//    NSLog(@"play");
//
//}
-(Person *)play{
    
    return self;
}
-(void)run{
    
    NSLog(@"run");
}
-(Person *(^)(NSString *))eat{
    
    return ^(NSString* eat){
        NSLog(@"%@",eat);
        return self;
        
    };
    
}
+(instancetype)initWithP:(void (^)(Person *))Block{
    
    Person * p = [Person new];
    return p;
    
}
- (Person *(^)(NSString *str))play2{
    
    return ^(NSString *str){
        
        NSLog(@"%@",str);
        return self;
    };
}
-(void (^)(NSString * str))play3{
    
    return ^(NSString * str){
        NSLog(@"%@",str);
    };
}
@end
