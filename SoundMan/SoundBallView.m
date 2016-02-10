//
//  SoundBallView.m
//  SoundMan
//
//  Created by Josh Levine on 2/9/16.
//  Copyright © 2016 Josh Levine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SoundBallView.h"
#import "SoundManager.h"
#import "TouchBeganGestureRecognizer.h"


@implementation SoundBallView
{
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    TouchBeganGestureRecognizer *gesture;
    BOOL moving;
    NSValue *lastToValue;
}
@synthesize soundUrl;

- (void)setColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    self.backgroundColor = [UIColor clearColor];
    self->red = red / 255;
    self->green = green / 255;
    self->blue = blue / 255;
}

- (void)startMoving {
    [[SoundManager sharedInstance] stopSound];
    moving = YES;
    self.alpha = 1.0;

    [self.layer removeAllAnimations];
    
    CATransform3D fromTransform;
    if (self.layer.presentationLayer != nil) {
        fromTransform = [(CALayer*)self.layer.presentationLayer transform];
    } else {
        fromTransform = [self.layer transform];
    }
    
    CATransform3D transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
    CABasicAnimation *scaleUp = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleUp.fromValue = [NSValue valueWithCATransform3D:fromTransform];
    scaleUp.toValue = [NSValue valueWithCATransform3D:transform];
    scaleUp.duration = 0.1;
    self.layer.transform = transform;
    [self.layer addAnimation:scaleUp forKey:@"frame.size"];
    
    [self move];
}

- (void)stopMoving {
    [self.superview bringSubviewToFront:self];
    CALayer *presentationLayer = self.layer.presentationLayer;
    if (presentationLayer != nil) {
        self.layer.position = presentationLayer.position;
        self.layer.transform = presentationLayer.transform;
    }
    [self.layer removeAllAnimations];
    
    CATransform3D transform = CATransform3DMakeScale(1.5, 1.5, 1.0);
    CABasicAnimation *scaleUp = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleUp.fromValue = [NSValue valueWithCATransform3D:self.layer.transform];
    scaleUp.toValue = [NSValue valueWithCATransform3D:transform];
    scaleUp.duration = 0.1;
    self.layer.transform = transform;
    [self.layer addAnimation:scaleUp forKey:@"frame.size"];

    self.alpha = 0.7;
    moving = NO;
    [[SoundManager sharedInstance] playSoundFromURL:soundUrl completion:^(BOOL successful) {
        //
    }];
}

- (void)move {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat x = -self.frame.size.width + arc4random_uniform(bounds.size.width + self.frame.size.width);
    CGFloat y = -self.frame.size.width + arc4random_uniform(bounds.size.height + self.frame.size.width);
    CGPoint position = CGPointMake(x, y);
    
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
    move.fromValue = [NSValue valueWithCGPoint:self.layer.position];
    move.toValue = [NSValue valueWithCGPoint:position];
    self.layer.position = position;
    move.duration = 3 + arc4random_uniform(2);
    move.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    move.delegate = self;
    [self.layer addAnimation:move forKey:@"position"];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    if (moving) {
        [self move];
    }
}

#pragma mark - drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(contextRef, red, green, blue, 1.0);
    CGContextFillEllipseInRect(contextRef, rect);
}

@end
