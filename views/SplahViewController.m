//
//  SplahViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 19/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "SplahViewController.h"

@interface SplahViewController ()

@end

@implementation SplahViewController
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
    NSLog(@"cargando desde view controller");
    //[self performSelector:@selector(checkLoad) withObject:self afterDelay:3.0f];
    
}

- (void) viewDidAppear:(BOOL)animated {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger userid = [[defaults objectForKey:@"userIdRedeactiva"] intValue];
    
    if (userid > 0) {
        app().userid = [NSString stringWithFormat:@"%li", (long)userid];
        [self.navigationController popToRootViewControllerAnimated:NO]; 
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"principal"] animated:YES];
    }else{
        [self cargarVideo];
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

-(void)checkLoad{
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"principal"]
                                         animated:YES];
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

@end
