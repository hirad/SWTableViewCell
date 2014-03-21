//
//  NSMutableArray+SWUtilityButtons.m
//  SWTableViewCell
//
//  Created by Matt Bowman on 11/27/13.
//  Copyright (c) 2013 Chris Wendel. All rights reserved.
//

#import "NSMutableArray+SWUtilityButtons.h"
#import "SWUtilityButtonDescriptor.h"

@implementation NSMutableArray (SWUtilityButtons)

- (void)sw_addUtilityButtonWithType:(UIButtonType)buttonType
                              color:(UIColor *)color
                              title:(NSString *)title
                         tapHandler:(SWUtilityButtonBlock)handlerBlock
{
    SWUtilityButtonDescriptor* buttonDescriptor = [SWUtilityButtonDescriptor new];
    buttonDescriptor.buttonType = buttonType;
    buttonDescriptor.title = title;
    buttonDescriptor.color = color;
    buttonDescriptor.tapHandler = handlerBlock;
    
    [self addObject:buttonDescriptor];
}

-(void)sw_addUtilityButtonWithType:(UIButtonType)buttonType
                             color:(UIColor *)color
                              icon:(UIImage *)icon
                        tapHandler:(SWUtilityButtonBlock)handlerBlock
{
    SWUtilityButtonDescriptor* buttonDescriptor = [SWUtilityButtonDescriptor new];
    buttonDescriptor.buttonType = buttonType;
    buttonDescriptor.icon = icon;
    buttonDescriptor.color = color;
    buttonDescriptor.tapHandler = handlerBlock;
    
    [self addObject:buttonDescriptor];
}

- (void)sw_addUtilityButtonWithColor:(UIColor *)color
                               title:(NSString *)title
{
    [self sw_addUtilityButtonWithType:UIButtonTypeCustom
                                color:color
                                title:title
                           tapHandler:nil];
}

- (void)sw_addUtilityButtonWithColor:(UIColor *)color
                                icon:(UIImage *)icon
{
    [self sw_addUtilityButtonWithType:UIButtonTypeCustom
                                color:color
                                 icon:icon
                           tapHandler:nil];
}

@end

