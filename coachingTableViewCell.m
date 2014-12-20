//
//  coachingTableViewCell.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 21/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "coachingTableViewCell.h"

@implementation coachingTableViewCell
@synthesize titulo, descripcion, contacto,cargando;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
