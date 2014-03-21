//
//  SWUtilityButtonDescriptor.h
//  SWTableViewCell
//
//  Created by Hirad Motamed on 2014-03-20.
//  Copyright (c) 2014 Chris Wendel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWUtilityButtonView.h"

@interface SWUtilityButtonDescriptor : NSObject

@property (nonatomic, assign) UIButtonType buttonType;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) UIImage* icon;
@property (nonatomic, strong) UIColor* color;
@property (nonatomic, copy) SWUtilityButtonBlock tapHandler;

-(UIButton*)describedButton;

@end
