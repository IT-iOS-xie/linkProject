# linkProject
链式编程
提到链式编程和函数式编程，最典型的代表是Masonry 比较完美的实现了函数式编程和链式编程。例如

```
[view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view.mas_centerX).offset(100);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
    }];
```
   所谓的链式编程其实就是 在返回值的基础上继续调用方法,那么问题来了。什么样的返回值才能调用方法，答案是返回对象 只要返回对象然后调用对应的对象方法即可实现 链式编程
   
   例如 ：
首先定义Person类
添加两个对象方法

```
-(void)play;

-(void)run;
```



```
-(void)play{
    NSLog(@"play");
}
-(void)run{
    
    NSLog(@"run");
}
```

**在`ViewController`调用**

```
 Person * xiaoming = [Person new];
 [xiaoming play];
```
我们现在想要实现的是 ` [[xiaoming play]run]`,所以play方法返回值就不能为空，应该是Person对象

```
-(Person *)play;

-(Person *)play{
    
    return self;
}
```
我们已经实现了`[[xiaoming play]run]`

这样的链式编程 和Masonry 确实有点相差甚远
我们知道在OC中的方法调用是 发送消息的方式实现的那么 要实现 person.eat 该怎么实现呢?
那么我们如何实现` .`方法呢

```
-(void(^)(void))play2;
```

```
-(void (^)(void))play2{
    
    return ^(){
        NSLog(@"play2");
    };
}
```
即可实现 `[xiaoming play].play2();`

然而后边如果想要添加点方法，实现方法相同，只需返回均为Person对象即可。

```
-(Person *(^)(NSString * str))play2;
-(void(^)(NSString * str))play3;
```

```
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
```

即可实现` xiaoming.play2(@"33").play3(@"333");`

上面的方法是通过block返回值为当前对象，即可实现点语法连续调用。
## 构造方法
函数式编程 就是通过类似于 函数调用的方式实现想要的功能即 method(); 这样的方式,
那么我们知道在OC能用method() 这样调用,只有一个可以实现,那就是BLOCK, 我们在调用BLOCK时 不就是这样调用的吗?  那么我们知道只要我的一个方法的返回值是BLOCK的时候就可以使用函数式调用。

**定义构造方法**

  
```
+(instancetype)initWithP:(void(^)(Person * p))Block;
```

```
+(instancetype)initWithP:(void (^)(Person *))Block{
    
    Person * p = [Person new];
    return p;
    
}
```
可以调用返回值为p的函数式构造方法，然后在内部对p对象进行使用；
```
[Person initWithP:^(Person *p) {
        
    }];
```
即可调用链式方法

```
 [Person initWithP:^(Person *p) {
          p.play2(@"222").play3(@"3333");
    }];
```
## 定义成员属性实现点语法

上面均是通过定义方法实现点语法调用，但是我们的编程习惯的用点语法调取类的成员属性。`OC`中的点语法，`.XX`是`getter`，`.XX=XXX`；是`setter`，显然链式编程是一串的，所以我们应该想到将`block`声明为属性，并且在这些`block`属性的`getter`方法中做一些事情。

**person类添加成员属性**

```
@property(nonatomic,readonly,copy)Person *(^eat)(NSString * str);
```
**重写成员属性getter方法**

```
-(Person *(^)(NSString *))eat{
    
    return ^(NSString* eat){
        NSLog(@"%@",eat);
        return self;
        
    };
    
}
```
所以我们就可以实现点调用`eat`方法。

```
    [Person initWithP:^(Person *p) {
         p.play2(@"222").eat(@"333").play3(@"444");
    }];
```
定义属性相比定义方法一个突出的优点就是输入的时候会有输入提示，所以更常用。   



## 举例说明：

**我们现在要在VC上加四个大小相同，圆角为2的红色view,实现代码如下**

```

@interface MYView : UIView
+(instancetype)initWith:(void(^)(MYView *view))BLOCK;

@property(nonatomic,readonly,copy)MYView *(^viewFrame)(CGRect  frame);
@property(nonatomic,readonly,copy)MYView * (^layerCornerRadious)(CGFloat radious);
@property(nonatomic,copy,readonly)MYView*(^ColorString)(NSString * colorStr);

@end
```

```

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
```
**只需在VC中调用**

```
[self.view addSubview:[MYView initWith:^(MYView *View) {
        View.viewFrame(CGRectMake(100, 200, 20, 20)).layerCornerRadious(2).ColorString(@"颜色自己设置");
    }]];
```

**完结**
