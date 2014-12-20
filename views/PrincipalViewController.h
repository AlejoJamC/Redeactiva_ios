//
//  PrincipalViewController.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 19/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PrincipalViewController : UIViewController{
    
    __weak IBOutlet UIView *vistaVideo;
    
}
- (IBAction)compartir:(id)sender;

@property (retain,strong) MPMoviePlayerController *player;

@end
