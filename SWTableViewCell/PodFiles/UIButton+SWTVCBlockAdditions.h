//
//  UIButton+SWTVCBlockAdditions.h
//  SWTableViewCell
//
//  Created by Hirad Motamed on 2014-03-20.
//  Copyright (c) 2014 Chris Wendel. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SWButtonBlock)(id);

/**
 * This category copies the functionality provided in BlocksKit's 
 * UIControl+BlocksKit category, but without needing to include
 * all of BlocksKit in the project.
 */

@interface UIButton (SWTVCBlockAdditions)

-(void)addHandler:(SWButtonBlock)handler forControlEvents:(UIControlEvents)controlEvents;
-(void)removeHandlersForControlEvents:(UIControlEvents)controlEvents;
-(BOOL)hasEventHandlersForControlEvents:(UIControlEvents)controlEvents;

@end
