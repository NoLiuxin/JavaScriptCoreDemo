//
//  JSCallOCVC.h
//  JavaScriptCoreDemo
//
//  Created by 刘新 on 2017/12/29.
//  Copyright © 2017年 Liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

//声明JSExport协议
@protocol TestJSExport <JSExport>
JSExportAs(calculateForJS  /** handleFactorialCalculateWithNumber 作为js方法的别名 */,
- (void)handleFactorialCalculateWithNumber:(NSNumber *)number
);
- (void)pushViewController:(NSString *)view title:(NSString *)title;
@end

@interface JSCallOCVC : UIViewController<TestJSExport>

@end
