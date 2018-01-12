//
//  MemoryManagementVC.m
//  JavaScriptCoreDemo
//
//  Created by 刘新 on 2018/1/12.
//  Copyright © 2018年 Liuxin. All rights reserved.
//

#import "MemoryManagementVC.h"
#import "JSProtocolObj.h"

@interface MemoryManagementVC ()<JSExportTest>

@property (nonatomic, strong) JSProtocolObj *obj;
@property (nonatomic, strong) JSContext *context;
@end

@implementation MemoryManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"内存管理";
    
    //创建context
    self.context = [[JSContext alloc] init];
    //设置异常处理
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        [JSContext currentContext].exception = exception;
        NSLog(@"exception:%@",exception);
    };
    
    //加载JS代码到context中
    [self.context evaluateScript:@"function callback (){};function setObj(obj) { this.obj = obj;obj.jsValue=callback;}"];
    //调用JS方法
    [self.context[@"setObj"] callWithArguments:@[self.obj]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@synthesize jsValue;

@end
