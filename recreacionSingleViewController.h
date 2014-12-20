//
//  recreacionSingleViewController.h
//  Redeactiva
//
//  Created by Paola andrea Poveda vargas on 8/12/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface recreacionSingleViewController : UIViewController{
    
    __weak IBOutlet UIActivityIndicatorView *cargando;
}
@property (weak, nonatomic) IBOutlet UIImageView *imagen_deporte;
@property (weak, nonatomic) IBOutlet UILabel *titulo_deporte;
@property (weak, nonatomic) IBOutlet UILabel *descripcion_deporte;

@end
