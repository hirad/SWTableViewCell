//
//  NSMutableArray+SWUtilityButtons.h
//  SWTableViewCell
//
//  Created by Matt Bowman on 11/27/13.
//  Copyright (c) 2013 Chris Wendel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWUtilityButtonView.h"

@interface NSMutableArray (SWUtilityButtons)

- (void)sw_addUtilityButtonWithColor:(UIColor *)color
                               title:(NSString *)title;
- (void)sw_addUtilityButtonWithColor:(UIColor *)color
                                icon:(UIImage *)icon;
- (void)sw_addUtilityButtonWithType:(UIButtonType)buttonType
                              color:(UIColor *)color
                              title:(NSString *)title
                         tapHandler:(SWUtilityButtonBlock)handlerBlock;
- (void)sw_addUtilityButtonWithType:(UIButtonType)buttonType
                              color:(UIColor *)color
                               icon:(UIImage *)icon
                         tapHandler:(SWUtilityButtonBlock)handlerBlock;

@end
