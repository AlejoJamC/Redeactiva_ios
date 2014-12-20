//
//  deportesTableViewCell.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 21/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface deportesTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *titulo;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cargando;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@end
