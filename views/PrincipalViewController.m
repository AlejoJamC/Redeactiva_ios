//
//  PrincipalViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 19/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "PrincipalViewController.h"
#import "Social/Social.h"

@interface PrincipalViewController ()

@end

@implementation PrincipalViewController

@synthesize player;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
}

- (void) viewDidAppear:(BOOL)animated {
    [self cargarVideo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)cargarVideo{
    NSString*thePath=[[NSBundle mainBundle] pathForResource:@"videoapp" ofType:@"mp4"];
    NSURL*url=[NSURL fileURLWithPath:thePath];
    
    player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    player.controlStyle = MPMovieControlStyleFullscreen;
    [player prepareToPlay];
    [player setContentURL:url];
    [player setMovieSourceType:MPMovieSourceTypeFile];
    
    [[player view] setFrame:self.view.bounds];
    
    player.scalingMode = MPMovieScalingModeAspectFill;
    player.controlStyle = MPMovieControlStyleDefault;
    player.backgroundView.backgroundColor = [UIColor whiteColor];
    player.repeatMode = MPMovieRepeatModeOne;
    
    [vistaVideo addSubview: [player view]];
    [player play];
}


- (IBAction)compartir:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Seleccione una de las siguientes opciones para compartir:" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Facebook",@"Twitter", nil];
            [sheet showInView:self.view];
        }else{
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Seleccione una de las siguientes opciones para compartir:" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", nil];
            [sheet showInView:self.view];
        }
        
    }else{
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Seleccione una de las siguientes opciones para compartir:" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Twitter", nil];
            [sheet showInView:self.view];
        }
    }
    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *txt = @"Te Invito a Descargar esta App, donde encontraras la mejor información";
    
    if (buttonIndex == 0) {
        //facebook
        SLComposeViewController *fbVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [fbVC setInitialText:txt];
        [fbVC addURL:[NSURL URLWithString:@"https://itunes.apple.com/co/app/eventsite/id708954209?mt=8"]];
        [self presentViewController:fbVC animated:YES completion:nil];
    } else if (buttonIndex == 1) {
        //twitter
        SLComposeViewController *twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [twitterVC setInitialText:txt];
        [twitterVC addURL:[NSURL URLWithString:@"https://itunes.apple.com/co/app/eventsite/id708954209?mt=8"]];
        [self presentViewController:twitterVC animated:YES completion:nil];
    }
}


@end
