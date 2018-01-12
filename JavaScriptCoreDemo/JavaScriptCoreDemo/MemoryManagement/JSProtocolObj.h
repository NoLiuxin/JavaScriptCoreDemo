//
//  JSProtocolObj.h
//  JavaScriptCoreDemo
//
//  Created by 刘新 on 2018/1/12.
//  Copyright © 2018年 Liuxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

//定义一个JSExport protocol
@protocol JSExportTest <JSExport>
//用来保存JS的对象
@property (nonatomic, strong) JSValue *jsValue;

@end
@interface JSProtocolObj : NSObject<JSExportTest>

//添加一个JSManagedValue用来保存JSValue
@property (nonatomic, strong) JSManagedValue *managedValue;
@end
