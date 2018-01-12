//
//  OCCallJSVC.m
//  JavaScriptCoreDemo
//
//  Created by 刘新 on 2018/1/8.
//  Copyright © 2018年 Liuxin. All rights reserved.
//

#import "OCCallJSVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface OCCallJSVC ()
@property (weak, nonatomic) IBOutlet UITextField *testTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultLab;
@property (strong, nonatomic) JSContext *context;
@end

@implementation OCCallJSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"OC调用JS";
    self.context = [[JSContext alloc] init];
    [self.context evaluateScript:[self loadJsFile:@"OCCallJS"]];
}
- (NSString *)loadJsFile:(NSString*)fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"js"];
    NSString *jsScript = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return jsScript;
}
- (IBAction)clickCalculate:(UIButton *)sender {
    NSNumber *inputNumber = [NSNumber numberWithInteger:[self.testTextField.text integerValue]];
    //这里面首先要获取JS里面的计算函数，在OC中，所有表示JS中对象，都用JSValue来创建，通过objectForKeyedSubscript方法或者直接使用下标的方法获取JS对象，然后使用callWithArguments方法来执行函数
    JSValue *function = [self.context objectForKeyedSubscript:@"factorial"];
    JSValue *result = [function callWithArguments:@[inputNumber]];
    self.resultLab.text = [NSString stringWithFormat:@"%@", [result toNumber]];
    
    // 方法二.
//    JSValue * function = self.context[@"factorial"];
//    JSValue *result = [function callWithArguments:@[inputNumber]];
//    self.resultLab.text = [NSString stringWithFormat:@"%@", [result toNumber]];
    
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
