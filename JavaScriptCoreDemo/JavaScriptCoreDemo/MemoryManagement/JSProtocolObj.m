//
//  JSProtocolObj.m
//  JavaScriptCoreDemo
//
//  Created by 刘新 on 2018/1/12.
//  Copyright © 2018年 Liuxin. All rights reserved.
//

#import "JSProtocolObj.h"

@implementation JSProtocolObj

@synthesize jsValue = _jsValue;

//重写setter方法
- (void)setJsValue:(JSValue *)jsValue
{
    _managedValue = [JSManagedValue managedValueWithValue:jsValue];
    [[[JSContext currentContext] virtualMachine] addManagedReference:_managedValue
                                                           withOwner:self];
}
@end
