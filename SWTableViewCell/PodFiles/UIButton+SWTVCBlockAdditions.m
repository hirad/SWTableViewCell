//
//  UIButton+SWTVCBlockAdditions.m
//  SWTableViewCell
//
//  Created by Hirad Motamed on 2014-03-20.
//  Copyright (c) 2014 Chris Wendel. All rights reserved.
//

#import "UIButton+SWTVCBlockAdditions.h"
#import <objc/runtime.h>

#pragma mark Private Class

static char kButtonHandlerKey;

@interface BKControlWrapper : NSObject <NSCopying>

- (id)initWithHandler:(SWButtonBlock)aHandler
     forControlEvents:(UIControlEvents)someControlEvents;

@property (nonatomic, copy) SWButtonBlock handler;
@property (nonatomic) UIControlEvents controlEvents;

@end


@implementation BKControlWrapper

@synthesize handler, controlEvents;

- (id)initWithHandler:(SWButtonBlock)aHandler
     forControlEvents:(UIControlEvents)someControlEvents {
	if ((self = [super init])) {
		self.handler = aHandler;
		self.controlEvents = someControlEvents;
	}
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
	return [[BKControlWrapper alloc] initWithHandler:self.handler
                                    forControlEvents:self.controlEvents];
}

- (void)invoke:(id)sender {
	self.handler(sender);
}

- (void)dealloc {
	self.handler = nil;
}

@end

#pragma mark -

@implementation UIButton (SWTVCBlockAdditions)

-(void)addHandler:(SWButtonBlock)handler
 forControlEvents:(UIControlEvents)controlEvents
{
    NSParameterAssert(handler);
    
	NSMutableDictionary *events = objc_getAssociatedObject(self,
                                                           &kButtonHandlerKey);
	if (!events) {
		events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self,
                                 &kButtonHandlerKey,
                                 events,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
    
	NSNumber *key = @(controlEvents);
	NSMutableSet *handlers = [events objectForKey:key];
	if (!handlers) {
		handlers = [NSMutableSet set];
		[events setObject:handlers forKey:key];
	}
    
	BKControlWrapper *target = [[BKControlWrapper alloc] initWithHandler:handler
                                                        forControlEvents:controlEvents];
	[handlers addObject:target];
	[self addTarget:target
             action:@selector(invoke:)
   forControlEvents:controlEvents];
}

-(void)removeHandlersForControlEvents:(UIControlEvents)controlEvents
{
    NSMutableDictionary *events = objc_getAssociatedObject(self,
                                                           &kButtonHandlerKey);
	if (!events) {
		events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self,
                                 &kButtonHandlerKey,
                                 events,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
    
	NSNumber *key = @(controlEvents);
	NSSet *handlers = [events objectForKey:key];
    
	if (!handlers)
		return;
    
    for (BKControlWrapper* handler in handlers) {
        [self removeTarget:handler
                    action:NULL
          forControlEvents:controlEvents];
    }
    
	[events removeObjectForKey:key];
}

- (BOOL)hasEventHandlersForControlEvents:(UIControlEvents)controlEvents {
    NSMutableDictionary *events = objc_getAssociatedObject(self,
                                                           &kButtonHandlerKey);
	if (!events) {
		events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self,
                                 &kButtonHandlerKey,
                                 events,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
    
	NSNumber *key = @(controlEvents);
	NSSet *handlers = [events objectForKey:key];
    
	if (!handlers)
		return NO;
    
	return handlers.count;
}

@end
