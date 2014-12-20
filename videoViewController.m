//
//  videoViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 5/11/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "videoViewController.h"

@interface videoViewController ()

@end

@implementation videoViewController
@synthesize navegador, cargando;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    navegador.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    NSURL *targetURL = [NSURL URLWithString:[app().ruta objectForKey:@"linkvideoimagen"]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [navegador loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.view viewWithTag:100].hidden = YES;
    [cargando stopAnimating];
    cargando.hidden = YES;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
