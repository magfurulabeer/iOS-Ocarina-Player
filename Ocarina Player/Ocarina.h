//
//  Ocarina.h
//  Ocarina Player
//
//  Created by Magfurul Abeer on 2/23/16.
//  Copyright © 2016 Magfurul Abeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef enum {
    Up,
    Down,
    Left,
    Right,
    A,
    B
} Button;

@interface Ocarina : NSObject

@property (strong, nonatomic) NSMutableArray *melody;
@property (strong, nonatomic) AVAudioPlayer *ocarinaA;
@property (strong, nonatomic) AVAudioPlayer *ocarinaF;
@property (strong, nonatomic) AVAudioPlayer *ocarinaD;
@property (strong, nonatomic) AVAudioPlayer *ocarinaD2;
@property (strong, nonatomic) AVAudioPlayer *ocarinaB;
@property (strong, nonatomic) NSDictionary *songList;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

-(void)addNoteToMelody:(Button)button;
-(void)resetMelody;
-(void)playOcarinaA; // right
-(void)playOcarinaF; // down
-(void)playOcarinaD; // a
-(void)playOcarinaD2; // left
-(void)playOcarinaB; // up
-(NSString *)melodyMatchesSong;
-(void)playSong:(NSString *)songName;
@end
