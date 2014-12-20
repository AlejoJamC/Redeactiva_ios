//
//  recreacionTableViewCell.h
//  Redeactiva
//
//  Created by Paola andrea Poveda vargas on 8/12/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface recreacionTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *titulo;
@property (nonatomic, weak) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cargando;
@end
