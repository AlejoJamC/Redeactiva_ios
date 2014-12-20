//
//  rutinasViewController.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 20/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rutinasViewController : UIViewController{
    NSString *urlServicioRutinas;
    NSMutableArray *filasArray;
    BOOL work;
}
@property (nonatomic) IBOutlet UITableView *tabla_rutinas;
@property (strong, nonatomic) NSMutableData *responseData;

@end
