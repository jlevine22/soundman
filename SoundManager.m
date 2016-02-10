//
//  SoundManager.m
//  SoundMan
//
//  Created by Josh Levine on 2/8/16.
//  Copyright © 2016 Josh Levine. All rights reserved.
//

#import "SoundManager.h"
#import <AVFoundation/AVFoundation.h>

@implementation SoundManager
{
    AVAudioPlayer *player;
    SoundPlayedCompletion completionBlock;
}

+ (SoundManager*)sharedInstance {
    static SoundManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[SoundManager alloc] init];
    });
    return _sharedInstance;
}

- (void)playSoundFromURL:(NSURL*)url completion:(SoundPlayedCompletion)completion {
    if (player != nil) {
        [player stop];
        player = nil;
    }
    NSError *error;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (error != nil) {
        completion(NO);
        return;
    }
    completionBlock = completion;
    player.delegate = self;
    player.volume = 1.0;
    [player prepareToPlay];
    [player play];
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    self->player = nil;
    if (completionBlock != nil) {
        completionBlock(flag);
        completionBlock = nil;
    }
}

@end