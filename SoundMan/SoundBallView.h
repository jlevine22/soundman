//
//  SoundBallView.h
//  SoundMan
//
//  Created by Josh Levine on 2/9/16.
//  Copyright © 2016 Josh Levine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SoundBallView : UIView
@property (nonatomic, copy) NSURL *soundUrl;
- (void)move;
- (void)setColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
- (void)startMoving;
- (void)stopMoving;
@end
