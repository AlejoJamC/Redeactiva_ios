//
//  reglamentoViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 21/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "reglamentoViewController.h"

@interface reglamentoViewController ()

@end

@implementation reglamentoViewController

@synthesize navegador, cargando;
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
    navegador.delegate = self;
    
   
    
}

- (void) viewDidAppear:(BOOL)animated {
    if ([[app().ruta objectForKey:@"reglamento"] isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"Sitio web No disponible"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        NSString *url = [[app().ruta objectForKey:@"reglamento"] stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
        NSURL *targetURL = [NSURL URLWithString:url];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        [navegador loadRequest:request];
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.view viewWithTag:100].hidden = YES;
    [cargando stopAnimating];
    cargando.hidden = YES;
    
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

@end
