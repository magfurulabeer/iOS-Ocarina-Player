//
//  Ocarina.m
//  Ocarina Player
//
//  Created by Magfurul Abeer on 2/23/16.
//  Copyright © 2016 Magfurul Abeer. All rights reserved.
//

#import "Ocarina.h"

@implementation Ocarina

-(instancetype)init {
    self = [super init];
    if (self) {
        NSURL *ocarinaAUrl = [[NSBundle mainBundle]URLForResource:@"ocarinaA" withExtension:@"wav"];
        NSURL *ocarinaFUrl = [[NSBundle mainBundle]URLForResource:@"ocarinaF" withExtension:@"wav"];
        NSURL *ocarinaDUrl = [[NSBundle mainBundle]URLForResource:@"ocarinaD" withExtension:@"wav"];
        NSURL *ocarinaD2Url = [[NSBundle mainBundle]URLForResource:@"ocarinaD2" withExtension:@"wav"];
        NSURL *ocarinaBUrl = [[NSBundle mainBundle]URLForResource:@"ocarinaB" withExtension:@"wav"];
        NSArray *songOfStorms = @[@(A),@(Down),@(Up),@(A),@(Down),@(Up)];
        NSArray *eponasSong = @[@(Up),@(Left),@(Right),@(Up),@(Left),@(Right)];
        NSArray *zeldasLullaby = @[@(Left),@(Up),@(Right),@(Left),@(Up),@(Right)];
        NSArray *sariasSong = @[@(Down),@(Right),@(Left),@(Down),@(Right),@(Left)];
        NSArray *sunSong = @[@(Right),@(Down),@(Up),@(Right),@(Down),@(Up)];
        NSArray *requiemOfSpirit = @[@(A),@(Down),@(A),@(Right),@(Down),@(A)];
        NSArray *minuetOfWoods = @[@(A),@(Up),@(Left),@(Right),@(Left),@(Right)];
        NSArray *boleroOfFire = @[@(Down),@(A),@(Down),@(A),@(Right),@(Down),@(Right),@(Down)];
        NSArray *songOfTime = @[@(Right),@(A),@(Down),@(Right),@(A),@(Down)];
        NSArray *serenadeOfWater = @[@(A),@(Down),@(Right),@(Right),@(Left)];
        NSArray *nocturneOfShadow = @[@(Left),@(Right),@(Right),@(A),@(Left),@(Right),@(Down)];
        
        
        _melody = [@[] mutableCopy];
        _ocarinaA = [[AVAudioPlayer alloc] initWithContentsOfURL:ocarinaAUrl  error:nil];
        _ocarinaF = [[AVAudioPlayer alloc] initWithContentsOfURL:ocarinaFUrl  error:nil];
        _ocarinaD = [[AVAudioPlayer alloc] initWithContentsOfURL:ocarinaDUrl  error:nil];
        _ocarinaD2 = [[AVAudioPlayer alloc] initWithContentsOfURL:ocarinaD2Url  error:nil];
        _ocarinaB = [[AVAudioPlayer alloc] initWithContentsOfURL:ocarinaBUrl  error:nil];
        _songList = @{  @"Song Of Storms"    :   songOfStorms,
                        @"Zelda's Lullaby"   :   zeldasLullaby,
                        @"Epona's Song"      :   eponasSong,
                        @"Saria's Song"      :   sariasSong,
                        @"Sun Song"          :   sunSong,
                        @"Requiem Of Spirit" :   requiemOfSpirit,
                        @"Minuet Of Forest"  :   minuetOfWoods,  // mp3 & song names dont match
                        @"Bolero Of Fire"    :   boleroOfFire,
                        @"Song Of Time"      :   songOfTime,
                        @"Serenade Of Water" :   serenadeOfWater,
                        @"Nocturne of Shadow":   nocturneOfShadow
                      };
    }
    return self;
}

-(void)addNoteToMelody:(Button)button {
    NSNumber *note = @(button);
    [self.melody addObject:note];
    
}

-(void)resetMelody {
    self.melody = [@[] mutableCopy];
}

-(void)playOcarinaA {
    NSURL *ocarinaAUrl = [[NSBundle mainBundle]URLForResource:@"ocarinaA" withExtension:@"wav"];

    self.ocarinaA = [[AVAudioPlayer alloc] initWithContentsOfURL:ocarinaAUrl error:nil];
    [self.ocarinaA prepareToPlay];
    self.ocarinaA.currentTime = 0;
    [self.ocarinaA play];
}

-(void)playOcarinaF {
    [self.ocarinaF play];
}

-(void)playOcarinaD {
    [self.ocarinaD play];
}

-(void)playOcarinaD2 {
    [self.ocarinaD2 play];
}
-(void)playOcarinaB {
    [self.ocarinaB play];
}

-(NSString *)melodyMatchesSong {
    if ([self.melody count] == 6) {
        NSArray *sixNoteSongs = @[@"Song Of Storms", @"Epona's Song", @"Zelda's Lullaby", @"Saria's Song", @"Sun Song", @"Requiem Of Spirit", @"Minuet Of Forest", @"Song Of Time"];
        for (NSString *songName in sixNoteSongs) {
            NSArray *songNotes = self.songList[songName];
            if ([self.melody isEqualToArray:songNotes]) {
                return songName;
            }
        }
    } else if ([self.melody count] == 5) {
        if ([self.melody isEqualToArray:self.songList[@"Serenade Of Water"]]) {
            return @"Serenade Of Water";
        }
    } else if ([self.melody count] == 7) {
        if ([self.melody isEqualToArray:self.songList[@"Nocturne of Shadow"]]) {
            return @"Nocturne of Shadow";
        }
    } else if ([self.melody count] == 8) {
        if ([self.melody isEqualToArray:self.songList[@"Bolero Of Fire"]]) {
            return @"Bolero Of Fire";
        }
    }
    
    return nil;
}

-(void)playSong:(NSString *)songName {
    NSDictionary *audioFileNames = @{  @"Song Of Storms"    :   @"song of storms",
                                       @"Zelda's Lullaby"   :   @"zeldas lullaby",
                                       @"Epona's Song"      :   @"eponas song",
                                       @"Saria's Song"      :   @"sarias song",
                                       @"Sun Song"          :   @"sun song",
                                       @"Requiem Of Spirit" :   @"requiem of spirit",
                                       @"Minuet Of Forest"  :   @"minuet of woods",
                                       @"Bolero Of Fire"    :   @"bolero of fire",
                                       @"Song Of Time"      :   @"song of time",
                                       @"Serenade Of Water" :   @"serenade of water",
                                       @"Nocturne of Shadow":   @"nocturne of shadow"
                                       };
    NSURL *matchedSongUrl = [[NSBundle mainBundle] URLForResource:audioFileNames[songName] withExtension:@"mp3"];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:matchedSongUrl  error:nil];
    [self.audioPlayer play];
}

@end
