//
//  videoViewController.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 5/11/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface videoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *navegador;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cargando;
@end
