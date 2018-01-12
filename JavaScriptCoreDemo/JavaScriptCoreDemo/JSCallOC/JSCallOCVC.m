//
//  JSCallOCVC.m
//  JavaScriptCoreDemo
//
//  Created by 刘新 on 2017/12/29.
//  Copyright © 2017年 Liuxin. All rights reserved.
//

#import "JSCallOCVC.h"

@interface JSCallOCVC ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *testWebView;
@property (strong, nonatomic) JSContext *context;
@end

@implementation JSCallOCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"JS调用OC.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    self.testWebView.delegate = self;
    [self.testWebView loadRequest:request];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    // 以 html title 设置 导航栏 title
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    // 禁用 页面元素选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];

    // 禁用 长按弹出ActionSheet
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    //初始化content
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 打印异常,由于JS的异常信息是不会在OC中被直接打印的,所以我们在这里添加打印异常信息
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@"___%@",exception);
    };
    
    // 以 JSExport 协议关联 native 的方法
    self.context[@"native"] = self;
    
    // 以 block 形式关联 JavaScript function
    self.context[@"log"] = ^(NSString *str){
        NSLog(@"++++%@",str);
    };
    
    // 以 block 形式关联 JavaScript function
    __weak __typeof(self)weakSelf = self;
    self.context[@"alert"] =
    ^(NSString *str)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"msg from js" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    };
    
    self.context[@"addSubView"] =
    ^(NSString *viewname)
    {
        //异步调用需要回调到主线程，不然控制台会打印警告log
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 100, 100)];
            testView.backgroundColor = [UIColor redColor];
            UISwitch *sw = [[UISwitch alloc]init];
            [testView addSubview:sw];
            [weakSelf.view addSubview:testView];
        });
    };
    //多参数
    self.context[@"mutiParams"] =
    ^(NSString *a,NSString *b,NSString *c)
    {
        NSLog(@"%@ %@ %@",a,b,c);
    };
    
    //直接调用JS的方法
    [self.context evaluateScript:@"mutiParams"];
}
#pragma mark - JSExport Methods
//实现JSExport协议声明的计算结果方法
- (void)handleFactorialCalculateWithNumber:(NSNumber *)number
{
    NSLog(@"%@", number);
    
    NSNumber *result = [self calculateFactorialOfNumber:number];
    
    NSLog(@"%@", result);
    
    [self.context[@"showResult"] callWithArguments:@[result]];
}
//实现JSExport协议声明的Push页面方法
- (void)pushViewController:(NSString *)view title:(NSString *)title
{
    dispatch_async(dispatch_get_main_queue(), ^{
        Class second = NSClassFromString(view);
        UIViewController *secondVC = (UIViewController *)[[second alloc]init];
        secondVC.title = title;
        [self.navigationController pushViewController:secondVC animated:YES];
    });
}
#pragma mark - Factorial Method
- (NSNumber *)calculateFactorialOfNumber:(NSNumber *)number
{
    NSInteger i = [number integerValue];
    if (i < 0)
    {
        return [NSNumber numberWithInteger:0];
    }
    if (i == 0)
    {
        return [NSNumber numberWithInteger:1];
    }
    
    NSInteger r = (i * [(NSNumber *)[self calculateFactorialOfNumber:[NSNumber numberWithInteger:(i - 1)]] integerValue]);
    
    return [NSNumber numberWithInteger:r];
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

@end

