//
//  reglamentoViewController.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 21/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface reglamentoViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *navegador;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cargando;

@end
