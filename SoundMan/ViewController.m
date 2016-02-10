//
//  ViewController.m
//  SoundMan
//
//  Created by Josh Levine on 2/7/16.
//  Copyright © 2016 Josh Levine. All rights reserved.
//

#import "ViewController.h"
#import "SoundManager.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray<NSURL *> *soundFiles;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playSound:(id)sender {
    int index = arc4random_uniform(soundFiles.count);
    NSURL *url = [soundFiles objectAtIndex:index];
    [[SoundManager sharedInstance] playSoundFromURL:url completion:^(BOOL successful) {
        // Sound finished playing
    }];
}

@end
