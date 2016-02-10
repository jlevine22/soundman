//
//  TouchBeganGestureRecognizer.m
//  SoundMan
//
//  Created by Josh Levine on 2/10/16.
//  Copyright © 2016 Josh Levine. All rights reserved.
//

#import <UIKit/UIGestureRecognizerSubclass.h>

#import "TouchBeganGestureRecognizer.h"

@implementation TouchBeganGestureRecognizer

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setState:UIGestureRecognizerStateBegan];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setState:UIGestureRecognizerStateCancelled];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //[self setState:UIGestureRecognizerStateFailed];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setState:UIGestureRecognizerStateEnded];
}

@end
