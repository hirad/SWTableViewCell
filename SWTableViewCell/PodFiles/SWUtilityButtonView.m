//
//  SWUtilityButtonView.m
//  SWTableViewCell
//
//  Created by Matt Bowman on 11/27/13.
//  Copyright (c) 2013 Chris Wendel. All rights reserved.
//

#import "SWUtilityButtonView.h"
#import "SWUtilityButtonTapGestureRecognizer.h"
#import "SWConstants.h"
#import "UIButton+SWTVCBlockAdditions.h"
#import "SWUtilityButtonDescriptor.h"

@interface SWUtilityButtonView ()

@property (nonatomic, strong) NSArray* utilityButtonDescriptors;

@end

@implementation SWUtilityButtonView

#pragma mark - SWUtilityButonView initializers

- (id)initWithUtilityButtons:(NSArray *)utilityButtons parentCell:(SWTableViewCell *)parentCell utilityButtonSelector:(SEL)utilityButtonSelector
{
    self = [super init];
    
    if (self) {
        self.utilityButtons = [NSMutableArray new];
        self.utilityButtonDescriptors = utilityButtons;
        self.utilityButtonWidth = [self calculateUtilityButtonWidth];
        self.parentCell = parentCell;
        self.utilityButtonSelector = utilityButtonSelector;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame utilityButtons:(NSArray *)utilityButtons parentCell:(SWTableViewCell *)parentCell utilityButtonSelector:(SEL)utilityButtonSelector
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.utilityButtons = [NSMutableArray new];
        self.utilityButtonDescriptors = utilityButtons;
        self.utilityButtonWidth = [self calculateUtilityButtonWidth];
        self.parentCell = parentCell;
        self.utilityButtonSelector = utilityButtonSelector;
    }
    
    return self;
}

#pragma mark Populating utility buttons

- (CGFloat)calculateUtilityButtonWidth
{
    CGFloat buttonWidth = kUtilityButtonWidthDefault;
    if (buttonWidth * _utilityButtons.count > kUtilityButtonsWidthMax)
    {
        CGFloat buffer = (buttonWidth * _utilityButtons.count) - kUtilityButtonsWidthMax;
        buttonWidth -= (buffer / _utilityButtons.count);
    }
    return buttonWidth;
}

- (CGFloat)utilityButtonsWidth
{
    return (_utilityButtons.count * _utilityButtonWidth);
}

- (void)populateUtilityButtons
{
    NSUInteger utilityButtonsCounter = 0;
    for (SWUtilityButtonDescriptor* buttonDescriptor in _utilityButtonDescriptors)
    {
        UIButton* utilityButton = [buttonDescriptor describedButton];
        CGFloat utilityButtonXCord = 0;
        if (utilityButtonsCounter >= 1) utilityButtonXCord = _utilityButtonWidth * utilityButtonsCounter;
        [utilityButton setFrame:CGRectMake(utilityButtonXCord, 0, _utilityButtonWidth, CGRectGetHeight(self.bounds))];
        [utilityButton setTag:utilityButtonsCounter];
        
        if (buttonDescriptor.tapHandler == nil) {
            SWUtilityButtonTapGestureRecognizer *utilityButtonTapGestureRecognizer =
            [[SWUtilityButtonTapGestureRecognizer alloc] initWithTarget:_parentCell
                                                                 action:_utilityButtonSelector];
            utilityButtonTapGestureRecognizer.buttonIndex = utilityButtonsCounter;
            [utilityButton addGestureRecognizer:utilityButtonTapGestureRecognizer];
        }
        else
        {
            SWButtonBlock tapHandlerBlock = ^(id sender)
            {
                buttonDescriptor.tapHandler(_parentCell, sender);
            };
            
            [utilityButton addHandler:tapHandlerBlock
                     forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self addSubview: utilityButton];
        [self.utilityButtons addObject:utilityButton];
        
        utilityButtonsCounter++;
    }
}

- (void)setHeight:(CGFloat)height
{
    for (NSUInteger utilityButtonsCounter = 0; utilityButtonsCounter < _utilityButtons.count; utilityButtonsCounter++)
    {
        UIButton *utilityButton = (UIButton *)_utilityButtons[utilityButtonsCounter];
        CGFloat utilityButtonXCord = 0;
        if (utilityButtonsCounter >= 1) utilityButtonXCord = _utilityButtonWidth * utilityButtonsCounter;
        [utilityButton setFrame:CGRectMake(utilityButtonXCord, 0, _utilityButtonWidth, height)];
    }
}

@end

