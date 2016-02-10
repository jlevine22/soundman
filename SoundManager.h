//
//  SoundManager.h
//  SoundMan
//
//  Created by Josh Levine on 2/8/16.
//  Copyright © 2016 Josh Levine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^SoundPlayedCompletion)(BOOL successful);

@interface SoundManager : NSObject <AVAudioPlayerDelegate>
+ (SoundManager*)sharedInstance;
- (void)playSoundFromURL:(NSURL*)url completion:(SoundPlayedCompletion)completion;
- (void)stopSound;
@end
