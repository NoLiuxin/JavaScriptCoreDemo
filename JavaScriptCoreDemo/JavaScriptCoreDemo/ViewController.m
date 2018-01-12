//
//  ViewController.m
//  JavaScriptCoreDemo
//
//  Created by 刘新 on 2017/12/27.
//  Copyright © 2017年 Liuxin. All rights reserved.
//

#import "ViewController.h"
#import "JSCallOCVC.h"
#import "OCCallJSVC.h"
#import "MemoryManagementVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Home";
}

- (IBAction)onClickPushVC:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            JSCallOCVC *jSCallOCVC = [[JSCallOCVC alloc] init];
            [self.navigationController pushViewController:jSCallOCVC animated:YES];
        }
            break;
        case 2:{
            OCCallJSVC *oCCallJSVC = [[OCCallJSVC alloc] init];
            [self.navigationController pushViewController:oCCallJSVC animated:YES];
        }
            break;
        case 3:{
            MemoryManagementVC *memoryManagementVC = [[MemoryManagementVC alloc] init];
            [self.navigationController pushViewController:memoryManagementVC animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
