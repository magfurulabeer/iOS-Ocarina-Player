//
//  ViewController.m
//  Hey Listen - Animation Test
//
//  Created by Magfurul Abeer on 2/23/16.
//  Copyright © 2016 Magfurul Abeer. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Ocarina.h"
#import <Social/Social.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *leftBubble;
@property (weak, nonatomic) IBOutlet UIView *rightBubble;
@property (weak, nonatomic) IBOutlet UIImageView *navi;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *note1;
@property (weak, nonatomic) IBOutlet UIImageView *note2;
@property (weak, nonatomic) IBOutlet UIImageView *note3;
@property (weak, nonatomic) IBOutlet UIImageView *note4;
@property (weak, nonatomic) IBOutlet UIImageView *note5;
@property (weak, nonatomic) IBOutlet UIImageView *note6;
@property (weak, nonatomic) IBOutlet UIImageView *note7;
@property (weak, nonatomic) IBOutlet UIImageView *note8;
@property (weak, nonatomic) IBOutlet UILabel *songTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *youPlayedLabel;

@property (nonatomic) BOOL onLeft;
@property (nonatomic) NSUInteger counter;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) AVAudioPlayer *heyListenPlayer;
@property (strong, nonatomic) AVAudioPlayer *heyPlayer;
@property (strong, nonatomic) AVAudioPlayer *songCorrectPlayer;
@property (strong, nonatomic) AVAudioPlayer *songErrorPlayer;
@property (strong, nonatomic) Ocarina *ocarina;
@property (strong, nonatomic) NSArray *notes;
@property (strong, nonatomic) NSString *songPlaying;
@property (weak, nonatomic) IBOutlet UIImageView *staff;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *naviRightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *naviLeftConstraint;
@property (weak, nonatomic) IBOutlet UIButton *cuccoButton;
@property (weak, nonatomic) IBOutlet UIButton *heartButton;

@property (nonatomic) CGFloat heightForNotes;

@end

// TODO: Place notes on right part of staff
// TODO: Make staff red. Possibly add clef.
@implementation ViewController


#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.backgroundImage setUserInteractionEnabled:YES];
    
    self.notes = @[self.note1, self.note2, self.note3, self.note4, self.note5, self.note6, self.note7, self.note8];
    
    self.ocarina = [[Ocarina alloc] init];
    
    self.leftBubble.hidden = YES;
    self.rightBubble.hidden = NO;
    
    // Prepare audio players
    
    NSURL *hyruleThemeUrl = [[NSBundle mainBundle]URLForResource:@"hyruleTheme" withExtension:@"mp3"];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:hyruleThemeUrl  error:nil];
    self.audioPlayer.volume = 0.2;
    self.audioPlayer.numberOfLoops = -1;
    [self.audioPlayer play];
    
    NSURL *heyListenUrl = [[NSBundle mainBundle]URLForResource:@"heyListen" withExtension:@"mp3"];
    self.heyListenPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:heyListenUrl  error:nil];
    self.heyListenPlayer.volume = 0.9;
    
    NSURL *heyUrl = [[NSBundle mainBundle]URLForResource:@"hey" withExtension:@"mp3"];
    self.heyPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:heyUrl  error:nil];
    self.heyPlayer.volume = 0.9;
    
    NSURL *songCorrectUrl = [[NSBundle mainBundle]URLForResource:@"song correct" withExtension:@"wav"];
    self.songCorrectPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:songCorrectUrl  error:nil];
    
    NSURL *songErrorUrl = [[NSBundle mainBundle]URLForResource:@"song error" withExtension:@"wav"];
    self.songErrorPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:songErrorUrl  error:nil];
    
    
    self.onLeft = NO;
    self.counter = 0;
    self.heartButton.hidden = YES;
    self.cuccoButton.hidden = YES;
    
    
    // Hide them after first second
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(hideBubbles) userInfo:nil repeats:NO];
    
    // Toggle bubbles every 3 seconds
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(toggleActions) userInfo:nil repeats:YES];
    
    
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    self.heightForNotes = self.note1.frame.size.height;
    [self hideNotes];

    
    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.naviRightConstraint.active = NO;
        self.naviLeftConstraint.active = YES;
        
        [self.view layoutIfNeeded];
        
    } completion:nil];
    
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(flip) userInfo:nil repeats:YES];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navi Animation methods

-(void)toggleActions {
    // Toggle bubbles and image
    self.onLeft = !self.onLeft;
    if (self.onLeft) {
        self.leftBubble.hidden = NO;
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(hideBubbles) userInfo:nil repeats:NO];

    } else {
        self.rightBubble.hidden = NO;
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(hideBubbles) userInfo:nil repeats:NO];
    }
    
    
    
    // Play correct hey sound
    if (self.onLeft) {
        [self.heyListenPlayer play];
    } else {
        [self.heyPlayer play];
    }
}

-(void)hideBubbles {
    self.rightBubble.hidden = YES;
    self.leftBubble.hidden = YES;
}

#pragma mark - Unimplemented Methods
-(void)flip {
    [UIView animateWithDuration:0.5 delay:2.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.navi.layer.transform = CATransform3DMakeRotation(M_PI,0.0,-1.0,0.0);
                     } completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - Music Methods

-(void)resetNotes {
    NSDictionary *audioTimes = @{       @"Song Of Storms"    :   @5,
                                        @"Zelda's Lullaby"   :   @10,
                                        @"Epona's Song"      :   @8,
                                        @"Saria's Song"      :   @6,
                                        @"Sun Song"          :   @5,
                                        @"Requiem Of Spirit" :   @21,
                                        @"Minuet Of Forest"  :   @16,
                                        @"Bolero Of Fire"    :   @18,
                                        @"Song Of Time"      :   @10,
                                        @"Serenade Of Water" :   @17,
                                        @"Nocturne of Shadow":   @20
                                        
                                        };
    NSTimeInterval time = [audioTimes[self.songPlaying] integerValue];
    
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(hideNotes) userInfo:nil repeats:NO];
    [self.ocarina resetMelody];
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(turnOnVolume) userInfo:nil repeats:NO];
}

