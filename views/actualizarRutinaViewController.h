//
//  actualizarRutinaViewController.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 20/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface actualizarRutinaViewController : UIViewController{
    IBOutlet UISwitch *lunes, *martes, *miercoles, *jueves, *viernes, *sabado, *domingo;
    IBOutlet UITextField *titulo_de_la_rutina;
    IBOutlet UIDatePicker *hora;
    NSString *urlServicioRutinas;
}
@property (strong, nonatomic) NSMutableData *responseData;
@end
