//
//  deporteViewController.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 21/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface deporteViewController : UIViewController{
    __weak IBOutlet UIActivityIndicatorView *cargando;
}
@property (weak, nonatomic) IBOutlet UILabel *titulo_deporte;
@property (weak, nonatomic) IBOutlet UILabel *descripcion_deporte;
@end