// Also hides labels. Rename?
-(void)turnOnVolume {
    self.audioPlayer.volume = 0.5;
    self.songTitleLabel.hidden = YES;
    self.youPlayedLabel.hidden = YES;
    self.songPlaying = nil;
    self.heartButton.hidden = YES;
    self.cuccoButton.hidden = YES;
}

-(void)hideNotes {
    self.staff.transform = CGAffineTransformMakeTranslation(0, 0);
    
    for (UIImageView *noteImgView in self.notes) {
        CGSize size = noteImgView.frame.size;
        CGPoint origin = noteImgView.frame.origin;
        noteImgView.frame = CGRectMake(origin.x, origin.y, size.width, 0);
    }
}

-(void)checkForMatch {
    NSString *matchedSong = [self.ocarina melodyMatchesSong];
    if (matchedSong) {
        self.audioPlayer.volume = 0;
        self.heyListenPlayer.volume = 0;
        self.heyPlayer.volume = 0;
        [self.songCorrectPlayer play];
        self.heartButton.hidden = NO;
        self.cuccoButton.hidden = NO;
        self.songPlaying = matchedSong;
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playSong) userInfo:nil repeats:NO];
    } else {
        if ([self.ocarina.melody count] == 8) {
            [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.staff.transform = CGAffineTransformIdentity;
            } completion:nil];
            [self.songErrorPlayer play];
            [self resetNotes];
         
        }
    }
}

-(void)playSong {
    self.youPlayedLabel.hidden = NO;
    self.songTitleLabel.text = self.songPlaying;
    self.songTitleLabel.hidden = NO;
    [self.ocarina playSong:self.songPlaying];
    [self resetNotes];
}

-(void)displayImage:(UIImage *)img {
    NSUInteger count = [self.ocarina.melody count];
    UIImageView *note = self.notes[count-1];
    note.image = img;
    CGSize size = note.frame.size;
    CGPoint origin = note.frame.origin;
    note.frame = CGRectMake(origin.x, origin.y, size.width, self.heightForNotes);
}

#pragma mark - IBActions and Gestures


- (IBAction)bubbleTapped:(UIButton *)sender {
    self.counter++;
    self.heyPlayer.volume = 0;
    self.heyListenPlayer.volume = 0;
    
    NSString *msg;
    if (self.counter == 0) {
        msg = @"ok";
    } else if (self.counter > 0 && self.counter < 3) {
        msg = @"OK";
    } else {
        msg = @"OK!!!";
    }
    
    
    UIAlertController *listen = [UIAlertController alertControllerWithTitle:@"Hey Listen" message:@"I'm Navi the fairy! The Great Deku Tree asked me to tell you how to play.\n\nSwipe to input a C Directional button.\n\nTap to input an A Button.\n\nYou can shake your phone to reset the melody!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:msg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [listen addAction:ok];
    
    [self presentViewController:listen animated:YES completion:nil];
    
}

- (IBAction)tapGestureRecognized:(UITapGestureRecognizer *)sender {
    [self playNoteForButton:A withImage:@"a"];
}

- (IBAction)swipeUpRecognized:(UISwipeGestureRecognizer *)sender {
    [self playNoteForButton:Up withImage:@"up"];

}

- (IBAction)swipeDownRecognized:(UISwipeGestureRecognizer *)sender {
    [self playNoteForButton:Down withImage:@"down"];
}

- (IBAction)swipeLeftRecognized:(UISwipeGestureRecognizer *)sender {
    [self playNoteForButton:Left withImage:@"left"];
}

- (IBAction)swipeRightRecognized:(UISwipeGestureRecognizer *)sender {
    [self playNoteForButton:Right withImage:@"right"];
}

-(void)playNoteForButton:(Button)button withImage:(NSString *)imageName {
    if (!self.songPlaying) {
        if ([imageName isEqualToString:@"a"]) {
            [self.ocarina playOcarinaD];
        }
        if ([imageName isEqualToString:@"up"]) {
            [self.ocarina playOcarinaD2];
        }
        if ([imageName isEqualToString:@"down"]) {
            [self.ocarina playOcarinaF];
        }
        if ([imageName isEqualToString:@"left"]) {
            [self.ocarina playOcarinaB];
        }
        if ([imageName isEqualToString:@"right"]) {
            [self.ocarina playOcarinaA];
        }
        [self.ocarina addNoteToMelody:button];
        [self displayImage:[UIImage imageNamed:imageName]];
        [self checkForMatch];
    }
}


-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.staff.transform = CGAffineTransformIdentity;
        } completion:nil];
        [self.songErrorPlayer play];
        [self resetNotes];
    }
}

- (IBAction)heartTapped:(id)sender {
    SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    NSString *msg = [NSString stringWithFormat:@"I just played %@ on Ocarina Player!", self.songPlaying];
    [vc setInitialText:msg];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)cuccoTapped:(UIButton *)sender {
    SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    NSString *msg = [NSString stringWithFormat:@"I just played %@ on Ocarina Player!", self.songPlaying];
    [vc setInitialText:msg];
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark - MISC settings

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}
@end
