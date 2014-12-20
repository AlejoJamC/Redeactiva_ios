//
//  galeriasViewController.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 21/09/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface galeriasViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *filasArray;
}
@property (nonatomic) IBOutlet UITableView *tabla_rutinas;

@end
