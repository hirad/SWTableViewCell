//
//  SWUtilityButtonDescriptor.m
//  SWTableViewCell
//
//  Created by Hirad Motamed on 2014-03-20.
//  Copyright (c) 2014 Chris Wendel. All rights reserved.
//

#import "SWUtilityButtonDescriptor.h"
#import "UIButton+SWTVCBlockAdditions.h"

@implementation SWUtilityButtonDescriptor

-(UIButton *)describedButton
{
    UIButton* button = [UIButton buttonWithType:self.buttonType];
    button.backgroundColor = self.color;
    
    if (self.title) {
        [button setTitle:self.title forState:UIControlStateNormal];
    }
    else if (self.icon)
    {
        [button setImage:self.icon forState:UIControlStateNormal];
    }
    else
        [NSException raise:NSInvalidArgumentException
                    format:@"SWUtilityButtonDesciptor should not "
                            "have nil title and nil icon."];
    
    return button;
}

@end
