//
//  eventoTableViewCell.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 21/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface eventoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *horario;
@property (weak, nonatomic) IBOutlet UILabel *telefonos;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cargando;
@property (weak, nonatomic) IBOutlet UILabel *titulo_evento;
@property (weak, nonatomic) IBOutlet UILabel *costo_evento;
@property (weak, nonatomic) IBOutlet UILabel *direccion;
@end
