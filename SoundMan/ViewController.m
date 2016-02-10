//
//  ViewController.m
//  SoundMan
//
//  Created by Josh Levine on 2/7/16.
//  Copyright © 2016 Josh Levine. All rights reserved.
//

#import "ViewController.h"
#import "SoundBallView.h"
#import "SoundManager.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray<NSURL *> *soundFiles;
    SoundBallView *touchedBall;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    soundFiles = [[NSMutableArray alloc] init];
    NSArray *types = [NSArray arrayWithObjects:@"wav", @"mp3", @"aif", @"aiff", nil];
    for (NSString *type in types) {
        NSArray *files = [[NSBundle mainBundle] URLsForResourcesWithExtension:type subdirectory:nil];
        [soundFiles addObjectsFromArray:files];
    }
    for (NSURL *soundFile in soundFiles) {
        int minSize = 50;
        int sizeVariance = 30;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            minSize = 80;
            sizeVariance = 40;
        }
        int size = minSize + arc4random_uniform(sizeVariance);
        CGRect bounds = [[UIScreen mainScreen] bounds];
        CGFloat x = arc4random_uniform(bounds.size.width - size);
        CGFloat y = arc4random_uniform(bounds.size.height - size);
        SoundBallView *ball = [[SoundBallView alloc] initWithFrame:CGRectMake(x, y, size, size)];
        [ball setSoundUrl:soundFile];
        [ball setColorWithRed:arc4random_uniform(256) green:arc4random_uniform(256) blue:arc4random_uniform(256)];
        [self.view addSubview:ball];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[SoundBallView class]]) {
            SoundBallView *soundBallView = (SoundBallView *)view;
            [soundBallView startMoving];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[SoundBallView class]]) {
            if ([view.layer.presentationLayer hitTest:location]) {
                touchedBall = view;
                [touchedBall stopMoving];
                break;
            }
        }
    }
}

- (void)releaseTouchedBall {
    if (touchedBall != nil) {
        [touchedBall startMoving];
    }
    touchedBall = nil;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self releaseTouchedBall];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self releaseTouchedBall];
}

@end
